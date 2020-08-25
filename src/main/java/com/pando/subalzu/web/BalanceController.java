package com.pando.subalzu.web;

import com.google.common.base.Strings;
import com.pando.subalzu.form.SupplierSearchForm;
import com.pando.subalzu.form.SupplierTransactionSearch;
import com.pando.subalzu.model.Supplier;
import com.pando.subalzu.model.SupplierTransaction;
import com.pando.subalzu.repository.SupplierRepository;
import com.pando.subalzu.repository.SupplierTransactionRepository;
import com.pando.subalzu.specification.SearchCriteria;
import com.pando.subalzu.specification.SupplierSpecification;
import com.pando.subalzu.specification.SupplierTransactionSpecification;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.util.Pair;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/balance")
public class BalanceController {

    @Autowired
    SupplierRepository supplierRepository;

    @Autowired
    SupplierTransactionRepository transactionRepository;

    @GetMapping("")
    public String index(@ModelAttribute("form")SupplierSearchForm form, Model model) {
        String type = form.getType();
        String keyword = form.getKeyword();
        int page = form.getPage();
        Page<Supplier> supplierPage;
        if (type != null && keyword != null) {
            SupplierSpecification spec = new SupplierSpecification(new SearchCriteria(type, ":", keyword));
            Pageable pageable = PageRequest.of(page - 1, 50);
            supplierPage = supplierRepository.findAll(spec, pageable);
        } else {
            Pageable pageable = PageRequest.of(page - 1, 50);
            supplierPage = supplierRepository.findAll(pageable);
        }
        List<Supplier> suppliers = supplierPage.getContent();

        model.addAttribute("supplierPage", supplierPage);
        model.addAttribute("suppliers", suppliers);
        model.addAttribute("currentPage", page);
        model.addAttribute("localDateTimeFormat", DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        model.addAttribute("sumPrevBalance", supplierRepository.sumPrevTotal());
        model.addAttribute("sumOrderAmount", transactionRepository.sumOrderAmount());
        model.addAttribute("sumUpdateAmount", transactionRepository.sumUpdateAmount());
        model.addAttribute("sumOutputAmount", transactionRepository.sumOutputAmount());
        model.addAttribute("sumAmount", transactionRepository.sumAmount());

        return "balance_list";
    }

    @GetMapping("/download_excel")
    public void downloadExcel(HttpServletResponse response) throws IOException {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");
        LocalDateTime now = LocalDateTime.now();
        String fileName = URLEncoder.encode("매입처_잔액_목록_" + dtf.format(now) + ".xlsx", "UTF-8");

        Long sumPrevTotal = supplierRepository.sumPrevTotal();
        if (sumPrevTotal == null) sumPrevTotal = 0L;

        Long sumShippingAmount = transactionRepository.sumOrderAmount();
        if (sumShippingAmount == null) sumShippingAmount = 0L;

        Long sumUpdateAmount = transactionRepository.sumUpdateAmount();
        if (sumUpdateAmount == null) sumUpdateAmount = 0L;

        Long sumOutputAmount = transactionRepository.sumOutputAmount();
        if (sumOutputAmount == null) sumOutputAmount = 0L;

        Long sumAmount = transactionRepository.sumAmount();
        if (sumAmount == null) sumAmount = 0L;

        List<Supplier> suppliers = supplierRepository.findAll();

        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ";");

        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Worksheet");

        Font defaultFont = workbook.createFont();
        defaultFont.setFontName("맑은 고딕");
        defaultFont.setFontHeightInPoints((short) 12);

        CellStyle headerCellStyle = workbook.createCellStyle();
        headerCellStyle.setFillForegroundColor(IndexedColors.AQUA.getIndex());
        headerCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        headerCellStyle.setFont(defaultFont);

        CellStyle defaultStyle = workbook.createCellStyle();
        defaultStyle.setFont(defaultFont);

        Row row = sheet.createRow(0);
        Cell cell = row.createCell(1);
        cell.setCellValue("총이전 잔액");
        cell.setCellStyle(headerCellStyle);

        cell = row.createCell(2);
        cell.setCellValue("총 매입 금액");
        cell.setCellStyle(headerCellStyle);

        cell = row.createCell(3);
        cell.setCellValue("총 출금 금액");
        cell.setCellStyle(headerCellStyle);

        cell = row.createCell(4);
        cell.setCellValue("총 수정 금액");
        cell.setCellStyle(headerCellStyle);

        cell = row.createCell(5);
        cell.setCellValue("총 잔액");
        cell.setCellStyle(headerCellStyle);

        row = sheet.createRow(1);
        cell = row.createCell(1);
        cell.setCellValue(sumPrevTotal);
        cell.setCellStyle(defaultStyle);

        cell = row.createCell(2);
        cell.setCellValue(sumShippingAmount);
        cell.setCellStyle(defaultStyle);

        cell = row.createCell(3);
        cell.setCellValue(sumOutputAmount);
        cell.setCellStyle(defaultStyle);

        cell = row.createCell(4);
        cell.setCellValue(sumUpdateAmount);
        cell.setCellStyle(defaultStyle);

        cell = row.createCell(5);
        cell.setCellValue(sumAmount);
        cell.setCellStyle(defaultStyle);


        row = sheet.createRow(3);
        // Creating header
        cell = row.createCell(0);
        cell.setCellValue("#");
        cell.setCellStyle(headerCellStyle);

        cell = row.createCell(1);
        cell.setCellValue("매입처");
        cell.setCellStyle(headerCellStyle);

        cell = row.createCell(2);
        cell.setCellValue("이전 잔액");
        cell.setCellStyle(headerCellStyle);

        cell = row.createCell(3);
        cell.setCellValue("매입 금액");
        cell.setCellStyle(headerCellStyle);

        cell = row.createCell(4);
        cell.setCellValue("출금 금액");
        cell.setCellStyle(headerCellStyle);

        cell = row.createCell(5);
        cell.setCellValue("잔액");
        cell.setCellStyle(headerCellStyle);

        cell = row.createCell(6);
        cell.setCellValue("최종거래일");
        cell.setCellStyle(headerCellStyle);

        // Creating data rows for each customer
        for(int i = 0; i < suppliers.size(); i++) {
            Supplier supplier = suppliers.get(i);

            Row dataRow = sheet.createRow(i + 4);
            cell = dataRow.createCell(0);
            cell.setCellValue(i + 1);
            cell.setCellStyle(defaultStyle);

            cell = dataRow.createCell(1);
            cell.setCellValue(supplier.getName());
            cell.setCellStyle(defaultStyle);

            cell = dataRow.createCell(2);
            cell.setCellValue(supplier.getPrevTotalFunds());
            cell.setCellStyle(defaultStyle);

            cell = dataRow.createCell(3);
            cell.setCellValue(supplier.getTotalInputFunds());
            cell.setCellStyle(defaultStyle);

            cell = dataRow.createCell(4);
            cell.setCellValue(supplier.getTotalOutputFunds());
            cell.setCellStyle(defaultStyle);

            cell = dataRow.createCell(5);
            cell.setCellValue(supplier.getTotalFunds());
            cell.setCellStyle(defaultStyle);

            cell = dataRow.createCell(6);
            if (supplier.getDealtAt() != null) {
                cell.setCellValue(supplier.getDealtAt().format(localDateTimeFormat()));
            }
            cell.setCellStyle(defaultStyle);
        }

        // Making size of column auto resize to fit with data
        sheet.autoSizeColumn(0);
        sheet.autoSizeColumn(1);
        sheet.autoSizeColumn(2);
        sheet.autoSizeColumn(3);
        sheet.autoSizeColumn(4);
        sheet.autoSizeColumn(5);
        sheet.autoSizeColumn(6);

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        workbook.write(outputStream);

        ByteArrayInputStream stream = new ByteArrayInputStream(outputStream.toByteArray());
        IOUtils.copy(stream, response.getOutputStream());
    }

    private DateTimeFormatter localDateTimeFormat() {
        return DateTimeFormatter.ofPattern("yyyy-MM-dd");
    }

    @GetMapping("/{id}")
    public String show(@PathVariable Long id, @ModelAttribute("searchForm") SupplierTransactionSearch searchForm, Model model) {
        Optional<Supplier> optionalSupplier = supplierRepository.findById(id);
        if (optionalSupplier.isPresent()) {
            Supplier supplier = optionalSupplier.get();
            String type = searchForm.getType();
            String method = searchForm.getMethod();
            String strDateFrom = searchForm.getDateFrom();
            String strDateTo = searchForm.getDateTo();
            int page = searchForm.getPage();

            Specification<SupplierTransaction> spec = new SupplierTransactionSpecification(new SearchCriteria("supplier", ":", supplier));

            if (!Strings.isNullOrEmpty(type)) {
                spec = Specification.where(spec).and(new SupplierTransactionSpecification(new SearchCriteria("type", ":", type)));
            }
            if (!Strings.isNullOrEmpty(method)) {
                spec = Specification.where(spec).and(new SupplierTransactionSpecification(new SearchCriteria("method", ":", method)));
            }
            if (!Strings.isNullOrEmpty(strDateFrom) && !Strings.isNullOrEmpty(strDateTo)) {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                LocalDateTime dateFrom = LocalDate.parse(strDateFrom, formatter).atStartOfDay();
                LocalDateTime dateTo = LocalDate.parse(strDateTo, formatter).atTime(23, 59, 59);
                Pair<LocalDateTime, LocalDateTime> dateTimePair = Pair.of(dateFrom, dateTo);
                spec = Specification.where(spec).and(new SupplierTransactionSpecification(new SearchCriteria("createdAt", "<>", dateTimePair)));
            }
            Pageable pageable = PageRequest.of(page - 1, 50, Sort.by("createdAt").descending());
            Page<SupplierTransaction> transactionPage = transactionRepository.findAll(spec, pageable);
            List<SupplierTransaction> transactions = transactionPage.getContent();

            model.addAttribute("supplier", optionalSupplier.get());
            model.addAttribute("localDateTimeFormat", DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            SupplierTransaction form1 = new SupplierTransaction(supplier);
            SupplierTransaction form2 = new SupplierTransaction(supplier);
            form1.setType("output");
            form1.setMethod("direct_minus");
            form2.setType("update");
            form2.setMethod("fund_minus");
            model.addAttribute("form1", form1);
            model.addAttribute("form2", form2);

            model.addAttribute("transactionPage", transactionPage);
            model.addAttribute("transactions", transactions);
            model.addAttribute("currentPage", page);

            return "balance_show";
        } else {
            return "redirect:/balance";
        }
    }

    @GetMapping("/{id}/ajax")
    @ResponseBody
    public Map<String, Object> getBalance(@PathVariable Long id) {
        Optional<Supplier> optionalSupplier = supplierRepository.findById(id);
        Map<String, Object> resultMap = new HashMap<>();
        if (optionalSupplier.isPresent()) {
            Supplier supplier = optionalSupplier.get();
            resultMap.put("totalFunds", supplier.getTotalFunds());
            resultMap.put("name", supplier.getName());
        }
        return resultMap;
    }

    @GetMapping("/{id}/download_excel")
    public void downloadTransactionExcel(HttpServletResponse response, @PathVariable Long id) throws IOException {
        Optional<Supplier> optionalSupplier = supplierRepository.findById(id);
        if (optionalSupplier.isPresent()) {
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");
            LocalDateTime now = LocalDateTime.now();
            String fileName = URLEncoder.encode("매입처잔액(상세내역)_" + dtf.format(now) + ".xlsx", "UTF-8");

            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ";");

            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("Worksheet");

            Font defaultFont = workbook.createFont();
            defaultFont.setFontName("맑은 고딕");
            defaultFont.setFontHeightInPoints((short) 12);

            CellStyle headerCellStyle = workbook.createCellStyle();
            headerCellStyle.setFillForegroundColor(IndexedColors.AQUA.getIndex());
            headerCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            headerCellStyle.setFont(defaultFont);

            CellStyle defaultStyle = workbook.createCellStyle();
            defaultStyle.setFont(defaultFont);


            Row row = sheet.createRow(0);
            Cell cell = row.createCell(0);
            cell.setCellValue("매입처잔액 상세 내역");
            cell.setCellStyle(defaultStyle);

            row = sheet.createRow(1);
            // Creating header
            cell = row.createCell(0);
            cell.setCellValue("#");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(1);
            cell.setCellValue("일시");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(2);
            cell.setCellValue("구분");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(3);
            cell.setCellValue("거래 방식");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(4);
            cell.setCellValue("거래 금액");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(5);
            cell.setCellValue("총 잔액");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(6);
            cell.setCellValue("비고");
            cell.setCellStyle(headerCellStyle);

            Supplier supplier = optionalSupplier.get();
            Specification<SupplierTransaction> spec = new SupplierTransactionSpecification(new SearchCriteria("supplier", ":", supplier));
            List<SupplierTransaction> transactions = transactionRepository.findAll(spec);

            // Creating data rows for each customer
            for(int i = 0; i < transactions.size(); i++) {
                SupplierTransaction transaction = transactions.get(i);

                Row dataRow = sheet.createRow(i + 2);
                cell = dataRow.createCell(0);
                cell.setCellValue(i + 1);
                cell.setCellStyle(defaultStyle);

                cell = dataRow.createCell(1);
                cell.setCellValue(transaction.getCreatedAt().format(localDateTimeFormat()));
                cell.setCellStyle(defaultStyle);

                String transactionType = transaction.getType();
                cell = dataRow.createCell(2);
                if (transactionType.equalsIgnoreCase("output"))
                    cell.setCellValue("출금");
                else if (transactionType.equalsIgnoreCase("update"))
                    cell.setCellValue("수정");
                else if (transactionType.equalsIgnoreCase("shipping"))
                    cell.setCellValue("매입");
                cell.setCellStyle(defaultStyle);

                String processingMethod = transaction.getMethod();
                cell = dataRow.createCell(3);
                if (processingMethod.equalsIgnoreCase("manual_order"))
                    cell.setCellValue("일반 발주");
                else if (processingMethod.equalsIgnoreCase("fund_minus"))
                    cell.setCellValue("금액 차감");
                else if (processingMethod.equalsIgnoreCase("fund_plus"))
                    cell.setCellValue("금액 추가");
                else if (processingMethod.equalsIgnoreCase("direct_minus"))
                    cell.setCellValue("직접 출금");
                cell.setCellStyle(defaultStyle);

                cell = dataRow.createCell(4);
                cell.setCellValue(transaction.getAmount());
                cell.setCellStyle(defaultStyle);

                cell = dataRow.createCell(5);
                cell.setCellValue(transaction.getTotalAmount());
                cell.setCellStyle(defaultStyle);

                cell = dataRow.createCell(6);
                cell.setCellValue(transaction.getDescription());
                cell.setCellStyle(defaultStyle);
            }

            // Making size of column auto resize to fit with data
            sheet.autoSizeColumn(0);
            sheet.autoSizeColumn(1);
            sheet.autoSizeColumn(2);
            sheet.autoSizeColumn(3);
            sheet.autoSizeColumn(4);
            sheet.autoSizeColumn(5);
            sheet.autoSizeColumn(6);

            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            workbook.write(outputStream);

            ByteArrayInputStream stream = new ByteArrayInputStream(outputStream.toByteArray());
            IOUtils.copy(stream, response.getOutputStream());
        }
    }

    @PostMapping("/{id}/add")
    @ResponseBody
    public Map<String, String> store(@PathVariable Long id, @RequestBody Map<String, Object> payload, HttpServletResponse response) {
        Optional<Supplier> optionalSupplier = supplierRepository.findById(id);
        if (optionalSupplier.isPresent()) {
            Supplier supplier = optionalSupplier.get();

            String method = (String)payload.get("method");
            SupplierTransaction supplierTransaction = new SupplierTransaction();
            supplierTransaction.setMethod(method);
            supplierTransaction.setType((String)payload.get("type"));
            supplierTransaction.setSupplier(supplier);
            supplierTransaction.setDescription((String)payload.get("description"));
            double amount = ((Integer)payload.get("funds")).doubleValue();
            if (method.contains("minus")) {
                amount = -amount;
            }
            supplierTransaction.setAmount(amount);
            supplierTransaction.setTotalAmount(supplier.getTotalFunds() + amount);
            transactionRepository.save(supplierTransaction);

            supplier.setPrevTotalFunds(supplier.getTotalFunds());
            supplier.setDealtAt(LocalDateTime.now());
            supplierRepository.save(supplier);
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }

        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }
}

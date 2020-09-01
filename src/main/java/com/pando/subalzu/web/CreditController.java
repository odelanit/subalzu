package com.pando.subalzu.web;

import com.google.common.base.Strings;
import com.pando.subalzu.form.ShopSearchForm4;
import com.pando.subalzu.form.TransactionForm;
import com.pando.subalzu.form.TransactionSearchForm;
import com.pando.subalzu.model.Order;
import com.pando.subalzu.model.Shop;
import com.pando.subalzu.model.Transaction;
import com.pando.subalzu.model.User;
import com.pando.subalzu.repository.ShopRepository;
import com.pando.subalzu.repository.TransactionRepository;
import com.pando.subalzu.service.UserDetailsImpl;
import com.pando.subalzu.specification.SearchCriteria;
import com.pando.subalzu.specification.ShopSpecification;
import com.pando.subalzu.specification.TransactionSpecification;
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
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.Principal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
@RequestMapping("/credits")
public class CreditController {

    @Autowired
    ShopRepository shopRepository;

    @Autowired
    TransactionRepository transactionRepository;

    @Autowired
    UserDetailsService userDetailsService;

    @ModelAttribute("localDateTimeFormat")
    DateTimeFormatter localDateTimeFormat() {
        return DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss");
    }

    @GetMapping("")
    public String index(@ModelAttribute("form") ShopSearchForm4 form, Model model) {
        Page<Shop> shopPage;
        String field = form.getField();
        String keyword = form.getKeyword();
        String dateFrom = form.getDateFrom();
        String dateTo = form.getDateTo();
        String dealStatus = form.getDealStatus();
        String paymentMethod = form.getPaymentMethod();
        int page = form.getPage();

        Specification<Shop> spec = new ShopSpecification(new SearchCriteria(field, ":", keyword));
        if (!Strings.isNullOrEmpty(dealStatus)) {
            spec = Specification.where(spec).and(new ShopSpecification(new SearchCriteria("dealStatus", ":", Boolean.parseBoolean(dealStatus))));
        }
        if (!Strings.isNullOrEmpty(paymentMethod)) {
            spec = Specification.where(spec).and(new ShopSpecification(new SearchCriteria("paymentMethod", ":", paymentMethod)));
        }

        Pageable pageable = PageRequest.of(page - 1, 50);
        shopPage = shopRepository.findAll(spec, pageable);
        List<Shop> shops = shopPage.getContent();

        model.addAttribute("shopPage", shopPage);
        model.addAttribute("currentPage", page);
        model.addAttribute("shops", shops);
        model.addAttribute("localDateTimeFormat", DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        Long subPrevTotal = shopRepository.sumPrevTotal();
        if (subPrevTotal == null) subPrevTotal = 0L;
        Long sumAmount = transactionRepository.sumAmount();
        if (sumAmount == null) sumAmount = 0L;
        Long sumUpdateAmount = transactionRepository.sumUpdateAmount();
        if (sumUpdateAmount == null) sumUpdateAmount = 0L;
        Long sumInputAmount = transactionRepository.sumInputAmount();
        if (sumInputAmount == null) sumInputAmount = 0L;
        Long sumSaleAmount = transactionRepository.sumSaleAmount();
        if (sumSaleAmount == null) sumSaleAmount = 0L;

        model.addAttribute("sumPrevBalance", subPrevTotal);
        model.addAttribute("sumAmount", sumAmount);
        model.addAttribute("sumUpdateAmount", sumUpdateAmount);
        model.addAttribute("sumInputAmount", sumInputAmount);
        model.addAttribute("sumTotalSales", sumSaleAmount);

        return "credit_list";
    }

    @GetMapping("/download_excel")
    public void downloadExcel(HttpServletResponse response) throws IOException {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");
        LocalDateTime now = LocalDateTime.now();
        String fileName = URLEncoder.encode("외상잔액_" + dtf.format(now) + ".xlsx", "UTF-8");

        Long sumPrevTotal = shopRepository.sumPrevTotal();
        if (sumPrevTotal == null) sumPrevTotal = 0L;
        Long sumAmount = transactionRepository.sumAmount();
        if (sumAmount == null) sumAmount = 0L;
        Long sumUpdateAmount = transactionRepository.sumUpdateAmount();
        if (sumUpdateAmount == null) sumUpdateAmount = 0L;
        Long sumInputAmount = transactionRepository.sumInputAmount();
        if (sumInputAmount == null) sumInputAmount = 0L;
        Long sumSaleAmount = transactionRepository.sumSaleAmount();
        if (sumSaleAmount == null) sumSaleAmount = 0L;
        List<Shop> shops = shopRepository.findAll();

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
        cell.setCellValue("총 매출 금액");
        cell.setCellStyle(headerCellStyle);

        cell = row.createCell(3);
        cell.setCellValue("총 입금 금액");
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
        cell.setCellValue(sumSaleAmount);
        cell.setCellStyle(defaultStyle);

        cell = row.createCell(3);
        cell.setCellValue(sumInputAmount);
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
        cell.setCellValue("결제수단");
        cell.setCellStyle(headerCellStyle);

        cell = row.createCell(2);
        cell.setCellValue("거래처");
        cell.setCellStyle(headerCellStyle);

        cell = row.createCell(3);
        cell.setCellValue("이전 잔액");
        cell.setCellStyle(headerCellStyle);

        cell = row.createCell(4);
        cell.setCellValue("매출 금액");
        cell.setCellStyle(headerCellStyle);

        cell = row.createCell(5);
        cell.setCellValue("입금 금액");
        cell.setCellStyle(headerCellStyle);

        cell = row.createCell(6);
        cell.setCellValue("수정 금액");
        cell.setCellStyle(headerCellStyle);

        cell = row.createCell(7);
        cell.setCellValue("잔액");
        cell.setCellStyle(headerCellStyle);

        cell = row.createCell(8);
        cell.setCellValue("담당자");
        cell.setCellStyle(headerCellStyle);

        cell = row.createCell(9);
        cell.setCellValue("최종거래일");
        cell.setCellStyle(headerCellStyle);

        // Creating data rows for each customer
        for(int i = 0; i < shops.size(); i++) {
            Shop shop = shops.get(i);

            Row dataRow = sheet.createRow(i + 4);
            cell = dataRow.createCell(0);
            cell.setCellValue(i + 1);
            cell.setCellStyle(defaultStyle);

            String paymentMethod = shop.getPaymentMethod().equalsIgnoreCase("credits") ? "외상잔액" : "예치금";
            cell = dataRow.createCell(1);
            cell.setCellValue(paymentMethod);
            cell.setCellStyle(defaultStyle);

            cell = dataRow.createCell(2);
            cell.setCellValue(shop.getName());
            cell.setCellStyle(defaultStyle);

            cell = dataRow.createCell(3);
            cell.setCellValue(shop.getPrevTotalBalance());
            cell.setCellStyle(defaultStyle);

            cell = dataRow.createCell(4);
            cell.setCellValue(shop.getTotalSales());
            cell.setCellStyle(defaultStyle);

            cell = dataRow.createCell(5);
            cell.setCellValue(shop.getTotalInput());
            cell.setCellStyle(defaultStyle);

            cell = dataRow.createCell(6);
            cell.setCellValue(shop.getTotalUpdate());
            cell.setCellStyle(defaultStyle);

            cell = dataRow.createCell(7);
            cell.setCellValue(shop.getTotalBalance());
            cell.setCellStyle(defaultStyle);

            cell = dataRow.createCell(8);
            cell.setCellValue(shop.getShopOwner().getFullName());
            cell.setCellStyle(defaultStyle);

            if (shop.getDealtAt() != null) {
                cell = dataRow.createCell(9);
                cell.setCellValue(shop.getDealtAt().format(localDateTimeFormat()));
                cell.setCellStyle(defaultStyle);
            }
        }

        // Making size of column auto resize to fit with data
        sheet.autoSizeColumn(0);
        sheet.autoSizeColumn(1);
        sheet.autoSizeColumn(2);
        sheet.autoSizeColumn(3);
        sheet.autoSizeColumn(4);
        sheet.autoSizeColumn(5);
        sheet.autoSizeColumn(6);
        sheet.autoSizeColumn(7);
        sheet.autoSizeColumn(8);
        sheet.autoSizeColumn(9);

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        workbook.write(outputStream);

        ByteArrayInputStream stream = new ByteArrayInputStream(outputStream.toByteArray());
        IOUtils.copy(stream, response.getOutputStream());
    }

    @GetMapping("/{id}")
    public String show(@PathVariable Long id, @ModelAttribute("form") TransactionSearchForm form, Model model, Principal principal) {
        Optional<Shop> optionalShop = shopRepository.findById(id);
        if (optionalShop.isPresent()) {
            Shop shop = optionalShop.get();
            UserDetailsImpl userDetails = (UserDetailsImpl) userDetailsService.loadUserByUsername(principal.getName());
            if (userDetails.hasPermission("in_charge")) {
                User user = userDetails.getUser();
                Set<Shop> salesShops = user.getSalesShops();
                if (!salesShops.contains(shop)) {
                    return "redirect:/credits";
                }
            }
            String transactionType = form.getTransactionType();
            String processingMethod = form.getProcessingMethod();
            String strDateFrom = form.getDateFrom();
            String strDateTo = form.getDateTo();
            int page = form.getPage();

            Specification<Transaction> spec = new TransactionSpecification(new SearchCriteria("shop", ":", shop));
            if (!Strings.isNullOrEmpty(transactionType)) {
                spec = Specification.where(spec).and(new TransactionSpecification(new SearchCriteria("transactionType", ":", transactionType)));
            }
            if (!Strings.isNullOrEmpty(processingMethod)) {
                spec = Specification.where(spec).and(new TransactionSpecification(new SearchCriteria("processingMethod", ":", processingMethod)));
            }
            if (!Strings.isNullOrEmpty(strDateFrom) && !Strings.isNullOrEmpty(strDateTo)) {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                LocalDateTime dateFrom = LocalDate.parse(strDateFrom, formatter).atStartOfDay();
                LocalDateTime dateTo = LocalDate.parse(strDateTo, formatter).atTime(23, 59, 59);
                Pair<LocalDateTime, LocalDateTime> dateTimePair = Pair.of(dateFrom, dateTo);
                spec = Specification.where(spec).and(new TransactionSpecification(new SearchCriteria("createdAt", "<>", dateTimePair)));
            }
            Pageable pageable = PageRequest.of(page - 1, 50, Sort.by("createdAt").descending());
            Page<Transaction> transactionPage = transactionRepository.findAll(spec, pageable);
            List<Transaction> transactions = transactionPage.getContent();

            model.addAttribute("shop", shop);
            model.addAttribute("transactionPage", transactionPage);
            model.addAttribute("transactions", transactions);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalBalance", shop.getTotalBalance());
            return "credit_show";
        } else {
            return "redirect:/credits";
        }
    }

    @GetMapping("/{id}/data")
    @ResponseBody
    public Map<String, Object> getData(@PathVariable Long id, HttpServletResponse response) {
        Map<String, Object> resultMap = new HashMap<>();

        Optional<Shop> optionalShop = shopRepository.findById(id);
        if (optionalShop.isPresent()) {
            Shop shop = optionalShop.get();
            resultMap.put("shopName", shop.getName());
            resultMap.put("totalFunds", shop.getTotalBalance());
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }
        resultMap.put("message", "Success");
        return resultMap;
    }

    @PostMapping("/{id}/store")
    @ResponseBody
    public Map<String, Object> storeData(@PathVariable Long id, @RequestBody TransactionForm form, HttpServletResponse response) {
        Map<String, Object> resultMap = new HashMap<>();

        Optional<Shop> optionalShop = shopRepository.findById(id);
        if (optionalShop.isPresent()) {
            Shop shop = optionalShop.get();
            String description = form.getDescription();
            Double funds = form.getFunds();
            String method = form.getMethod();
            String type = form.getType();
            if (method.contains("minus")) {
                funds = -funds;
            }

            Transaction transaction = new Transaction();
            transaction.setShop(shop);
            transaction.setFunds(funds);
            transaction.setProcessingMethod(method);
            transaction.setTransactionType(type);
            transaction.setDescription(description);
            transaction.setPrevTotal(shop.getTotalBalance());
            transaction.setTotalFunds(shop.getTotalBalance() + funds);
            transactionRepository.save(transaction);

            shop.setPrevTotalBalance(shop.getTotalBalance());
            shop.setDealtAt(LocalDateTime.now());
            shopRepository.save(shop);
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }
        resultMap.put("message", "Success");
        return resultMap;
    }

    @GetMapping("/{id}/download_excel")
    public void downloadTransactionExcel(HttpServletResponse response, @PathVariable Long id) throws IOException {
        Optional<Shop> optionalShop = shopRepository.findById(id);
        if (optionalShop.isPresent()) {
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");
            LocalDateTime now = LocalDateTime.now();
            String fileName = URLEncoder.encode("외상잔액(상세내역)_" + dtf.format(now) + ".xlsx", "UTF-8");

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
            cell.setCellValue("외상잔액 상세 내역");
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
            cell.setCellValue("현재 잔액");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(6);
            cell.setCellValue("비고");
            cell.setCellStyle(headerCellStyle);

            Shop shop = optionalShop.get();
            Specification<Transaction> spec = new TransactionSpecification(new SearchCriteria("shop", ":", shop));
            List<Transaction> transactions = transactionRepository.findAll(spec);

            // Creating data rows for each customer
            for(int i = 0; i < transactions.size(); i++) {
                Transaction transaction = transactions.get(i);

                Row dataRow = sheet.createRow(i + 2);
                cell = dataRow.createCell(0);
                cell.setCellValue(i + 1);
                cell.setCellStyle(defaultStyle);

                cell = dataRow.createCell(1);
                cell.setCellValue(transaction.getCreatedAt().format(localDateTimeFormat()));
                cell.setCellStyle(defaultStyle);

                String transactionType = transaction.getTransactionType();
                cell = dataRow.createCell(2);
                if (transactionType.equalsIgnoreCase("input"))
                    cell.setCellValue("입금");
                else if (transactionType.equalsIgnoreCase("update"))
                    cell.setCellValue("수정");
                else if (transactionType.equalsIgnoreCase("sale"))
                    cell.setCellValue("매출");
                cell.setCellStyle(defaultStyle);

                String processingMethod = transaction.getProcessingMethod();
                cell = dataRow.createCell(3);
                if (processingMethod.equalsIgnoreCase("manual_minus"))
                    cell.setCellValue("직접 입금");
                else if (processingMethod.equalsIgnoreCase("fund_minus"))
                    cell.setCellValue("금액 차감");
                else if (processingMethod.equalsIgnoreCase("fund_plus"))
                    cell.setCellValue("금액 추가");
                else if (processingMethod.equalsIgnoreCase("order_minus"))
                    cell.setCellValue("주문 거래");
                cell.setCellStyle(defaultStyle);

                cell = dataRow.createCell(4);
                cell.setCellValue(transaction.getFunds());
                cell.setCellStyle(defaultStyle);

                cell = dataRow.createCell(5);
                cell.setCellValue(transaction.getTotalFunds());
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

    @PostMapping("/store")
    @ResponseBody
    public Map<String, String> store(Transaction transaction) {
        Map<String, String> resultMap = new HashMap<>();
        String method = transaction.getProcessingMethod();
        if (method.contains("minus")) {
            transaction.setFunds(-transaction.getFunds());
        }
        Double prevTotal = transaction.getPrevTotal();
        transaction = transactionRepository.save(transaction);
        Shop shop = transaction.getShop();
        shop.setDealtAt(LocalDateTime.now());
        shop.setPrevTotalBalance(prevTotal);
        shopRepository.save(shop);
        resultMap.put("message", "처리 완료 되었습니다.");
        return resultMap;
    }
}

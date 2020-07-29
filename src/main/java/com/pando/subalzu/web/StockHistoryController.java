package com.pando.subalzu.web;

import com.google.common.base.Strings;
import com.pando.subalzu.form.RecordSearchForm;
import com.pando.subalzu.model.ProductRecord;
import com.pando.subalzu.repository.ProductRecordRepository;
import com.pando.subalzu.specification.ProductRecordSpecification;
import com.pando.subalzu.specification.SearchCriteria;
import com.pando.subalzu.specification.TransactionSpecification;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.util.Pair;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
@RequestMapping("/stock-history")
public class StockHistoryController {

    @Autowired
    ProductRecordRepository productRecordRepository;

    @GetMapping("")
    public String index(@ModelAttribute("form") RecordSearchForm form, Model model) {
        String field = form.getField();
        String keyword = form.getKeyword();
        String action = form.getAction();
        String strDateFrom = form.getDateFrom();
        String strDateTo = form.getDateTo();
        int page = form.getPage();
        Page<ProductRecord> recordPage;

        Specification<ProductRecord> spec = new ProductRecordSpecification(new SearchCriteria(field, ":", keyword));

        if (!Strings.isNullOrEmpty(action)) {
            spec = Specification.where(spec).and(new ProductRecordSpecification(new SearchCriteria("action", ":", action)));
        }

        if (!Strings.isNullOrEmpty(strDateFrom) && !Strings.isNullOrEmpty(strDateTo)) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDateTime dateFrom = LocalDate.parse(strDateFrom, formatter).atStartOfDay();
            LocalDateTime dateTo = LocalDate.parse(strDateTo, formatter).atTime(23, 59, 59);
            Pair<LocalDateTime, LocalDateTime> dateTimePair = Pair.of(dateFrom, dateTo);
            spec = Specification.where(spec).and(new ProductRecordSpecification(new SearchCriteria("createdAt", "<>", dateTimePair)));
        }

        Pageable pageable = PageRequest.of(page - 1, 50);
        recordPage = productRecordRepository.findAll(spec, pageable);
        List<ProductRecord> records = recordPage.getContent();

        model.addAttribute("recordPage", recordPage);
        model.addAttribute("records", records);
        model.addAttribute("currentPage", page);
        model.addAttribute("localDateTimeFormat", DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        return "stock_history";
    }

    ByteArrayInputStream recordListToExcelFile(List<ProductRecord> records) {
        try (Workbook workbook = new XSSFWorkbook()) {
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

            // Creating header
            Row row = sheet.createRow(0);

            Cell cell = row.createCell(0);
            cell.setCellValue("#");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(1);
            cell.setCellValue("일지");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(2);
            cell.setCellValue("상품코드");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(3);
            cell.setCellValue("상품명");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(4);
            cell.setCellValue("제조사(원산지)");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(5);
            cell.setCellValue("구분");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(6);
            cell.setCellValue("처리수량");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(7);
            cell.setCellValue("재고");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(8);
            cell.setCellValue("처리관리자");
            cell.setCellStyle(headerCellStyle);

            // Creating data rows for each customer
            for (int i = 0; i < records.size(); i++) {
                Row dataRow = sheet.createRow(i + 1);
                cell = dataRow.createCell(0);
                cell.setCellValue(records.get(i).getId());
                cell.setCellStyle(defaultStyle);

                cell = dataRow.createCell(1);
                cell.setCellValue(records.get(i).getCreatedAt().format(DateTimeFormatter.ofPattern("yy-MM-dd hh:mm:ss")));
                cell.setCellStyle(defaultStyle);

                cell = dataRow.createCell(2);
                cell.setCellValue(records.get(i).getProduct().getErpCode());
                cell.setCellStyle(defaultStyle);

                cell = dataRow.createCell(3);
                cell.setCellValue(records.get(i).getProduct().getName());
                cell.setCellStyle(defaultStyle);

                cell = dataRow.createCell(4);
                cell.setCellValue(records.get(i).getProduct().getMakerName() + "(" + records.get(i).getProduct().getCountry() + ")");
                cell.setCellStyle(defaultStyle);

                cell = dataRow.createCell(5);
                String action = records.get(i).getAction();
                if (action.equalsIgnoreCase("manual_input")) {
                    cell.setCellValue("수동입고");
                } else if (action.equalsIgnoreCase("manual_output")) {
                    cell.setCellValue("수동출고");
                } else if (action.equalsIgnoreCase("discard_output")) {
                    cell.setCellValue("폐기출고");
                } else if (action.equalsIgnoreCase("return_output")) {
                    cell.setCellValue("반품출고");
                }
                cell.setCellStyle(defaultStyle);

                cell = dataRow.createCell(6);
                if (records.get(i).getProduct().getUseDecimal()) {
                    cell.setCellValue(records.get(i).getDiff());
                } else {
                    cell.setCellValue(Math.round(records.get(i).getDiff()));
                }
                cell.setCellStyle(defaultStyle);

                cell = dataRow.createCell(7);
                if (records.get(i).getProduct().getUseDecimal()) {
                    cell.setCellValue(records.get(i).getProduct().getQty());
                } else {
                    cell.setCellValue(Math.round(records.get(i).getProduct().getQty()));
                }
                cell.setCellStyle(defaultStyle);

                cell = dataRow.createCell(8);
                if (records.get(i).getUser() != null)
                    cell.setCellValue(records.get(i).getUser().getFullName());
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
            sheet.autoSizeColumn(7);
            sheet.autoSizeColumn(8);
            sheet.autoSizeColumn(9);
            sheet.autoSizeColumn(10);
            sheet.autoSizeColumn(11);
            sheet.autoSizeColumn(12);


            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            workbook.write(outputStream);
            return new ByteArrayInputStream(outputStream.toByteArray());
        } catch (IOException exception) {
            exception.printStackTrace();
            return null;
        }
    }

    @GetMapping("/download_excel")
    @ResponseBody
    public void downloadExcel(HttpServletResponse response) throws IOException {
        List<ProductRecord> records = productRecordRepository.findAll();
        response.setContentType("application/octet-stream");
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");
        LocalDateTime now = LocalDateTime.now();
        String fileName = URLEncoder.encode("입출고내역_" + dtf.format(now) + ".xlsx", "UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ";");
        ByteArrayInputStream stream = recordListToExcelFile(records);
        IOUtils.copy(stream, response.getOutputStream());
    }
}

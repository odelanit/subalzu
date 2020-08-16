package com.pando.subalzu.web;

import com.pando.subalzu.form.PriceUpdateForm;
import com.pando.subalzu.form.ProductSearchForm;
import com.pando.subalzu.model.*;
import com.pando.subalzu.repository.*;
import com.pando.subalzu.specification.ProductSpecification;
import com.pando.subalzu.specification.SearchCriteria;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
@RequestMapping("/prices")
public class PriceController {

    @Autowired
    CompanyConfigRepository companyRepository;

    @Autowired
    PriceGroupRepository priceGroupRepository;

    @Autowired
    ProductRepository productRepository;

    @Autowired
    CategoryRepository categoryRepository;

    @ModelAttribute("categories")
    List<Category> categories() {
        return categoryRepository.findByParentNull(Sort.by(Sort.Direction.DESC, "level"));
    }

    @GetMapping("")
    public String index(@ModelAttribute("form") ProductSearchForm form, Model model) {
        String field = form.getField();
        String keyword = form.getKeyword();
        Category category = form.getCategory();
        int page = form.getPage();

        Page<Product> productPage;
        Specification<Product> spec = new ProductSpecification(new SearchCriteria(field, ":", keyword));

        if (category != null) {
            List<Category> subcategories = categoryRepository.findByParent(category);
            model.addAttribute("subcategories", subcategories);
            spec = Specification.where(spec).and(new ProductSpecification(new SearchCriteria("category", ":", category)));

            Category subcategory = form.getSubcategory();
            if (subcategory != null) {
                spec = Specification.where(spec).and(new ProductSpecification(new SearchCriteria("subCategory", ":", subcategory)));
            }
        } else {
            form.setSubcategory(null);
        }

        Pageable pageable = PageRequest.of(page - 1, 50);
        productPage = productRepository.findAll(spec, pageable);
        List<Product> products = productPage.getContent();

        model.addAttribute("productPage", productPage);
        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);

        return "price_list";
    }

    @ModelAttribute("priceGroups")
    public List<PriceGroup> priceGroupList() {
        return priceGroupRepository.findAll();
    }

    @GetMapping("/fixed-price-rate")
    public String fixedRate(Principal principal, Model model) {
//        List<Company> companies = companyRepository.findAll();
//        if (companies.size() > 0) {
//            Company company = companies.get(0);
//            Company companySetting = company.getCompanySetting();
//            if (companySetting == null) {
//                return "redirect:/company";
//            }
//            boolean fixedRateSetting = companySetting.getFixedPriceRate();
//            model.addAttribute("fixedRateSetting", fixedRateSetting);
//
//        } else {
//            return "redirect:/company";
//        }
        return "price_fixed_rate_vue";
    }

    @PostMapping("/fixed-price-rate")
    public String updateRate(Principal principal, @RequestParam Map<String, String> formData) {
//        List<Company> companies = companyRepository.findAll();
//        if (companies.size() > 0) {
//            Company company = companies.get(0);
//            Company companySetting = company.getCompanySetting();
//            boolean fixedRateSetting = Boolean.parseBoolean(formData.get("is_fixed"));
//            companySetting.setFixedPriceRate(fixedRateSetting);
//            companySettingRepository.save(companySetting);
//
//        } else {
//            return "redirect:/company";
//        }
        return "redirect:/prices";
    }

    @PostMapping("/update")
    @ResponseBody
    public Map<String, String> updatePrice(PriceUpdateForm form) {
        Long productId = form.getProduct();
        Optional<Product> optionalProduct = productRepository.findById(productId);
        if (optionalProduct.isPresent()) {
            Product product = optionalProduct.get();
            product.setBuyPrice(form.getBuyPrice());
            product.setDirectPrice(form.getDirectPrice());
            product.setParcelPrice(form.getParcelPrice());
            product.setSellPrice(form.getSellPrice());
            productRepository.save(product);
        }
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "단가 변경이 완료되었습니다.");
        return resultMap;
    }

    @PostMapping("/update_all")
    @ResponseBody
    public Map<String, String> updateAll(@RequestBody List<PriceUpdateForm> infos) {
        for (PriceUpdateForm form: infos) {
            Long productId = form.getProduct();
            Optional<Product> optionalProduct = productRepository.findById(productId);
            if (optionalProduct.isPresent()) {
                Product product = optionalProduct.get();
                product.setBuyPrice(form.getBuyPrice());
                product.setDirectPrice(form.getDirectPrice());
                product.setParcelPrice(form.getParcelPrice());
                product.setSellPrice(form.getSellPrice());
                productRepository.save(product);
            }
        }
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "단가 변경이 완료되었습니다.");
        return resultMap;
    }

    @GetMapping("/download")
    @ResponseBody
    public void downloadExcel(HttpServletResponse response)throws IOException {
        response.setContentType("application/octet-stream");
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");
        LocalDateTime now = LocalDateTime.now();
        String fileName = URLEncoder.encode("단가_일괄수정_엑셀양식_" + dtf.format(now) + ".xlsx", "UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename=" + fileName +";");

        try(Workbook workbook = new XSSFWorkbook()) {
            Font defaultFont = workbook.createFont();
            defaultFont.setFontName("맑은 고딕");
            defaultFont.setFontHeightInPoints((short)12);

            Font requiredFont = workbook.createFont();
            requiredFont.setFontName("맑은 고딕");
            requiredFont.setColor(IndexedColors.RED.getIndex());
            requiredFont.setFontHeightInPoints((short)12);

            Font headerFont = workbook.createFont();
            headerFont.setFontName("맑은 고딕");
            headerFont.setFontHeightInPoints((short)16);

            Font hintFont = workbook.createFont();
            hintFont.setFontName("맑은 고딕");
            hintFont.setFontHeightInPoints((short)11);

            Font importantFont = workbook.createFont();
            importantFont.setFontName("맑은 고딕");
            importantFont.setColor(IndexedColors.RED.getIndex());
            importantFont.setFontHeightInPoints((short)11);

            // Create sheet
            Sheet sheet = workbook.createSheet("Worksheet");

            CellStyle defaultStyle = workbook.createCellStyle();
            defaultStyle.setFont(defaultFont);

            CellStyle headerStyle = workbook.createCellStyle();
            headerStyle.setFont(headerFont);

            CellStyle hintStyle = workbook.createCellStyle();
            hintStyle.setFont(hintFont);

            CellStyle importantStyle = workbook.createCellStyle();
            importantStyle.setFont(importantFont);

            CellStyle pkStyle = workbook.createCellStyle();
            pkStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            pkStyle.setFillForegroundColor(IndexedColors.BLUE_GREY.getIndex());
            pkStyle.setFont(defaultFont);

            CellStyle normalHeaderStyle = workbook.createCellStyle();
            normalHeaderStyle.setBorderTop(BorderStyle.THIN);
            normalHeaderStyle.setBorderLeft(BorderStyle.THIN);
            normalHeaderStyle.setBorderBottom(BorderStyle.THIN);
            normalHeaderStyle.setBorderRight(BorderStyle.THIN);
            normalHeaderStyle.setTopBorderColor(IndexedColors.BLACK.getIndex());
            normalHeaderStyle.setRightBorderColor(IndexedColors.BLACK.getIndex());
            normalHeaderStyle.setBottomBorderColor(IndexedColors.BLACK.getIndex());
            normalHeaderStyle.setLeftBorderColor(IndexedColors.BLACK.getIndex());
            normalHeaderStyle.setFont(defaultFont);

            CellStyle requiredHeaderStyle = workbook.createCellStyle();
            requiredHeaderStyle.setBorderTop(BorderStyle.THIN);
            requiredHeaderStyle.setBorderRight(BorderStyle.THIN);
            requiredHeaderStyle.setBorderBottom(BorderStyle.THIN);
            requiredHeaderStyle.setBorderLeft(BorderStyle.THIN);
            requiredHeaderStyle.setTopBorderColor(IndexedColors.BLACK.getIndex());
            requiredHeaderStyle.setRightBorderColor(IndexedColors.BLACK.getIndex());
            requiredHeaderStyle.setBottomBorderColor(IndexedColors.BLACK.getIndex());
            requiredHeaderStyle.setLeftBorderColor(IndexedColors.BLACK.getIndex());
            requiredHeaderStyle.setFont(requiredFont);

            // Set default style of all cells
            org.openxmlformats.schemas.spreadsheetml.x2006.main.CTCol ctCol = ((XSSFSheet)sheet).getCTWorksheet().getColsArray(0).addNewCol();
            ctCol.setMin(1);
            ctCol.setMax(16384);
            ctCol.setWidth(12.7109375);
            ctCol.setStyle(defaultStyle.getIndex());

            Row row = sheet.createRow(0);
            Cell cell = row.createCell(0);
            cell.setCellValue("단가 일괄 수정 양식");
            cell.setCellStyle(headerStyle);

            row = sheet.createRow(1);
            cell = row.createCell(0);
            cell.setCellValue("* 단가는 숫자만 입력해주세요.");
            cell.setCellStyle(hintStyle);

            row = sheet.createRow(2);
            cell = row.createCell(0);
            cell.setCellValue("* 단가를 입력하지 않으실 경우 0원으로 등록됩니다.");
            cell.setCellStyle(hintStyle);

            row = sheet.createRow(3);
            cell = row.createCell(0);
            cell.setCellValue("* 상품 고유기, 상품명, 규격(단위), 제조사(원산지) 수정시 상품 업로드를 할수 없습니다.");
            cell.setCellStyle(requiredHeaderStyle);

            row = sheet.createRow(4);
            cell = row.createCell(0);
            cell.setCellValue("* 등록되어 있는 상품 외 추가시 상품 업로드를 할수 없습니다.");
            cell.setCellStyle(requiredHeaderStyle);

            row = sheet.createRow(5);

            // Creating header
            row = sheet.createRow(6);

            cell = row.createCell(0);
            cell.setCellValue("상품 고유키(변경불가)");
            cell.setCellStyle(pkStyle);

            cell = row.createCell(1);
            cell.setCellValue("상품 카테고리 고유키(변경불가)");
            cell.setCellStyle(pkStyle);

            cell = row.createCell(2);
            cell.setCellValue("상품 코드(변경불가)");
            cell.setCellStyle(pkStyle);

            cell = row.createCell(3);
            cell.setCellValue("상품명(변경불가)");
            cell.setCellStyle(pkStyle);

            cell = row.createCell(4);
            cell.setCellValue("규격(단위)(변경불가)");
            cell.setCellStyle(pkStyle);

            cell = row.createCell(5);
            cell.setCellValue("제조사(원산지(변경불가)");
            cell.setCellStyle(pkStyle);

            cell = row.createCell(6);
            cell.setCellValue("매입단가");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(7);
            cell.setCellValue("직 배송 단가");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(8);
            cell.setCellValue("택배배송 단가");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(9);
            cell.setCellValue("기본단가");
            cell.setCellStyle(normalHeaderStyle);

//            List<PriceGroup> priceGroupList = priceGroupRepository.findAll();
//            for (int j = 0; j < priceGroupList.size(); j++) {
//                cell = row.createCell(10 + j);
//                cell.setCellValue(priceGroupList.get(j).getName());
//                cell.setCellStyle(normalHeaderStyle);
//            }

            List<Product> products = productRepository.findAll();

            for (int i = 0; i < products.size(); i++) {
                Product product = products.get(i);
                Row dataRow = sheet.createRow(i + 7);
                Cell dataCell = dataRow.createCell(0);
                dataCell.setCellValue(product.getId());
                dataCell.setCellStyle(pkStyle);

                dataCell = dataRow.createCell(1);
                Category category = product.getCategory();
                if (category != null) {
                    dataCell.setCellValue(product.getCategory().getId());
                } else {
                    dataCell.setCellValue(0);
                }
                dataCell.setCellStyle(pkStyle);

                dataCell = dataRow.createCell(2);
                dataCell.setCellValue(product.getErpCode());
                dataCell.setCellStyle(pkStyle);

                dataCell = dataRow.createCell(3);
                dataCell.setCellValue(product.getName());
                dataCell.setCellStyle(pkStyle);

                dataCell = dataRow.createCell(4);
                dataCell.setCellValue(product.getStandard() + "(" + product.getUnit() + ")");
                dataCell.setCellStyle(pkStyle);

                dataCell = dataRow.createCell(5);
                dataCell.setCellValue(product.getMakerName() + "(" + product.getCountry() + ")");
                dataCell.setCellStyle(pkStyle);

                dataCell = dataRow.createCell(6);
                dataCell.setCellValue(product.getBuyPrice());
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(7);
                dataCell.setCellValue(product.getDirectPrice());
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(8);
                dataCell.setCellValue(product.getParcelPrice());
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(9);
                dataCell.setCellValue(product.getSellPrice());
                dataCell.setCellStyle(defaultStyle);

//                for (int j = 0; j < priceGroupList.size(); j++) {
//                    dataCell = dataRow.createCell(10 + j);
//                    Set<ProductGroupPrice> groupPrices = product.getGroupPrices();
//                    for (ProductGroupPrice productGroupPrice : groupPrices) {
//                        if (productGroupPrice.getPriceGroup().getId().equals(priceGroupList.get(j).getId())) {
//                            dataCell.setCellValue(productGroupPrice.getPrice());
//                            break;
//                        }
//                    }
//                    dataCell.setCellStyle(defaultStyle);
//                }
            }

            // Making size of column auto resize to fit with data
            sheet.setColumnWidth(0, 7000);
            sheet.autoSizeColumn(1);
            sheet.autoSizeColumn(2);
            sheet.autoSizeColumn(3);
            sheet.autoSizeColumn(4);
            sheet.autoSizeColumn(5);
            sheet.autoSizeColumn(6);
            sheet.autoSizeColumn(7);
            sheet.autoSizeColumn(8);
            sheet.autoSizeColumn(9);

//            for (int j = 0; j < priceGroupList.size(); j++) {
//                sheet.autoSizeColumn(10 + j);
//            }

            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            workbook.write(outputStream);
            ByteArrayInputStream stream = new ByteArrayInputStream(outputStream.toByteArray());
            IOUtils.copy(stream, response.getOutputStream());
        } catch (IOException exception) {
            exception.printStackTrace();
        }
    }

    @PostMapping("/upload")
    @ResponseBody
    public Map<String, String> uploadExcel(@RequestParam("upload") MultipartFile file, HttpServletResponse response) {
        try {
            InputStream is = file.getInputStream();
            Workbook workbook = new XSSFWorkbook(is);
            Sheet sheet = workbook.getSheet("Worksheet");
            Iterator<Row> rows = sheet.iterator();
            List<Product> products = new ArrayList<>();
            while (rows.hasNext()) {
                Row currentRow = rows.next();

                // skip header and comments
                if (currentRow.getRowNum() < 7) {
                    continue;
                }
                Iterator<Cell> cellsInRow = currentRow.iterator();

                Product product = new Product();

                while (cellsInRow.hasNext()) {
                    Cell currentCell = cellsInRow.next();
                    int cellIdx = currentCell.getColumnIndex();
                    switch (cellIdx) {
                        case 0:
                            Optional<Product> optionalProduct = productRepository.findById((long)currentCell.getNumericCellValue());
                            if (optionalProduct.isPresent()) {
                                product = optionalProduct.get();
                            } else {
                                continue;
                            }
                            break;
                        case 6:
                            product.setBuyPrice((long) currentCell.getNumericCellValue());
                            break;
                        case 7:
                            product.setDirectPrice((long) currentCell.getNumericCellValue());
                            break;
                        case 8:
                            product.setParcelPrice((long) currentCell.getNumericCellValue());
                            break;
                        case 9:
                            product.setSellPrice((long) currentCell.getNumericCellValue());
                            break;

                        default:
                            break;
                    }
                }
                products.add(product);
            }

            productRepository.saveAll(products);
            workbook.close();

        } catch (IOException exception) {
            exception.printStackTrace();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }
}

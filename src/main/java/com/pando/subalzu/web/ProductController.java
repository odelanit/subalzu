package com.pando.subalzu.web;

import com.google.common.base.Strings;
import com.pando.subalzu.form.*;
import com.pando.subalzu.model.*;
import com.pando.subalzu.repository.*;
import com.pando.subalzu.specification.ProductSpecification;
import com.pando.subalzu.specification.SearchCriteria;
import com.pando.subalzu.validator.ProductValidator;
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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.persistence.*;
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
@RequestMapping("/products")
public class ProductController {

    @Autowired
    CategoryRepository categoryRepository;

    @Autowired
    SupplierRepository supplierRepository;

    @Autowired
    UserRepository userRepository;

    @Autowired
    ProductRepository productRepository;

    @Autowired
    PriceGroupRepository priceGroupRepository;

    @Autowired
    ProductGroupPriceRepository productGroupPriceRepository;

    @Autowired
    ProductPriceRepository productPriceRepository;

    @Autowired
    ProductRecordRepository productRecordRepository;

    @Autowired
    ProductValidator productValidator;

    @Autowired
    CompanyConfigRepository companyConfigRepository;

    @Autowired
    FixedPriceRateRepository fixedPriceRateRepository;

    @PersistenceContext
    private EntityManager em;

    @ModelAttribute("categories")
    List<Category> categories() {
        return categoryRepository.findByParentNull(Sort.by(Sort.Direction.DESC, "level"));
    }

    @ModelAttribute("suppliers")
    List<Supplier> suppliers() {
        return supplierRepository.findAll();
    }

    @ModelAttribute("priceGroups")
    List<PriceGroup> priceGroups() {
        return priceGroupRepository.findAll();
    }

    @GetMapping("")
    public String index(@ModelAttribute("form") ProductSearchForm2 form, Model model) {
        String field = form.getField();
        String keyword = form.getKeyword();
        int page = form.getPage();
        Page<Product> productPage;
        Specification<Product> spec = new ProductSpecification(new SearchCriteria(field, ":", keyword));

        String status = form.getStatus();
        if (!Strings.isNullOrEmpty(status)) {
            if (status.equalsIgnoreCase("true") || status.equalsIgnoreCase("false")) {
                spec = Specification.where(spec).and(new ProductSpecification(new SearchCriteria("status", ":", Boolean.parseBoolean(status))));
            } else {
                spec = Specification.where(spec).and(new ProductSpecification(new SearchCriteria("qty", "<", 0.0)));
            }
        }
        String deliveryType = form.getDeliveryType();
        if (!Strings.isNullOrEmpty(deliveryType)) {
            spec = Specification.where(spec).and(Specification.where(new ProductSpecification(new SearchCriteria("deliveryType", ":", Integer.parseInt(deliveryType)))).or(new ProductSpecification(new SearchCriteria("deliveryType", ":", 0))));
        }

        Category category = form.getCategory();
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
        return "product_list";
    }

    @GetMapping("/data_for_order")
    @ResponseBody
    public Map<String, Object> getProductsForOrder(ProductSearchForm form) {
        String keyword = form.getKeyword();
        Category category = form.getCategory();
        Category subcategory = form.getSubcategory();
        int deliveryType = form.getDeliveryType();
        String qs = "select p.*, pt from products p left join (select op.product_id, count(*) pt from orders left join order_products op on orders.id = op.order_id where shop_id=:shopId group by op.product_id) c on c.product_id=p.id where (name like concat('%',:keyword,'%') or erp_code like concat('%',:keyword,'%')) and (p.delivery_type=0 or p.delivery_type=:deliveryType) order by pt desc, name";
        if (category != null) {
            qs = "select p.*, pt from products p left join (select op.product_id, count(*) pt from orders left join order_products op on orders.id = op.order_id where shop_id=:shopId group by op.product_id) c on c.product_id=p.id where (name like concat('%',:keyword,'%') or erp_code like concat('%',:keyword,'%')) and (p.delivery_type=0 or p.delivery_type=:deliveryType) and p.category_id=:categoryId order by pt desc, name";
            if (subcategory != null) {
                qs = "select p.*, pt from products p left join (select op.product_id, count(*) pt from orders left join order_products op on orders.id = op.order_id where shop_id=:shopId group by op.product_id) c on c.product_id=p.id where (name like concat('%',:keyword,'%') or erp_code like concat('%',:keyword,'%')) and (p.delivery_type=0 or p.delivery_type=:deliveryType) and p.category_id=:categoryId and p.subcategory_id=:subcategoryId order by pt desc, name";
            }
        }

        Query nativeQuery = em.createNativeQuery(qs, Product.class);
        nativeQuery.setParameter("shopId", form.getShop().getId());
        nativeQuery.setParameter("keyword", keyword);
        nativeQuery.setParameter("deliveryType", deliveryType);
        if (category != null) {
            nativeQuery.setParameter("categoryId", category.getId());
            if (subcategory != null) {
                nativeQuery.setParameter("subcategoryId", subcategory.getId());
            }
        }

        String qs2 = "select p.*, pt from products p inner join (select op.product_id, count(*) pt from orders left join order_products op on orders.id = op.order_id where shop_id=:shopId group by op.product_id) c on c.product_id=p.id where p.delivery_type=0 or p.delivery_type=:deliveryType order by pt desc, name";
        Query nativeQuery2 = em.createNativeQuery(qs2, Product.class);
        nativeQuery2.setParameter("shopId", form.getShop().getId());
        nativeQuery2.setParameter("deliveryType", deliveryType);

        @SuppressWarnings("unchecked")
        List<Product> products = nativeQuery.getResultList();
        @SuppressWarnings("unchecked")
        List<Product> prevProducts = nativeQuery2.getResultList();
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        resultMap.put("products", products);
        resultMap.put("prev_products", prevProducts);
        return resultMap;
    }

    @GetMapping("/data_for_supply_order")
    @ResponseBody
    public Map<String, Object> getProducts(ProductSearchForm5 form5) {
        Long supplierId = form5.getSupplierId();
        Optional<Supplier> optionalSupplier = supplierRepository.findById(supplierId);
        Map<String, Object> resultMap = new HashMap<>();

        if (optionalSupplier.isPresent()) {
            Supplier supplier = optionalSupplier.get();
            Specification<Product> spec = new ProductSpecification(new SearchCriteria("supplier", ":", supplier));
            List<Product> products = productRepository.findAll(spec);
            resultMap.put("products", products);
        }
        resultMap.put("message", "Success");
        return resultMap;
    }

    @GetMapping("/create")
    public String create() {
        return "product_create_vue";
    }

    @GetMapping("/data_for_product")
    @ResponseBody
    public Map<String, Object> getDataForProduct() {
        Map<String, Object> resultMap = new HashMap<>();

        Optional<CompanyConfig> optionalCompanyConfig = companyConfigRepository.findByKey("use_special_price_rate");
        boolean useSpecialPriceRate = false;
        if (optionalCompanyConfig.isPresent()) {
            CompanyConfig config = optionalCompanyConfig.get();
            useSpecialPriceRate = Boolean.parseBoolean(config.getValue());
        }
        resultMap.put("use_special_price_rate", useSpecialPriceRate);

        if (useSpecialPriceRate) {
            List<FixedPriceRate> fixedPriceRates = fixedPriceRateRepository.findAll();
            resultMap.put("fixed_price_rates", fixedPriceRates);
        }

        List<Category> categories = categoryRepository.findByParentNull();
        resultMap.put("categories", categories);

        List<PriceGroup> priceGroups = priceGroupRepository.findAll();
        resultMap.put("price_groups", priceGroups);

        List<Supplier> suppliers = supplierRepository.findAll();
        resultMap.put("suppliers", suppliers);

        return resultMap;
    }

    @PostMapping("/store")
    @ResponseBody
    public Map<String, String> store(@RequestBody ProductCreationInput formData) {
        Product product = new Product();
        product.setErpCode(formData.getErpCode());
        product.setName(formData.getName());
        if (formData.getCategoryId() != null) {
            Optional<Category> optionalCategory = categoryRepository.findById(formData.getCategoryId());
            optionalCategory.ifPresent(product::setCategory);
        }
        if (formData.getSubcategoryId() != null) {
            Optional<Category> optionalSubcategory = categoryRepository.findById(formData.getSubcategoryId());
            optionalSubcategory.ifPresent(product::setSubCategory);
        }
        product.setMakerName(formData.getMakerName());
        product.setCountry(formData.getCountry());
        product.setStandard(formData.getStandard());
        product.setUnit(formData.getUnit());
        product.setTax(formData.getTax());
        product.setDeliveryType(formData.getDeliveryType());
        product.setShippingMethod(formData.getShippingMethod());
        product.setUseDecimal(formData.getUseDecimal());
        product.setImageUrl(formData.getImageUrl());
        product.setMessage(formData.getMessage());
        if (formData.getSupplierId() != null) {
            Optional<Supplier> optionalSupplier = supplierRepository.findById(formData.getSupplierId());
            optionalSupplier.ifPresent(product::setSupplier);
        }
        product.setBuyPrice(formData.getBuyPrice());
        product = productRepository.save(product);

        Set<ProductPriceInput> productPriceInputs = formData.getProductPriceInputs();
        for (ProductPriceInput productPriceInput : productPriceInputs) {
            ProductPrice productPrice = new ProductPrice();
            Optional<PriceGroup> optionalPGPrice = priceGroupRepository.findById(productPriceInput.getPriceGroupId());
            optionalPGPrice.ifPresent(productPrice::setPriceGroup);
            productPrice.setProduct(product);
            productPrice.setPrice(productPriceInput.getPrice());
            productPriceRepository.save(productPrice);
        }

        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }

    @PostMapping("/update")
    @ResponseBody
    public Map<String, String> update(@RequestBody ProductCreationInput formData) {
        Long id = formData.getId();
        Optional<Product> optionalProduct = productRepository.findById(id);
        if (optionalProduct.isPresent()) {
            Product product = optionalProduct.get();
            product.setErpCode(formData.getErpCode());
            product.setName(formData.getName());
            if (formData.getCategoryId() != null) {
                Optional<Category> optionalCategory = categoryRepository.findById(formData.getCategoryId());
                optionalCategory.ifPresent(product::setCategory);
            }
            if (formData.getSubcategoryId() != null) {
                Optional<Category> optionalSubcategory = categoryRepository.findById(formData.getSubcategoryId());
                optionalSubcategory.ifPresent(product::setSubCategory);
            }
            product.setMakerName(formData.getMakerName());
            product.setCountry(formData.getCountry());
            product.setStandard(formData.getStandard());
            product.setUnit(formData.getUnit());
            product.setTax(formData.getTax());
            product.setDeliveryType(formData.getDeliveryType());
            product.setShippingMethod(formData.getShippingMethod());
            product.setUseDecimal(formData.getUseDecimal());
            product.setImageUrl(formData.getImageUrl());
            product.setMessage(formData.getMessage());
            if (formData.getSupplierId() != null) {
                Optional<Supplier> optionalSupplier = supplierRepository.findById(formData.getSupplierId());
                optionalSupplier.ifPresent(product::setSupplier);
            }
            product.setBuyPrice(formData.getBuyPrice());
            product = productRepository.save(product);

            Set<ProductPriceInput> productPriceInputs = formData.getProductPriceInputs();
            for (ProductPriceInput productPriceInput : productPriceInputs) {
                ProductPrice productPrice = new ProductPrice();
                Optional<PriceGroup> optionalPGPrice = priceGroupRepository.findById(productPriceInput.getPriceGroupId());
                optionalPGPrice.ifPresent(productPrice::setPriceGroup);
                productPrice.setProduct(product);
                productPrice.setPrice(productPriceInput.getPrice());
                productPriceRepository.save(productPrice);
            }
        }

        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }

    @GetMapping("/{id}")
    public String edit() {
        return "product_edit_vue";
    }

    @GetMapping("/{id}/data")
    @ResponseBody
    public Map<String, Object> getProduct(@PathVariable Long id, HttpServletResponse response) {
        Optional<Product> optionalProduct = productRepository.findById(id);
        Map<String, Object> resultMap = new HashMap<>();

        List<Category> categories = categoryRepository.findByParentNull();
        resultMap.put("categories", categories);

        List<PriceGroup> priceGroups = priceGroupRepository.findAll();
        resultMap.put("price_groups", priceGroups);

        List<Supplier> suppliers = supplierRepository.findAll();
        resultMap.put("suppliers", suppliers);

        Optional<CompanyConfig> optionalCompanyConfig = companyConfigRepository.findByKey("use_special_price_rate");
        boolean useSpecialPriceRate = false;
        if (optionalCompanyConfig.isPresent()) {
            CompanyConfig config = optionalCompanyConfig.get();
            useSpecialPriceRate = Boolean.parseBoolean(config.getValue());
        }
        resultMap.put("use_special_price_rate", useSpecialPriceRate);

        if (useSpecialPriceRate) {
            List<FixedPriceRate> fixedPriceRates = fixedPriceRateRepository.findAll();
            resultMap.put("fixed_price_rates", fixedPriceRates);
        }

        if (optionalProduct.isPresent()) {
            resultMap.put("product", optionalProduct.get());

            List<ProductPrice> productPrices = productPriceRepository.findByProduct(optionalProduct.get());
            resultMap.put("productPrices", productPrices);
            return resultMap;
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return null;
        }
    }

    @PostMapping("/{id}")
    public String update(@PathVariable long id, Model model, @ModelAttribute("productForm")Product productForm, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        productValidator.validate(productForm, bindingResult);
        if (bindingResult.hasErrors()) {
            return "product_edit";
        }
        redirectAttributes.addFlashAttribute("message", "Product Updated");
        productRepository.save(productForm);
        return "redirect:/products";
    }

    @GetMapping("/create_form")
    @ResponseBody
    public void serveExcelForm(HttpServletResponse response) throws IOException {
        response.setContentType("application/octet-stream");
        String fileName = URLEncoder.encode("상품_대량등록_엑셀양식.xlsx", "UTF-8");
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
            Sheet sheet = workbook.createSheet("상품 대량 업로드 양식");

            CellStyle defaultStyle = workbook.createCellStyle();
            defaultStyle.setFont(defaultFont);

            CellStyle headerStyle = workbook.createCellStyle();
            headerStyle.setFont(headerFont);

            CellStyle hintStyle = workbook.createCellStyle();
            hintStyle.setFont(hintFont);

            CellStyle importantStyle = workbook.createCellStyle();
            importantStyle.setFont(importantFont);

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
            cell.setCellValue("상품 대량 등록 양식");
            cell.setCellStyle(headerStyle);

            row = sheet.createRow(1);
            cell = row.createCell(0);
            cell.setCellValue("* 배송유형은 번호로 입력해 주세요 ->  0: 직배송+택배배송, 1: 직배송, 2: 택배배송");
            cell.setCellStyle(hintStyle);

            row = sheet.createRow(2);
            cell = row.createCell(0);
            cell.setCellValue("* 과세여부 : 과세 상품일 경우 TRUE, 면세 상품일 경우 FALSE 으로 입력해주세요.");
            cell.setCellStyle(hintStyle);

            row = sheet.createRow(3);
            cell = row.createCell(0);
            cell.setCellValue("* 상품 카테고리 :  카테고리 설정으로 들어가 직접 등록 후, 등록하신 카테고리 명을 입력해주세요. (등록한 카테고리가 없으면 입력하지 않아도 무방 - 전체 상품으로 노출)");
            cell.setCellStyle(hintStyle);

            row = sheet.createRow(4);
            cell = row.createCell(0);
            cell.setCellValue("* ERP 상품코드는 기존 사용하던 ERP의 상품코드를 입력하면 됩니다.(상품코드가 없으면 입력하지 않아도 무방)");
            cell.setCellStyle(hintStyle);

            row = sheet.createRow(5);
            cell = row.createCell(0);
            cell.setCellValue("* 발주유형 : 수동발주일 경우 manual, 자동발주일 경우 automatic 으로 입력해주세요.");
            cell.setCellStyle(hintStyle);

            row = sheet.createRow(6);
            cell = row.createCell(0);
            cell.setCellValue("* 발주유형 : 상품을 유통사에서 매입처에 직접 발주 하는 경우(수동발주)");
            cell.setCellStyle(hintStyle);

            row = sheet.createRow(7);
            cell = row.createCell(0);
            cell.setCellValue("                거래처(가맹점)에서 매입처로 직접 주문하는 경우로 매입처가 직접 배송해주는 경우(자동발주)");
            cell.setCellStyle(hintStyle);

            row = sheet.createRow(8);
            cell = row.createCell(0);
            cell.setCellValue("* 매입처 : 매입관리로 들어가 매입처 직접 등록 후, 매입처 명을 입력해주세요.");
            cell.setCellStyle(hintStyle);

            row = sheet.createRow(9);
            cell = row.createCell(0);
            cell.setCellValue("* 수량 소수점 사용 : 상품의 수량을 소수점으로 입력 받으실 경우 true, 정수의 수량으로 입력 받으실 경우 false 으로 입력해주세요.");
            cell.setCellStyle(hintStyle);

            row = sheet.createRow(10);
            cell = row.createCell(0);
            cell.setCellValue("*상품 단가는 메뉴 단가 관리>상품 단가 일괄 적용>단가 일괄 수정을 클릭해 등록해주세요.");
            cell.setCellStyle(importantStyle);

            row = sheet.createRow(11);
            cell = row.createCell(0);
            cell.setCellValue("* (필수)를 꼭 입력해주세요. (필수) 미입력 시 상품 업로드를 할 수 없습니다.");
            cell.setCellStyle(importantStyle);

            row = sheet.createRow(12);
            cell = row.createCell(0);
            cell.setCellValue("* 상품은 16번 행부터 등록됩니다. 기존 예시 데이터는 참고만 하고 지워주세요.");
            cell.setCellStyle(importantStyle);

            row = sheet.createRow(13);

            // Creating header
            row = sheet.createRow(14);

            cell = row.createCell(0);
            cell.setCellValue("ERP상품코드");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(1);
            cell.setCellValue("상품 카테고리(1차)");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(2);
            cell.setCellValue("상품 카테고리(2차)");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(3);
            cell.setCellValue("상품명(필수)");
            cell.setCellStyle(requiredHeaderStyle);

            cell = row.createCell(4);
            cell.setCellValue("판매규격");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(5);
            cell.setCellValue("판매단위");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(6);
            cell.setCellValue("배송유형(필수)");
            cell.setCellStyle(requiredHeaderStyle);

            cell = row.createCell(7);
            cell.setCellValue("제조사");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(8);
            cell.setCellValue("원산지");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(9);
            cell.setCellValue("유통사 매입단가(필수)");
            cell.setCellStyle(requiredHeaderStyle);

            cell = row.createCell(10);
            cell.setCellValue("과세여부(필수)");
            cell.setCellStyle(requiredHeaderStyle);

            cell = row.createCell(11);
            cell.setCellValue("매입처명");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(12);
            cell.setCellValue("발주유형(필수)");
            cell.setCellStyle(requiredHeaderStyle);

            cell = row.createCell(13);
            cell.setCellValue("수량 소수점 사용(필수)");
            cell.setCellStyle(requiredHeaderStyle);

            cell = row.createCell(14);
            cell.setCellValue("기초재고량(필수)");
            cell.setCellStyle(requiredHeaderStyle);

            // Insert example data
            row = sheet.createRow(15);
            cell = row.createCell(0);
            cell.setCellValue("PD123123");
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(1);
            cell.setCellValue("농산물");
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(2);
            cell.setCellValue("채소류");
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(3);
            cell.setCellValue("상품명1");
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(4);
            cell.setCellValue("1.3kg");
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(5);
            cell.setCellValue("개");
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(6);
            cell.setCellValue(1);
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(7);
            cell.setCellValue("(주)농심");
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(8);
            cell.setCellValue("대한민국");
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(9);
            cell.setCellValue(5000);
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(10);
            cell.setCellValue(false);
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(11);
            cell.setCellValue("길동수산");
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(12);
            cell.setCellValue("automatic");
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(13);
            cell.setCellValue(false);
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(14);
            cell.setCellValue(0);
            cell.setCellStyle(defaultStyle);

            // example data 2
            row = sheet.createRow(16);

            cell = row.createCell(0);
            cell.setCellValue("123124");
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(1);
            cell.setCellValue("어류");
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(2);
            cell.setCellValue("");
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(3);
            cell.setCellValue("상품명2");
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(4);
            cell.setCellValue("1.3kg");
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(5);
            cell.setCellValue("개");
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(6);
            cell.setCellValue(2);
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(7);
            cell.setCellValue("(주)농심");
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(8);
            cell.setCellValue("대한민국");
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(9);
            cell.setCellValue(2000);
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(10);
            cell.setCellValue(true);
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(11);
            cell.setCellValue("길동수산");
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(12);
            cell.setCellValue("manual");
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(13);
            cell.setCellValue(true);
            cell.setCellStyle(defaultStyle);

            cell = row.createCell(14);
            cell.setCellValue(0);
            cell.setCellStyle(defaultStyle);

            // Making size of column auto resize to fit with data
            sheet.setColumnWidth(0, 5000);
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
            sheet.autoSizeColumn(13);
            sheet.autoSizeColumn(14);

            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            workbook.write(outputStream);
            ByteArrayInputStream stream = new ByteArrayInputStream(outputStream.toByteArray());
            IOUtils.copy(stream, response.getOutputStream());
        } catch (IOException exception) {
            exception.printStackTrace();
        }
    }

    @GetMapping("/edit_form")
    @ResponseBody
    public void downloadEditForm(HttpServletResponse response) throws IOException {
        response.setContentType("application/octet-stream");
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");
        LocalDateTime now = LocalDateTime.now();
        String fileName = URLEncoder.encode("상품_일괄수정_엑셀양식_" + dtf.format(now) + ".xlsx", "UTF-8");
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
            cell.setCellValue("상품 일괄 수정 양식");
            cell.setCellStyle(headerStyle);

            row = sheet.createRow(1);
            cell = row.createCell(0);
            cell.setCellValue("* 배송유형은 번호로 입력해 주세요 -> 0: 직배송+택배배송, 1: 직배송, 2: 택배배송, ");
            cell.setCellStyle(hintStyle);

            row = sheet.createRow(2);
            cell = row.createCell(0);
            cell.setCellValue("* 과세여부 : 과세 상품일 경우 true, 면세 상품일 경우 false 으로 입력해주세요.");
            cell.setCellStyle(hintStyle);

            row = sheet.createRow(3);
            cell = row.createCell(0);
            cell.setCellValue("* 상품 카테고리 :  카테고리 설정으로 들어가 직접 등록 후, 등록하신 카테고리 명을 입력해주세요. (등록한 카테고리가 없으면 입력하지 않아도 무방 - 전체 상품으로 노출)");
            cell.setCellStyle(hintStyle);

            row = sheet.createRow(4);
            cell = row.createCell(0);
            cell.setCellValue("* ERP 상품코드는 기존 사용하던 ERP의 상품코드를 입력하면 됩니다.(상품코드가 없으면 입력하지 않아도 무방)");
            cell.setCellStyle(hintStyle);

            row = sheet.createRow(5);
            cell = row.createCell(0);
            cell.setCellValue("* 발주유형 : 수동발주일 경우 manual, 자동발주일 경우 automatic 으로 입력해주세요.");
            cell.setCellStyle(hintStyle);

            row = sheet.createRow(6);
            cell = row.createCell(0);
            cell.setCellValue("* 발주유형 : 상품을 유통사에서 매입처에 직접 발주 하는 경우(수동발주)");
            cell.setCellStyle(hintStyle);

            row = sheet.createRow(7);
            cell = row.createCell(0);
            cell.setCellValue("                거래처(가맹점)에서 매입처로 직접 주문하는 경우로 매입처가 직접 배송해주는 경우(자동발주)");
            cell.setCellStyle(hintStyle);

            row = sheet.createRow(8);
            cell = row.createCell(0);
            cell.setCellValue("* 매입처 : 매입관리로 들어가 매입처 직접 등록 후, 매입처 명을 입력해주세요.");
            cell.setCellStyle(hintStyle);

            row = sheet.createRow(9);
            cell = row.createCell(0);
            cell.setCellValue("* 수량 소수점 사용 : 상품의 수량을 소수점으로 입력 받으실 경우 true, 정수의 수량으로 입력 받으실 경우 false 으로 입력해주세요.");
            cell.setCellStyle(hintStyle);

            row = sheet.createRow(10);
            cell = row.createCell(0);
            cell.setCellValue("*상품 단가는 메뉴 단가 관리>상품 단가 일괄 적용>단가 일괄 수정을 클릭해 등록해주세요.");
            cell.setCellStyle(importantStyle);

            row = sheet.createRow(11);
            cell = row.createCell(0);
            cell.setCellValue("* (필수)를 꼭 입력해주세요. (필수) 미입력 시 상품 업로드를 할 수 없습니다.");
            cell.setCellStyle(importantStyle);

            row = sheet.createRow(12);
            cell = row.createCell(0);
            cell.setCellValue("* 상품 고유키 수정, 삭제, 추가 시 상품 업로드를 할수 없습니다.");
            cell.setCellStyle(importantStyle);

            row = sheet.createRow(13);
            cell = row.createCell(0);
            cell.setCellValue("* 등록 되어 있는 상품을 삭제 및 추가 시 상품업로드를 할수 없습니다.");
            cell.setCellStyle(importantStyle);

            row = sheet.createRow(14);

            // Creating header
            row = sheet.createRow(15);

            cell = row.createCell(0);
            cell.setCellValue("상품 고유키(변경불가)");
            cell.setCellStyle(pkStyle);

            cell = row.createCell(1);
            cell.setCellValue("ERP상품코드");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(2);
            cell.setCellValue("상품 카테고리(1차)");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(3);
            cell.setCellValue("상품 카테고리(2차)");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(4);
            cell.setCellValue("상품명(필수)");
            cell.setCellStyle(requiredHeaderStyle);

            cell = row.createCell(5);
            cell.setCellValue("판매규격");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(6);
            cell.setCellValue("판매단위");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(7);
            cell.setCellValue("배송유형(필수)");
            cell.setCellStyle(requiredHeaderStyle);

            cell = row.createCell(8);
            cell.setCellValue("제조사");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(9);
            cell.setCellValue("원산지");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(10);
            cell.setCellValue("유통사 매입단가(필수)");
            cell.setCellStyle(requiredHeaderStyle);

            cell = row.createCell(11);
            cell.setCellValue("과세여부(필수)");
            cell.setCellStyle(requiredHeaderStyle);

            cell = row.createCell(12);
            cell.setCellValue("매입처명");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(13);
            cell.setCellValue("발주유형(필수)");
            cell.setCellStyle(requiredHeaderStyle);

            cell = row.createCell(14);
            cell.setCellValue("수량 소수점 사용(필수)");
            cell.setCellStyle(requiredHeaderStyle);

            cell = row.createCell(15);
            cell.setCellValue("판매여부(필수)");
            cell.setCellStyle(requiredHeaderStyle);

            List<Product> products = productRepository.findAll();

            for (int i = 0; i < products.size(); i++) {
                Product product = products.get(i);
                Row dataRow = sheet.createRow(i + 16);
                Cell dataCell = dataRow.createCell(0);
                dataCell.setCellValue(product.getId());
                dataCell.setCellStyle(pkStyle);

                dataCell = dataRow.createCell(1);
                dataCell.setCellValue(product.getErpCode());
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(2);
                if (product.getCategory() != null) {
                    dataCell.setCellValue(product.getCategory().getName());
                }
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(3);
                if (product.getSubCategory() != null) {
                    dataCell.setCellValue(product.getSubCategory().getName());
                }
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(4);
                dataCell.setCellValue(product.getName());
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(5);
                dataCell.setCellValue(product.getStandard());
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(6);
                dataCell.setCellValue(product.getUnit());
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(7);
                dataCell.setCellValue(product.getDeliveryType());
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(8);
                dataCell.setCellValue(product.getMakerName());
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(9);
                dataCell.setCellValue(product.getCountry());
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(10);
                dataCell.setCellValue(product.getBuyPrice());
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(11);
                dataCell.setCellValue(product.getTax());
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(12);
                if (product.getSupplier() != null) {
                    dataCell.setCellValue(product.getSupplier().getName());
                }
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(13);
                dataCell.setCellValue(product.getShippingMethod());
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(14);
                dataCell.setCellValue(product.getUseDecimal());
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(15);
                dataCell.setCellValue(product.getStatus());
                dataCell.setCellStyle(defaultStyle);
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
            sheet.autoSizeColumn(10);
            sheet.autoSizeColumn(11);
            sheet.autoSizeColumn(12);
            sheet.autoSizeColumn(13);
            sheet.autoSizeColumn(14);
            sheet.autoSizeColumn(15);

            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            workbook.write(outputStream);
            ByteArrayInputStream stream = new ByteArrayInputStream(outputStream.toByteArray());
            IOUtils.copy(stream, response.getOutputStream());
        } catch (IOException exception) {
            exception.printStackTrace();
        }
    }


    @PostMapping("/upload_create_file")
    @ResponseBody
    public Map<String, String> uploadFile(@RequestParam("upload") MultipartFile file, Principal principal, HttpServletResponse response) {
        try {
            InputStream is = file.getInputStream();
            Workbook workbook = new XSSFWorkbook(is);
            Sheet sheet = workbook.getSheet("상품 대량 업로드 양식");
            Iterator<Row> rows = sheet.iterator();
            while (rows.hasNext()) {
                Row currentRow = rows.next();

                // skip header and comments
                if (currentRow.getRowNum() < 15) {
                    continue;
                }
                Iterator<Cell> cellsInRow = currentRow.iterator();

                Product product = new Product();

                while (cellsInRow.hasNext()) {
                    Cell currentCell = cellsInRow.next();
                    int cellIdx = currentCell.getColumnIndex();
                    switch (cellIdx) {
                        case 0:
                            currentCell.setCellType(CellType.STRING);
                            product.setErpCode(currentCell.getStringCellValue());
                            break;
                        case 1: // category
                            currentCell.setCellType(CellType.STRING);
                            String categoryName = currentCell.getStringCellValue();
                            Optional<Category> optionalCategory = categoryRepository.findByName(categoryName);
                            if (optionalCategory.isPresent()) {
                                Category category = optionalCategory.get();
                                product.setCategory(category);
                            } else {
                                product.setCategory(null);
                            }
                            break;
                        case 2: // subcategory
                            currentCell.setCellType(CellType.STRING);
                            String subcategoryName = currentCell.getStringCellValue();
                            Optional<Category> optionalCategory1 = categoryRepository.findByName(subcategoryName);
                            if (optionalCategory1.isPresent()) {
                                Category category = optionalCategory1.get();
                                product.setSubCategory(category);
                            } else {
                                product.setSubCategory(null);
                            }
                            break;
                        case 3:
                            currentCell.setCellType(CellType.STRING);
                            product.setName(currentCell.getStringCellValue());
                            break;
                        case 4:
                            currentCell.setCellType(CellType.STRING);
                            product.setStandard(currentCell.getStringCellValue());
                            break;
                        case 5:
                            currentCell.setCellType(CellType.STRING);
                            product.setUnit(currentCell.getStringCellValue());
                            break;
                        case 6: // delivery type
                            currentCell.setCellType(CellType.NUMERIC);
                            int deliveryType = (int)currentCell.getNumericCellValue();
                            if (deliveryType != 1 && deliveryType != 2 && deliveryType != 0) deliveryType = 0;
                            product.setDeliveryType(deliveryType);
                            break;
                        case 7:
                            currentCell.setCellType(CellType.STRING);
                            product.setMakerName(currentCell.getStringCellValue());
                            break;
                        case 8:
                            currentCell.setCellType(CellType.STRING);
                            product.setCountry(currentCell.getStringCellValue());
                            break;
                        case 9:
                            product.setBuyPrice((long)currentCell.getNumericCellValue());
                            break;
                        case 10:
                            currentCell.setCellType(CellType.BOOLEAN);
                            product.setTax(currentCell.getBooleanCellValue());
                            break;
                        case 11: // supplier
                            String supplierName = currentCell.getStringCellValue();
                            Optional<Supplier> optionalSupplier = supplierRepository.findByName(supplierName);
                            if (optionalSupplier.isPresent()) {
                                Supplier supplier = optionalSupplier.get();
                                product.setSupplier(supplier);
                            } else {
                                product.setSupplier(null);
                            }
                            break;
                        case 12:
                            product.setShippingMethod(currentCell.getStringCellValue());
                            break;
                        case 13:
                            product.setUseDecimal(currentCell.getBooleanCellValue());
                            break;
                        case 14:
                            product.setQty((int)currentCell.getNumericCellValue());
                            break;
                        default:
                            break;
                    }
                }
                product = productRepository.save(product);
                if (product.getQty() > 0) {
                    ProductRecord productRecord = new ProductRecord();
                    productRecord.setAction("manual_input");
                    productRecord.setProduct(product);
                    productRecord.setDiff(product.getQty());
                    productRecord.setQty(product.getQty());
                    Optional<User> optionalUser = userRepository.findByUsername(principal.getName());
                    optionalUser.ifPresent(productRecord::setUser);
                    productRecordRepository.save(productRecord);
                }

            }

            workbook.close();
        } catch (IOException exception) {
            exception.printStackTrace();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }

    @PostMapping("/upload_edit_file")
    @ResponseBody
    public Map<String, String> editFromFile(@RequestParam("upload") MultipartFile file, HttpServletResponse response) {
        try {
            InputStream is = file.getInputStream();
            Workbook workbook = new XSSFWorkbook(is);
            Sheet sheet = workbook.getSheet("Worksheet");
            Iterator<Row> rows = sheet.iterator();
            List<Product> products = new ArrayList<>();
            while (rows.hasNext()) {
                Row currentRow = rows.next();

                // skip header and comments
                if (currentRow.getRowNum() < 16) {
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
                        case 1:
                            product.setErpCode(currentCell.getStringCellValue());
                            break;
                        case 2: // category
                            String categoryName = currentCell.getStringCellValue();
                            Optional<Category> optionalCategory = categoryRepository.findByName(categoryName);
                            if (optionalCategory.isPresent()) {
                                Category category = optionalCategory.get();
                                product.setCategory(category);
                            } else {
                                product.setCategory(null);
                            }
                            break;
                        case 3: // subcategory
                            String subcategoryName = currentCell.getStringCellValue();
                            Optional<Category> optionalCategory1 = categoryRepository.findByName(subcategoryName);
                            if (optionalCategory1.isPresent()) {
                                Category category = optionalCategory1.get();
                                product.setSubCategory(category);
                            } else {
                                product.setSubCategory(null);
                            }
                            break;
                        case 4:
                            product.setName(currentCell.getStringCellValue());
                            break;
                        case 5:
                            product.setStandard(currentCell.getStringCellValue());
                            break;
                        case 6:
                            product.setUnit(currentCell.getStringCellValue());
                            break;
                        case 7: // delivery type
                            int deliveryType = (int)currentCell.getNumericCellValue();
                            if (deliveryType < 0 || deliveryType > 2)
                                product.setDeliveryType(0);
                            product.setDeliveryType(deliveryType);
                            break;
                        case 8:
                            product.setMakerName(currentCell.getStringCellValue());
                            break;
                        case 9:
                            product.setCountry(currentCell.getStringCellValue());
                            break;
                        case 10:
                            product.setBuyPrice((long)currentCell.getNumericCellValue());
                            break;
                        case 11:
                            product.setTax(currentCell.getBooleanCellValue());
                            break;
                        case 12: // supplier
                            String supplierName = currentCell.getStringCellValue();
                            Optional<Supplier> optionalSupplier = supplierRepository.findByName(supplierName);
                            if (optionalSupplier.isPresent()) {
                                Supplier supplier = optionalSupplier.get();
                                product.setSupplier(supplier);
                            } else {
                                product.setSupplier(null);
                            }
                            break;
                        case 13:
                            product.setShippingMethod(currentCell.getStringCellValue());
                            break;
                        case 14:
                            product.setUseDecimal(currentCell.getBooleanCellValue());
                            break;
                        case 15:
                            product.setStatus(currentCell.getBooleanCellValue());
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

    @PostMapping("/change_status")
    @ResponseBody
    public Map<String, String> changeStatus(@RequestParam("ids[]")List<Long> ids, @RequestParam("action") boolean action) {
        Map<String, String> resultMap = new HashMap<>();
        List<Product> products = productRepository.findAllById(ids);
        for (Product product: products) {
            product.setStatus(action);
        }
        productRepository.saveAll(products);
        resultMap.put("message", "판매처리 완료됐습니다.");
        return resultMap;
    }

    @PostMapping("/delete")
    @ResponseBody
    public Map<String, String> deleteProducts(@RequestParam("ids[]")List<Long> ids) {
        Map<String, String> resultMap = new HashMap<>();
        List<Product> products = productRepository.findAllById(ids);
        productRepository.deleteAll(products);
        resultMap.put("message", "삭제처리 완료됐습니다.");
        return resultMap;
    }

    @PostMapping("/change_qty")
    @ResponseBody
    public Map<String, String> changeQty(ProductRecord productRecord, Principal principal) {
        Product product = productRecord.getProduct();
        String action = productRecord.getAction();
        double previousQty = product.getQty();

        if (action.contains("input")) {
            product.setQty(previousQty + productRecord.getDiff());
        } else if (action.contains("output")) {
            product.setQty(previousQty - productRecord.getDiff());
        }

        product = productRepository.save(product);

        Optional<User> optionalUser = userRepository.findByUsername(principal.getName());
        optionalUser.ifPresent(productRecord::setUser);
        productRecord.setQty(product.getQty());
        productRecordRepository.save(productRecord);

        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "재고값 변경이 완료되었습니다.");
        return resultMap;
    }

    @PostMapping("/change_qty_all")
    @ResponseBody
    public Map<String, String> changeQtyAll(@RequestBody List<Map<String, Object>> productRecords, Principal principal) {
        for (Map<String, Object> recordMap: productRecords) {
            Long productId = Long.parseLong((String) recordMap.get("product"));
            double diff = Double.parseDouble((String) recordMap.get("diff")) ;
            String action = (String) recordMap.get("action");
            ProductRecord productRecord = new ProductRecord();
            Optional<Product> optionalProduct = productRepository.findById(productId);
            if (optionalProduct.isPresent()) {

                Product product = optionalProduct.get();

                productRecord.setProduct(product);
                productRecord.setAction(action);
                productRecord.setDiff(diff);

                double previousQty = product.getQty();

                if (action.contains("input")) {
                    product.setQty(previousQty + productRecord.getDiff());
                } else if (action.contains("output")) {
                    product.setQty(previousQty - productRecord.getDiff());
                }

                productRepository.save(product);

                Optional<User> optionalUser = userRepository.findByUsername(principal.getName());
                optionalUser.ifPresent(productRecord::setUser);
                productRecord.setQty(previousQty);
                productRecordRepository.save(productRecord);
            }

        }

        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "재고값 변경이 완료되었습니다.");
        return resultMap;
    }

    @GetMapping("/get_data")
    @ResponseBody
    public Map<String, Object> getData(ProductSearchForm form) {
        Map<String, Object> resultMap = new HashMap<>();
        Specification<Product> spec = new ProductSpecification(new SearchCriteria("name", ":", form.getKeyword()));
        spec = Specification.where(spec).or(new ProductSpecification(new SearchCriteria("erpCode", ":", form.getKeyword())));
        List<Product> products = productRepository.findAll(spec);
        resultMap.put("products", products);
        resultMap.put("message", "Success");
        return resultMap;
    }
}

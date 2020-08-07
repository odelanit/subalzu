package com.pando.subalzu.web;

import com.google.common.base.Strings;
import com.pando.subalzu.form.OrderSearchForm;
import com.pando.subalzu.form.ShopSearchForm3;
import com.pando.subalzu.model.*;
import com.pando.subalzu.repository.*;
import com.pando.subalzu.specification.OrderSpecification;
import com.pando.subalzu.specification.SearchCriteria;
import com.pando.subalzu.specification.ShopSpecification;
import com.pando.subalzu.validator.ShopValidator;
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
import org.springframework.data.util.Pair;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
@RequestMapping("/shops")
public class ShopController {
    @Autowired
    ShopRepository clientRepository;

    @Autowired
    BusinessRepository businessRepository;

    @Autowired
    UserRepository userRepository;

    @Autowired
    ShopOwnerRepository shopOwnerRepository;

    @Autowired
    PriceGroupRepository priceGroupRepository;

    @Autowired
    ShopGradeRepository shopGradeRepository;

    @Autowired
    AssigneeTypeRepository assigneeTypeRepository;

    @Autowired
    OrderRepository orderRepository;

    @Autowired
    ShopRepository shopRepository;

    @Autowired
    ShopValidator shopValidator;

    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private PermissionRepository permissionsRepository;

    @ModelAttribute("businesses")
    List<Business> businessList() {
        return businessRepository.findAll();
    }

    @ModelAttribute("deliverers")
    List<User> delivererList() {
        return userRepository.findByRoleName("deliverer");
    }

    @ModelAttribute("salesMans")
    List<User> salesManList() {
        return userRepository.findByRoleName("sales");
    }

    @ModelAttribute("priceGroups")
    List<PriceGroup> priceGroupList() {
        return priceGroupRepository.findAll();
    }

    @ModelAttribute("shopGrades")
    List<ShopGrade> shopGradeList() {
        return shopGradeRepository.findAll();
    }

    @ModelAttribute("assigneeTypes")
    List<AssigneeType> assigneeTypeList() {
        return assigneeTypeRepository.findAll();
    }

    @ModelAttribute("localDateTimeFormat")
    DateTimeFormatter localDateTimeFormat() {
        return DateTimeFormatter.ofPattern("yyyy-MM-dd");
    }

    @GetMapping("")
    public String index(@ModelAttribute("form") ShopSearchForm3 form, Model model) {
        Page<Shop> shopPage;
        String field = form.getField();
        String keyword = form.getKeyword();
        String deliveryType = form.getDeliveryType();
        User deliverer = form.getDeliverer();
        User salesman = form.getSalesman();
        String dealStatus = form.getDealStatus();
        int page = form.getPage();

        Specification<Shop> spec = new ShopSpecification(new SearchCriteria(field, ":", keyword));
        if (!Strings.isNullOrEmpty(deliveryType)) {
            spec = Specification.where(spec).and(Specification.where(new ShopSpecification(new SearchCriteria("deliveryType", ":", Integer.parseInt(deliveryType)))).or(new ShopSpecification(new SearchCriteria("deliveryType", ":", 0))));
        }
        if (deliverer != null) {
            spec = Specification.where(spec).and(new ShopSpecification(new SearchCriteria("deliverer", ":", deliverer)));
        }
        if (salesman != null) {
            spec = Specification.where(spec).and(new ShopSpecification(new SearchCriteria("salesman", ":", salesman)));
        }
        if (!Strings.isNullOrEmpty(dealStatus)) {
            spec = Specification.where(spec).and(new ShopSpecification(new SearchCriteria("dealStatus", ":", Boolean.parseBoolean(dealStatus))));
        }

        Pageable pageable = PageRequest.of(page - 1, 50, Sort.by("createdAt").descending());
        shopPage = shopRepository.findAll(spec, pageable);
        List<Shop> shops = shopPage.getContent();

        model.addAttribute("shopPage", shopPage);
        model.addAttribute("currentPage", page);
        model.addAttribute("shops", shops);

        return "shop_list";
    }

    @GetMapping("/get_shops")
    @ResponseBody
    public Map<String, Object> getShops(@RequestParam("keyword") String keyword) {
        Map<String, Object> resultMap = new HashMap<>();
        Specification<Shop> spec = new ShopSpecification(new SearchCriteria("name", ":", keyword));
        spec = Specification.where(spec).and(new ShopSpecification(new SearchCriteria("dealStatus", ":", true)));
        List<Shop> shops = shopRepository.findAll(spec);
        resultMap.put("shops", shops);
        resultMap.put("message", "Success");
        return resultMap;
    }

    @GetMapping("/create")
    public String create(Model model) {
        model.addAttribute("shopForm", new Shop());
        return "shop_create";
    }

    @PostMapping("/create")
    public String store(@ModelAttribute("shopForm")Shop shopForm, BindingResult bindingResult, Model model) {
        shopValidator.validate(shopForm, bindingResult);
        if (bindingResult.hasErrors()) {
            return "shop_create";
        }

        String username = shopForm.getOwnerUsername();
        ShopOwner shopOwner = new ShopOwner();
        shopOwner.setFullName(shopForm.getOwnerFullname());
        shopOwner.setUsername(username);
        shopOwner.setPhone(shopForm.getOwnerPhone());
        shopOwner.setPassword(bCryptPasswordEncoder.encode(username));
        ShopOwner savedUser = shopOwnerRepository.save(shopOwner);
        shopForm.setShopOwner(savedUser);
        shopRepository.save(shopForm);
        model.addAttribute("success", true);
        return "shop_create";
    }

    @GetMapping("/{id}")
    public String show(@ModelAttribute("form") OrderSearchForm form, Model model, @PathVariable Long id) throws ParseException {
        Optional<Shop> optionalShop = shopRepository.findById(id);
        if (optionalShop.isPresent()) {
            Shop shop = optionalShop.get();
            String field = form.getField();
            String keyword = form.getKeyword();
            String dateField = form.getDateField();
            String strDateFrom = form.getDateFrom();
            String strDateTo = form.getDateTo();
            int page = form.getPage();

            Page<Order> orderPage;
            Specification<Order> spec = new OrderSpecification(new SearchCriteria("shop", ":", shop));
            spec = Specification.where(spec).and(new OrderSpecification(new SearchCriteria(field, ":", keyword)));
            if (!Strings.isNullOrEmpty(strDateFrom) && !Strings.isNullOrEmpty(strDateTo)) {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                LocalDateTime dateFrom = LocalDate.parse(strDateFrom, formatter).atStartOfDay();
                LocalDateTime dateTo = LocalDate.parse(strDateTo, formatter).atTime(23, 59, 59);
                Pair<LocalDateTime, LocalDateTime> dateTimePair = Pair.of(dateFrom, dateTo);
                spec = Specification.where(spec).and(new OrderSpecification(new SearchCriteria(dateField, "<>", dateTimePair)));
            }
            Pageable pageable = PageRequest.of(page - 1, 50, Sort.by("createdAt").descending());
            orderPage = orderRepository.findAll(spec, pageable);
            List<Order> orders = orderPage.getContent();

            model.addAttribute("orderPage", orderPage);
            model.addAttribute("orders", orders);
            model.addAttribute("currentPage", page);
            model.addAttribute("localDateTimeFormat", DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss"));
            model.addAttribute("localDateTimeFormat2", DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            return "shop_show";
        } else {
            return "redirect:/shops";
        }
    }

    @GetMapping("/{id}/edit")
    public String edit(Model model, @PathVariable Long id) {
        Optional<Shop> optionalShop = shopRepository.findById(id);
        if (optionalShop.isPresent()) {
            Shop shop = optionalShop.get();
            shop.setOwnerUsername(shop.getShopOwner().getUsername());
            shop.setOwnerFullname(shop.getShopOwner().getFullName());
            shop.setOwnerPhone(shop.getShopOwner().getPhone());
            model.addAttribute("shopForm", shop);
            return "shop_edit";
        } else {
            return "redirect:/shops";
        }
    }

    @PostMapping("/{id}/edit")
    public String update(@PathVariable Long id, @ModelAttribute("shopForm") Shop shopForm, BindingResult bindingResult, Model model, RedirectAttributes redirectAttributes) {
        Optional<Shop> optionalShop = shopRepository.findById(id);
        if (optionalShop.isPresent()) {
            shopValidator.validate(shopForm, bindingResult);
            if (bindingResult.hasErrors()) {
                return "shop_edit";
            }
            String ownerFullname = shopForm.getOwnerFullname();
            String ownerPhone = shopForm.getOwnerPhone();

            ShopOwner shopOwner = shopForm.getShopOwner();
            shopOwner.setFullName(ownerFullname);
            shopOwner.setPhone(ownerPhone);
            shopOwnerRepository.save(shopOwner);

            shopRepository.save(shopForm);
            redirectAttributes.addFlashAttribute("message", "Shop Updated");
        }
        return "redirect:/shops";
    }

    @PostMapping("/update_status")
    @ResponseBody
    public Map<String, String> updateStatus(@RequestParam("id") Long id, @RequestParam("action") String action) {
        Optional<Shop> shopOptional = shopRepository.findById(id);
        if (shopOptional.isPresent()) {
            Shop shop = shopOptional.get();
            if (action.equalsIgnoreCase("stop")) {
                shop.setDealStatus(false);
                shop.setStoppedAt(LocalDateTime.now());
            } else if (action.equalsIgnoreCase("start")) {
                shop.setDealStatus(true);
                shop.setStoppedAt(null);
            }
            shopRepository.save(shop);
        }
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }

    @PostMapping("/reset_owner_password")
    @ResponseBody
    public Map<String, String> resetOwnerPassword(@RequestParam("id") Long id) {
        Optional<Shop> optionalShop = shopRepository.findById(id);
        if (optionalShop.isPresent()) {
            Shop shop = optionalShop.get();
            ShopOwner owner = shop.getShopOwner();
            owner.setPassword(bCryptPasswordEncoder.encode(owner.getUsername()));
            shopOwnerRepository.save(owner);
        }
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }

    @GetMapping("/download_edit_form")
    @ResponseBody
    public void downloadEditForm(HttpServletResponse response) throws IOException {
        response.setContentType("application/octet-stream");
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");
        LocalDateTime now = LocalDateTime.now();
        String fileName = URLEncoder.encode("거래처_일괄수정_엑셀양식" + dtf.format(now) + ".xlsx", "UTF-8");
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
            cell.setCellValue("거래처 일괄 수정 양식");
            cell.setCellStyle(headerStyle);

            row = sheet.createRow(1);

            row = sheet.createRow(2);
            cell = row.createCell(0);
            cell.setCellValue("* 거래처 업종: 한식, 중식, 일식, 수산물, 분식, 닭/오리, 양식, 패스트푸드, 제빵 유흥분점, 퓨전요리, 커피/음료, 음식배달, 뷔페, 기타음식점 중 하나 택일.");
            cell.setCellStyle(hintStyle);

            row = sheet.createRow(3);
            cell = row.createCell(0);
            cell.setCellValue("* 거래처명은 유통업체(도매점/프랜차이즈 본사)에서 거래처를 지칭할 때 사용하는 이름입니다. 거래처(업소) 주점에게 거래처명이 노출되니 신경 써서 입력해야 합니다.");
            cell.setCellStyle(hintStyle);

            row = sheet.createRow(4);
            cell = row.createCell(0);
            cell.setCellValue("* ERP 거래처코드는 기존 사용하시던 ERP의 거래처코드를 입력하면 됩니다. (거래처코드가 없으면 입력하지 않아도 무방)");
            cell.setCellStyle(hintStyle);

            row = sheet.createRow(5);
            cell = row.createCell(0);
            cell.setCellValue("* 배송유형은 번호로 입력해 주세요 -> 0: 직배송+택배배송, 1: 직배송, 2: 택배배송, 입력하지 않는 경우 \"전체(직배송 + 택배배송)\"로 등록됩니다.");
            cell.setCellStyle(hintStyle);

            row = sheet.createRow(6);
            cell = row.createCell(0);
            cell.setCellValue("* 단가 속성명은 메뉴 단가 관리 > 단가 속성 관리에서 단가 속성명 등록 후 기재해주세요. (단가 속성의 금액은 상품 관리 페이지에서 상품별로 입력해주셔야 합니다.)");
            cell.setCellStyle(hintStyle);

            row = sheet.createRow(7);
            cell = row.createCell(0);
            cell.setCellValue("* (필수)를 꼭 입력해주세요. (필수) 미입력 시 거래처 업로드를 할 수 없습니다.");
            cell.setCellStyle(importantStyle);

            row = sheet.createRow(8);
            cell = row.createCell(0);
            cell.setCellValue("* 거래처 고유키 수정, 삭제, 추가 시 상품 업로드를 할수 없습니다.");
            cell.setCellStyle(importantStyle);

            row = sheet.createRow(9);

            // Creating header
            row = sheet.createRow(10);

            cell = row.createCell(0);
            cell.setCellValue("거래 고유키(변경불가)");
            cell.setCellStyle(pkStyle);

            cell = row.createCell(1);
            cell.setCellValue("거래처 업종");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(2);
            cell.setCellValue("거래처 명(필수)");
            cell.setCellStyle(requiredHeaderStyle);

            cell = row.createCell(3);
            cell.setCellValue("ERP거래처코드");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(4);
            cell.setCellValue("배송 유형");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(5);
            cell.setCellValue("거래처 담당자");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(6);
            cell.setCellValue("거래처 담당자 휴대폰");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(7);
            cell.setCellValue("우편번호(배송지)");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(8);
            cell.setCellValue("배송지 주소(기본)");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(9);
            cell.setCellValue("배송지 주소(상세)");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(10);
            cell.setCellValue("유통사배송직원아이디(필수)");
            cell.setCellStyle(requiredHeaderStyle);

            cell = row.createCell(11);
            cell.setCellValue("유통사영업직원아이디");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(12);
            cell.setCellValue("거래처 이메일");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(13);
            cell.setCellValue("팩스 번호");
            cell.setCellStyle(normalHeaderStyle);

            cell = row.createCell(14);
            cell.setCellValue("단가 속성 명");
            cell.setCellStyle(normalHeaderStyle);

            int rowNum = 11;

            List<Shop> shops = shopRepository.findAll();
            for (Shop shop: shops) {
                Row dataRow = sheet.createRow(rowNum);
                Cell dataCell = dataRow.createCell(0);
                dataCell.setCellValue(shop.getId());
                dataCell.setCellStyle(pkStyle);

                dataCell = dataRow.createCell(1);
                if (shop.getBusiness() != null) {
                    dataCell.setCellValue(shop.getBusiness().getName());
                }
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(2);
                dataCell.setCellValue(shop.getName());
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(3);
                dataCell.setCellValue(shop.getErpCode());
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(4);
                dataCell.setCellValue(shop.getDeliveryType());
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(5);
                dataCell.setCellValue(shop.getShopOwner().getUsername());
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(6);
                dataCell.setCellValue(shop.getShopOwner().getPhone());
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(7);
                dataCell.setCellValue(shop.getZipCode());
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(8);
                dataCell.setCellValue(shop.getAddressLine1());
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(9);
                dataCell.setCellValue(shop.getAddressLine2());
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(10);
                dataCell.setCellValue(shop.getDeliverer().getUsername());
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(11);
                if (shop.getSalesman() != null) {
                    dataCell.setCellValue(shop.getSalesman().getUsername());
                }
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(12);
                dataCell.setCellValue(shop.getEmail());
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(13);
                dataCell.setCellValue(shop.getFax());
                dataCell.setCellStyle(defaultStyle);

                dataCell = dataRow.createCell(14);
                if (shop.getPriceGroup() != null) {
                    dataCell.setCellValue(shop.getPriceGroup().getName());
                }
                dataCell.setCellStyle(defaultStyle);

                rowNum++;
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

            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            workbook.write(outputStream);
            ByteArrayInputStream stream = new ByteArrayInputStream(outputStream.toByteArray());
            IOUtils.copy(stream, response.getOutputStream());
        } catch (IOException exception) {
            exception.printStackTrace();
        }
    }

    @PostMapping("/upload_edit_file")
    @ResponseBody
    public Map<String, String> editFromFile(@RequestParam("upload") MultipartFile file, HttpServletResponse response) {
        try {
            InputStream is = file.getInputStream();
            Workbook workbook = new XSSFWorkbook(is);
            Sheet sheet = workbook.getSheet("Worksheet");
            Iterator<Row> rows = sheet.iterator();
            List<Shop> shops = new ArrayList<>();
            while (rows.hasNext()) {
                Row currentRow = rows.next();

                // skip header and comments
                if (currentRow.getRowNum() < 11) {
                    continue;
                }
                Iterator<Cell> cellsInRow = currentRow.iterator();

                Shop shop = new Shop();

                while (cellsInRow.hasNext()) {
                    Cell currentCell = cellsInRow.next();
                    int cellIdx = currentCell.getColumnIndex();
                    switch (cellIdx) {
                        case 0:
                            Optional<Shop> optionalShop = shopRepository.findById((long)currentCell.getNumericCellValue());
                            if (optionalShop.isPresent()) {
                                shop = optionalShop.get();
                            } else {
                                continue;
                            }
                            break;
                        case 1:
                            String businessName = currentCell.getStringCellValue();
                            Optional<Business> optionalBusiness = businessRepository.findByName(businessName);
                            if (optionalBusiness.isPresent()) {
                                Business category = optionalBusiness.get();
                                shop.setBusiness(category);
                            }
                            break;
                        case 2:
                            shop.setName(currentCell.getStringCellValue());
                            break;
                        case 3:
                            shop.setErpCode(currentCell.getStringCellValue());
                            break;
                        case 4:
                            shop.setDeliveryType((int) currentCell.getNumericCellValue());
                            break;
                        case 5:
                            String ownerUsername = currentCell.getStringCellValue();
                            ShopOwner shopOwner = shop.getShopOwner();
                            shopOwner.setUsername(ownerUsername);
                            shopOwnerRepository.save(shopOwner);
                            break;
                        case 6:
                            String ownerPhone = currentCell.getStringCellValue();
                            shopOwner = shop.getShopOwner();
                            shopOwner.setPhone(ownerPhone);
                            shopOwnerRepository.save(shopOwner);
                            break;
                        case 7:
                            shop.setZipCode(currentCell.getStringCellValue());
                            break;
                        case 8:
                            shop.setAddressLine1(currentCell.getStringCellValue());
                            break;
                        case 9:
                            shop.setAddressLine2(currentCell.getStringCellValue());
                            break;
                        case 10:
                            Optional<User> optionalUser = userRepository.findByUsername(currentCell.getStringCellValue());
                            if (optionalUser.isPresent()) {
                                User deliverer = optionalUser.get();
                                shop.setDeliverer(deliverer);
                            }
                            break;
                        case 11:
                            optionalUser = userRepository.findByUsername(currentCell.getStringCellValue());
                            if (optionalUser.isPresent()) {
                                User salesman = optionalUser.get();
                                shop.setSalesman(salesman);
                            }
                            break;
                        case 12: // supplier
                            shop.setEmail(currentCell.getStringCellValue());
                            break;
                        case 13:
                            shop.setFax(currentCell.getStringCellValue());
                            break;
                        case 14:
                            Optional<PriceGroup> optionalPriceGroup = priceGroupRepository.findByName(currentCell.getStringCellValue());
                            if (optionalPriceGroup.isPresent()) {
                                shop.setPriceGroup(optionalPriceGroup.get());
                            }
                            break;
                        default:
                            break;
                    }
                }
                shops.add(shop);
            }

            shopRepository.saveAll(shops);
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
        List<Shop> products = shopRepository.findAllById(ids);
        for (Shop product: products) {
            product.setDealStatus(action);
        }
        shopRepository.saveAll(products);
        resultMap.put("message", "거래 처리 완료됐습니다.");
        return resultMap;
    }
}

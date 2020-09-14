package com.pando.subalzu;

import com.pando.subalzu.model.*;
import com.pando.subalzu.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

@Component
public class SetupDataLoader implements ApplicationListener<ContextRefreshedEvent> {

    boolean alreadySetup = false;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private PermissionRepository permissionRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private AssigneeTypeRepository assigneeTypeRepository;

    @Autowired
    private BusinessRepository businessRepository;

    @Autowired
    private PriceGroupRepository priceGroupRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private CompanyConfigRepository companyConfigRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private ProductPriceRepository productPriceRepository;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @Override
    @Transactional
    public void onApplicationEvent(ContextRefreshedEvent event) {
        if (alreadySetup)
            return;
        Role adminRole = createRoleIfNotFound("admin", "관리자");
        createRoleIfNotFound("sales", "영업");
        createRoleIfNotFound("deliverer", "배송");
        createRoleIfNotFound("accounting", "회계");

        Permission allPermission = createPermissionIfNotFound("all", "전체");
        createPermissionIfNotFound("in_charge", "담당 거래처");

        Optional<User> optionalUser = userRepository.findByUsername("testadmin");
        if (!optionalUser.isPresent()) {
            User user = new User();
            user.setUsername("testadmin");
            user.setFullName("testadmin");
            user.setPhone("123456");
            user.setPassword(passwordEncoder.encode("123456"));
            user.setEnabled(true);

            Set<Role> set = new HashSet<>();
            set.add(adminRole);
            user.setRoles(set);

            Set<Permission> permissionSet = new HashSet<>();
            permissionSet.add(allPermission);
            user.setPermissions(permissionSet);

            userRepository.save(user);
        }

        createAssigneeTypeIfNotFound("유통업자");
        createAssigneeTypeIfNotFound("소매업자");
        createAssigneeTypeIfNotFound("손실량");
        createAssigneeTypeIfNotFound("수출");

        createBusinessIfNotFound("한식");
        createBusinessIfNotFound("중식");
        createBusinessIfNotFound("일식");
        createBusinessIfNotFound("수산물");
        createBusinessIfNotFound("분식");
        createBusinessIfNotFound("닭/오리");
        createBusinessIfNotFound("양식");
        createBusinessIfNotFound("패스트푸드");
        createBusinessIfNotFound("제빵");
        createBusinessIfNotFound("유흥주점");
        createBusinessIfNotFound("퓨전요리");
        createBusinessIfNotFound("커피/음료");
        createBusinessIfNotFound("음식배달");
        createBusinessIfNotFound("뷔페");
        createBusinessIfNotFound("기타");

        createPriceGroupIfNotFound("direct");
        createPriceGroupIfNotFound("parcel");
        createPriceGroupIfNotFound("main");

        createCompanyConfigIfNotFound("first_category_popup", "off");
        createCompanyConfigIfNotFound("use_special_price_rate", "false");

        initProductPrices();

        alreadySetup = true;
    }

    @Transactional
    Role createRoleIfNotFound(String name, String koName) {
        Role role = roleRepository.findByName(name);
        if (role == null) {
            role = new Role();
            role.setName(name);
            role.setKoName(koName);
            roleRepository.save(role);
        }
        return role;
    }

    @Transactional
    Permission createPermissionIfNotFound(String name, String koName) {
        Permission permission = permissionRepository.findByName(name);
        if (permission == null) {
            permission = new Permission();
            permission.setName(name);
            permission.setKoName(koName);
            permissionRepository.save(permission);
        }
        return permission;
    }

    @Transactional
    void createAssigneeTypeIfNotFound(String name) {
        AssigneeType assigneeType = assigneeTypeRepository.findByName(name);
        if (assigneeType == null) {
            assigneeType = new AssigneeType();
            assigneeType.setName(name);
            assigneeTypeRepository.save(assigneeType);
        }
    }

    @Transactional
    void createBusinessIfNotFound(String name) {
        Optional<Business> optionalBusiness = businessRepository.findByName(name);
        if (!optionalBusiness.isPresent()) {
            Business business = new Business();
            business.setName(name);
            businessRepository.save(business);
        }
    }

    @Transactional
    void createPriceGroupIfNotFound(String name) {
        Optional<PriceGroup> optionalPriceGroup = priceGroupRepository.findByName(name);
        if (!optionalPriceGroup.isPresent()) {
            PriceGroup priceGroup = new PriceGroup();
            priceGroup.setName(name);
            priceGroupRepository.save(priceGroup);
        }
    }

    @Transactional
    void createCategoryIfNotFound(String name) {
        Optional<Category> optionalCategory = categoryRepository.findByName(name);
        if (!optionalCategory.isPresent()) {
            Category category = new Category();
            category.setName(name);
            categoryRepository.save(category);
        }
    }

    @Transactional
    void createCompanyConfigIfNotFound(String key, String value) {
        Optional<CompanyConfig> optionalCompanyConfig = companyConfigRepository.findByKey(key);
        if (!optionalCompanyConfig.isPresent()) {
            CompanyConfig companyConfig = new CompanyConfig();
            companyConfig.setKey(key);
            companyConfig.setValue(value);
            companyConfigRepository.save(companyConfig);
        }
    }

    @Transactional
    void initProductPrices() {
        List<Product> products = productRepository.findAll();
        List<PriceGroup> priceGroups = priceGroupRepository.findAll();
        for (Product product : products) {
            for (PriceGroup priceGroup : priceGroups) {
                Optional<ProductPrice> optionalProductPrice = productPriceRepository.getByProductAndPriceGroup(product, priceGroup);
                if (!optionalProductPrice.isPresent()) {
                    ProductPrice productPrice = new ProductPrice();
                    productPrice.setPrice(0L);
                    productPrice.setPriceGroup(priceGroup);
                    productPrice.setProduct(product);
                    productPriceRepository.save(productPrice);
                }
            }
        }

    }
}

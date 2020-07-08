package com.pando.subalzu;

import com.pando.subalzu.model.*;
import com.pando.subalzu.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
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
    private PasswordEncoder passwordEncoder;

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

        User testAdmin = userRepository.findByUsername("testadmin");

        if (testAdmin == null) {
            User user = new User();
            user.setUsername("testadmin");
            user.setFullName("testadmin");
            user.setPhone("123456");
            user.setPassword(passwordEncoder.encode("123456"));

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
        Business business = businessRepository.findByName(name);
        if (business == null) {
            business = new Business();
            business.setName(name);
            businessRepository.save(business);
        }
    }
}

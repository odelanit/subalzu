package com.pando.subalzu;

import com.pando.subalzu.model.Permission;
import com.pando.subalzu.model.Role;
import com.pando.subalzu.model.User;
import com.pando.subalzu.repository.PermissionRepository;
import com.pando.subalzu.repository.RoleRepository;
import com.pando.subalzu.repository.UserRepository;
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
    private PasswordEncoder passwordEncoder;

    @Override
    @Transactional
    public void onApplicationEvent(ContextRefreshedEvent event) {
        if (alreadySetup)
            return;
        Role adminRole = createRoleIfNotFound("admin", "관리자");
        createRoleIfNotFound("manager", "영업");
        createRoleIfNotFound("deliver", "배송");
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
}

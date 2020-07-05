package com.pando.subalzu.web;

import com.pando.subalzu.model.Permission;
import com.pando.subalzu.model.Role;
import com.pando.subalzu.model.User;
import com.pando.subalzu.repository.PermissionRepository;
import com.pando.subalzu.repository.RoleRepository;
import com.pando.subalzu.repository.UserDataRepository;
import com.pando.subalzu.repository.UserRepository;
import com.pando.subalzu.specification.SearchCriteria;
import com.pando.subalzu.specification.UserSpecification;
import com.pando.subalzu.validator.UserUpdateValidator;
import com.pando.subalzu.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.datatables.mapping.DataTablesInput;
import org.springframework.data.jpa.datatables.mapping.DataTablesOutput;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.security.Principal;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Controller
public class UserController {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserDataRepository userDataRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private PermissionRepository permissionRepository;

    @Autowired
    private UserValidator userValidator;

    @Autowired
    private UserUpdateValidator userUpdateValidator;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @GetMapping("/login")
    public String login(Model model, String error, String logout) {
        if (error != null) {
            model.addAttribute("error", "Your username and password is invalid.");
        }

        if (logout != null) {
            model.addAttribute("message", "You have been logged out successfully.");
        }
        return "login";
    }

    @GetMapping("/users")
    public String index() {
        return "user_list";
    }

    @RequestMapping(value = "/data/users", method = RequestMethod.POST)
    @ResponseBody
    public DataTablesOutput<User> dataUsers(@Valid @RequestBody DataTablesInput input) {
        return userDataRepository.findAll(input);
    }

    @GetMapping("/users/create")
    public String create(Model model) {
        model.addAttribute("userForm", new User());
        List<Role> roles = roleRepository.findAll();
        List<Permission> permissions = permissionRepository.findAll();
        model.addAttribute("roles", roles);
        model.addAttribute("permissions", permissions);
        return "user_create";
    }

    @PostMapping("/users/create")
    public String store(@ModelAttribute("userForm") User userForm, BindingResult bindingResult, Model model, RedirectAttributes redirectAttributes) {
        userValidator.validate(userForm, bindingResult);
        if (bindingResult.hasErrors()) {
            List<Role> roles = roleRepository.findAll();
            List<Permission> permissions = permissionRepository.findAll();
            model.addAttribute("roles", roles);
            model.addAttribute("permissions", permissions);
            return "user_create";
        }
        userForm.setPassword(bCryptPasswordEncoder.encode(userForm.getPassword()));
        userRepository.save(userForm);
        redirectAttributes.addFlashAttribute("message", "User Created");
        return "redirect:/users";
    }

    @GetMapping("/users/{username}")
    public String edit(Model model, @PathVariable String username) {
        User user = userRepository.findByUsername(username);
        model.addAttribute("userForm", user);

        List<Role> roles = roleRepository.findAll();
        List<Permission> permissions = permissionRepository.findAll();

        List<Role> userRoles = new ArrayList<>(user.getRoles());
        List<Permission> userPermissions = new ArrayList<>(user.getPermissions());

        model.addAttribute("roles", roles);
        model.addAttribute("userRole", userRoles.get(0));
        model.addAttribute("permissions", permissions);
        model.addAttribute("userPermission", userPermissions.get(0));
        return "/user_edit";
    }

    @PostMapping("/users/{username}")
    public String update(@PathVariable String username, @ModelAttribute("userForm") User userForm, BindingResult bindingResult, Model model, RedirectAttributes redirectAttributes) {
        userUpdateValidator.validate(userForm, bindingResult);
        if (bindingResult.hasErrors()) {
            List<Role> roles = roleRepository.findAll();
            List<Permission> permissions = permissionRepository.findAll();
            model.addAttribute("roles", roles);
            model.addAttribute("permissions", permissions);
            return "/user_edit";
        }
        userForm.setPassword(bCryptPasswordEncoder.encode(userForm.getPassword()));
        userRepository.save(userForm);
        redirectAttributes.addFlashAttribute("message", "User Updated");
        return "redirect:/users";
    }

    @GetMapping("/users/{username}/delete")
    public String delete(Principal principal, @PathVariable String username) {
        String currentUsername = principal.getName();
        if (!currentUsername.equals(username)) {
            User user = userRepository.findByUsername(username);
            userRepository.delete(user);
        }
        return "redirect:/users";
    }
}

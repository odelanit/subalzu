package com.pando.subalzu.form;

import com.pando.subalzu.model.CompanyConfig;
import com.pando.subalzu.repository.CompanyConfigRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class CompanyConfigForm {

    CompanyConfigRepository configRepository;

    String vendorName;

    String erpCode;

    String ownerName;

    String zipCode;

    String addressLine1;

    String addressLine2;

    String businessConditions;

    String businessItem;

    String businessTel;

    String email;

    String fax;

    String bankName;

    String bankAccount;

    String accountHolder;

    public String getVendorName() {
        Optional<CompanyConfig> configOptional = configRepository.findByKey("vendorName");
        configOptional.ifPresent(companyConfig -> this.vendorName = companyConfig.getValue());
        return this.vendorName;
    }

    public void setVendorName(String vendorName) {
        this.vendorName = vendorName;
    }

    public String getErpCode() {
        Optional<CompanyConfig> configOptional = configRepository.findByKey("erpCode");
        configOptional.ifPresent(companyConfig -> this.erpCode = companyConfig.getValue());
        return this.erpCode;
    }

    public void setErpCode(String erpCode) {
        this.erpCode = erpCode;
    }

    public String getOwnerName() {
        Optional<CompanyConfig> configOptional = configRepository.findByKey("ownerName");
        configOptional.ifPresent(companyConfig -> this.ownerName = companyConfig.getValue());
        return ownerName;
    }

    public void setOwnerName(String ownerName) {
        this.ownerName = ownerName;
    }

    public String getZipCode() {
        Optional<CompanyConfig> configOptional = configRepository.findByKey("zipCode");
        configOptional.ifPresent(companyConfig -> this.zipCode = companyConfig.getValue());
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getAddressLine1() {
        Optional<CompanyConfig> configOptional = configRepository.findByKey("addressLine1");
        configOptional.ifPresent(companyConfig -> this.addressLine1 = companyConfig.getValue());
        return addressLine1;
    }

    public void setAddressLine1(String addressLine1) {
        this.addressLine1 = addressLine1;
    }

    public String getAddressLine2() {
        Optional<CompanyConfig> configOptional = configRepository.findByKey("addressLine2");
        configOptional.ifPresent(companyConfig -> this.addressLine2 = companyConfig.getValue());
        return addressLine2;
    }

    public void setAddressLine2(String addressLine2) {
        this.addressLine2 = addressLine2;
    }

    public String getBusinessConditions() {
        Optional<CompanyConfig> configOptional = configRepository.findByKey("businessConditions");
        configOptional.ifPresent(companyConfig -> this.businessConditions = companyConfig.getValue());
        return businessConditions;
    }

    public void setBusinessConditions(String businessConditions) {
        this.businessConditions = businessConditions;
    }

    public String getBusinessItem() {
        Optional<CompanyConfig> configOptional = configRepository.findByKey("businessItem");
        configOptional.ifPresent(companyConfig -> this.businessItem = companyConfig.getValue());
        return businessItem;
    }

    public void setBusinessItem(String businessItem) {
        this.businessItem = businessItem;
    }

    public String getBusinessTel() {
        Optional<CompanyConfig> configOptional = configRepository.findByKey("businessTel");
        configOptional.ifPresent(companyConfig -> this.businessTel = companyConfig.getValue());
        return businessTel;
    }

    public void setBusinessTel(String businessTel) {
        this.businessTel = businessTel;
    }

    public String getEmail() {
        Optional<CompanyConfig> configOptional = configRepository.findByKey("email");
        configOptional.ifPresent(companyConfig -> this.email = companyConfig.getValue());
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFax() {
        Optional<CompanyConfig> configOptional = configRepository.findByKey("fax");
        configOptional.ifPresent(companyConfig -> this.fax = companyConfig.getValue());
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getBankName() {
        Optional<CompanyConfig> configOptional = configRepository.findByKey("bankName");
        configOptional.ifPresent(companyConfig -> this.bankName = companyConfig.getValue());
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public String getBankAccount() {
        Optional<CompanyConfig> configOptional = configRepository.findByKey("bankAccount");
        configOptional.ifPresent(companyConfig -> this.bankAccount = companyConfig.getValue());
        return bankAccount;
    }

    public void setBankAccount(String bankAccount) {
        this.bankAccount = bankAccount;
    }

    public String getAccountHolder() {
        Optional<CompanyConfig> configOptional = configRepository.findByKey("accountHolder");
        configOptional.ifPresent(companyConfig -> this.accountHolder = companyConfig.getValue());
        return accountHolder;
    }

    public void setAccountHolder(String accountHolder) {
        this.accountHolder = accountHolder;
    }

    public void save() {
        List<CompanyConfig> configs = new ArrayList<>();
        Optional<CompanyConfig> optionalVendorName = configRepository.findByKey("vendorName");
        CompanyConfig vendorName;
        if (optionalVendorName.isPresent()) {
            vendorName = optionalVendorName.get();
            vendorName.setValue(this.vendorName);
        } else {
            vendorName = new CompanyConfig("vendorName", this.vendorName);
        }
        configs.add(vendorName);

        Optional<CompanyConfig> optionalErpCode = configRepository.findByKey("erpCode");
        CompanyConfig erpCode;
        if (optionalErpCode.isPresent()) {
            erpCode = optionalErpCode.get();
            erpCode.setValue(this.erpCode);
        } else {
            erpCode = new CompanyConfig("erpCode", this.erpCode);
        }
        configs.add(erpCode);

        Optional<CompanyConfig> optionalOwnerName = configRepository.findByKey("ownerName");
        CompanyConfig ownerName;
        if (optionalOwnerName.isPresent()) {
            ownerName = optionalOwnerName.get();
            ownerName.setValue(this.ownerName);
        } else {
            ownerName = new CompanyConfig("ownerName", this.ownerName);
        }
        configs.add(ownerName);

        Optional<CompanyConfig> optionalZipCode = configRepository.findByKey("zipCode");
        CompanyConfig zipCode;
        if (optionalZipCode.isPresent()) {
            zipCode = optionalZipCode.get();
            zipCode.setValue(this.zipCode);
        } else {
            zipCode = new CompanyConfig("zipCode", this.zipCode);
        }
        configs.add(zipCode);

        Optional<CompanyConfig> optionalAddressLine1 = configRepository.findByKey("addressLine1");
        CompanyConfig addressLine1;
        if (optionalAddressLine1.isPresent()) {
            addressLine1 = optionalAddressLine1.get();
            addressLine1.setValue(this.addressLine1);
        } else {
            addressLine1 = new CompanyConfig("addressLine1", this.addressLine1);
        }
        configs.add(addressLine1);

        Optional<CompanyConfig> optionalAddressLine2 = configRepository.findByKey("addressLine2");
        CompanyConfig addressLine2;
        if (optionalAddressLine2.isPresent()) {
            addressLine2 = optionalAddressLine2.get();
            addressLine2.setValue(this.addressLine2);
        } else {
            addressLine2 = new CompanyConfig("addressLine2", this.addressLine2);
        }
        configs.add(addressLine2);

        Optional<CompanyConfig> optionalBusinessConditions = configRepository.findByKey("businessConditions");
        CompanyConfig businessConditions;
        if (optionalBusinessConditions.isPresent()) {
            businessConditions = optionalBusinessConditions.get();
            businessConditions.setValue(this.businessConditions);
        } else {
            businessConditions = new CompanyConfig("businessConditions", this.businessConditions);
        }
        configs.add(businessConditions);

        Optional<CompanyConfig> optionalBusinessItem = configRepository.findByKey("businessItem");
        CompanyConfig businessItem;
        if (optionalBusinessItem.isPresent()) {
            businessItem = optionalBusinessItem.get();
            businessItem.setValue(this.businessItem);
        } else {
            businessItem = new CompanyConfig("businessItem", this.businessItem);
        }
        configs.add(businessItem);

        Optional<CompanyConfig> optionalBusinessTel = configRepository.findByKey("businessTel");
        CompanyConfig businessTel;
        if (optionalBusinessTel.isPresent()) {
            businessTel = optionalBusinessTel.get();
            businessTel.setValue(this.businessTel);
        } else {
            businessTel = new CompanyConfig("businessTel", this.businessTel);
        }
        configs.add(businessTel);

        Optional<CompanyConfig> optionalEmail = configRepository.findByKey("email");
        CompanyConfig email;
        if (optionalEmail.isPresent()) {
            email = optionalEmail.get();
            email.setValue(this.email);
        } else {
            email = new CompanyConfig("email", this.email);
        }
        configs.add(email);

        Optional<CompanyConfig> optionalFax = configRepository.findByKey("fax");
        CompanyConfig fax;
        if (optionalFax.isPresent()) {
            fax = optionalFax.get();
            fax.setValue(this.fax);
        } else {
            fax = new CompanyConfig("fax", this.fax);
        }
        configs.add(fax);

        Optional<CompanyConfig> optionalBankName = configRepository.findByKey("bankName");
        CompanyConfig bankName;
        if (optionalBankName.isPresent()) {
            bankName = optionalBankName.get();
            bankName.setValue(this.bankName);
        } else {
            bankName = new CompanyConfig("bankName", this.bankName);
        }
        configs.add(bankName);

        Optional<CompanyConfig> optionalBankAccount = configRepository.findByKey("bankAccount");
        CompanyConfig bankAccount;
        if (optionalBankAccount.isPresent()) {
            bankAccount = optionalBankAccount.get();
            bankAccount.setValue(this.bankAccount);
        } else {
            bankAccount = new CompanyConfig("bankAccount", this.bankAccount);
        }
        configs.add(bankAccount);

        Optional<CompanyConfig> optionalAccountHolder = configRepository.findByKey("accountHolder");
        CompanyConfig accountHolder;
        if (optionalAccountHolder.isPresent()) {
            accountHolder = optionalAccountHolder.get();
            accountHolder.setValue(this.accountHolder);
        } else {
            accountHolder = new CompanyConfig("accountHolder", this.accountHolder);
        }
        configs.add(accountHolder);

        configRepository.saveAll(configs);
    }

    public CompanyConfigRepository getConfigRepository() {
        return configRepository;
    }

    public void setConfigRepository(CompanyConfigRepository configRepository) {
        this.configRepository = configRepository;
    }
}

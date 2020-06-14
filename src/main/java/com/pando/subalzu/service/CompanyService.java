package com.pando.subalzu.service;

import com.pando.subalzu.model.Company;
import com.pando.subalzu.repository.CompanyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.persistence.EntityNotFoundException;
import java.util.List;
import java.util.Optional;

@Component
public class CompanyService {
    @Autowired
    CompanyRepository companyRepository;

    public Company getCompanyById(long id) {
        Optional<Company> optionalCompany = companyRepository.findById(id);
        return optionalCompany.orElseThrow(() -> new EntityNotFoundException("Couldn't find a company with id: " + id));
    }

    public Company getFirst() {
        List<Company> companyList = companyRepository.findAll();
        if (companyList.size() == 0) {
            return null;
        } else {
            return companyList.get(0);
        }
    }

    public void save(Company company) {
        companyRepository.save(company);
    }
}

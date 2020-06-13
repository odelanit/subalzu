package com.pando.subalzu;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication
public class SubalzuApplication {

    public static void main(String[] args) {
        SpringApplication.run(SubalzuApplication.class, args);
    }

}

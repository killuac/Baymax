package com.baymax;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.orm.jpa.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EnableTransactionManagement
@EnableJpaRepositories("com.baymax.model.repository")
@EntityScan("com.baymax.model.entity")
public class BaymaxApplication {

    public static void main(String[] args) {
        SpringApplication.run(BaymaxApplication.class, args);
    }
}

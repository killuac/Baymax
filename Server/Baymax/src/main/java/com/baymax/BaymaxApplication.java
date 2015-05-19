package com.baymax;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.embedded.ServletRegistrationBean;
import org.springframework.boot.orm.jpa.EntityScan;
import org.springframework.context.annotation.Bean;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import javax.servlet.Servlet;

@SpringBootApplication
@EnableJpaRepositories("com.baymax.model.repository")
@EntityScan("com.baymax.model.entity")
public class BaymaxApplication {

    public static void main(String[] args) {
        SpringApplication.run(BaymaxApplication.class, args);
    }

    @Bean
    public ServletRegistrationBean servletRegistrationBean(Servlet servlet) {
        ServletRegistrationBean registration = new ServletRegistrationBean(servlet, "/api/*");
        return registration;
    }
}

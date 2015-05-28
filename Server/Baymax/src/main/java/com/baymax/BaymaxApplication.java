package com.baymax;

import com.baymax.common.Constant;
import com.baymax.common.Util;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.data.rest.SpringBootRepositoryRestMvcConfiguration;
import org.springframework.boot.orm.jpa.EntityScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import java.util.List;

@SpringBootApplication
@EnableTransactionManagement
@EnableJpaRepositories(Constant.PACKAGE_REPOSITORY)
@EntityScan(Constant.PACKAGE_ENTITY)
@Import(BaymaxApplication.RestConfiguration.class)
public class BaymaxApplication {

    public static void main(String[] args) {
        SpringApplication.run(BaymaxApplication.class, args);
    }


    @Configuration
    public static class RestConfiguration extends SpringBootRepositoryRestMvcConfiguration {
        @Override
        public RepositoryRestConfiguration config() {
            List<Class<?>> classList = Util.findClassesFromPackage(Constant.PACKAGE_ENTITY);
            Class<?>[] classes = classList.toArray(new Class[classList.size()]);
            RepositoryRestConfiguration config = super.config();
            config.exposeIdsFor(classes);   // Expose all entities' ID
            return config;
        }
    }
}
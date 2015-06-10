package com.baymax;

import com.baymax.common.Constant;
import com.baymax.common.Util;
import com.baymax.model.entity.AutoSeriesPartsItem;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.data.rest.SpringBootRepositoryRestMvcConfiguration;
import org.springframework.boot.orm.jpa.EntityScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.core.convert.support.ConfigurableConversionService;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;
import org.springframework.hateoas.config.EnableEntityLinks;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import java.util.Set;

@SpringBootApplication
@EnableEntityLinks
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
            Set<Class<?>> classSet = Util.findClassesInPackage(Constant.PACKAGE_ENTITY);
            Class<?>[] classes = classSet.toArray(new Class[classSet.size()]);
            RepositoryRestConfiguration config = super.config();
            config.exposeIdsFor(classes);   // Expose all entities' ID
            return config;
        }

        @Override
        protected void configureConversionService(ConfigurableConversionService conversionService) {
            conversionService.addConverter(new AutoSeriesPartsItem.CompositeIdConverter());
        }
    }
}
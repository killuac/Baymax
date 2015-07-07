package com.baymax.processor;

import com.baymax.controller.OrderController;
import com.baymax.controller.UserController;
import org.springframework.data.rest.webmvc.RepositoryLinksResource;
import org.springframework.hateoas.Link;
import org.springframework.hateoas.ResourceProcessor;
import org.springframework.stereotype.Component;

import static com.baymax.common.CustomProperties.propertiesInstance;
import static org.springframework.hateoas.mvc.ControllerLinkBuilder.linkTo;
import static org.springframework.hateoas.mvc.ControllerLinkBuilder.methodOn;

/**
 * Created by Killua on 5/29/15.
 */

@Component
public class CustomResourceProcessor implements ResourceProcessor<RepositoryLinksResource> {

    @Override
    public RepositoryLinksResource process(RepositoryLinksResource resource) {
        resource.add(linkTo(methodOn(UserController.class).signIn(null)).withRel("signIn"));

        resource.add(new Link(propertiesInstance().getLogoBaseURL(), "logoBaseURL"));
        resource.add(new Link(propertiesInstance().getPartsBaseURL(), "partsBaseURL"));
        resource.add(new Link(propertiesInstance().getAvatarBaseURL(), "avatarBaseURL"));
        resource.add(new Link(propertiesInstance().getImagesZIPURL(), "imagesZIPURL"));

        return resource;
    }
}

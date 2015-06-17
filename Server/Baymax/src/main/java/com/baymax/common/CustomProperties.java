package com.baymax.common;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.net.InetAddress;

/**
 * Created by Killua on 6/10/15.
 */

@Getter
@Setter
@Component
@ConfigurationProperties("custom.webserver")
public class CustomProperties {

    private static CustomProperties customProperties;

    public static CustomProperties propertiesInstance() {
        return customProperties;
    }

    private CustomProperties() {
        customProperties = this;
    }

    private InetAddress address;

    private String logoPath;

    private String partsPath;

    private String avatarPath;

    public String getBaseURLString() {
        return "http://" + address.getHostName();
    }

    public String getLogoBaseURL() {
        return getBaseURLString() + logoPath;
    }

    public String getPartsBaseURL() {
        return getBaseURLString() + partsPath;
    }

    public String getAvatarBaseURL() {
        return getBaseURLString() + avatarPath;
    }
}

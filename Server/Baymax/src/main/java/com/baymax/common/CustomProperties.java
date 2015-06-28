package com.baymax.common;

import lombok.Getter;
import lombok.Setter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.net.InetAddress;
import java.net.MalformedURLException;
import java.net.URL;

/**
 * Created by Killua on 6/10/15.
 */

@Getter
@Setter
@Component
@ConfigurationProperties("custom.webserver")
public class CustomProperties {

    private final static Logger logger = LoggerFactory.getLogger(CustomProperties.class);


    private static CustomProperties customProperties;

    public static CustomProperties propertiesInstance() {
        return customProperties;
    }

    private CustomProperties() {
        customProperties = this;
    }

    private InetAddress address;

    private final String logoPath = "/images/logo/";
    private final String partsPath = "/images/parts/";
    private final String avatarPath = "/images/avatar/";
    private final String logoZip = "/images/logo.zip";
    private final String partsZip = "/images/parts.zip";

    public String getBaseURLString() {
        try {
            URL url = new URL("http", address.getHostName(), "");
            return url.toString();
        } catch (MalformedURLException e) {
            logger.error(e.getMessage());
            return "http://" + address.getHostName();
        }
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

    public String getLogoZipURL() {
        return getBaseURLString() + logoZip;
    }

    public String getPartsZipURL() {
        return getBaseURLString() + partsZip;
    }
}

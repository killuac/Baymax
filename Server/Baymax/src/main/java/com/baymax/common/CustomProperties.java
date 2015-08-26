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
@ConfigurationProperties("custom")
public class CustomProperties {

    private final static Logger logger = LoggerFactory.getLogger(CustomProperties.class);

    private static CustomProperties customProperties;

    public static CustomProperties propertiesInstance() {
        return customProperties;
    }

    private CustomProperties() {
        customProperties = this;
    }

//  WebServer Properties
    private InetAddress webserverAddress;

    private final String logoPath = "/images/logo/";
    private final String partsPath = "/images/parts/";
    private final String avatarPath = "/images/avatar/";
    private final String imagesZIP = "/images/images.zip";

    public String getBaseURLString() {
        try {
            URL url = new URL("http", webserverAddress.getHostName(), "");
            return url.toString();
        } catch (MalformedURLException e) {
            logger.error(e.getMessage());
            return "http://" + webserverAddress.getHostName();
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

    public String getImagesZIPURL() {
        return getBaseURLString() + imagesZIP;
    }

//  SMS Properties
    private String smsSendUrl;
    private String smsApikey;
    private String smsText = "【大白保养】尊敬的用户，您的验证码是&，请在10分钟内完成验证。";
}

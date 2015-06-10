package com.baymax.common;

/**
 * Created by Killua on 5/7/15.
 */
public interface Constant {

    final class C {
        public static final String WEB_SERVER;
        static {
            WEB_SERVER = "http://localhost";
        }
    }

    final String PACKAGE_ENTITY     = "com.baymax.model.entity";
    final String PACKAGE_REPOSITORY = "com.baymax.model.repository";

    final String IMG_LOGO_PATH      = C.WEB_SERVER + "/images/logo/";
    final String IMG_PARTS_PATH     = C.WEB_SERVER + "/images/parts/";
    final String IMG_AVATAR_PATH    = C.WEB_SERVER + "/images/avatar/";

    final String PREFIX_RANDOM_USER = "U";
    final String HYPHEN             = "-";
}

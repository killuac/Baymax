//
//  BMUser.h
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "BMAutomobile.h"
#import "BMAddress.h"

@interface BMUser : JSONModel

@property (nonatomic, assign) NSUInteger userId;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString<Optional> *password;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, assign) BOOL isWrongPassword;
@property (nonatomic, strong) NSDate *createTime;
@property (nonatomic, strong) NSURL<Optional> *avatarURL;

@property (nonatomic, strong) NSURL<Optional> *automobilesURL;
@property (nonatomic, strong) NSURL<Optional> *addressesURL;

@property (nonatomic, strong) NSArray<BMAutomobile, Optional> *autombiles;
@property (nonatomic, strong) NSArray<BMAddress, Optional> *addresses;

@end

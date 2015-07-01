//
//  BMCredential.h
//  Baymax
//
//  Created by Killua Liu on 6/11/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "BMUtil.h"

@interface BMCredential : JSONModel

+ (instancetype)sharedCredential;

@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, assign) BOOL isSignedIn;

- (void)save;

@end

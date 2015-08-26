//
//  BMSMSCode.h
//  Baymax
//
//  Created by Killua Liu on 7/11/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BMSMSCode : JSONModel

@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString<Optional> *code;

@end

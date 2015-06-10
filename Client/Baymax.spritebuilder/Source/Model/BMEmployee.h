//
//  BMEmployee.h
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "BMOrder.h"

@interface BMEmployee : JSONModel

@property (nonatomic, copy) NSString *employeeId;
@property (nonatomic, copy) NSString *employeeName;
@property (nonatomic, copy) NSString<Ignore> *password;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *email;

@property (nonatomic, strong) NSURL<Optional> *employeeOrdersURL;
@property (nonatomic, strong) NSURL<Optional> *coworkerOrdersURL;

@property (nonatomic, strong) NSArray<BMOrder, Optional> *employeeOrders;
@property (nonatomic, strong) NSArray<BMOrder, Optional> *coworkerOrders;

@end

//
//  BMPayment.h
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BMPayment : JSONModel

@property (nonatomic, assign) short paymentId;
@property (nonatomic, copy) NSString *paymentName;

@end

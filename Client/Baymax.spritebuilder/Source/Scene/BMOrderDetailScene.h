//
//  BMOrderDetailScene.h
//  Baymax
//
//  Created by Killua Liu on 7/4/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMTableViewScene.h"
#import "BMOrderService.h"
#import "BMOrderStatusNode.h"

#define ORDER_DETAIL_SCENE  @"OrderDetailScene"

@interface BMOrderDetailScene : BMTableViewScene

@property (nonatomic, weak) BMOrderService *orderService;

@property (nonatomic, strong) BMOrderStatusNode *statusNode;
@property (nonatomic, strong) CCNode *detailNode;

@property (nonatomic, weak, readonly) CCLabelTTF *contactLabel;
@property (nonatomic, weak, readonly) CCLabelTTF *mobileLabel;
@property (nonatomic, weak, readonly) CCLabelTTF *addressLabel;
@property (nonatomic, weak, readonly) CCLabelTTF *reserveTimeLabel;
@property (nonatomic, weak, readonly) CCLabelTTF *paymentLabel;
@property (nonatomic, weak, readonly) CCLabelTTF *needInvoiceLabel;
@property (nonatomic, weak, readonly) CCLabelTTF *remarkLabel;

@end

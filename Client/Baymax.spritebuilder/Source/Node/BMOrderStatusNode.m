//
//  BMOrderStatusNode.m
//  Baymax
//
//  Created by Killua Liu on 7/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMOrderStatusNode.h"
#import "BMMainScene.h"
#import "BMOrderScene.h"

#define HIGHLIGHTED_LINK_LINE   @"order_status_link_line_highlighted.png"

@implementation BMOrderStatusNode

- (BMOrderService *)orderService
{
    return [(id)self.parent orderService];
}

- (void)updateStatus
{
    BMOrder *order = self.orderService.selectedOrder;
    
    _stepCreated.statusLabel.string = [self.orderService statusNameForId:BMOrderStatusCreated];
    _stepCreated.spriteFrame = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(@"order_status_icon_created.png")];
    
    _stepAcceptance.statusLabel.string = [self.orderService statusNameForId:BMOrderStatusWaitingAccept];
    _stepAcceptance.spriteFrame = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(@"order_status_icon_waiting_accept.png")];
    
    _stepCompletion.statusLabel.string = [self.orderService statusNameForId:BMOrderStatusWaitingService];
    _stepCompletion.spriteFrame = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(@"order_status_icon_waiting_service.png")];
    
    switch (order.statusId) {
        case BMOrderStatusRating:
        case BMOrderStatusSuccess:
        case BMOrderStatusClosed:
            _linkLineTwo.spriteFrame = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(HIGHLIGHTED_LINK_LINE)];
        case BMOrderStatusAccepted:
        case BMOrderStatusWaitingService:
            _stepAcceptance.statusLabel.string = [self.orderService statusNameForId:BMOrderStatusAccepted];
            _stepAcceptance.spriteFrame = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(@"order_status_icon_accepted.png")];
            
            _linkLineOne.spriteFrame = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(HIGHLIGHTED_LINK_LINE)];
            
            if (BMOrderStatusSuccess == order.statusId || BMOrderStatusRating == order.statusId) {
                _stepCompletion.statusLabel.string = [self.orderService statusNameForId:BMOrderStatusSuccess];
                _stepCompletion.spriteFrame = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(@"order_status_icon_success.png")];
            }
            else if (BMOrderStatusClosed == order.statusId) {
                _stepCompletion.statusLabel.string = [self.orderService statusNameForId:BMOrderStatusClosed];
                _stepCompletion.spriteFrame = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(@"order_status_icon_closed.png")];
            }
            break;
            
        default:
            break;
    }
}

@end

//
//  BMOrderDetailScene.m
//  Baymax
//
//  Created by Killua Liu on 7/4/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMOrderDetailScene.h"
#import "BMMainNextScene.h"

#define REPLACE_SIGN    @"&"

@implementation BMOrderDetailScene

- (void)didLoadFromCCB
{
    self.navigationBar.titleLabel.string = NAV_TITLE_ORDER_DETAIL;
    [self.navigationBar.rightBarItem setNormalBackgroundImage:IMG_NAV_BUTTON_HOME];
}

- (void)setOrderService:(BMOrderService *)orderService
{
    _orderService = orderService;
    
    [_statusNode updateStatus];
    [self reloadData];
}

- (void)onEnter
{
    [super onEnter];
    self.navigationBar.rightBarItem.visible = [self.scene.lastScene.children.firstObject isMemberOfClass:[BMMainNextScene class]];
}

- (BMOrder *)order
{
    return _orderService.selectedOrder;
}

- (NSArray *)allItems
{
    return _orderService.selectedOrder.orderItems;
}

- (void)navigationBar:(BMNavigationBar *)navBar didSelectItem:(BMNavBarItem *)item
{
    if ([item isEqual:self.navigationBar.leftBarItem]) {
        [super navigationBar:navBar didSelectItem:item];
    } else {
        [self popToRootSceneAnimated:YES];
    }
}

- (NSUInteger)numberOfSectionsInTableView:(BMTableView *)tableView
{
    return 3;
}

- (NSUInteger)tableView:(BMTableView *)tableView numberOfRowsInSection:(NSUInteger)section
{
    if (!self.allItems.count) return 0;
    
    if (1 == section) {
        return self.allItems.count + 1;
    } else {
        return 1;
    }
}

- (BMTableViewCell *)tableView:(BMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMTableViewCell *cell = [BMTableViewCell cellWithStyle:BMTableViewCellStyleValue accessoryType:BMTableViewCellAccessoryNone];
    
    if (0 == indexPath.section) {
        cell.visible = NO;
        [_statusNode removeFromParent];
        _statusNode.position = CGPointZero;
        [_tableView.contentNode addChild:_statusNode];
    } else if (2 == indexPath.section) {
        cell.visible = NO;
        [self setLabelsString];
        [_detailNode removeFromParent];
        _detailNode.position = ccpSub(_detailNode.position, ccp(0, 10));
        [_tableView.contentNode addChild:_detailNode];
    } else {
        if (indexPath.row == self.allItems.count) {
            cell.detailTextLabel.string = [TEXT_TOTAL_AMOUNT stringByReplacingOccurrencesOfString:REPLACE_SIGN
                                                                                       withString:@(self.order.amount).stringValue];
        } else {
            BMOrderItem *orderItem = self.allItems[indexPath.row];
            cell.textLabel.string = orderItem.itemName;
            cell.detailTextLabel.string = [NSString stringWithFormat:@"%.0f %@", orderItem.price, TEXT_PRICE_UNIT];
        }
    }
    
    return cell;
}

- (void)setLabelsString
{
    BMAddress *address = self.orderService.selectedAddress;
    _contactLabel.string = [_contactLabel.string stringByReplacingOccurrencesOfString:REPLACE_SIGN withString:address.realName];
    _mobileLabel.string = [_mobileLabel.string stringByReplacingOccurrencesOfString:REPLACE_SIGN withString:address.mobile];
    _addressLabel.string = [_addressLabel.string stringByReplacingOccurrencesOfString:REPLACE_SIGN withString:address.detailAddress];
    
    _reserveTimeLabel.string = [_reserveTimeLabel.string stringByReplacingOccurrencesOfString:REPLACE_SIGN withString:self.order.reserveTime];
    _paymentLabel.string = [_paymentLabel.string stringByReplacingOccurrencesOfString:REPLACE_SIGN withString:self.order.paymentName];
    
    NSString *text = self.order.isNeedInvoice ? TEXT_YES : TEXT_NO;
    _needInvoiceLabel.string = [_needInvoiceLabel.string stringByReplacingOccurrencesOfString:REPLACE_SIGN withString:text];
    
    text = (self.order.remark) ? self.order.remark : TEXT_NO_CONTENT;
    _remarkLabel.string = [_remarkLabel.string stringByReplacingOccurrencesOfString:REPLACE_SIGN withString:text];
}

- (CGFloat)tableView:(BMTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section) {
        return 100;
    } else if (2 == indexPath.section) {
        return 160;
    } else {
        return tableView.rowHeight;
    }
}

@end

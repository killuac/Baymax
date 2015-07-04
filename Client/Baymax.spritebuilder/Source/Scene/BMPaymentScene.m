//
//  BMPaymentScene.m
//  Baymax
//
//  Created by Killua Liu on 7/3/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMPaymentScene.h"
#import "BMMainNextScene.h"

@implementation BMPaymentScene

- (void)loadData
{
    [_tableView setupWithStyle:BMTableViewStyleGrouped];
    
    if (self.payments.count) {
        [self reloadData];
        return;
    }
    
    [self.orderService findAllPayments:^(id service) {
        [self reloadData];
    }];
}

- (BMOrderService *)orderService
{
    return [self.scene.lastScene.children.firstObject orderService];
}

- (NSArray *)payments
{
    return self.orderService.payments;
}

- (NSUInteger)tableView:(BMTableView *)tableView numberOfRowsInSection:(NSUInteger)section
{
    return self.payments.count;
}

- (BMTableViewCell *)tableView:(BMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMTableViewCell *cell = [BMTableViewCell cellWithStyle:BMTableViewCellStyleDefault accessoryType:BMTableViewCellAccessoryCheckmark];
    cell.textLabel.string = [self.payments[indexPath.row] paymentName];
    
    NSUInteger idx = [self.payments indexOfObject:self.orderService.selectedPayment];
    cell.selected = (idx == indexPath.row);
    
    return cell;
}

- (void)tableView:(BMTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.orderService.selectedPayment.isSelected = NO;
    [self.payments[indexPath.row] setIsSelected:YES];
}

@end

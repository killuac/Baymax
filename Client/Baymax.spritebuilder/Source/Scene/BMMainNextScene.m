//
//  BMMainNextScene.m
//  Baymax
//
//  Created by Killua Liu on 7/1/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMMainNextScene.h"
#import "BMMainScene.h"
#import "BMMainNextSceneModel.h"
#import "BMButtonFactory.h"
#import "BMPaymentScene.h"

@implementation BMMainNextScene {
    BMMainNextSceneModel *_model;
    NSIndexPath *_currentIndexPath;
}

- (id)init
{
    if (self = [super init]) {
        _model = [BMMainNextSceneModel model];
        [_tableView setupWithStyle:BMTableViewStyleGrouped];
    }
    return self;
}

- (void)didLoadFromCCB
{
    _orderButton.enabled = NO;
    self.userInteractionEnabled = NO;
    
    CGFloat height = _tableView.contentSize.height - _buttonBackground.contentSize.height;
    _tableView.contentSize = CGSizeMake(_tableView.contentSize.width, height);
    
    self.navigationBar.titleLabel.string = NAV_TITLE_MAIN_NEXT;
}

- (void)setOrderService:(BMOrderService *)orderService
{
    _orderService = orderService;
    
    double amount = self.orderService.selectedOrder.amount;
    _amountLabel.string = [_amountLabel.string stringByReplacingOccurrencesOfString:@"&" withString:@(amount).stringValue];
    
    [self reloadData];
}

- (NSArray *)itemsInSection:(NSUInteger)section
{
    return [_model.sections[section] items];
}

- (NSUInteger)numberOfSectionsInTableView:(BMTableView *)tableView
{
    return _model.sections.count;
}

- (NSUInteger)tableView:(BMTableView *)tableView numberOfRowsInSection:(NSUInteger)section
{
    return [_model.sections[section] items].count;
}

- (BMTableViewCell *)tableView:(BMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMModelItem *modelItem = [self itemsInSection:indexPath.section][indexPath.row];
    BMTableViewCell *cell = [BMTableViewCell cellWithStyle:BMTableViewCellStyleValue accessoryType:modelItem.accessoryType];
    
    if (modelItem.imageName) {
        cell.imageSprite.spriteFrame = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(modelItem.imageName)];
    }
    
    if (modelItem.isEditable) {
        cell.textField.placeholder = modelItem.labelText;
        cell.textField.maxLength = modelItem.maxLength;
        cell.textField.keyboardType = modelItem.keyboardType;
        _currentIndexPath = indexPath;
    } else {
        cell.textLabel.string = modelItem.labelText;
        cell.detailTextLabel.string = modelItem.value;
    }
    
    if (BMTableViewCellAccessoryDetailDisclosureButton == modelItem.accessoryType) {
        cell.accessoryButton = [BMButtonFactory createToggleButton:cell];
        [cell.accessoryButton setTarget:self selector:@selector(toggleSwitch:)];
        cell.allowsSelection = NO;
    }
    
    switch (indexPath.section) {
        case 0:
            if (0 == indexPath.row) {
                cell.textField.string = self.orderService.selectedAddress.realName;
                cell.textField.block = ^(CCPlatformTextField *textField) {
                    self.orderService.selectedAddress.realName = textField.string;
                };
            } else {
                cell.textField.string = self.orderService.selectedAddress.mobile;
                cell.textField.block = ^(CCPlatformTextField *textField) {
                    self.orderService.selectedAddress.mobile = textField.string;
                };
            }
            break;
            
        case 1:
            if (0 == indexPath.row) {
                cell.detailTextLabel.string = self.orderService.selectedOrder.reserveDate;
            } else {
                cell.textField.string = self.orderService.selectedAddress.detailAddress;
                cell.textField.block = ^(CCPlatformTextField *textField) {
                    self.orderService.selectedAddress.detailAddress = textField.string;
                };
            }
            break;
            
        case 2:
            if (0 == indexPath.row) {
                cell.detailTextLabel.string = self.orderService.selectedPayment.paymentName;
            } else {
                cell.accessoryButton.selected = self.orderService.selectedOrder.isNeedInvoice;
            }
            break;
            
        case 3:
            cell.textField.string = self.orderService.selectedOrder.remark;
            cell.textField.block = ^(CCPlatformTextField *textField) {
                self.orderService.selectedOrder.remark = textField.string;
            };
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(BMTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.section+1 == _model.sections.count) ? 100 : tableView.rowHeight;
}

- (BOOL)tableView:(BMTableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self itemsInSection:indexPath.section][indexPath.row] isEditable];
}

- (void)tableView:(BMTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1:
            
            break;
            
        case 2:
            if (0 == indexPath.row) {
                BMPaymentScene *node = [BMPaymentScene node];
                node.delegate = self;
                node.navigationBar.titleLabel.string = tableView.selectedCell.textLabel.string;
                [self pushScene:[CCScene sceneWithNode:node] animated:YES];
            }
            break;
            
        default:
            break;
    }
}

- (void)navigationSceneDidPop:(BMNavigationScene *)navScene
{
    self.tableView.selectedCell.detailTextLabel.string = self.orderService.selectedPayment.paymentName;
}

- (void)toggleSwitch:(CCButton *)button
{
    self.orderService.selectedOrder.isNeedInvoice = button.selected;
}

- (void)createOrder:(CCButton *)button
{
    BMOrder *order = self.orderService.selectedOrder;
    order.automobileId = 1;
    order.paymentId = self.orderService.selectedPayment.paymentId;
    order.addressId = self.orderService.selectedAddress.addressId;
    order.serviceTime = [NSDate date];      // !!! - 需要更改
    
    NSMutableArray *orderItems = [NSMutableArray array];
    for (id item in self.orderService.allItems) {
        BMOrderItem *orderItem = [[BMOrderItem alloc] init];
        
        if ([item isKindOfClass:[BMPartsItem class]]) {
            orderItem.partsItem = item;
        } else if ([item isKindOfClass:[BMService class]]) {
            orderItem.service = item;
        } else {
            continue;
        }
        [orderItems addObject:orderItem];
    }
    order.orderItems = (id)orderItems;
    
    [self.orderService createWithData:order result:^(id service) {
//        !!! - 调转到订单详情页面
        NSLog(@"%@", self.orderService.selectedOrder);
        [BMTextTip showText:@"创建成功"];
    }];
}

- (void)update:(CCTime)delta
{
    CCTextField *userTextField = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].textField;
    CCTextField *mobileTextField = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]].textField;
    CCTextField *addressTextField = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]].textField;
    CCLabelTTF *timeLabel = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]].detailTextLabel;
    CCLabelTTF *paymentLabel = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]].detailTextLabel;
    
    _orderButton.enabled = (userTextField.string.length > 0 &&
                            mobileTextField.string.length == MOBILE_MAX_LENGTH &&
                            addressTextField.string.length > 0 &&
                            timeLabel.string.length > 0 &&
                            paymentLabel.string.length > 0);
}


#if __CC_PLATFORM_IOS
- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    
    self.scene.colorRGBA = BACKGROUND_COLOR_TRANSPARENT;
}

- (void)onExitTransitionDidStart
{
    [super onExitTransitionDidStart];
    [CCGLView removeBackgroundUIView];
    
    self.scene.colorRGBA = BACKGROUND_COLOR;
}
#endif

@end

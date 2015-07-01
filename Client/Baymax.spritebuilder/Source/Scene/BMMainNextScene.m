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

@implementation BMMainNextScene {
    BMMainNextSceneModel *_model;
}

- (id)init
{
    _model = [BMMainNextSceneModel new];
    if (self = [super init]) {
        [_tableView setupWithStyle:BMTableViewStyleGrouped];
        [self reloadData];
    }
    return self;
}

- (void)didLoadFromCCB
{
    _orderButton.enabled = NO;
    
    CGFloat height = _tableView.contentSize.height - _buttonBackground.contentSize.height;
    _tableView.contentSize = CGSizeMake(_tableView.contentSize.width, height);
    
//    [[CCDirector sharedDirector].view addSubview:[[UIView alloc] init]];
}

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    _amountLabel.string = [_amountLabel.string stringByReplacingOccurrencesOfString:@"&" withString:@(self.orderService.amount).stringValue];
}

- (BMMainScene *)mainScene
{
    return (BMMainScene *)[self.scene.lastScene.children.firstObject selectedScene];
}

- (BMOrderService *)orderService
{
    return self.mainScene.orderService;
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
        cell.textField.string = modelItem.value;
    } else {
        cell.textLabel.string = modelItem.labelText;
        cell.detailTextLabel.string = modelItem.value;
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
    
}

- (void)createOrder:(CCButton *)button
{
    
}

@end

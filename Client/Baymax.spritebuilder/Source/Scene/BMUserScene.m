//
//  BMUserScene.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMUserScene.h"
#import "BMUserSceneModel.h"

@implementation BMUserScene {
    BMUserSceneModel *_model;
}

- (id)init
{
    if (self = [super init]) {
        _model = [BMUserSceneModel model];
        [_tableView setupWithStyle:BMTableViewStyleGrouped];
    }
    return self;
}

- (void)didLoadFromCCB
{
    self.navigationBar.titleLabel.string = NAV_TITLE_ME;
    
    CGFloat height = SCREEN_HEIGHT + self.navigationBar.contentSize.height;
    _tableView.position = CGPointZero;
    _tableView.contentSize = CGSizeMake(_tableView.contentSize.width, height);
    
    [_avatarSprite drawFullRoundCorner];
}

- (BMUserService *)userService
{
    return ((BMTabBarScene *)(self.parent.parent)).userService;
}

- (void)loadData
{
    _userNameLabel.string = self.user.userName;
    
    [self reloadData];
}

- (BMUser *)user
{
    return self.userService.user;
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
    BMTableViewCell *cell = [BMTableViewCell cellWithStyle:modelItem.cellStyle accessoryType:modelItem.accessoryType];
    if (indexPath.section == 0) {
        cell.visible = NO;
        [_avatarNode removeFromParent];
        [_tableView.contentNode addChild:_avatarNode];
        return cell;
    }
    
    cell.textLabel.string = modelItem.labelText;
    cell.imageSprite.spriteFrame = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(modelItem.imageName)];
    cell.imageSprite.color = [CCColor colorWithRed:0 green:175/255.0 blue:1];
    
    switch (indexPath.section) {
        case 1:
            if (0 == indexPath.row) {
                cell.detailTextLabel.string = self.user.userName;
            } else {
                NSString *mobile = [self.user.mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                cell.detailTextLabel.string = mobile;
                cell.allowsSelection = NO;
            }
            break;
            
        case 2:
            if (0 == indexPath.row) {
                cell.detailTextLabel.string = self.user.areaName;
            }
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(BMTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (0 == indexPath.section) ? 164 : tableView.rowHeight;
}

@end

//
//  BMPlateScene.m
//  Baymax
//
//  Created by Killua Liu on 7/6/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMPlateScene.h"
#import "BMMainScene.h"
#import "BMAutoScene.h"
#import "BMPlateTableViewCell.h"

@implementation BMPlateScene {
    CCTextField *_plateTextField;
}

- (id)init
{
    if (self = [super init]) {
        self.navigationBar.titleLabel.string = NAV_TITLE_PLATE;
        self.navigationBar.rightBarItem.title = BUTTON_TITLE_DONE;
        self.navigationBar.rightBarItem.enabled = NO;
        
        [_tableView setupWithStyle:BMTableViewStyleGrouped];
    }
    return self;
}

- (void)loadData
{
    if (self.allProvinces.count) {
        [self reloadData];
        return;
    }
    
    [_autoService findAllProvinces:^(id service) {
        [self reloadData];
    }];
}

- (NSArray *)allProvinces
{
    return _autoService.provinces;
}

- (void)navigationBar:(BMNavigationBar *)navBar didSelectItem:(BMNavBarItem *)item
{
    if ([item isEqual:self.navigationBar.leftBarItem]) {
        [super navigationBar:navBar didSelectItem:item];
    } else {
        BMAutomobile *automobile = [[BMAutomobile alloc] init];
        automobile.userId = [[self selectedTabScene] userService].userId;
        automobile.modelId = _autoService.selectedModel.modelId;
        
        NSString *abbreviation = [(id)self.tableView.selectedCell abbreviationLabel].string;
        automobile.registrationPlate = [[abbreviation stringByAppendingString:_plateTextField.string] uppercaseString];
        
        [_autoService createWithData:automobile result:^(id service) {
            [[self selectedTabScene] reloadData:_autoService.automobile];
            [self dismissToRootSceneAnimated:YES];
        }];
    }
}

- (id)selectedTabScene
{
    return [self.rootScene.children.firstObject selectedScene];
}

- (NSUInteger)tableView:(BMTableView *)tableView numberOfRowsInSection:(NSUInteger)section
{
    return self.allProvinces.count;
}

- (BMTableViewCell *)tableView:(BMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMProvince *province = self.allProvinces[indexPath.row];
    
    BMPlateTableViewCell *cell = [BMPlateTableViewCell cellWithStyle:BMTableViewCellStyleDefault accessoryType:BMTableViewCellAccessoryCheckmark];
    cell.textLabel.string = province.provinceName;
    cell.abbreviationLabel.string = province.abbreviation;
    
    return cell;
}

- (void)tableView:(BMTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self addTextFieldInCell:tableView.selectedCell];
}

- (void)addTextFieldInCell:(BMTableViewCell *)cell
{
    CCTextField *textField = [CCTextField textFieldWithSpriteFrame:nil];
    textField.anchorPoint = ccp(0, 0.5);
    textField.position = ccp(85, cell.contentSize.height/2);
    textField.contentSize = textField.preferredSize = CGSizeMake(150, cell.contentSize.height);
    textField.padding = 11;
    [cell addChild:textField];
    
    textField.placeholder = PLACEHOLDER_PLATE;
    textField.keyboardType = BMKeyboardTypeASCIICapable;
    textField.maxLength = REGISTRATION_PLATE_LENGTH;
    
    [textField becomeFirstResponder];
    
    cell.textField = _plateTextField = textField;
    cell.contentButton.visible = NO;
}

- (void)update:(CCTime)delta
{
    self.navigationBar.rightBarItem.enabled = (_plateTextField.string.length == REGISTRATION_PLATE_LENGTH);
}

#if __CC_PLATFORM_IOS
- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    [self addBackgroundUIView];
}

- (void)onExitTransitionDidStart
{
    [super onExitTransitionDidStart];
    [self removeBackgroundUIView];
}
#endif

@end

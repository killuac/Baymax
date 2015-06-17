//
//  BMTableViewCell.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMTableViewCell.h"
#import "BMTableView.h"
#import "BMUtil.h"

#define HIGHLIGHTED_COLOR   [CCColor whiteColor]
#define SELECTED_COLOR      [CCColor colorWithRed:38/255.0 green:60/255.0 blue:114/255.0]

@implementation BMTableViewCell {
    CCColor *_textFontColor, *_detailTextFontColor;
}

+ (instancetype)cellWithStyle:(BMTableViewCellStyle)style accessoryType:(BMTableViewCellAccessoryType)accessoryType
{
    BMTableViewCell *cell = (BMTableViewCell *)[CCBReader load:DEFAULT_TABLE_VIEW_CELL];
    [cell setupWithStyle:style accessoryType:accessoryType];
    return cell;
}

+ (instancetype)cellWithCCBNamed:(NSString *)name Style:(BMTableViewCellStyle)style
{
    BMTableViewCell *cell = (BMTableViewCell *)[CCBReader load:name];
    [cell setupWithStyle:style accessoryType:BMTableViewCellAccessoryNone];
    return cell;
}

- (void)didLoadFromCCB
{
    _indentWidth = 10.0f;
}

- (BMTableView *)tableView
{
    return (BMTableView *)self.parent.parent;
}

- (void)setupWithStyle:(BMTableViewCellStyle)style accessoryType:(BMTableViewCellAccessoryType)accessoryType
{
    _style = style;
    _accessoryType = accessoryType;
    
    [self setupStyle];
    [self setupAccessoryType];
}

- (void)setupStyle
{
    CCNode *labelsBox = nil;
    
    switch (_style) {
        case BMTableViewCellStyleDefault:
            [_nodesBox removeChild:_valueLabelsBox];
            [_nodesBox removeChild:_subtitleLabelsBox];
            break;
            
        case BMTableViewCellStyleValue:
            [_nodesBox removeChild:_subtitleLabelsBox];
            labelsBox = _valueLabelsBox;
            break;
            
        case BMTableViewCellStyleSubtitle:
            [_nodesBox removeChild:_valueLabelsBox];
            labelsBox = _subtitleLabelsBox;
            break;
    }
    
    if (labelsBox) {
        [_textLabel removeFromParent];
        _textLabel = [labelsBox getNonRecursiveChildByName:@"textLabel"];
        _detailTextLabel = [labelsBox getNonRecursiveChildByName:@"detailTextLabel"];
    }
    
    _textFontColor = _textLabel.fontColor;
    _detailTextFontColor = _detailTextLabel.fontColor;
}

- (void)setupAccessoryType
{
    NSString *imageName = nil;
    
    switch (_accessoryType) {
        case BMTableViewCellAccessoryNone:
            _accessorySprite.visible = NO; return;
            break;
            
        case BMTableViewCellAccessoryCheckmark:
            imageName = IMG_FILE_NAME(@"check_mark");
            break;
            
        case BMTableViewCellAccessoryDisclosureIndicator:
            imageName = IMG_FILE_NAME(@"disclosure_indicator");
            break;
    }
    
    CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:[imageName stringByAppendingString:@".png"]];
    CCSpriteFrame *spriteFrameHL = [CCSpriteFrame frameWithImageNamed:[imageName stringByAppendingString:@"_highlighted.png"]];
    [_accessorySprite setBackgroundSpriteFrame:spriteFrame forState:CCControlStateNormal];
    [_accessorySprite setBackgroundSpriteFrame:spriteFrameHL forState:CCControlStateHighlighted];
}

- (void)setHighlighted:(BOOL)highlighted {
    if (highlighted) {
        _textLabel.fontColor = _detailTextLabel.fontColor = HIGHLIGHTED_COLOR;
        [_accessorySprite setBackgroundColor:HIGHLIGHTED_COLOR forState:CCControlStateHighlighted];
        _accessorySprite.highlighted = YES;
    } else {
        _textLabel.fontColor = _textFontColor;
        _detailTextLabel.fontColor = _detailTextFontColor;
        _accessorySprite.highlighted = NO;
    }
}

- (void)setSelected:(BOOL)selected
{
    if (selected) {
        _textLabel.fontColor = _detailTextLabel.fontColor = SELECTED_COLOR;
    } else {
        _textLabel.fontColor = _textFontColor;
        _detailTextLabel.fontColor = _detailTextFontColor;
    }
    _cellButton.selected = selected;
}

- (void)selected:(BMCellButton *)button
{
    if (BMTableViewCellAccessoryCheckmark == _accessoryType) {
        self.selected = YES;
        [[self tableView] selectedCell].selected = NO;
    }
    [[self tableView] selectRowAtIndexPath:_indexPath];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ = %p | Name = %@ | ZOrder = %tu | AnchorPoint = %@ | Position = %@ | ContentSize = %@>",
            [self class], self, _name, _zOrder, StringFromCGPoint(_anchorPoint), StringFromCGPoint(_position), StringFromCGSize(_contentSize)];
}

@end

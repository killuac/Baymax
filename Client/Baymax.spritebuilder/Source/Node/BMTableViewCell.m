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
#define SELECTED_COLOR      [CCColor colorWithRed:43/255.0 green:65/255.0 blue:116/255.0]

@implementation BMTableViewCell {
    NSMutableDictionary *_properties;
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
    
//  Set border line content size
    CGFloat width = self.contentSize.width + 2;
    _borderLine.contentSize = CGSizeMake(width/self.contentSize.width, 1.04);
    
//  Save previous node's property to buffer
    _properties = [NSMutableDictionary dictionary];
    [[self getAllChildren] enumerateObjectsUsingBlock:^(id node, NSUInteger idx, BOOL *stop) {
        if ([node isMemberOfClass:[CCLabelTTF class]]) {
            [_properties setObject:[node fontColor] forKey:@([node hash])];
        }
    }];
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
            [_valueLabelsBox removeFromParent];
            [_subtitleLabelsBox removeFromParent];
            _valueLabelsBox = nil; _subtitleLabelsBox = nil;
            break;
            
        case BMTableViewCellStyleValue:
            labelsBox = _valueLabelsBox;
            [_subtitleLabelsBox removeFromParent];
            _subtitleLabelsBox = nil;
            break;
            
        case BMTableViewCellStyleSubtitle:
            labelsBox = _subtitleLabelsBox;
            [_valueLabelsBox removeFromParent];
            _valueLabelsBox = nil;
            break;
    }
    
    if (labelsBox) {
        [_textLabel removeFromParent]; _textLabel = nil;
        _textLabel = [labelsBox getNonRecursiveChildByName:@"textLabel"];
        _detailTextLabel = [labelsBox getNonRecursiveChildByName:@"detailTextLabel"];
    }
}

- (void)setupAccessoryType
{
    NSString *imageName = nil;
    
    _accessoryButton.userInteractionEnabled = NO;
    
    switch (_accessoryType) {
        case BMTableViewCellAccessoryNone:
            _accessoryButton.visible = NO; return;
            break;
            
        case BMTableViewCellAccessoryCheckmark:
            imageName = IMG_FILE_NAME(@"check_mark");
            _accessoryButton.visible = NO;
            break;
            
        case BMTableViewCellAccessoryDisclosureIndicator:
            imageName = IMG_FILE_NAME(@"disclosure_indicator");
            break;
            
        case BMTableViewCellAccessoryDetailDisclosureButton:
            imageName = IMG_FILE_NAME(@"detail_disclosure_button");
            _accessoryButton.userInteractionEnabled = YES;
            break;
    }
    
    CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:[imageName stringByAppendingString:@".png"]];
    CCSpriteFrame *spriteFrameHL = [CCSpriteFrame frameWithImageNamed:[imageName stringByAppendingString:@"_highlighted.png"]];
    CCSprite *sprite = [CCSprite spriteWithSpriteFrame:spriteFrame];
    _accessoryButton.preferredSize = _accessoryButton.maxSize = sprite.contentSize;
    [_accessoryButton setBackgroundSpriteFrame:spriteFrame forState:CCControlStateNormal];
    [_accessoryButton setBackgroundSpriteFrame:spriteFrameHL forState:CCControlStateHighlighted];
    [_accessoryButton setBackgroundColor:[CCColor whiteColor] forState:CCControlStateHighlighted];
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    [self layout];
    
    _contentButton.enabled = !self.editing;
    if (self.editing) {
        _nodesBox.spacing = 0;
        [_textLabel removeFromParent]; _textLabel = nil;
        [_valueLabelsBox removeFromParent]; _valueLabelsBox = nil;
        [_subtitleLabelsBox removeFromParent]; _subtitleLabelsBox = nil;
    } else {
        [_textField removeFromParent]; _textField = nil;
    }
}

- (void)layout
{
    if (BMTableViewStyleGrouped == [self tableView].style) {
        NSUInteger rowCount = [[self tableView] rowCountInSection:_indexPath.section];
//      First row or last row
        if (0 == _indexPath.row || _indexPath.row == rowCount - 1) {
            NSString *bgImageName, *borderImageName;
            if (rowCount > 1) {
                bgImageName = @"table_view_cell_group_half.png";
                borderImageName = @"table_view_cell_group_border.png";
            } else {
                bgImageName = @"table_view_cell_group_full.png";
                borderImageName = @"table_view_cell_full_border.png";
                [_separatorLine removeFromParent];
            }
            
            [_contentButton setBackgroundSpriteFrame:[CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(bgImageName)]];
            _borderLine.spriteFrame = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(borderImageName)];
            
            if (_indexPath.row > 0) {
                [_separatorLine removeFromParent];
                _contentButton.background.rotation = _borderLine.rotation = 180;
            }
        }
    } else {
        if (0 == _indexPath.row) {
            CCSprite9Slice *line = [_separatorLine copySprite9Slice];
            line.position = ccp(0.5, 1);
            [self addChild:line];
        }
    }
    
    if (![self tableView].hasBorderLine) {
        [_borderLine removeFromParent];
        _borderLine = nil;
    }
}

- (void)setContentSize:(CGSize)contentSize
{
    CGSize preSize = self.contentSize;
    [super setContentSize:contentSize];
    
    if (_valueLabelsBox) {
        CGFloat width = _valueLabelsBox.contentSize.width - (preSize.width - contentSize.width);
        _valueLabelsBox.contentSize = CGSizeMake(width, _valueLabelsBox.contentSize.height);
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    [[self getAllChildren] enumerateObjectsUsingBlock:^(id node, NSUInteger idx, BOOL *stop) {
        if ([node isMemberOfClass:[CCLabelTTF class]]) {
            CCColor *color = (highlighted) ? HIGHLIGHTED_COLOR : _properties[@([node hash])];
            [node setFontColor:color];
        }
    }];
    
    _accessoryButton.highlighted = highlighted;
}

- (void)setSelected:(BOOL)selected
{
    [[self getAllChildren] enumerateObjectsUsingBlock:^(id node, NSUInteger idx, BOOL *stop) {
        if ([node isMemberOfClass:[CCLabelTTF class]]) {
            CCColor *color = (selected) ? SELECTED_COLOR : _properties[@([node hash])];
            [node setFontColor:color];
        }
    }];
    
    _contentButton.selected = selected;
    _accessoryButton.visible = _accessoryButton.selected = selected;
}

- (void)selected:(BMCellButton *)button
{
    if (BMTableViewCellAccessoryCheckmark == _accessoryType) {
        [[self tableView] selectedCell].selected = NO;
        self.selected = YES;
    }
    [[self tableView] selectRowAtIndexPath:_indexPath];
}

- (BOOL)editing
{
    if ([[self tableView].dataSource respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
        return [[self tableView].dataSource tableView:[self tableView] canEditRowAtIndexPath:_indexPath];
    } else {
        return NO;
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p | Name = %@ | ZOrder = %tu | AnchorPoint = %@ | Position = %@ | ContentSize = %@>",
            [self class], self, _name, _zOrder, StringFromCGPoint(_anchorPoint), StringFromCGPoint(_position), StringFromCGSize(_contentSize)];
}

@end

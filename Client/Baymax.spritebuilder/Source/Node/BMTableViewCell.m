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
    
    CGFloat width = self.contentSize.width + 2;
    _borderLine.contentSize = CGSizeMake(width/self.contentSize.width, 1);
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
            _accessorySprite.visible = NO;
            break;
            
        case BMTableViewCellAccessoryDisclosureIndicator:
            imageName = IMG_FILE_NAME(@"disclosure_indicator");
            break;
    }
    
    _accessorySprite.name = [imageName lastPathComponent];
    _accessorySprite.spriteFrame = [CCSpriteFrame frameWithImageNamed:[imageName stringByAppendingString:@".png"]];
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    if (BMTableViewStyleGrouped == [self tableView].style) {
        NSUInteger rowCount = [[self tableView] rowCountInSection:indexPath.section];
//      First row or last row
        if (0 == indexPath.row || indexPath.row == rowCount - 1) {
            NSString *bgImageName, *borderImageName;
            if (rowCount > 1) {
                bgImageName = @"table_view_cell_group_half.png";
                borderImageName = @"table_view_cell_group_border.png";
            } else {
                bgImageName = @"table_view_cell_group_full.png";
                borderImageName = @"table_view_cell_full_border.png";
                [self removeChild:_separatorLine];
            }
            
            [_contentButton setBackgroundSpriteFrame:[CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(bgImageName)]];
            _borderLine.spriteFrame = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(borderImageName)];
            
            if (indexPath.row > 0) {
                [self removeChild:_separatorLine];
                _contentButton.background.rotation = _borderLine.rotation = 180;
            }
        }
    } else {
        if (0 == indexPath.row) {
            CCSprite9Slice *line = [_separatorLine copySprite9Slice];
            line.position = ccp(0.5, 1);
            [self addChild:line];
        }
    }
    
    _indexPath = indexPath;
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
    NSString *imageName = _accessorySprite.name;
    
    if (highlighted) {
        _textLabel.fontColor = _detailTextLabel.fontColor = HIGHLIGHTED_COLOR;
        _accessorySprite.spriteFrame = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME([imageName stringByAppendingString:@"_highlighted.png"])];
    } else {
        _textLabel.fontColor = _textFontColor;
        _detailTextLabel.fontColor = _detailTextFontColor;
        _accessorySprite.spriteFrame = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME([imageName stringByAppendingString:@".png"])];
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
    
    _contentButton.selected = selected;
    _accessorySprite.visible = selected;
}

- (void)selected:(BMCellButton *)button
{
    if (BMTableViewCellAccessoryCheckmark == _accessoryType) {
        [[self tableView] selectedCell].selected = NO;
        self.selected = YES;
    }
    [[self tableView] selectRowAtIndexPath:_indexPath];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ = %p | Name = %@ | ZOrder = %tu | AnchorPoint = %@ | Position = %@ | ContentSize = %@>",
            [self class], self, _name, _zOrder, StringFromCGPoint(_anchorPoint), StringFromCGPoint(_position), StringFromCGSize(_contentSize)];
}

@end

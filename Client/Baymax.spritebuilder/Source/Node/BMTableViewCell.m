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
#import "BMNavigationBar.h"
#import "BMButtonFactory.h"

#define HIGHLIGHTED_COLOR   [CCColor whiteColor]
#define SELECTED_COLOR      [CCColor colorWithRed:43/255.0 green:65/255.0 blue:116/255.0]

@implementation BMTableViewCell {
    NSMutableDictionary *_properties;
    
#if __CC_PLATFORM_IOS
    UIImageView *_imageView;
#endif
}

+ (instancetype)cellWithStyle:(BMTableViewCellStyle)style accessoryType:(BMTableViewCellAccessoryType)accessoryType
{
    BMTableViewCell *cell = (BMTableViewCell *)[CCBReader load:DEFAULT_TABLE_VIEW_CELL];
    [cell setupWithStyle:style accessoryType:accessoryType];
    return cell;
}

+ (instancetype)cellWithCCBNamed:(NSString *)name Style:(BMTableViewCellStyle)style
{
    id cell = [CCBReader load:name];
    [cell setupWithStyle:style accessoryType:BMTableViewCellAccessoryNone];
    return cell;
}

- (id)init
{
    if (self = [super init]) {
        _indentWidth = 10.0f;
        _selectionStyle = BMTableViewCellSelectionStyleBlue;
        _allowsSelection = YES;
    }
    return self;
}

- (void)didLoadFromCCB
{    
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
    
    switch (_accessoryType) {
        case BMTableViewCellAccessoryNone: {
            _accessoryButton.visible = NO;
            CGSize size = _valueLabelsBox.contentSize;
            _valueLabelsBox.contentSize = CGSizeMake(size.width+20, size.height);
            return;
        }
            break;
            
        case BMTableViewCellAccessoryCheckmark:
            imageName = IMG_FILE_NAME(@"check_mark");
            break;
            
        case BMTableViewCellAccessoryDisclosureIndicator:
            imageName = IMG_FILE_NAME(@"disclosure_indicator");
            break;
            
        case BMTableViewCellAccessoryDetailDisclosureButton:
            imageName = IMG_FILE_NAME(@"button_detail_disclosure");
            break;
    }
    
    self.accessoryButton = [BMButtonFactory createAccessoryButtonWithImageName:imageName inCell:self];
    _accessoryButton.userInteractionEnabled = (BMTableViewCellAccessoryDetailDisclosureButton == _accessoryType);
    _accessoryButton.visible = (BMTableViewCellAccessoryDisclosureIndicator == _accessoryType ||
                                BMTableViewCellAccessoryDetailDisclosureButton == _accessoryType);
}

- (void)setAccessoryType:(BMTableViewCellAccessoryType)accessoryType
{
    _accessoryType = accessoryType;
    [self setupAccessoryType];
}

- (void)setSelectionStyle:(BMTableViewCellSelectionStyle)selectionStyle
{
    switch (selectionStyle) {
        case BMTableViewCellSelectionStyleNone:
            [_contentButton setBackgroundColor:[CCColor whiteColor] forState:CCControlStateHighlighted];
            break;
            
        case BMTableViewCellSelectionStyleGray:
            [_contentButton setBackgroundColor:[CCColor lightGrayColor] forState:CCControlStateHighlighted];
            break;
            
        default:
            break;
    }
}

- (void)setAllowsSelection:(BOOL)allowsSelection
{
    _contentButton.enabled = _allowsSelection = allowsSelection;
    
    if (!allowsSelection) {
        _detailTextLabel.fontColor = [CCColor lightGrayColor];
    }
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    [self layout];
    
    _contentButton.enabled = (_allowsSelection && !self.editing);
    
    if (self.editing) {
        _nodesBox.spacing = 0;
        [_textLabel removeFromParent]; _textLabel = nil;
        [_valueLabelsBox removeFromParent]; _valueLabelsBox = nil;
        [_subtitleLabelsBox removeFromParent]; _subtitleLabelsBox = nil;
        
        if (!_imageSprite.spriteFrame) {
            [_imageSprite removeFromParent];
            _textField.preferredSize = CGSizeMake(_textField.preferredSize.width+40, self.contentSizeInPoints.height);
        }
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
            if (line) [self addChild:line];
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
    
    if (_textField) {
        CGFloat width = _textField.preferredSize.width - (preSize.width - contentSize.width);
        _textField.preferredSize = CGSizeMake(width, _textField.contentSize.height);
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
    [[self getAllChildren] enumerateObjectsUsingBlock:^(id node, NSUInteger idx, BOOL *stop) {
        if ([node isMemberOfClass:[CCLabelTTF class]]) {
            CCColor *color = (highlighted) ? HIGHLIGHTED_COLOR : _properties[@([node hash])];
            [node setFontColor:color];
        }
    }];
    
    _accessoryButton.highlighted = highlighted;
    
    if (!highlighted && self.selected) {
        self.selected = YES;
    }
}

- (void)setSelected:(BOOL)selected
{
    [self tableView].selectedIndexPath = _indexPath;
    
    [[self getAllChildren] enumerateObjectsUsingBlock:^(id node, NSUInteger idx, BOOL *stop) {
        if ([node isMemberOfClass:[CCLabelTTF class]]) {
            CCColor *color = (selected) ? SELECTED_COLOR : _properties[@([node hash])];
            [node setFontColor:color];
        }
    }];
    
    _selected = _contentButton.selected = selected;
    _accessoryButton.selected = selected;
    _accessoryButton.visible = selected;
    
    if (!self.editing) {
        [_textField removeFromParent];
        _contentButton.visible = YES;
    }
}

- (void)selectCell:(BMCellButton *)button
{
    if (BMTableViewCellAccessoryCheckmark == _accessoryType) {
        if (!button.selected) {
            [[self tableView] selectedCell].selected = NO;
            [[self tableView] selectRowAtIndexPath:_indexPath];
        } else {
            [[self tableView] deselectRowAtIndexPath:_indexPath];
        }
    } else {
        [[self tableView] selectRowAtIndexPath:_indexPath];
    }
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

#if __CC_PLATFORM_IOS
- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    
    if (self.editing) {
        self.contentButton.visible = NO;
        [self addBackgroundImageView];
    }
}

- (void)onExitTransitionDidStart
{
    [super onExitTransitionDidStart];
    [_imageView removeFromSuperview];
}

- (void)addBackgroundImageView
{
    UIImage *image = [UIImage imageWithCGImage:[_contentButton.background newCGImage]];
    _imageView = [[UIImageView alloc] initWithImage:image];
    
    CGFloat scaleMultiplier = [(id)_textField.platformTextField scaleMultiplier];
    CGFloat width = self.contentSize.width * scaleMultiplier;
    CGFloat offsetHeight = self.tableView.navigationBar.contentSize.height;
    CGRect frame = CGRectMake(self.position.x, self.position.y+offsetHeight, width, image.size.height/2);
    _imageView.frame = frame;
    
    [(id)_textField.platformTextField setImageView:_imageView];
    
    UIView *glView = [CCDirector sharedDirector].view;
    UIView *superView = glView.superview;
    [superView insertSubview:_imageView belowSubview:_textField.textField];
}
#endif


@end

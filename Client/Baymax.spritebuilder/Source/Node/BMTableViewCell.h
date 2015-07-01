//
//  BMTableViewCell.h
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCTableView.h"
#import "BMCellButton.h"
#import "BMImageSprite.h"
#import "BMConstant.h"

#define DEFAULT_TABLE_VIEW_CELL @"TableViewCell"
#define NAME_VALUE_LABELS_BOX   @"valueLabelsBox"

typedef NS_ENUM(NSInteger, BMTableViewCellStyle) {
    BMTableViewCellStyleDefault,	// Simple cell with text label and optional image view (behavior of UITableViewCell in iPhoneOS 2.x)
    BMTableViewCellStyleValue,		// Left aligned label on left and right aligned label on right with blue text (Used in Settings)
    BMTableViewCellStyleSubtitle	// Left aligned label on top and left aligned label on bottom with gray text (Used in iPod).
};

typedef NS_ENUM(NSInteger, BMTableViewCellAccessoryType) {
    BMTableViewCellAccessoryNone,
    BMTableViewCellAccessoryDisclosureIndicator,
    BMTableViewCellAccessoryDetailDisclosureButton,
    BMTableViewCellAccessoryCheckmark
};

typedef NS_ENUM(NSInteger, BMTableViewCellSelectionStyle) {
    BMTableViewCellSelectionStyleNone,
    BMTableViewCellSelectionStyleBlue,  // default
    BMTableViewCellSelectionStyleGray,
};

@interface BMTableViewCell : CCNode {
    CCLayoutBox *_nodesBox;
    CCLayoutBox *_subtitleLabelsBox;
    CCNode *_valueLabelsBox;
    CCSprite9Slice *_borderLine;
    CCSprite9Slice *_separatorLine;
}

// Use default CCB file name "TableViewCell"
+ (instancetype)cellWithStyle:(BMTableViewCellStyle)style accessoryType:(BMTableViewCellAccessoryType)accessoryType;
+ (instancetype)cellWithCCBNamed:(NSString *)name Style:(BMTableViewCellStyle)style;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak, readonly) BMCellButton *contentButton;

@property (nonatomic, weak, readonly) BMImageSprite *imageSprite;
@property (nonatomic, weak, readonly) CCLabelTTF *textLabel;
@property (nonatomic, weak, readonly) CCLabelTTF *detailTextLabel;
@property (nonatomic, weak, readonly) CCTextField *textField;
@property (nonatomic, weak, readonly) CCButton *accessoryButton;

@property (nonatomic, readonly) BMTableViewCellStyle style;
@property (nonatomic, assign) BMTableViewCellAccessoryType accessoryType;
@property (nonatomic, assign) BMTableViewCellSelectionStyle selectionStyle;
@property (nonatomic, assign) BOOL allowsSelection;
@property (nonatomic, assign) CGFloat indentWidth;  // Width for each level. default is 10.0

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL highlighted;
@property (nonatomic, assign, readonly) BOOL editing;

- (void)selectCell:(BMCellButton *)button;

@end

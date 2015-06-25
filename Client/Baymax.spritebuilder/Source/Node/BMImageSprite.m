//
//  BMImageSprite.m
//  Baymax
//
//  Created by Killua Liu on 6/16/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMImageSprite.h"
#import "BMTableViewCell.h"
#import "BMUtil.h"

@implementation BMImageSprite

- (BMTableViewCell *)tableViewCell
{
    return (BMTableViewCell *)self.parent.parent;
}

- (void)setSpriteFrame:(CCSpriteFrame *)spriteFrame
{
    [super setSpriteFrame:spriteFrame];
    
    CGFloat indent = [self tableViewCell].indentWidth;
    self.parent.position = ccp(indent/2, self.parent.position.y);
    
    CGFloat height = [self tableViewCell].contentSize.height - indent;
    self.contentSize = CGSizeMake(height, height);
    
    CCLayoutBox *box = (CCLayoutBox *)self.parent;
    CCNode *valueLabelsBox = [box getNonRecursiveChildByName:NAME_VALUE_LABELS_BOX];
    if (valueLabelsBox) {
        CGFloat accessoryWidth = [self tableViewCell].accessoryButton.preferredSize.width + indent * 2;
        CGFloat width = [self tableViewCell].contentSize.width - (self.contentSize.width + indent/2 + box.spacing + accessoryWidth);
        valueLabelsBox.contentSize = CGSizeMake(width, valueLabelsBox.contentSize.height);
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p | Name = %@ | ZOrder = %tu | AnchorPoint = %@ | Position = %@ | ContentSize = %@>",
            [self class], self, _name, _zOrder, StringFromCGPoint(_anchorPoint), StringFromCGPoint(_position), StringFromCGSize(_contentSize)];
}

@end

//
//  BMImageSprite.m
//  Baymax
//
//  Created by Killua Liu on 6/16/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMImageSprite.h"
#import "BMTableView.h"
#import "BMUtil.h"

@implementation BMImageSprite

- (BMTableViewCell *)tableViewCell
{
    return (BMTableViewCell *) (self.parent.parent ? self.parent.parent : self.parent);
}

- (CCLayoutBox *)nodesBox
{
    return (CCLayoutBox *)self.parent;
}

//- (void)setSpriteFrame:(CCSpriteFrame *)spriteFrame
//{
//    CGFloat indent = self.tableViewCell.indentWidth;
//    
//    if (spriteFrame) {
//        [super setSpriteFrame:spriteFrame];
//        
//        self.nodesBox.position = ccpAdd(self.nodesBox.position, ccp(indent, 0));
//        
//        indent = (self.tableViewCell.contentSize.height > DEFAULT_ROW_HEIGHT) ? indent * 2 : indent;
//        CGFloat height = self.contentSize.height - indent;
//        self.contentSize = CGSizeMake(height, height);
//    }
//    
//    CCLayoutBox *valueLabelsBox = [self.nodesBox getNonRecursiveChildByName:NAME_VALUE_LABELS_BOX];
//    
//    if (valueLabelsBox) {
//        CGFloat accessoryWidth = self.tableViewCell.accessoryButton.preferredSize.width;
//        accessoryWidth = (accessoryWidth > 0) ? accessoryWidth + indent * 2 : indent;
//        
//        CGFloat delta = (spriteFrame) ? self.contentSize.width + indent : 0;
//        CGFloat width = self.contentSize.width - (delta + self.nodesBox.spacing + accessoryWidth);
//        
//        valueLabelsBox.contentSize = CGSizeMake(width, valueLabelsBox.contentSize.height);
//    }
//}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p | Name = %@ | ZOrder = %tu | AnchorPoint = %@ | Position = %@ | ContentSize = %@>",
            [self class], self, _name, _zOrder, StringFromCGPoint(_anchorPoint), StringFromCGPoint(_position), StringFromCGSize(_contentSize)];
}

@end

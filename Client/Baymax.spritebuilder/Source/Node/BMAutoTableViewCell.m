//
//  BMAutoTableViewCell.m
//  Baymax
//
//  Created by Killua Liu on 6/22/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMAutoTableViewCell.h"

@implementation BMAutoTableViewCell

+ (instancetype)cellWithStyle:(BMTableViewCellStyle)style accessoryType:(BMTableViewCellAccessoryType)accessoryType
{
    id cell = [BMAutoTableViewCell cellWithCCBNamed:@"AutoTableViewCell" Style:style];
    [cell setAccessoryType:accessoryType];
    return cell;
}

- (void)setHighlighted:(BOOL)highlighted
{
//  Do not highlight label string
}

@end

//
//  BMOrderTableViewCell.m
//  Baymax
//
//  Created by Killua Liu on 7/6/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMOrderTableViewCell.h"

@implementation BMOrderTableViewCell

+ (instancetype)cellWithStyle:(BMTableViewCellStyle)style accessoryType:(BMTableViewCellAccessoryType)accessoryType
{
    BMOrderTableViewCell *cell = [BMOrderTableViewCell cellWithCCBNamed:@"OrderTableViewCell" Style:style];
    [cell setAccessoryType:accessoryType];
    return cell;
}

@end

//
//  BMPlateTableViewCell.m
//  Baymax
//
//  Created by Killua Liu on 7/6/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMPlateTableViewCell.h"

@implementation BMPlateTableViewCell

+ (instancetype)cellWithStyle:(BMTableViewCellStyle)style accessoryType:(BMTableViewCellAccessoryType)accessoryType
{
    BMPlateTableViewCell *cell = [BMPlateTableViewCell cellWithCCBNamed:@"PlateTableViewCell" Style:style];
    [cell setAccessoryType:accessoryType];
    return cell;
}

@end

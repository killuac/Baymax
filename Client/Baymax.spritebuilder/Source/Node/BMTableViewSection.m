//
//  BMTableViewSection.m
//  Baymax
//
//  Created by Killua Liu on 6/18/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMTableViewSection.h"

@implementation BMTableViewSection

+ (instancetype)node
{
    return (BMTableViewSection *)[CCBReader load:@"TableViewSection"];
}

@end

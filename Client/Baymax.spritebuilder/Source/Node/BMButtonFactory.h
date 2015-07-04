//
//  BMButtonFactory.h
//  Baymax
//
//  Created by Killua Liu on 7/3/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMTableViewCell.h"

@interface BMButtonFactory : NSObject

+ (id)createToggleButton;
+ (id)createToggleButton:(BMTableViewCell *)cell;

+ (id)createPasswordButtonInCell:(BMTableViewCell *)cell;

+ (id)createNormalAccessoryButtonInCell:(BMTableViewCell *)cell;

+ (id)createAccessoryButtonWithImageName:(NSString *)imageName inCell:(BMTableViewCell *)cell;

@end

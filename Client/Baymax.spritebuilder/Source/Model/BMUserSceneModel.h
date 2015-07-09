//
//  BMUserSceneModel.h
//  Baymax
//
//  Created by Killua Liu on 7/1/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BMUserSceneModel : JSONModel

@property (nonatomic, strong) NSArray<BMModelSection> *sections;

@end

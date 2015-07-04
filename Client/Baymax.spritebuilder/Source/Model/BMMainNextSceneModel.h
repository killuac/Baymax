//
//  BMMainNextSceneModel.h
//  Baymax
//
//  Created by Killua Liu on 7/1/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "BMTableViewCell.h"

@protocol BMModelItem <NSObject>
@end

@interface BMModelItem : JSONModel

@property (nonatomic, copy) NSString *labelText;
@property (nonatomic, assign) BMTableViewCellAccessoryType accessoryType;
@property (nonatomic, assign) BOOL isEditable;
@property (nonatomic, strong) NSNumber<Optional> *maxLengthValue;
@property (nonatomic, strong) NSNumber<Optional> *keyboardTypeValue;
@property (nonatomic, copy) NSString<Optional> *imageName;
@property (nonatomic, copy) NSString<Optional> *value;

- (NSUInteger)maxLength;
- (BMKeyboardType)keyboardType;

@end

@protocol BMModelSection <NSObject>
@end

@interface BMModelSection : JSONModel

@property (nonatomic, strong) NSArray<BMModelItem> *items;

@end

@interface BMMainNextSceneModel : JSONModel

@property (nonatomic, strong) NSArray<BMModelSection> *sections;

@end

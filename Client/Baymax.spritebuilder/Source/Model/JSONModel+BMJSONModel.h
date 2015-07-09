//
//  JSONModel+BMJSONModel.h
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "BMTableViewCell.h"

@interface JSONModel (BMJSONModel)

+ (instancetype)model;
+ (instancetype)modelWithString:(NSString *)string;
+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)modelWithData:(NSData *)data;

@property (nonatomic, assign) BOOL isSelected;

@end


@protocol BMModelItem <NSObject>
@end

@interface BMModelItem : JSONModel

@property (nonatomic, copy) NSString *labelText;
@property (nonatomic, assign) BMTableViewCellStyle cellStyle;
@property (nonatomic, assign) BMTableViewCellAccessoryType accessoryType;
@property (nonatomic, assign) NSNumber<Optional> *isEditableValue;
@property (nonatomic, strong) NSNumber<Optional> *maxLengthValue;
@property (nonatomic, strong) NSNumber<Optional> *keyboardTypeValue;
@property (nonatomic, copy) NSString<Optional> *imageName;
@property (nonatomic, copy) NSString<Optional> *value;

- (BOOL)isEditable;
- (NSUInteger)maxLength;
- (BMKeyboardType)keyboardType;

@end

@protocol BMModelSection <NSObject>
@end

@interface BMModelSection : JSONModel

@property (nonatomic, strong) NSArray<BMModelItem> *items;

@end

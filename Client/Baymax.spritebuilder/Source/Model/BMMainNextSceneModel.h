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
@property (nonatomic, assign) NSUInteger maxLength;
@property (nonatomic, copy) NSString<Optional> *imageName;
@property (nonatomic, copy) NSString<Optional> *value;

@end

@protocol BMModelSection <NSObject>
@end

@interface BMModelSection : JSONModel

@property (nonatomic, strong) NSArray<BMModelItem> *items;

@end

@interface BMMainNextSceneModel : JSONModel

//@property (nonatomic, strong) BMModelItem *contact;
//@property (nonatomic, strong) BMModelItem *mobile;
//@property (nonatomic, strong) BMModelItem *registrationPlate;
//@property (nonatomic, strong) BMModelItem *reserveDate;
//@property (nonatomic, strong) BMModelItem *area;
//@property (nonatomic, strong) BMModelItem *address;
//@property (nonatomic, strong) BMModelItem *payment;
//@property (nonatomic, strong) BMModelItem *needInvoice;
//@property (nonatomic, strong) BMModelItem *remark;

@property (nonatomic, strong) NSArray<BMModelSection> *sections;

@end

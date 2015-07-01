//
//  BMParts.h
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "BMPartsItem.h"

@protocol BMParts <NSObject>
@end

@interface BMParts : JSONModel

@property (nonatomic, assign) short partsId;
@property (nonatomic, copy) NSString *partsName;
@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, strong, readonly) NSURL<Ignore> *imageURL;
@property (nonatomic, strong, readonly) NSString<Ignore> *imageFile;

@property (nonatomic, strong) NSURL<Optional> *partsItemsURL;
@property (nonatomic, strong) NSArray<BMPartsItem, Optional> *partsItems;

@property (nonatomic, weak, readonly) BMPartsItem<Ignore> *selectedPartsItem;

@end

//
//  BMParts.h
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "BMPartsItem.h"

@interface BMParts : JSONModel

@property (nonatomic) ushort partsId;
@property (nonatomic, copy) NSString *partsName;

@property (nonatomic, strong) NSURL<Optional> *partsItemsURL;
@property (nonatomic, strong) NSArray<BMPartsItem, Optional> *partsItems;

@end

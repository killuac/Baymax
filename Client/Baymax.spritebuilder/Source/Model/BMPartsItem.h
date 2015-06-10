//
//  BMPartsItem.h
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol BMPartsItem <NSObject>
@end

@interface BMPartsItem : JSONModel

@property (nonatomic) ushort itemId;
@property (nonatomic) ushort partsId;
@property (nonatomic, copy) NSString *brandName;
@property (nonatomic) double price;
@property (nonatomic) double fourLiterPrice;
@property (nonatomic, copy) NSString *partsItemDesc;
@property (nonatomic, strong) NSURL *imageURL;

@end

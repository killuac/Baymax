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

@property (nonatomic, assign) ushort itemId;
@property (nonatomic, assign) ushort partsId;
@property (nonatomic, assign) double price;
@property (nonatomic, assign) double fourLiterPrice;
@property (nonatomic, copy) NSString *brandName;
@property (nonatomic, copy) NSString *partsItemDesc;
@property (nonatomic, strong) NSURL *imageURL;

@end

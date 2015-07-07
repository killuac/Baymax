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

@property (nonatomic, assign) short itemId;
@property (nonatomic, assign) double price;
@property (nonatomic, assign) double fourLiterPrice;
@property (nonatomic, copy) NSString *brandName;
@property (nonatomic, copy) NSString<Optional> *partsItemDesc;
@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, strong) NSNumber<Ignore> *totalPrice;

@property (nonatomic, strong, readonly) NSURL<Ignore> *imageURL;
@property (nonatomic, strong, readonly) NSString<Ignore> *imageFile;

@end

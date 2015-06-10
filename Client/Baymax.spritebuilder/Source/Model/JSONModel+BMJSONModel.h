//
//  JSONModel+BMJSONModel.h
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JSONModel (BMJSONModel)

+ (instancetype)jsonModelWithString:(NSString *)string;
+ (instancetype)jsonModelWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)jsonModelWithData:(NSData *)data;

@end

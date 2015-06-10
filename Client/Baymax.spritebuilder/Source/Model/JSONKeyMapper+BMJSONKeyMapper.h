//
//  JSONKeyMapper+BMJSONKeyMapper.h
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JSONKeyMapper (BMJSONKeyMapper)

+ (instancetype)jsonKeyMapperWithDictionary:(NSDictionary *)dictionary;

@end

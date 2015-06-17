//
//  JSONModel+BMJSONModel.m
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "JSONModel+BMJSONModel.h"

@implementation JSONModel (BMJSONModel)

+ (instancetype)modelWithString:(NSString *)string
{
    NSError *error;
    id jsonModel = [[self alloc] initWithString:string error:&error];
    if (error)  NSLog(@"%@", error);
    return jsonModel;
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    NSError *error;
    id jsonModel = [[self alloc] initWithDictionary:dictionary error:&error];
    if (error)  NSLog(@"%@", error);
    return jsonModel;
}

+ (instancetype)modelWithData:(NSData *)data
{
    NSError *error;
    id jsonModel = [[self alloc] initWithData:data error:&error];
    if (error)  NSLog(@"%@", error);
    return jsonModel;
}

@end

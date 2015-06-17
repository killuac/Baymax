//
//  BMCredential.m
//  Baymax
//
//  Created by Killua Liu on 6/11/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMCredential.h"

#define JSON_CREDENTIAL @"credential.json"

@implementation BMCredential

static BMCredential *instanceOfCredential = nil;
+ (instancetype)sharedCredential
{
    if (!instanceOfCredential) {
        NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *fileName = [docDir stringByAppendingPathComponent:JSON_CREDENTIAL];
        if ([[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
            instanceOfCredential = [self modelWithDictionary:[NSDictionary dictionaryWithContentsOfFile:fileName]];
        } else {
            instanceOfCredential = [[self alloc] init];
        }
    }
    return instanceOfCredential;
}

- (void)save
{
    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [docDir stringByAppendingPathComponent:JSON_CREDENTIAL];
    [[self toJSONData] writeToFile:fileName atomically:YES];
}

@end

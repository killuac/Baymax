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
        NSString *fileName = DocumentFilePath(JSON_CREDENTIAL);
        if ([[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
            instanceOfCredential = [self modelWithData:[NSData dataWithContentsOfFile:fileName]];
        } else {
            instanceOfCredential = [[self alloc] init];
            instanceOfCredential.mobile = @"";
        }
    }
    return instanceOfCredential;
}

- (void)save
{
    [[self toJSONData] writeToFile:DocumentFilePath(JSON_CREDENTIAL) atomically:YES];
}

@end

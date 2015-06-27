//
//  BMUserService.m
//  Baymax
//
//  Created by Killua Liu on 6/25/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMUserService.h"
#import "BMAutomobileService.h"
#import "SSZipArchive.h"

@implementation BMUserService

- (NSUInteger)userId
{
    return self.user.userId;
}

- (NSUInteger)automobileCount
{
    return self.user.automobiles.count;
}

- (NSArray *)automobiles
{
    return self.user.automobiles;
}

- (void)updateAutomobiles:(BMAutomobile *)automobile
{
    [_user.automobiles addObject:automobile];
}

- (void)downloadAllAutoLogos
{
    NSString *logoZipFile = DocumentFilePath(_user.logoZipURL.relativePath);
    [[BMSessionManager sharedSessionManager] GetResource:_user.logoZipURL success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [responseObject writeToFile:logoZipFile atomically:YES];
        [SSZipArchive unzipFileAtPath:logoZipFile toDestination:[logoZipFile stringByDeletingPathExtension]];
        [[NSFileManager defaultManager] removeItemAtPath:logoZipFile error:nil];
    }];
}

- (void)createWithData:(id)data result:(void (^)(id))result
{
    NSURL *url = [BMServerAPI sharedServerAPI].usersURL;
    
    [[BMSessionManager sharedSessionManager] POST:url parameters:[data toDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _user = [BMUser modelWithDictionary:responseObject];
        _response = operation.response;
        if (result) result(self);
    }];
}

- (void)signInWithData:(id)data result:(void (^)(id))result
{
    NSURL *url = [BMServerAPI sharedServerAPI].signInURL;
    
    [[BMSessionManager sharedSessionManager] POST:url parameters:[data toDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _user = [BMUser modelWithDictionary:responseObject];
        _response = operation.response;
        if (result) result(self);
    }];
}

- (void)findAutomobiles:(void (^)(id))result
{
    NSURL *url = _user.automobilesURL;
    
    [[BMSessionManager sharedSessionManager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BMContainer *container = [BMContainer modelWithDictionary:responseObject];
        _user.automobiles = container.automobiles;
        result(self);
    }];
}

@end

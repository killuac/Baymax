//
//  BMSessionManager.m
//  Baymax
//
//  Created by Killua Liu on 6/5/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMSessionManager.h"
#import "BMConstant.h"
#import "BMContainer.h"

@implementation BMSessionManager

static BMSessionManager *instanceOfSessionManager = nil;
+ (instancetype)sharedSessionManager
{
    if (!instanceOfSessionManager) {
        NSString *path = [[NSBundle mainBundle] pathForResource:PLIST_APPLICATION ofType:FILE_TYPE_PLIST];
        NSURL *baseURL = [NSURL URLWithString:[NSDictionary dictionaryWithContentsOfFile:path][@"baseURL"]];
        instanceOfSessionManager = [[self alloc] initWithBaseURL:baseURL];
    }
    return instanceOfSessionManager;
}

- (NSDictionary *)userInfo
{
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [self GET:@"api/autoBrands" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BMContainer *container = [BMContainer jsonModelWithDictionary:responseObject];
        NSLog(@"%@", container);
        NSLog(@"%ld", operation.response.statusCode);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    return nil;
}

- (AFHTTPRequestOperation *)GET:(NSURL *)url
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
{
    return [self GET:url.relativePath parameters:parameters success:success failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        if ([self.delegate respondsToSelector:@selector(sessionManager:didFailWithError:)]) {
            [self.delegate sessionManager:self didFailWithError:error];
        }
    }];
}

@end

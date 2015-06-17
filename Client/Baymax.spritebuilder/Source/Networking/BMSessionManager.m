//
//  BMSessionManager.m
//  Baymax
//
//  Created by Killua Liu on 6/5/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMSessionManager.h"
#import "BMAppSetting.h"

#define HTTP_HEADER_ACCEPT  @"application/json"

@implementation BMSessionManager

static BMSessionManager *instanceOfSessionManager = nil;
+ (instancetype)sharedSessionManager
{
    if (!instanceOfSessionManager) {
        instanceOfSessionManager = [[self alloc] initWithBaseURL:[BMAppSetting defaultAppSetting].baseURL];
        [instanceOfSessionManager.requestSerializer setValue:HTTP_HEADER_ACCEPT forHTTPHeaderField:@"Accept"];
    }
    return instanceOfSessionManager;
}

- (AFHTTPRequestOperation *)GET:(NSURL *)url
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
{
    return [self GET:url.relativePath
          parameters:parameters
             success:success
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"GET ERROR: %@", error);
                 if ([self.delegate respondsToSelector:@selector(sessionManager:didFailWithError:)]) {
                     [self.delegate sessionManager:self didFailWithError:error];
                 }
             }];
}

- (AFHTTPRequestOperation *)POST:(NSURL *)url
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
{
    return [self POST:url.relativePath
           parameters:parameters
              success:success
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"POST ERROR: %@", error);
                  if ([self.delegate respondsToSelector:@selector(sessionManager:didFailWithError:)]) {
                      [self.delegate sessionManager:self didFailWithError:error];
                  }
              }];
}

- (AFHTTPRequestOperation *)POST:(NSURL *)url
                      parameters:(id)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
{
    return [self POST:url.relativePath
           parameters:parameters
constructingBodyWithBlock:block success:success
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"POST MULTIPART ERROR: %@", error);
                  if ([self.delegate respondsToSelector:@selector(sessionManager:didFailWithError:)]) {
                      [self.delegate sessionManager:self didFailWithError:error];
                  }
              }];
}

- (AFHTTPRequestOperation *)PATCH:(NSURL *)url
                       parameters:(id)parameters
                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
{
    return [self PATCH:url.relativePath
            parameters:parameters
               success:success
               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   NSLog(@"PATCH ERROR: %@", error);
                   if ([self.delegate respondsToSelector:@selector(sessionManager:didFailWithError:)]) {
                       [self.delegate sessionManager:self didFailWithError:error];
                   }
               }];
}

@end

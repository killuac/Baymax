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

- (void)showActivityIndicator
{
    [[CCDirector sharedDirector].runningScene showActivityIndicator];
}

- (void)removeActivityIndicator
{
    [[CCDirector sharedDirector].runningScene removeActivityIndicator];
}

- (AFHTTPRequestOperation *)GET:(NSURL *)url
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
{
    [self showActivityIndicator];
    
    return [self GET:url.relativePath
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 [self removeActivityIndicator];
                 success(operation, responseObject);
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"GET ERROR: %@", error);
                 [self removeActivityIndicator];
                 if ([self.delegate respondsToSelector:@selector(sessionManager:didFailWithError:)]) {
                     [self.delegate sessionManager:self didFailWithError:error];
                 }
             }];
}

- (AFHTTPRequestOperation *)POST:(NSURL *)url
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
{
    [self showActivityIndicator];
    
    return [self POST:url.relativePath
           parameters:parameters
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  [self removeActivityIndicator];
                  success(operation, responseObject);
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"POST ERROR: %@", error);
                  [self removeActivityIndicator];
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
    [self showActivityIndicator];
    
    return [self POST:url.relativePath
           parameters:parameters
constructingBodyWithBlock:block
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  [self removeActivityIndicator];
                  success(operation, responseObject);
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"POST MULTIPART ERROR: %@", error);
                  [self removeActivityIndicator];
                  if ([self.delegate respondsToSelector:@selector(sessionManager:didFailWithError:)]) {
                      [self.delegate sessionManager:self didFailWithError:error];
                  }
              }];
}

- (AFHTTPRequestOperation *)PATCH:(NSURL *)url
                       parameters:(id)parameters
                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
{
    [self showActivityIndicator];
    
    return [self PATCH:url.relativePath
            parameters:parameters
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   [self removeActivityIndicator];
                   success(operation, responseObject);
               }
               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   NSLog(@"PATCH ERROR: %@", error);
                   [self removeActivityIndicator];
                   if ([self.delegate respondsToSelector:@selector(sessionManager:didFailWithError:)]) {
                       [self.delegate sessionManager:self didFailWithError:error];
                   }
               }];
}

@end

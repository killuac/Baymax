//
//  BMSessionManager.m
//  Baymax
//
//  Created by Killua Liu on 6/5/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMSessionManager.h"

@implementation BMSessionManager

static BMSessionManager *instanceOfSessionManager = nil;
+ (instancetype)sharedSessionManager
{
    if (!instanceOfSessionManager) {
//        instanceOfSessionManager = [[self alloc] initWithBaseURL:[BMAppSetting defaultAppSetting].baseURL];
        instanceOfSessionManager = [self manager];
        instanceOfSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [instanceOfSessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [instanceOfSessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
    }
    return instanceOfSessionManager;
}

- (NSString *)decodingString:(NSString *)string
{
    return [[string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
            stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (AFHTTPRequestOperation *)GET:(NSURL *)url
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
{
    if (!url) return nil;
    
    return [self GET:url.absoluteString
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 success(operation, responseObject);
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"GET ERROR: %@", error);
                 [BMActivityIndicator remove];
                 
                 if (-1004 == error.code) {
                     [BMTextTip showText:TIP_CONNECTION_FAILED];
                 }
                 
                 if ([self.delegate respondsToSelector:@selector(sessionManager:didFailWithError:)]) {
                     [self.delegate sessionManager:self didFailWithError:error];
                 }
             }];
}

- (AFHTTPRequestOperation *)getResource:(NSURL *)url
                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
{
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFHTTPRequestOperation *operation = [self GET:url parameters:nil success:success];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    
    return operation;
}

- (AFHTTPRequestOperation *)POST:(NSURL *)url
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
{
    if (!url) return nil;
    
    return [self POST:url.absoluteString
           parameters:parameters
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  success(operation, responseObject);
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"POST ERROR: %@", error);
                  [BMActivityIndicator remove];
                  
                  if (-1004 == error.code) {
                      [BMTextTip showText:TIP_CONNECTION_FAILED];
                  }
                  
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
    if (!url) return nil;
    
    return [self POST:url.relativePath
           parameters:parameters
constructingBodyWithBlock:block
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  success(operation, responseObject);
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"POST MULTIPART ERROR: %@", error);
                  [BMActivityIndicator remove];
                  
                  if (-1004 == error.code) {
                      [BMTextTip showText:TIP_CONNECTION_FAILED];
                  }
                  
                  if ([self.delegate respondsToSelector:@selector(sessionManager:didFailWithError:)]) {
                      [self.delegate sessionManager:self didFailWithError:error];
                  }
              }];
}

- (AFHTTPRequestOperation *)PATCH:(NSURL *)url
                       parameters:(id)parameters
                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
{
    if (!url) return nil;
    
    return [self PATCH:url.relativePath
            parameters:parameters
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   success(operation, responseObject);
               }
               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   NSLog(@"PATCH ERROR: %@", error);
                   [BMActivityIndicator remove];
                   
                   if (-1004 == error.code) {
                       [BMTextTip showText:TIP_CONNECTION_FAILED];
                   }
                   
                   if ([self.delegate respondsToSelector:@selector(sessionManager:didFailWithError:)]) {
                       [self.delegate sessionManager:self didFailWithError:error];
                   }
               }];
}

@end

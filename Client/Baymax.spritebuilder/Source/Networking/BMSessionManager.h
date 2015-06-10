//
//  BMSessionManager.h
//  Baymax
//
//  Created by Killua Liu on 6/5/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@class BMSessionManager;

@protocol BMSessionManagerDelegate <NSObject>
@optional
-(void)sessionManager:(BMSessionManager *)sessionManager didFailWithError:(NSError *)error;
@end

@interface BMSessionManager : AFHTTPRequestOperationManager

@property (nonatomic, weak) id<BMSessionManagerDelegate> delegate;

+ (instancetype)sharedSessionManager;
- (NSDictionary *)userInfo;

- (AFHTTPRequestOperation *)GET:(NSURL *)url
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success;

@end
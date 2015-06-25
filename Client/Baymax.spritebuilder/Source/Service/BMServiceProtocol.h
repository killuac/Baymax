//
//  BMServiceProtocol.h
//  Baymax
//
//  Created by Killua Liu on 6/25/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BMServiceProtocol <NSObject>

@optional

- (void)findOne:(void (^)(id service))result;

- (void)findAll:(void (^)(id service))result;

- (void)findByKey:(id)key result:(void (^)(id service))result;

- (void)findByParameters:(id)parameters result:(void (^)(id service))result;

- (void)createWithData:(id)data result:(void (^)(id service))result;

- (void)updateWithData:(id)data result:(void (^)(id service))result;

@end

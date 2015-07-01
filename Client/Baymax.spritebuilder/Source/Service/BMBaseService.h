//
//  BMBaseService.h
//  Baymax
//
//  Created by Killua Liu on 6/25/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMServiceProtocol.h"
#import "BMSessionManager.h"
#import "BMContainer.h"

@interface BMBaseService : NSObject <BMServiceProtocol> {
    NSHTTPURLResponse *_response;
}

+ (instancetype)serviceWithModel:(id)modelObject;
- (instancetype)initWithModel:(id)modelObject;

@property (nonatomic, strong, readonly) NSHTTPURLResponse *response;
@property (nonatomic, assign, readonly) NSInteger statusCode;

@end

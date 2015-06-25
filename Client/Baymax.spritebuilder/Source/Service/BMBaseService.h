//
//  BMBaseService.h
//  Baymax
//
//  Created by Killua Liu on 6/25/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMServiceProtocol.h"
#import "BMContainer.h"

@interface BMBaseService : NSObject <BMServiceProtocol> {
    NSHTTPURLResponse *_response;
}

@property (nonatomic, strong, readonly) NSHTTPURLResponse *response;
@property (nonatomic, assign, readonly) NSInteger statusCode;

@end

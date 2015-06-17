//
//  BMUtil.m
//  Baymax
//
//  Created by Killua Liu on 6/17/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMUtil.h"

@implementation BMUtil

@end


NSString *StringFromCGPoint(CGPoint point)
{
#if __CC_PLATFORM_MAC
    return NSStringFromPoint(point);
#else
    return NSStringFromCGPoint(point);
#endif
}

NSString *StringFromCGSize(CGSize size)
{
#if __CC_PLATFORM_MAC
    return NSStringFromSize(size);
#else
    return NSStringFromCGSize(size);
#endif
}

NSString *StringFromCGRect(CGRect rect)
{
#if __CC_PLATFORM_MAC
    return NSStringFromRect(rect);
#else
    return NSStringFromCGRect(rect);
#endif
}
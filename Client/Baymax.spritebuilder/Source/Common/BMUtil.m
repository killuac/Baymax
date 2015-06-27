//
//  BMUtil.m
//  Baymax
//
//  Created by Killua Liu on 6/17/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMUtil.h"

NSString *DocumentFilePath(NSString *fileName)
{
    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *path = [docDir stringByAppendingPathComponent:fileName];
    if ([fileName rangeOfString:@"/"].location != NSNotFound) {
        [[NSFileManager defaultManager] createDirectoryAtPath:[path stringByDeletingLastPathComponent]
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    }
    return path;
}

NSString *PlistFilePath(NSString *fileName)
{
    return [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
}

NSString *StringFromCGPoint(CGPoint point)
{
#if __CC_PLATFORM_IOS
    return NSStringFromCGPoint(point);
#elif __CC_PLATFORM_MAC
    return NSStringFromPoint(point);
#else
    return [NSString stringWithFormat:@"{%f, %f}", point.x, point.y];
#endif
}

NSString *StringFromCGSize(CGSize size)
{
#if __CC_PLATFORM_IOS
    return NSStringFromCGSize(size);
#elif __CC_PLATFORM_MAC
    return NSStringFromSize(size);
#else
    return [NSString stringWithFormat:@"{%f, %f}", size.width, size.height];
#endif
}

NSString *StringFromCGRect(CGRect rect)
{
#if __CC_PLATFORM_IOS
    return NSStringFromCGRect(rect);
#elif __CC_PLATFORM_MAC
    return NSStringFromRect(rect);
#else
    return [NSString stringWithFormat:@"{%f, %f, %f, %f}", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];
#endif
}
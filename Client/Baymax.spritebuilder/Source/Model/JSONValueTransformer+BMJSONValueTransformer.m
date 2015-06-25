//
//  JSONValueTransformer+BMJSONValueTransformer.m
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "JSONValueTransformer+BMJSONValueTransformer.h"

@implementation JSONValueTransformer (BMJSONValueTransformer)

- (NSDate *)NSDateFromNSString:(NSString*)string
{
    static dispatch_once_t onceInput;
    static NSDateFormatter* inputDateFormatter;
    dispatch_once(&onceInput, ^{
        inputDateFormatter = [[NSDateFormatter alloc] init];
        [inputDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        [inputDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.000+0000"];
    });
    return [inputDateFormatter dateFromString:string];
}

- (NSString *)JSONObjectFromNSDate:(NSDate *)date
{
    static dispatch_once_t onceOutput;
    static NSDateFormatter *outputDateFormatter;
    dispatch_once(&onceOutput, ^{
        outputDateFormatter = [[NSDateFormatter alloc] init];
        [outputDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        [outputDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
    });
    return [outputDateFormatter stringFromDate:date];
}

- (NSString *)JSONObjectFromNSURL:(NSURL *)url
{
    NSString *string = [[url absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSRange range = [string rangeOfString:@"{"];
    return (range.location != NSNotFound) ? [string substringToIndex:range.location] : string;
}

@end

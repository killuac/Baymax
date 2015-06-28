//
//  BMServerAPI.m
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMServerAPI.h"
#import "BMSessionManager.h"
#import "SSZipArchive.h"

#define JSON_SERVER_API @"server-api.json"

@implementation BMServerAPI

+ (JSONKeyMapper *)keyMapper
{
    return [JSONKeyMapper jsonKeyMapperWithDictionary:@
    {
        @"_links.signIn.href": @"signInURL",
        @"_links.users.href": @"usersURL",
        @"_links.employees.href": @"employeesURL",
        @"_links.autoBrands.href": @"autoBrandsURL",
        @"_links.automobiles.href": @"automobilesURL",
        @"_links.addresses.href": @"addressesURL",
        @"_links.provinces.href": @"provincesURL",
        @"_links.cities.href": @"citiesURL",
        @"_links.orders.href": @"ordersURL",
        @"_links.orderItems.href": @"orderItemsURL",
        @"_links.partses.href": @"partsesURL",
        @"_links.services.href": @"servicesURL",
        @"_links.payments.href": @"paymentsURL",
        @"_links.ratings.href": @"ratingsURL",
        
        @"_links.logoBaseURL.href": @"logoBaseURL",
        @"_links.logoZipURL.href": @"logoZipURL",
        @"_links.partsBaseURL.href": @"partsBaseURL",
        @"_links.partsZipURL.href": @"partsZipURL",
        @"_links.avatarBaseURL.href": @"avatarBaseURL"
    }];
}

static BMServerAPI *instanceOfServerAPI = nil;
+ (instancetype)sharedServerAPI
{
    if (!instanceOfServerAPI) {
        instanceOfServerAPI = [self modelWithData:[NSData dataWithContentsOfFile:DocumentFilePath(JSON_SERVER_API)]];
    }
    return instanceOfServerAPI;
}

+ (void)writeAPIFile
{
    NSString *urlString = [[BMAppSetting defaultAppSetting].baseURL.absoluteString stringByAppendingString:@"/api"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[BMSessionManager sharedSessionManager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BMServerAPI *serverAPI = [BMServerAPI modelWithDictionary:responseObject];
        [[serverAPI toJSONData] writeToFile:DocumentFilePath(JSON_SERVER_API) atomically:YES];
        
        [serverAPI downloadAllAutoLogos];
        
//        [BMAppSetting defaultAppSetting].isFirstLaunch = NO;
//        [[BMAppSetting defaultAppSetting] save];
    }];
}

- (void)downloadAllAutoLogos
{
//    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSString *logoZipFile = DocumentFilePath(self.logoZipURL.relativePath);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *content = [fileManager contentsOfDirectoryAtPath:[logoZipFile stringByDeletingLastPathComponent] error:nil];
    if (content.count > 0) return;
    
    [BMActivityIndicator showWithText:TIP_INITIALIZATION userInteractionEnabled:NO];
    
    [[BMSessionManager sharedSessionManager] getResource:self.logoZipURL success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [responseObject writeToFile:logoZipFile atomically:YES];
        NSString *logoPath = [logoZipFile stringByDeletingPathExtension];
        [SSZipArchive unzipFileAtPath:logoZipFile toDestination:logoPath];
        
//      After unzip, maybe there is also a "logo" folder in /image/logo/ directory because of different zip approach.
        NSString *path = [logoPath stringByAppendingPathComponent:@"logo"];
        if ([fileManager fileExistsAtPath:path]) {
            NSString *logoPathTemp = [logoPath stringByAppendingString:@"temp"];
            [fileManager moveItemAtPath:logoPath toPath:logoPathTemp error:nil];
            
            path = [logoPathTemp stringByAppendingPathComponent:path.lastPathComponent];
            [fileManager moveItemAtPath:path toPath:logoPath error:nil];
            
            [fileManager removeItemAtPath:logoPathTemp error:nil];
        }
        
        [fileManager removeItemAtPath:logoZipFile error:nil];
        
        [BMActivityIndicator remove];
    }];
}

@end

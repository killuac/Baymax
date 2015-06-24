//
//  BMSignScene.m
//  Baymax
//
//  Created by Killua Liu on 6/22/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMSignScene.h"
#import "BMSignInScene.h"
#import "BMSignUpScene.h"

@implementation BMSignScene

- (void)signIn:(CCButton *)button
{
    [self presentSceneWithName:@"SignInScene" animated:YES];
}

- (void)signUp:(CCButton *)button
{
    [self presentSceneWithName:@"SignUpScene" animated:YES];
}

@end

//
//  CCDirectorMac+BMDirectorMac.m
//  Baymax
//
//  Created by Killua Liu on 7/3/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCDirectorMac+BMDirectorMac.h"

@implementation CCDirectorMac (BMDirectorMac)

- (void)replaceScene:(CCScene *)scene animated:(BOOL)animated
{
    if (animated) {
        [[CCDirector sharedDirector] replaceScene:scene withTransition:[CCTransition transitionFade]];
    } else {
        [[CCDirector sharedDirector] replaceScene:scene];
    }
}

@end

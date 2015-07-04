//
//  CCDirectorIOS+BMDirectorIOS.m
//  Baymax
//
//  Created by Killua Liu on 7/3/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCDirectorIOS+BMDirectorIOS.h"

@implementation CCDirectorIOS (BMDirectorIOS)

- (void)replaceScene:(CCScene *)scene animated:(BOOL)animated
{
    if (!animated) {
        [[CCDirector sharedDirector] replaceScene:scene]; return;
    }
    
    [UIView animateWithDuration:1 animations:^{
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft
                               forView:[CCDirector sharedDirector].view.superview
                                 cache:YES];
        
        [[CCDirector sharedDirector] replaceScene:scene];
    }];
}

@end

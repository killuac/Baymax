//
//  BMSignInScene.h
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMTableViewScene.h"
#import "BMUser.h"

@interface BMSignInScene : BMTableViewScene {
    CCTextField *_mobileTextField, *_passwordTextField;
    CCButton *_signButton;
}

@property (nonatomic, strong, readonly) CCButton *signButton;

- (void)didLoadFromCCB;
- (void)loadOnce;

- (void)signIn:(CCButton *)button;

@end

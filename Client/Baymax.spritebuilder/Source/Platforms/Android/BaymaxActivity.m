/*
 * SpriteBuilder: http://www.spritebuilder.org
 *
 * Copyright (c) 2014 Apportable Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */


#import "BaymaxActivity.h"
#import "BMAppSetting.h"
#import "BMServerAPI.h"
#import "BMCredential.h"
#import <AndroidKit/AndroidKeyEvent.h>
#import "AFNetworkReachabilityManager+BMNetworkReachabilityManager.h"

@implementation BaymaxActivity

- (void)run
{
    [super run];
    [self setupApplication];
}

- (void)setupApplication
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] checkReachability];
}

- (CCScene *)startScene
{
    CCScene *firstScene = [self firstLaunch];
    if (firstScene) {
        return firstScene;
    } else {
        NSString *sceneName = ([BMCredential sharedCredential].isSignedIn) ? MAIN_SCENE : SIGN_SCENE;
        return [CCBReader loadAsScene:sceneName];
    }
}

- (CCScene *)firstLaunch
{
    BMAppSetting *appSetting = [BMAppSetting defaultAppSetting];
    if (appSetting.isFirstLaunch) {
        [BMServerAPI writeAPIFile];
        return (appSetting.guideScene.length) ? [CCBReader loadAsScene:appSetting.guideScene] : nil;
    }
    return nil;
}

- (BOOL)onKeyUp:(int32_t)keyCode keyEvent:(AndroidKeyEvent *)event
{
    if (keyCode == AndroidKeyEventKeycodeBack)
    {
        [self finish];
    }
    return NO;
}

- (void)onResume
{
    
}

@end

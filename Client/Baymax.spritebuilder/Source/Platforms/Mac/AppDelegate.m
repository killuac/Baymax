#import "AppDelegate.h"
#import "BMAppSetting.h"
#import "BMServerAPI.h"
#import "BMCredential.h"
#import "AFNetworkReachabilityManager+BMNetworkReachabilityManager.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet CCGLView *glView;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    CCDirectorMac *director = (CCDirectorMac*) [CCDirector sharedDirector];

    // enable FPS and SPF
    // [director setDisplayStats:YES];

    // Set a default window size
    CGSize defaultWindowSize = CGSizeMake(320.0f, 568.0f);
    [self.window setFrame:CGRectMake(0.0f, 0.0f, defaultWindowSize.width, defaultWindowSize.height) display:true animate:false];
    [self.glView setFrame:self.window.frame];

    // connect the OpenGL view with the director
    [director setView:self.glView];

    // 'Effects' don't work correctly when autoscale is turned on.
    // Use kCCDirectorResize_NoScale if you don't want auto-scaling.
    //[director setResizeMode:kCCDirectorResize_NoScale];

    // Enable "moving" mouse event. Default no.
    [self.window setAcceptsMouseMovedEvents:NO];

    // Center main window
    [self.window center];

    // Configure CCFileUtils to work with SpriteBuilder
    [CCBReader configureCCFileUtils];
    
    [[CCPackageManager sharedManager] loadPackages];
    
    [director runWithScene:[self startScene]];
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

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    [[CCPackageManager sharedManager] savePackages];
}

- (void)applicationDidBecomeActive:(NSNotification *)notification
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] checkReachability];
}

@end

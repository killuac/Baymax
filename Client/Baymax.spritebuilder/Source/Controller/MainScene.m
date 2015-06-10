#import "MainScene.h"
#import "BMSessionManager.h"

@implementation MainScene

- (void)didLoadFromCCB
{
    BMSessionManager *sessionManager = [BMSessionManager sharedSessionManager];
    NSLog(@"%@", [sessionManager userInfo]);
}

@end

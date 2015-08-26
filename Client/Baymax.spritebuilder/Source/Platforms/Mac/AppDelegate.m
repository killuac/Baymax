#import "AppDelegate.h"
#import "BMAppSetting.h"
#import "BMServerAPI.h"
#import "BMCredential.h"
#import "AFNetworkReachabilityManager+BMNetworkReachabilityManager.h"

@interface Table : NSObject

@property (nonatomic, assign) int row;
@property (nonatomic, assign) int column;

@end

@implementation Table
- (BOOL)isEqual:(Table *)object
{
    return (self.row == object.row && self.column == object.column);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"row = %i, column = %i", _row, _column];
}
@end

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet CCGLView *glView;
@end

@implementation AppDelegate {
    NSMutableArray *array;
    NSMutableArray *newArray;
    NSMutableArray *paths;
    NSMutableArray *container;
    Table *currentTab;
    Table *startTab;
    BOOL stop;
}

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
    
    NSMutableArray *row1 = [NSMutableArray arrayWithObjects:@"w", @"r", @"b", @"b", nil];
    NSMutableArray *row2 = [NSMutableArray arrayWithObjects:@"r", @"r", @"b", @"b", nil];
    NSMutableArray *row3 = [NSMutableArray arrayWithObjects:@"r", @"r", @"b", @"b", nil];;
    NSMutableArray *row4 = [NSMutableArray arrayWithObjects:@"r", @"r", @"b", @"b", nil];;
    array = [NSMutableArray arrayWithObjects:row1, row2, row3, row4, nil];
    
    NSMutableArray *newRow1 = [NSMutableArray arrayWithObjects:@"w", @"b", @"r", @"b", nil];
    NSMutableArray *newRow2 = [NSMutableArray arrayWithObjects:@"b", @"r", @"b", @"r", nil];
    NSMutableArray *newRow3 = [NSMutableArray arrayWithObjects:@"b", @"r", @"b", @"r", nil];
    NSMutableArray *newRow4 = [NSMutableArray arrayWithObjects:@"b", @"r", @"b", @"r", nil];
    newArray = [NSMutableArray arrayWithObjects:newRow1, newRow2, newRow3, newRow4, nil];
    
    paths = [NSMutableArray array];
    
    currentTab = [Table new];
    currentTab.row = currentTab.column = 0;
    startTab = [Table new];
    startTab.row = startTab.column = 0;
    
    Table *rightTab = [Table new];
    rightTab.row = 0; rightTab.column = 1;
    Table *downTab = [Table new];
    downTab.row = 1; downTab.column = 0;
    NSArray *loops = @[rightTab, downTab];
    
    container = [NSMutableArray array];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self updateByLoops:loops];
//        NSLog(@"%@", [paths componentsJoinedByString:@""]);
//    });
}

- (void)updateByLoops:(NSArray *)loops
{
    for (Table *tab in loops) {
        if (stop) break;
        
//        if (currentTab.row-1 == startTab.row && currentTab.column == startTab.column && tab.row < currentTab.row) {
//            startTab.row = currentTab.row;
//            startTab.column = currentTab.column;
//            continue;
//        }
        
        id temp = [array[tab.row][tab.column] copy];
        array[tab.row][tab.column] = [array[currentTab.row][currentTab.column] copy];
        array[currentTab.row][currentTab.column] = temp;
        
        NSMutableArray *tables = [NSMutableArray array];
        Table *leftTab = [Table new];
        Table *rightTab = [Table new];
        Table *upTab = [Table new];
        Table *downTab = [Table new];
        
        if (tab.column < currentTab.column) {
            [paths addObject:@"L"];
            if (tab.column-1 >= 0) {
                leftTab.row = tab.row;
                leftTab.column = tab.column-1;
                [tables addObject:leftTab];
            }
//            if (tab.row-1 >= 0) {
//                upTab.row = tab.row-1;
//                upTab.column = tab.column;
//                [tables addObject:upTab];
//            }
            if (tab.row+1 < 4) {
                downTab.row = tab.row+1;
                downTab.column = tab.column;
                [tables addObject:downTab];
            }
        }
        else if (tab.column > currentTab.column) {
            [paths addObject:@"R"];
            if (tab.column+1 < 4) {
                rightTab.row = tab.row;
                rightTab.column = tab.column+1;
                [tables addObject:rightTab];
            }
//            if (tab.row-1 >= 0) {
//                upTab.row = tab.row-1;
//                upTab.column = tab.column;
//                [tables addObject:upTab];
//            }
            if (tab.row+1 < 4) {
                downTab.row = tab.row+1;
                downTab.column = tab.column;
                [tables addObject:downTab];
            }
        }
        else if (tab.row > currentTab.row) {
            [paths addObject:@"D"];
            if (tab.column-1 >= 0) {
                leftTab.row = tab.row;
                leftTab.column = tab.column-1;
                [tables addObject:leftTab];
            }
            if (tab.column+1 < 4) {
                rightTab.row = tab.row;
                rightTab.column = tab.column+1;
                [tables addObject:rightTab];
            }
            if (tab.row+1 < 4) {
                downTab.row = tab.row+1;
                downTab.column = tab.column;
                [tables addObject:downTab];
            }
        }
        else if (tab.row < currentTab.row) {
            [paths addObject:@"U"];
            if (tab.column-1 >= 0) {
                leftTab.column = tab.column-1;
                leftTab.row = tab.row;
                [tables addObject:leftTab];
            }
            if (tab.column+1 < 4) {
                rightTab.column = tab.column+1;
                rightTab.row = tab.row;
                [tables addObject:rightTab];
            }
            if (tab.row-1 >= 0) {
                upTab.row = tab.row-1;
                upTab.column = tab.column;
                [tables addObject:upTab];
            }
        }
        
        currentTab.row = tab.row;
        currentTab.column = tab.column;
        
        if ([array isEqual:newArray]) {
            stop = YES;
            break;
        } else {
            [self updateByLoops:tables];
//            BOOL exist = false;
//            for (NSArray *item in container) {
//                if ([item isEqual:tables]) {
//                    exist = true;
//                    break;
//                }
//            }
//            
//            if (!exist) {
//                [container addObject:tables];
//                [self updateByLoops:tables];
//            } else {
//                [paths removeLastObject];
//            }
        }
    }
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

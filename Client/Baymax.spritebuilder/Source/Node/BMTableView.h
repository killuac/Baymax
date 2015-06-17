//
//  BMTableView.h
//  Baymax
//
//  Created by Killua Liu on 6/13/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCScrollView.h"
#import "BMTableViewCell.h"

#define DEFAULT_TABLE_VIEW  @"TableView"

typedef NS_ENUM(NSInteger, BMTableViewStyle) {
    BMTableViewStylePlain,                  // regular table view
    BMTableViewStyleGrouped                 // preferences style table view
};

@protocol BMTableViewDataSource;
@protocol BMTableViewDelegate;

@interface BMTableView : CCScrollView {
    BOOL _visibleRowsDirty;
    NSMutableArray *_rows;
    NSRange _currentlyVisibleRange;
}

+ (instancetype)tableViewWithStyle:(BMTableViewStyle)style;     // Use default CCB file name "TableView"
+ (instancetype)tableViewWithCCBNamed:(NSString *)name style:(BMTableViewStyle)style;

- (void)setupWithStyle:(BMTableViewStyle)style;

@property (nonatomic, weak) id <BMTableViewDelegate> delegate;
@property (nonatomic, weak) id <BMTableViewDataSource> dataSource;

@property (nonatomic, assign, readonly) BMTableViewStyle style;
@property (nonatomic, assign, readonly) CGFloat margin;

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

- (BMTableViewCell *)selectedCell;
- (BMTableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath;

/** The height of the rows. The unit depends on rowHeightUnit and defaults to points.
 @note Changing the row height calls reloadData. */
@property (nonatomic, assign) CGFloat rowHeight;    // Default 44

/** The size scale type for row Height, one of CCSizeUnit. Defaults to CCSizeUnitPoints (rowHeight is in points). */
@property (nonatomic, assign) CCSizeUnit rowHeightUnit;

/** Returns the rowHeight in points, properly converting the rowHeight value based on rowHeightUnit. */
@property (nonatomic, readonly) CGFloat rowHeightInPoints;

/** Removes all cells from memory and requests a new set of cells from the dataSource.
 Assigning a different dataSource and changing the rowHeight will cause reloadData to run.
 @warning Depending on which and how many nodes are in the table view and how the dataSource is implemented this operation can be potentially expensive
 as cells are first removed from the table view and requested anew from the dataSource. */
- (void)reloadData;

/** Block that is executed when a row is selected (tapped, clicked).
 **Objective-C:**
 
 tableView.block = ^(id sender) {
 NSLog(@"row selected: %i", (int)tableView.selectedRow);
 };
 
 **Swift:**
 
 tableView.block = {(sender: AnyObject!) in
 NSLog("row selected: %i", Int(tableView.selectedRow))
 }
 */
@property (nonatomic, copy) void(^block)(id sender);

/** Selector that is executed when a row is selected (tapped, clicked). The selector must take one parameter of type `id` and return void:
 **Objective-C:**
 
 -(void) onRowSelected:(id)sender {
 }
 
 **Swift:**
 
 func onRowSelected(sender: AnyObject!) {
 }
 
 @param target The object that should receive the selector.
 @param selector The selector to run, ie `@selector(onRowSelected:)`.
*/
-(void) setTarget:(id)target selector:(SEL)selector;

@end

#pragma mark - BMTableViewDataSource
@protocol BMTableViewDataSource <NSObject>

@required
- (NSUInteger)tableView:(BMTableView *)tableView numberOfRowsInSection:(NSUInteger)section;
- (BMTableViewCell *)tableView:(BMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (NSUInteger)numberOfSectionsInTableView:(BMTableView *)tableView;  // Default is 1 if not implemented

@end

#pragma mark - BMTableViewDelegate
@protocol BMTableViewDelegate <CCScrollViewDelegate>

@optional
- (CGFloat)tableView:(BMTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(BMTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

#pragma mark - NSIndexPath
// This category provides convenience methods to make it easier to use an NSIndexPath to represent a section and row
@interface NSIndexPath (BMTableView)

+ (NSIndexPath *)indexPathForRow:(NSUInteger)row inSection:(NSUInteger)section;

@property (nonatomic, readonly) NSUInteger section;
@property (nonatomic, readonly) NSUInteger row;

@end
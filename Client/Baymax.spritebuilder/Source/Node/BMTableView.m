//
//  BMTableView.m
//  Baymax
//
//  Created by Killua Liu on 6/13/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMTableView.h"
#import <objc/message.h>
#import "BMTabBarScene.h"

#define DEFAULT_ROW_HEIGHT  44


#pragma mark - BMTableView+Helper
@interface BMTableView (Helper)

- (void)updateVisibleRows;
- (void)markVisibleRowsDirty;

@end

#pragma mark - BMTableViewCellHolder
@interface BMTableViewCellHolder : NSObject

@property (nonatomic, strong) CCNode *cell;

@end

@implementation BMTableViewCellHolder
@end

#pragma mark - BMTableViewContentNode
@interface BMTableViewContentNode : CCNode
@end

@implementation BMTableViewContentNode

- (void)setPosition:(CGPoint)position
{
    [super setPosition:position];
    
    BMTableView* tableView = (BMTableView*)self.parent;
    [tableView markVisibleRowsDirty];
    [tableView updateVisibleRows];
}

@end


#pragma mark - BMTableView

@implementation BMTableView

@synthesize delegate = _delegate;

+ (instancetype)tableViewWithCCBNamed:(NSString *)name style:(BMTableViewStyle)style
{
    BMTableView *tableView = (BMTableView *)[CCBReader load:name];
    [tableView setupWithStyle:style];
    return tableView;
}

+ (instancetype)tableViewWithStyle:(BMTableViewStyle)style
{
    return [self tableViewWithCCBNamed:DEFAULT_TABLE_VIEW style:style];
}

- (void)didLoadFromCCB
{
    if ([self navigationBar]) {
        CGFloat height = SCREEN_HEIGHT - [self navigationBar].contentSize.height - [self tabBar].contentSize.height;
        self.position = ccp(self.position.x, [self navigationBar].contentSize.height);
        self.contentSize = CGSizeMake(self.contentSize.width, height);
    }
}

- (void)setupWithStyle:(BMTableViewStyle)style
{
    _style = style;
}

- (BMNavigationBar *)navigationBar
{
    return [(id)self.parent respondsToSelector:@selector(navigationBar)] ? (BMNavigationBar *)[(id)self.parent navigationBar] : nil;
}

- (BMTabBar *)tabBar
{
    return [[self tabBarScene] respondsToSelector:@selector(tabBar)] ? (BMTabBar *)[[self tabBarScene] tabBar] : nil;
}

- (BMTabBarScene *)tabBarScene
{
    return (BMTabBarScene *)self.parent.parent.parent;
}

- (CGFloat)margin
{
    return (BMTableViewStyleGrouped == _style) ? _margin : 0.0f;
}

#if __CC_PLATFORM_IOS
/**
 For correct responding table view scroll. If the table view is visible, but its parent is invisible,
 it shouldn't handle the table view's action, otherwise, the correct table view's action will be intercepted.
 It leads to table view can't scoll. So need check if table view's parent is visible.
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(CCTouch *)touch
{
    if (!self.parent.visible) return NO;
    return [super gestureRecognizer:gestureRecognizer shouldReceiveTouch:touch];
}
#endif

- (BMTableViewCell *)selectedCell
{
    return [self cellForRowAtIndexPath:[self selectedIndexPath]];
}

- (BMTableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_cellHolders[indexPath.row+[self totcalRowCountInSections:indexPath.section]] cell];
}

- (id)init
{
    if (self = [super init]) {
        _margin = 10;
        _hasBorderLine = YES;
        
        self.contentNode = [BMTableViewContentNode node];
        
        self.contentNode.contentSizeType = CCSizeTypeMake(CCSizeUnitNormalized, CCSizeUnitPoints);
        
        _rowHeight = DEFAULT_ROW_HEIGHT;
        _rowHeightUnit = CCSizeUnitPoints;
        self.horizontalScrollEnabled = NO;
        
        _visibleRowsDirty = YES;
    }
    return self;
}

- (NSUInteger)sectionCount
{
    if ([_dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return [_dataSource numberOfSectionsInTableView:self];
    } else {
        return 1;
    }
}

- (NSUInteger)rowCountInSection:(NSUInteger)sectionNumber
{
    return [_dataSource tableView:self numberOfRowsInSection:sectionNumber];
}

- (NSUInteger)totcalRowCountInSections:(NSUInteger)sectionCount
{
    NSUInteger rowCount = 0;
    for (NSUInteger i = 0; i < sectionCount; i++) {
        rowCount += [self rowCountInSection:i];
    }
    return rowCount;
}

- (NSUInteger)totalRowCount
{
    NSUInteger rowCount = 0;
    for (NSUInteger i = 0; i < [self sectionCount]; i++) {
        rowCount += [self rowCountInSection:i];
    }
    return rowCount;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        return [_delegate tableView:self heightForRowAtIndexPath:indexPath];
    } else {
        return DEFAULT_ROW_HEIGHT;
    }
}

- (NSRange)visibleRangeForScrollPosition:(CGFloat)scrollPosition
{
    CGFloat positionScale = [CCDirector sharedDirector].UIScaleFactor;
    CGFloat deltaMargin = self.margin;
    
    if ([_delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        // Rows may have different heights
        NSUInteger startSection = 0;
        NSUInteger startRow = 0;
        NSUInteger rowCount = 0;
        CGFloat currentRowPos = 0;
        
        NSUInteger numVisibleRows = 1;
        CGFloat tableHeight = self.contentSizeInPoints.height;
        
        // Find start row
        for (NSUInteger section = 0; section < [self sectionCount]; section++) {
            for (NSUInteger row = 0; row < [self rowCountInSection:section]; row++) {
                // Increase row position
                CGFloat rowHeight = [self heightForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
                if (_rowHeightUnit == CCSizeUnitUIPoints) {
                    rowHeight *= positionScale;
                }
                currentRowPos += rowHeight;
                
                // Check if we are within visible range
                if (currentRowPos + deltaMargin >= scrollPosition) {
                    startSection = section;
                    startRow = row + rowCount;
                    goto find_end_row;
                }
            }
            rowCount += [self rowCountInSection:section];
            deltaMargin += self.margin * 2;
        }
        
    find_end_row:
        // Find end row
        for (NSUInteger section = startSection; section < [self sectionCount]; section++) {
            for (NSUInteger row = startRow; row < rowCount + [self rowCountInSection:section]; row++) {
                // Check if we are out of visible range
                if (currentRowPos + deltaMargin > scrollPosition + tableHeight){
                    goto done_if;
                }
                
                // Increase row position
                CGFloat rowHeight = [self heightForRowAtIndexPath:[NSIndexPath indexPathForRow:row+1 inSection:section]];
                if (_rowHeightUnit == CCSizeUnitUIPoints) {
                    rowHeight *= positionScale;
                }
                currentRowPos += rowHeight;
                
                numVisibleRows++;
            }
            rowCount += [self rowCountInSection:section];
            deltaMargin += self.margin * 2;
        }
        
    done_if:
        // Handle potential edge case
        if ((startRow + numVisibleRows) > [self totalRowCount]) {
            numVisibleRows -= 1;
        }
        
        return NSMakeRange(startRow, numVisibleRows);
    }
    else {
        // All rows have the same height
        NSUInteger totalNumRows = [self totalRowCount];
        
        NSUInteger startRow = clampf(floorf(scrollPosition/self.rowHeightInPoints), 0, totalNumRows - 1);
        NSUInteger numVisibleRows = floorf(self.contentSizeInPoints.height/self.rowHeightInPoints) + 2;
        
        if (0 == deltaMargin) goto done_else;
        for (NSUInteger section = 0, rowCount = 0; section < [self sectionCount]; section++) {
            for (NSUInteger row = 0; row < [self rowCountInSection:section]; row++) {
                if (startRow == row + rowCount) {
                    startRow = clampf(floorf(scrollPosition/(self.rowHeightInPoints+deltaMargin/startRow)), 0, totalNumRows - 1);
                    goto done_else;
                }
            }
            rowCount += [self rowCountInSection:section];
            deltaMargin += self.margin * 2;
        }
        
    done_else:
        // Make sure we are in range
        if (startRow + numVisibleRows >= totalNumRows) {
            numVisibleRows = totalNumRows - startRow;
        }
        
        return NSMakeRange(startRow, numVisibleRows);
    }
}

- (CGFloat)locationForCellWithIndexPath:(NSIndexPath *)indexPath
{
    if (!_delegate) return 0;
    
    CGFloat location = 0;
    NSUInteger rowCount = [self totcalRowCountInSections:indexPath.section] + indexPath.row;
    
    if ([_delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        for (NSUInteger i = 0; i < rowCount; i++) {
            location += [self heightForRowAtIndexPath:indexPath];
        }
    } else {
        location += rowCount * _rowHeight;
    }
    
    if (_rowHeightUnit == CCSizeUnitUIPoints) {
        location *= [CCDirector sharedDirector].UIScaleFactor;
    }
    
    return location;
}

- (void)showRowsForRange:(NSRange)range
{
    if (NSEqualRanges(range, _currentlyVisibleRange) || _cellHolders.count == 0) return;
    
    for (NSUInteger oldIdx = _currentlyVisibleRange.location; oldIdx < NSMaxRange(_currentlyVisibleRange); oldIdx++) {
        if (!NSLocationInRange(oldIdx, range)) {
            BMTableViewCellHolder *holder = [_cellHolders objectAtIndex:oldIdx];
            if (holder) {
                [holder.cell removeFromParent];
//                holder.cell = nil;
            }
        }
    }
    
    CGFloat deltaMargin = self.margin;
    for (NSUInteger section = 0, rowCount = 0; section < [self sectionCount]; section++) {
        for (NSUInteger row = 0; row < [self rowCountInSection:section]; row++) {
            NSUInteger newIdx = row + rowCount;
            if (newIdx < range.location) continue;
            if (newIdx >= NSMaxRange(range)) goto done;
            
            if (!NSLocationInRange(newIdx, _currentlyVisibleRange)) {
                BMTableViewCellHolder* holder = [_cellHolders objectAtIndex:newIdx];
                if (!holder.cell) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
                    if (0 == row || row == [self rowCountInSection:section]-1) {
                        holder.cell = [BMTableViewSection node];
                        [self.contentNode addChild:holder.cell];
                    }
                    
                    BMTableViewCell *cell = [_dataSource tableView:self cellForRowAtIndexPath:indexPath];
                    holder.cell = cell;
                    [self.contentNode addChild:cell];
                    cell.indexPath = indexPath;
                    cell.position = CGPointMake(self.margin, [self locationForCellWithIndexPath:indexPath] + deltaMargin);
                    cell.positionType = CCPositionTypeMake(CCPositionUnitPoints, CCPositionUnitPoints, CCPositionReferenceCornerTopLeft);
                    cell.contentSize = CGSizeMake(cell.contentSize.width - 2*self.margin, [self heightForRowAtIndexPath:indexPath]);
                } else {
                    [self.contentNode addChild:holder.cell];
                }
            }
        }
        
        rowCount += [self rowCountInSection:section];
        deltaMargin += self.margin * 2;
    }
    
done:
    _currentlyVisibleRange = range;
}

- (void)markVisibleRowsDirty
{
    _visibleRowsDirty = YES;
}

- (void)updateVisibleRows
{
    if (_visibleRowsDirty) {
        [self showRowsForRange:[self visibleRangeForScrollPosition:-self.contentNode.position.y]];
        _visibleRowsDirty = NO;
    }
}

- (CGFloat)heightIncrement
{
    CGFloat increment = self.margin;
    for (NSInteger section = 0; section < [self sectionCount]; section++) {
        increment += self.margin * 2;
    }
    return increment;
}

- (void)reloadData
{
    _currentlyVisibleRange = NSMakeRange(0, 0);
    
    [self.contentNode removeAllChildrenWithCleanup:YES];
    
    if (!_dataSource) return;
    
    // Resize the content node
    NSUInteger rowCount = [self totalRowCount];
    CGFloat layerHeight = 0;
    
    if ([_delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        for (NSInteger section = 0; section < [self sectionCount]; section++) {
            for (int row = 0; row < [self rowCountInSection:section]; row++) {
                layerHeight += [self heightForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
            }
        }
    } else {
        layerHeight = rowCount * _rowHeight;
    }
    
    self.contentNode.contentSize = CGSizeMake(1, layerHeight + [self heightIncrement]);
    self.contentNode.contentSizeType = CCSizeTypeMake(CCSizeUnitNormalized, _rowHeightUnit);
    
    // Create empty placeholders for all rows
    _cellHolders = [NSMutableArray arrayWithCapacity:rowCount];
    for (int i = 0; i < rowCount; i++) {
        [_cellHolders addObject:[[BMTableViewCellHolder alloc] init]];
    }
    
    // Update scroll position
    self.scrollPosition = self.scrollPosition;
    
    [self markVisibleRowsDirty];
    [self updateVisibleRows];
}

- (void)setDataSource:(id <BMTableViewDataSource>)dataSource
{
    if (_dataSource != dataSource) {
        _dataSource = dataSource;
        [self reloadData];
    }
}

- (CGFloat)rowHeightInPoints
{
    if (_rowHeightUnit == CCSizeUnitPoints) {
        return _rowHeight;
    } else if (_rowHeightUnit == CCSizeUnitUIPoints) {
        return _rowHeight * [CCDirector sharedDirector].UIScaleFactor;
    } else {
        NSAssert(NO, @"Only point and scaled units are supported for row height");
        return 0;
    }
}

- (void)visit:(CCRenderer *)renderer parentTransform:(const GLKMatrix4 *)parentTransform
{
    [self updateVisibleRows];
    [super visit:renderer parentTransform:parentTransform];
}

- (void)setRowHeight:(CGFloat)rowHeight
{
    if (_rowHeight != rowHeight) {
        _rowHeight = rowHeight;
        [self reloadData];
    }
}

- (void)setContentSize:(CGSize)contentSize
{
    [super setContentSize:contentSize];
    [self markVisibleRowsDirty];
}

- (void)setContentSizeType:(CCSizeType)contentSizeType
{
    [super setContentSizeType:contentSizeType];
    [self markVisibleRowsDirty];
}

- (void)onEnter
{
    [super onEnter];
    [self markVisibleRowsDirty];
}

#pragma mark Action Handling

- (void)setTarget:(id)target selector:(SEL)selector
{
    __weak id weakTarget = target; // avoid retain cycle
    [self setBlock:^(id sender) {
        typedef void (*Func)(id, SEL, id);
        ((Func)objc_msgSend)(weakTarget, selector, sender);
    }];
}

- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    
    if ([_delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [_delegate tableView:self didSelectRowAtIndexPath:indexPath];
    } else {
        [self triggerAction];
    }
}

- (void)triggerAction {
    if (self.userInteractionEnabled && _block) {
        _block(self);
    }
}

@end

#pragma mark - NSIndexPath
@implementation NSIndexPath (BMTableView)

+ (NSIndexPath *)indexPathForRow:(NSUInteger)row inSection:(NSUInteger)section
{
    return [[self alloc] initForRow:row inSection:section];
}

- (instancetype)initForRow:(NSUInteger)row inSection:(NSUInteger)section
{
    if (self = [self init]) {
        objc_setAssociatedObject(self, @selector(row), @(row), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, @selector(section), @(section), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return self;
}

- (NSUInteger)section
{
    return [objc_getAssociatedObject(self, @selector(section)) unsignedIntegerValue];
}

- (NSUInteger)row
{
    return [objc_getAssociatedObject(self, @selector(row)) unsignedIntegerValue];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p | Section = %tu | Row = %tu >", [self class], self, self.section, self.row];
}

@end

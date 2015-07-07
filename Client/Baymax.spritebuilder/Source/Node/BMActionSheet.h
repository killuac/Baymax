//
//  BMActionSheet.h
//  Baymax
//
//  Created by Killua Liu on 6/25/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCNode.h"

@protocol BMActionSheetDelegate;

@interface BMActionSheet : CCNode {
    CCLayoutBox *_buttonsBox;
}

@property (nonatomic, weak) id <BMActionSheetDelegate> delegate;

@property (nonatomic, weak, readonly) CCButton *cancelButton;
@property (nonatomic, weak, readonly) CCButton *destructiveButton;

+ (instancetype)actionSheet;
+ (instancetype)actionSheetWithCancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle;

- (void)addButtonWithTitle:(NSString *)title;

- (void)show;
- (void)dismiss;

@end

@protocol BMActionSheetDelegate <NSObject>

@optional
- (void)actionSheet:(BMActionSheet *)actionSheet clickedButton:(CCButton *)button;

@end

//
//  BMOrderTableViewCell.h
//  Baymax
//
//  Created by Killua Liu on 7/6/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMTableViewCell.h"

@interface BMOrderTableViewCell : BMTableViewCell

@property (nonatomic, weak, readonly) CCLabelTTF *titleLabel;
@property (nonatomic, weak, readonly) CCLabelTTF *createTimeLabel;
@property (nonatomic, weak, readonly) CCLabelTTF *serviceTimeLabel;
@property (nonatomic, weak, readonly) CCLabelTTF *statusLabel;
@property (nonatomic, weak, readonly) CCLabelTTF *amountLabel;

@end

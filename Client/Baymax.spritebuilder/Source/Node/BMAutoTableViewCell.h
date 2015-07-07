//
//  BMAutoTableViewCell.h
//  Baymax
//
//  Created by Killua Liu on 6/22/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMTableViewCell.h"

@interface BMAutoTableViewCell : BMTableViewCell

@property (nonatomic, weak, readonly) CCLabelTTF *titleLabel;
@property (nonatomic, weak, readonly) CCLabelTTF *modelLabel;
@property (nonatomic, weak, readonly) CCLabelTTF *plateNoLabel;
@property (nonatomic, weak, readonly) CCLabelTTF *mainCountLabel;

@end

//
//  BMAutoTableViewCell.h
//  Baymax
//
//  Created by Killua Liu on 6/22/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMTableViewCell.h"

@interface BMAutoTableViewCell : BMTableViewCell

@property (nonatomic, weak) CCLabelTTF *titleLabel;
@property (nonatomic, weak) CCLabelTTF *modelLabel;
@property (nonatomic, weak) CCLabelTTF *plateNoLabel;
@property (nonatomic, weak) CCLabelTTF *mainCountLabel;

@end

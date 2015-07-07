//
//  BMPlateTableViewCell.h
//  Baymax
//
//  Created by Killua Liu on 7/6/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMTableViewCell.h"

@interface BMPlateTableViewCell : BMTableViewCell

@property (nonatomic, weak, readonly) CCLayoutBox *plateBox;
@property (nonatomic, weak, readonly) CCLabelTTF *abbreviationLabel;

@end

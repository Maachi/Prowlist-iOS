//
//  SmallUserCell.h
//  Prowlist
//
//  Created by Sebastian Romero on 5/23/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProwlistTheme.h"

@interface SmallUserCell : UIView
@property (weak, nonatomic) IBOutlet UIView *frameS;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) id <ProwlistTheme> theme;

- (void) initialize;

@end

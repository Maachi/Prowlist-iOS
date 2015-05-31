//
//  SmallUserCell.h
//  Prowlist
//
//  Created by Sebastian Romero on 5/23/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProwlistTheme.h"


@protocol SmallUserCellDelegate <NSObject>

@optional
- (void) cellSelected:(UIView *)cell;

@end

@interface SmallUserCell : UIView
@property (nonatomic) int imageSize;
@property (weak, nonatomic) IBOutlet UIView *frameS;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) id <ProwlistTheme> theme;
@property (nonatomic,assign) id <SmallUserCellDelegate> delegate;

- (void) initialize;

@end

//
//  VenueCell.h
//  Prowlist
//
//  Created by Sebastian Romero on 7/06/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProwlistTheme.h"

@interface VenueCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *imageWrapper;
@property (weak, nonatomic) IBOutlet UIButton *tagButton;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) NSString *imagePath;

@property (strong, nonatomic) id <ProwlistTheme> theme;
@property (weak, nonatomic) IBOutlet UIView *tagsWrapper;

@property (strong, nonatomic) NSString *title;
@property (weak, nonatomic) IBOutlet UIView *content;
-(void) resizeImageCellWithValue:(CGFloat)value;
-(void) render;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *smallDescriptionLabel;
-(void) changeColorWithColor:(NSArray *) colorArray;
-(void) buildTagsInView:(NSSet *) tagsArray;
@end

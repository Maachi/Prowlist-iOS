//
//  VenueCell.m
//  Prowlist
//
//  Created by Sebastian Romero on 7/06/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+Util.h"
#import "VenueCell.h"
#import "Tag.h"

@implementation VenueCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


-(void) render {
    _theme = [ProwlistThemeManager sharedTheme];
    if([_smallDescriptionLabel.text isEqualToString:@""]){
        
        [_smallDescriptionLabel.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
            if ((constraint.firstItem == _smallDescriptionLabel) && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
                if (constraint.constant>0){
                    constraint.constant = 0;
                }
            }
        }];
    }
    //[_theme roundCorners:_tagButton];
}

-(void) setTitle:(NSString *)title {
    _title = title;
}


-(void) resizeImageCellWithValue:(CGFloat)value {
    if(value<= 0){
        [self.content.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
            if ((constraint.firstItem == self.imageWrapper) && (constraint.firstAttribute == NSLayoutAttributeTop)) {
                constraint.constant = value - 8;
            }
        }];
    } else {
        [self.content.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
            if ((constraint.secondItem == self.imageWrapper) && (constraint.secondAttribute == NSLayoutAttributeBottom)) {
                constraint.constant = (8 + value)*-1;
            }
        }];
    }
}


- (void) setImagePath:(NSString *)imagePath {
    _imagePath = [imagePath imagePathService];
    _imagePath = [_imagePath stringByReplacingOccurrencesOfString:@"[WIDTH]x[HEIGHT]" withString:[NSString stringWithFormat:@"%dx%d", 800, 400]];
    if(_imagePath){
        [_image sd_setImageWithURL:[NSURL URLWithString:_imagePath]
                          placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                     
                                 }];
    }
}


- (UIColor *) arrayToColor:(NSArray *)colorArray {
    UIColor *color = [UIColor whiteColor];
    
    if (colorArray.count >1  && colorArray.count<4){
        float alpha = 1;
        if(colorArray.count == 4){
            alpha = [[colorArray objectAtIndex:3] floatValue];
        }
        color = [UIColor colorWithRed:[[colorArray objectAtIndex:0] floatValue]/255.0 green:[[colorArray objectAtIndex:1] floatValue]/255.0 blue:[[colorArray objectAtIndex:2] floatValue]/255.0 alpha:alpha];
    }
    return color;
}


-(void) buildTagsInView:(NSSet *) tagsArray {
    
    if(tagsArray){
        int i = 0;
        float xPos = 0;
        for (Tag *tag in tagsArray){
            CGSize stringsize =  [[tag.label uppercaseString] sizeWithAttributes:@{
                                    NSFontAttributeName:[UIFont boldSystemFontOfSize:10]
                                }];
            UIButton *labelView = [[UIButton alloc] initWithFrame:CGRectMake(xPos, 0, stringsize.width+10, 20)];
            labelView.titleLabel.font = [UIFont boldSystemFontOfSize:10];
            [labelView setTitle:[tag.label uppercaseString] forState:UIControlStateNormal];
            labelView.backgroundColor = [self.theme arrayToColorWithDictionary:tag.tint];
            [labelView setTitleColor:[self.theme arrayToColorWithDictionary:tag.textColor] forState:UIControlStateNormal];
            [_tagsWrapper addSubview:labelView];
            labelView.layer.cornerRadius = 5;
            labelView.layer.masksToBounds = YES;
            i++;
            xPos+=(stringsize.width+10)+5;
        }
    }
}


-(void) changeColorWithColor:(NSArray *) colorArray {
    if (colorArray.count >1  && colorArray.count<4){
        float alpha = 1;
        if(colorArray.count == 4){
            alpha = [[colorArray objectAtIndex:3] floatValue];
        }
        UIColor *color = [UIColor colorWithRed:[[colorArray objectAtIndex:0] floatValue]/255.0 green:[[colorArray objectAtIndex:1] floatValue]/255.0 blue:[[colorArray objectAtIndex:2] floatValue]/255.0 alpha:alpha];
        _titleLabel.textColor = _smallDescriptionLabel.textColor = color;
    } else {
        //leave the color as it is...
    }
}

@end

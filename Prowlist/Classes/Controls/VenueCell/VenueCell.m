//
//  VenueCell.m
//  Prowlist
//
//  Created by Sebastian Romero on 7/06/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import "VenueCell.h"

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


-(void) buildTagsInView:(NSArray *) tagsArray {
    
    if(tagsArray){
        int i = 0;
        float xPos = 0;
        for (NSDictionary *tag in tagsArray){
            CGSize stringsize = [[tag objectForKey:@"label"] sizeWithFont:[UIFont boldSystemFontOfSize:11]];
            UIButton *labelView = [[UIButton alloc] initWithFrame:CGRectMake(xPos, 0, stringsize.width+10, 20)];
            labelView.titleLabel.font = [UIFont boldSystemFontOfSize:11];
            [labelView setTitle:[tag objectForKey:@"label"] forState:UIControlStateNormal];
            labelView.backgroundColor = [self arrayToColor:[tag objectForKey:@"tint"]];
        
            [labelView setTitleColor:[self arrayToColor:[tag objectForKey:@"textColor"]] forState:UIControlStateNormal];
            
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

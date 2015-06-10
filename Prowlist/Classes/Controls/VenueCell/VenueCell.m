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
    [_theme roundCorners:_tagButton];
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
            NSLog(@"Hola mundo, %ld", (long)constraint.secondAttribute);
            if ((constraint.secondItem == self.imageWrapper) && (constraint.secondAttribute == NSLayoutAttributeBottom)) {
                constraint.constant = (8 + value)*-1;
            }
        }];
    }
}

@end

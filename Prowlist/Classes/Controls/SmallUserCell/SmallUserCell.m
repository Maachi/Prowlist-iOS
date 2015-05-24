//
//  SmallUserCell.m
//  Prowlist
//
//  Created by Sebastian Romero on 5/23/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import "SmallUserCell.h"

@implementation SmallUserCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) initialize {
    _theme = [ProwlistThemeManager sharedTheme];
    [_theme roundCorners:_frameS];
}


- (IBAction)likeAction:(id)sender {
}

- (IBAction)commentsAction:(id)sender {
}

- (IBAction)cellAction:(id)sender {
    if (_delegate){
        if([_delegate respondsToSelector:@selector(cellSelected:)]){
            [_delegate cellSelected:self];
        }
    }
}

@end

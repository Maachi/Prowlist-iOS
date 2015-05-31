//
//  MenuBase.m
//  Prowlist
//
//  Created by Sebastian Romero on 5/31/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import "MenuBase.h"

@implementation MenuBase

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void) didMoveToSuperview {
    [super didMoveToSuperview];
    _theme = [ProwlistThemeManager sharedTheme];
    [_theme styleRoudCornersThumb:self.thumb];
}

@end

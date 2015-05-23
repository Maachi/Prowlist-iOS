//
//  BlackTheme.m
//  Prowlist
//
//  Created by Sebastian Romero on 5/9/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import "BlackTheme.h"

@implementation BlackTheme


- (void) styleRoudCornersThumb:(UIView *)view {
    CALayer * layer = [view layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:view.frame.size.width/2];
}


- (void) roundCorners:(UIView *)view {
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
}

@end

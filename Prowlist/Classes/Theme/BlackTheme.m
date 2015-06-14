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


- (void) roundCornersButton:(UIView *)view {
    view.layer.cornerRadius = 2;
    view.layer.masksToBounds = YES;
}


-(UIImage *) tintImage:(UIImage *)image color:(UIColor*)color {
    return [image imageWithColor:color];
}

-(UIButton *) tintButtonWithColor:(UIButton *)button color:(UIColor*)color imageNamed:(NSString *)name
                            state:(UIControlState)state {
    UIImage *stateNormalBackground = [UIImage imageNamed:name];
    stateNormalBackground = [[self tintImage:stateNormalBackground color:color] resizableImageWithCapInsets:UIEdgeInsetsMake(3, 3, 3, 3)];
    [button setImage:stateNormalBackground forState:state];
    [button setTitleColor:color forState:state];
    return button;
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


@end

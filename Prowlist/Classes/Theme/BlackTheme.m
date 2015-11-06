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


-(void) styleTextField:(UITextField *)textField {
    UIColor *color = [UIColor colorWithRed:134.0 green:134.0 blue:134.0 alpha:.7];
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textField.placeholder attributes:@{NSForegroundColorAttributeName: color}];
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

- (UIColor *) arrayToColorWithDictionary:(NSDictionary *)colorDictionary {
    UIColor *color = [UIColor whiteColor];
    if (colorDictionary){
        float alpha = 1;
        if([colorDictionary objectForKey:@"alpha"]){
            alpha = [[colorDictionary objectForKey:@"alpha"] floatValue];
        }
        color = [UIColor colorWithRed:[[colorDictionary objectForKey:@"red"] floatValue]/255.0 green:[[colorDictionary objectForKey:@"green"] floatValue]/255.0 blue:[[colorDictionary objectForKey:@"blue"] floatValue]/255.0 alpha:alpha];
    }
    return color;
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

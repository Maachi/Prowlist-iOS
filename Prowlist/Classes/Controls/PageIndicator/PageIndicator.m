//
//  PageIndicator.m
//  Prowlist
//
//  Created by Sebastian Romero on 5/10/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import "PageIndicator.h"


@interface PageIndicator (){
    NSArray *colors;
    int selectedIndex;
}

@end

@implementation PageIndicator

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void ) selectItem:(int) index {
    if (selectedIndex>=0){
        [UIView animateWithDuration:.5 animations:^{
            UIView *step  = [self.subviews objectAtIndex:selectedIndex];
            CGRect frame = step.frame;
            frame.size.height = self.frame.size.height;
            frame.origin.y = 0;
            step.frame = frame;
        } completion:^(BOOL finished) {
        }];
    }
    
    selectedIndex = index;
    [UIView animateWithDuration:.5 animations:^{
        UIView *step  = [self.subviews objectAtIndex:index];
        CGRect frame = step.frame;
        frame.size.height = 10;
        frame.origin.y = -7;
        step.frame = frame;
    } completion:^(BOOL finished) {
    }];
}


- (UIView *) createViewStep:(int) index {
    float width = self.frame.size.width/_pages;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(width*index, 0, width, self.frame.size.height)];
    view.backgroundColor = [colors objectAtIndex:index];
    [self addSubview:view];
    return view;
}



- (void) setPages:(int)pages {
    _pages = pages;
    colors = @[
               [UIColor colorWithRed:35.0/255.0 green:35.0/255.0 blue:35.0/255.0 alpha:1],
               [UIColor colorWithRed:191.0/255.0 green:51.0/255.0 blue:5.0/255.0 alpha:1],
               [UIColor colorWithRed:128.0/255.0 green:168.0/255.0 blue:204.0/255.0 alpha:1],
               [UIColor colorWithRed:247.0/255.0 green:207.0/255.0 blue:23.0/255.0 alpha:1],
               [UIColor redColor],
               [UIColor yellowColor],
               ];
    for (int i = 0; i<pages; i++){
        [self createViewStep:i];
    }
    [self selectItem:0];
}

@end

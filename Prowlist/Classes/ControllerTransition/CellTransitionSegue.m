//
//  CellTransitionSegue.m
//  Prowlist
//
//  Created by Sebastian Romero on 5/8/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import "CellTransitionSegue.h"
#define kTransitionDuration     .5

@interface CellTransitionSegue() {
    
    UIView *viewDot;
}

@end

@implementation CellTransitionSegue

- (void)perform
{
    
    [self createDot];
    
    
    
    [UIView animateWithDuration:.5 animations:^{
        
        [viewDot setTransform:CGAffineTransformMakeScale(50.0, 50.0)];

    } completion:^(BOOL finished) {
        [self.sourceViewController presentViewController:self.destinationViewController
                                                animated:NO
                                              completion:^{
                                                  [viewDot removeFromSuperview];
                                              }];
    }];
    
}


-(void) createDot {
    float initialSize = 30;
    CGPoint position = [self.selectedCell.superview convertPoint:self.selectedCell.frame.origin toView:self.selectedCell.superview.superview];
    
    
    
    viewDot = [[UIView alloc] initWithFrame:CGRectMake(position.x + ((self.selectedCell.frame.size.width - initialSize )/2),position.y+ ((self.selectedCell.frame.size.height - initialSize )/2),initialSize,initialSize)];
    
    viewDot.layer.cornerRadius = 15;
    viewDot.backgroundColor = [UIColor blackColor];
    
    [self.selectedCell.superview.superview addSubview:viewDot];
}

@end

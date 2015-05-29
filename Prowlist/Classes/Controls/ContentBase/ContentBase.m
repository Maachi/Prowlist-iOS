//
//  ContentBase.m
//  Prowlist
//
//  Created by Sebastian Romero on 5/28/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import "ContentBase.h"

@implementation ContentBase

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void) showMoreInformation {
    [_moreInformation.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == _moreInformation) && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            //if (constraint.constant>0){
            constraint.constant = 280;
            //}
        }
    }];
    
    
    [UIView animateWithDuration:0.8
                          delay: 0
         usingSpringWithDamping: 0.8
          initialSpringVelocity:0.5
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _moreInformation.alpha = 1;
                         [_moreInformation layoutIfNeeded];
                         [self layoutIfNeeded];
                         
                     } completion:^(BOOL finished){
                     }];
    
    
    
}


-(void) hideMoreInformation{
    [_moreInformation.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == _moreInformation) && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            //if (constraint.constant>0){
            constraint.constant = 0;
            //}
        }
    }];
    
    
    [UIView animateWithDuration:0.8
                          delay: 0
         usingSpringWithDamping: 0.8
          initialSpringVelocity:0.5
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _moreInformation.alpha = 0;
                         [_moreInformation layoutIfNeeded];
                         [self layoutIfNeeded];
                         
                     } completion:^(BOOL finished){
                     }];
}

@end

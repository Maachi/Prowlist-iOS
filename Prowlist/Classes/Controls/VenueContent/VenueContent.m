//
//  VenueContent.m
//  Prowlist
//
//  Created by Sebastian Romero on 5/28/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import "VenueContent.h"

@interface VenueContent(){
    BOOL addedSuperView;
}
@end

@implementation VenueContent

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void) willMoveToSuperview:(UIView *)newSuperview {
    self.moreInformation.alpha = 0;
}


-(void) showMoreInformation {
    [self.moreInformation.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == self.moreInformation) && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            //if (constraint.constant>0){
            constraint.constant = 280;
            //}
        }
    }];
    
    [self.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == self.logo) && (constraint.firstAttribute == NSLayoutAttributeTop)) {
            if (constraint.constant>0){
                constraint.constant = self.superview.superview.frame.size.height - 255;
            }
        }
    }];
    
    
    [UIView animateWithDuration:0.8
                          delay: 0
         usingSpringWithDamping: 0.8
          initialSpringVelocity:0.5
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.moreInformation.alpha = 1;
                         [self.moreInformation layoutIfNeeded];
                         [self layoutIfNeeded];
                         
                     } completion:^(BOOL finished){
                     }];
    
    
    
}


-(void) hideMoreInformation{
    [self.moreInformation.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == self.moreInformation) && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            //if (constraint.constant>0){
            constraint.constant = 0;
            //}
        }
    }];
    
    [self.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == self.logo) && (constraint.firstAttribute == NSLayoutAttributeTop)) {
            if (constraint.constant>0){
                constraint.constant = self.superview.superview.frame.size.height - 420;
            }
        }
    }];
    
    
    [UIView animateWithDuration:0.8
                          delay: 0
         usingSpringWithDamping: 0.8
          initialSpringVelocity:0.5
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.moreInformation.alpha = 0;
                         [self.moreInformation layoutIfNeeded];
                         [self layoutIfNeeded];
                         
                     } completion:^(BOOL finished){
                     }];
}


-(void) adjustView {
    
    [self.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == self.logo) && (constraint.firstAttribute == NSLayoutAttributeTop)) {
            if (constraint.constant>0){
                constraint.constant = self.superview.superview.frame.size.height - 420;
            }
        }
    }];
}


-(void) addMapInformation {
    CLLocationCoordinate2D coord = {.latitude =  37.775, .longitude =  -122.4183333};
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coord, 400, 400);
    MKCoordinateRegion adjustedRegion = [_mapInfo regionThatFits:viewRegion];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:coord];
    [annotation setTitle:@"Axiom Hotel SF."]; //You can set the subtitle too
    [_mapInfo addAnnotation:annotation];
    [_mapInfo setRegion:adjustedRegion animated:NO];
    _mapInfo.userInteractionEnabled = NO;
}


- (void) layoutSubviews {
    if(!addedSuperView){
        addedSuperView = YES;
        [self adjustView];
        [self addMapInformation];
        CGRect frame = self.frame;
        frame.size.width = self.superview.frame.size.width;
    }
}

@end

//
//  Slide.m
//  Prowlist
//
//  Created by Sebastian Romero on 5/14/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import "Slide.h"

@implementation Slide

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(void) initialize {
    _scrollView.delegate = self;
}



#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //NSLog(@"Scrolling... %f", _scrollView.contentOffset.y);
    [_headerImage.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == _headerImage) && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            if (constraint.constant>0){
                if(560 +(_scrollView.contentOffset.y*-1) >= 50){
                    constraint.constant = 560 +(_scrollView.contentOffset.y*-1);
                }
            }
        }
    }];
}


@end

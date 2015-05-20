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
    //_scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    _scrollView.scrollEnabled = YES;
    self.mainScroll.delegate = self;
}



#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(scrollView == _scrollView){
        //self.mainScroll.delaysContentTouches = NO;
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
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if(scrollView == _scrollView){
        self.mainScroll.scrollEnabled = NO;
    } else {
        _scrollView.scrollEnabled = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == _scrollView){
        self.mainScroll.scrollEnabled = YES;
    } else {
        _scrollView.scrollEnabled = YES;
    }
}


@end

//
//  Slide.m
//  Prowlist
//
//  Created by Sebastian Romero on 5/14/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import "Slide.h"
#import "CellBase.h"

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
    
    [self adjustTitle];
    
    
    /*CellBase *cell = (CellBase *)[[[NSBundle mainBundle] loadNibNamed:@"CellBase" owner:self options:nil] firstObject];
    CGRect frame = cell.frame;
    frame.size.width = contentWrapper.frame.size.width - 60;
    frame.origin.x = 30;
    frame.origin.y = (index*(frame.size.height+20)) + 410;
    cell.frame = frame;
    
    [cell setOnSelect:^(CellBase *referenceCell) {
        selectedCell = referenceCell;
        [self performSegueWithIdentifier:@"showCityDetail" sender:self];
    }];
    
    
    [contentWrapper addSubview:cell];*/
}



-(void) adjustTitle {
    [_mainWrapper.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == _title) && (constraint.firstAttribute == NSLayoutAttributeTop)) {
            if (constraint.constant>0){
                constraint.constant = self.frame.size.height - 300;
            }
        }
    }];
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

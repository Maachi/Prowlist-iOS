//
//  Slide.m
//  Prowlist
//
//  Created by Sebastian Romero on 5/14/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import "Slide.h"
#import "CellBase.h"
#import "SmallUserCell.h"


@interface Slide()<SmallUserCellDelegate>
@property (weak, nonatomic) IBOutlet UIView *firstElement;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *itemsCollection;
@property (weak, nonatomic) IBOutlet UIView *photoCredits;

@end

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
    [self adjustCell];
   
    
    
    for (UIView *item in _itemsCollection) {
        SmallUserCell *cellC = (SmallUserCell *)[[[NSBundle mainBundle] loadNibNamed:@"SmallUserCell" owner:self options:nil] firstObject];
        [item addSubview:cellC];
        cellC.delegate = self;
        [cellC initialize];
        CGRect frame = cellC.frame;
        frame.size.width = item.frame.size.width;
        frame.size.height = item.frame.size.height;
        cellC.frame = frame;
    }
    
    
    [_mainWrapper.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == _mainWrapper) && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            if (constraint.constant>0){
                constraint.constant = 2200;
            }
        }
    }];
    
    
    [_photoCredits.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == _photoCredits) && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            if (constraint.constant>0){
                constraint.constant = 0;
            }
        }
    }];
    
    
    
    
    
    
    //_scrollView.contentSize = CGSizeMake(self.frame.size.width, 1800);
    
    
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


- (void) cellSelected:(UIView *)cell {
    [_scrollView setContentOffset:CGPointMake(0, self.frame.size.height/3 * -1) animated:YES];
    //[_parentController performSegueWithIdentifier:@"showPlace" sender:nil];
}


- (void) adjustCell {
    [_firstElement.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == _firstElement) && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            if (constraint.constant>0){
                constraint.constant = 250;
            }
        }
    }];
}



-(void) adjustTitle {
    [_mainWrapper.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == _title) && (constraint.firstAttribute == NSLayoutAttributeTop)) {
            if (constraint.constant>0){
                constraint.constant = self.frame.size.height - 400;
            }
        }
    }];
    
    /*
    [UIView animateWithDuration:0.8
                          delay: 0
         usingSpringWithDamping: 0.8
          initialSpringVelocity:0.5
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [_mainWrapper layoutIfNeeded];
                         
                     } completion:^(BOOL finished){
                     }];*/
    
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
        if(_scrollView.contentOffset.y < -120){
            
            
            [_mainWrapper.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
                if ((constraint.firstItem == _title) && (constraint.firstAttribute == NSLayoutAttributeTop)) {
                    if (constraint.constant>0){
                        constraint.constant = self.frame.size.height - 215;
                    }
                }
            }];
            
            [UIView animateWithDuration:0.8
                                  delay: 0
                 usingSpringWithDamping: 0.8
                  initialSpringVelocity:0.5
                                options: UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 [_mainWrapper layoutIfNeeded];
                                 
                             } completion:^(BOOL finished){
                                 
                                 [_photoCredits.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
                                     if ((constraint.firstItem == _photoCredits) && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
                                         //if (constraint.constant>0){
                                             constraint.constant = 150;
                                         //}
                                     }
                                 }];
                                 
                                 
                                 [UIView animateWithDuration:0.8
                                                       delay: 0
                                      usingSpringWithDamping: 0.8
                                       initialSpringVelocity:0.5
                                                     options: UIViewAnimationOptionCurveEaseInOut
                                                  animations:^{
                                                      _photoCredits.alpha = 1;
                                                    [_photoCredits layoutIfNeeded];
                                                      [_mainWrapper layoutIfNeeded];
                                                      
                                                  } completion:^(BOOL finished){
                                                  }];
                                 
                                 
                             }];
        } else if (_scrollView.contentOffset.y > 100){
            [_mainWrapper.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
                if ((constraint.firstItem == _title) && (constraint.firstAttribute == NSLayoutAttributeTop)) {
                    if (constraint.constant>0){
                        constraint.constant = self.frame.size.height - 400;
                    }
                }
            }];
            
            [_photoCredits.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
                if ((constraint.firstItem == _photoCredits) && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
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
                                 _photoCredits.alpha = 0;
                                 [_mainWrapper layoutIfNeeded];
                                 [_photoCredits layoutIfNeeded];
                                 
                             } completion:^(BOOL finished){
                                 
                             }];
        }
    }
}

-(void) enableMainScroll{
    _scrollView.scrollEnabled = YES;
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if(scrollView == _scrollView){
        self.mainScroll.scrollEnabled = NO;
    } else {
        _scrollView.scrollEnabled = NO;
        [self performSelector:@selector(enableMainScroll) withObject:self afterDelay:2];
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

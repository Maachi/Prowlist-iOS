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


@interface Slide()<SmallUserCellDelegate> {
    BOOL showController;
    int lastScrollYPosition;
}
@property (weak, nonatomic) IBOutlet UIView *firstElement;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *itemsCollection;
@property (weak, nonatomic) IBOutlet UIView *photoCredits;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *frameCollection;
@property (weak, nonatomic) IBOutlet UIView *thumbFrame;
@property (weak, nonatomic) IBOutlet UIImageView *imageDetail;
@property (strong, nonatomic) id <ProwlistTheme> theme;
@property (weak, nonatomic) IBOutlet UIButton *descriptionLabelButton;
@property (weak, nonatomic) IBOutlet UIView *wrapperCollection;

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
    _theme = [ProwlistThemeManager sharedTheme];
    [_theme styleRoudCornersThumb:_thumbFrame];
    [_theme styleRoudCornersThumb:_imageDetail];
    
    _thumbFrame.alpha = 0;
    
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
    lastScrollYPosition = _scrollView.contentOffset.y;
    showController = YES;
    
    [_mainWrapper.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == _thumbFrame) && (constraint.firstAttribute == NSLayoutAttributeTop)) {
            if (constraint.constant>0){
                constraint.constant = self.frame.size.height;
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
                         [self showControllerAnimated];
                     }];
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    //[_parentController performSegueWithIdentifier:@"showPlace" sender:nil];
}


- (void) adjustCell {
    [_firstElement.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == _firstElement) && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            if (constraint.constant>0){
                constraint.constant = 210;
            }
        }
    }];
    [_wrapperCollection.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == _wrapperCollection) && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            if (constraint.constant>0){
                constraint.constant = 490;
            }
        }
    }];
    
}



-(void) adjustTitle {
    [_mainWrapper.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == _thumbFrame) && (constraint.firstAttribute == NSLayoutAttributeTop)) {
            if (constraint.constant>0){
                constraint.constant = self.frame.size.height - 470;
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
        
        if(showController){
            return;
        }
        if(_scrollView.contentOffset.y < -120){
            
            
            [_mainWrapper.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
                if ((constraint.firstItem == _thumbFrame) && (constraint.firstAttribute == NSLayoutAttributeTop)) {
                    if (constraint.constant>0){
                        constraint.constant = self.frame.size.height - 325;
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
                if ((constraint.firstItem == _thumbFrame) && (constraint.firstAttribute == NSLayoutAttributeTop)) {
                    if (constraint.constant>0){
                        constraint.constant = self.frame.size.height - 470;
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


-(void) showControllerAnimated {
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    _title.text = @"The Langahm";
    
    
    _descriptionLabelButton.alpha = 0;
    [_descriptionLabelButton.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == _descriptionLabelButton) && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            //if (constraint.constant>0){
            constraint.constant = 0;
            //}
        }
    }];
    
    [_mainWrapper.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == _thumbFrame) && (constraint.firstAttribute == NSLayoutAttributeTop)) {
            if (constraint.constant>0){
                constraint.constant = self.frame.size.height -470;
            }
        }
    }];
    
    [UIView animateWithDuration:0.8
                          delay: 0
         usingSpringWithDamping: 0.8
          initialSpringVelocity:0.5
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _thumbFrame.alpha = 1;
                         [_mainWrapper layoutIfNeeded];
                         
                     } completion:^(BOOL finished){
                         
                     }];
}

- (void) scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if(showController){
        [self performSelector:@selector(showControllerAnimated) withObject:self afterDelay:0];
    }
}


@end

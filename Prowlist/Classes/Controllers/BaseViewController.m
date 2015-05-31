//
//  BaseViewController.m
//  Prowlist
//
//  Created by Sebastian Romero on 5/7/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import "BaseViewController.h"
#import "ContentBase.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate> {
    UIView *displayView;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideHeader];
    [self addEvents];
    _theme = [ProwlistThemeManager sharedTheme];
}


-(void) addMenu {
    _menuView = (UIView *)[[[NSBundle mainBundle] loadNibNamed:@"MenuBase" owner:self options:nil] firstObject];
    CGRect frame = _menuView.frame;
    frame.size.width = ((self.view.bounds.size.width / 2.0) + 50);
    frame.size.height = self.view.bounds.size.height;
    frame.origin.x = frame.size.width*-1;
    
    _menuView.frame = frame;
    [self.view addSubview:_menuView];
}


-(void) addEvents {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    pan.delegate = self;
    pan.maximumNumberOfTouches = 1;
    pan.delaysTouchesBegan =YES;
    pan.cancelsTouchesInView = YES;
    [self.view addGestureRecognizer:pan];
    
    _scrollView.canCancelContentTouches = NO;
}


- (void)handlePan:(UIPanGestureRecognizer *)gesture {
    CGPoint translate = [gesture translationInView:gesture.view];
    translate.y = 0.0;
    
    CGRect frameMade = CGRectMake(translate.x, translate.y, self.view.bounds.size.width, self.view.bounds.size.height);
    
    if (frameMade.origin.x>0 && frameMade.origin.x<(self.view.bounds.size.width / 2.0) + 50)
        self.view.frame = frameMade;
    
    
    if (gesture.state == UIGestureRecognizerStateCancelled ||
        gesture.state == UIGestureRecognizerStateEnded ||
        gesture.state == UIGestureRecognizerStateFailed)
    {
        
        CGPoint velocity = [gesture velocityInView:gesture.view];
        
        
        if (translate.x > 0.0 && (translate.x + velocity.x * 0.25) > (gesture.view.bounds.size.width / 2.0))
        {
            
            [UIView animateWithDuration:0.5
                                  delay: 0.0
                 usingSpringWithDamping: 1.0
                  initialSpringVelocity:0.5
                                options: UIViewAnimationOptionCurveLinear
                             animations:^{
                                 CGRect frame = self.view.frame;
                                 frame.origin.x = (self.view.bounds.size.width / 2.0) - 20;
                                 self.view.frame = frame;
                             }
                             completion:^(BOOL finished){
                             }];
            
        } else
        {
            [UIView animateWithDuration:0.5
                                  delay: 0.0
                 usingSpringWithDamping: 1.0
                  initialSpringVelocity:0.5
                                options: UIViewAnimationOptionCurveLinear
                             animations:^{
                                 CGRect frame = self.view.frame;
                                 frame.origin.x = 0;
                                 self.view.frame = frame;
                             }
                             completion:^(BOOL finished){
                             }];
            
        }
        
    }
}


-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self addMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


-(void) hideHeader{
    [self.header.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == self.header) && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
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
                         [self.header layoutIfNeeded];
                     } completion:^(BOOL finished){
                     }];
}



-(void) showHeader{
    [self.header.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == self.header) && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            //if (constraint.constant>0){
            constraint.constant = 70;
            //}
        }
    }];
    
    [UIView animateWithDuration:0.8
                          delay: 0
         usingSpringWithDamping: 0.8
          initialSpringVelocity:0.5
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.header layoutIfNeeded];
                     } completion:^(BOOL finished){
                     }];
}


- (void) initializeScroll {
    _scrollView.delegate = self;
}


- (void) displayView {
    
    displayView = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2 - 1000), (self.view.frame.size.height/2 - 1000),2000,2000)];
    displayView.backgroundColor = [UIColor blackColor];
    displayView.layer.cornerRadius = 1000;
    
    [self.view addSubview:displayView];
    
    
    [UIView animateWithDuration:.3 animations:^{
        [displayView setTransform:CGAffineTransformMakeScale(0.1, 0.1)];
        displayView.alpha = 0;
        
    } completion:^(BOOL finished) {
        [displayView removeFromSuperview];
    }];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //NSLog(@"Scrolling... %f", _scrollView.contentOffset.y);
    [_mainHeader.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == _mainHeader) && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            if (constraint.constant>0){
                if(560 +(_scrollView.contentOffset.y*-1) >= 50){
                    constraint.constant = 560 +(_scrollView.contentOffset.y*-1);
                }
            }
        }
    }];
    
    if(_scrollView.contentOffset.y < - 100){
        if(_contentScroll){
            [_contentScroll showMoreInformation];
        }
    } else if (_scrollView.contentOffset.y > 480){
        if(_contentScroll){
            [_contentScroll hideMoreInformation];
        }
    }
    
    if(_scrollView.contentOffset.y > _scrollView.frame.size.height - 360){
        [self showHeader];
    } else {
        [self hideHeader];
    }
}

@end

//
//  BaseViewController.m
//  Prowlist
//
//  Created by Sebastian Romero on 5/7/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController () {
    UIView *displayView;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _theme = [ProwlistThemeManager sharedTheme];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
}

@end

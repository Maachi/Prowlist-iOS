//
//  WalkthroughViewController.m
//  Prowlist
//
//  Created by Sebastian Romero on 5/9/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import "WalkthroughViewController.h"
#import "PageIndicator.h"

@interface WalkthroughViewController (){

    __weak IBOutlet PageIndicator *pageIndicator;
    NSInteger previousPage;
    __weak IBOutlet UILabel *titleFooter;
    __weak IBOutlet UIView *footer;
    NSArray *sections;
    __weak IBOutlet UIButton *startWIth;
}

@end

@implementation WalkthroughViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.delegate = self;
    sections = @[@"Personal", @"Upgraded", @"Tailored", @"Prowlist"];
}


- (void) viewDidAppear:(BOOL)animated {
    pageIndicator.pages = 4;
    titleFooter.text = [sections objectAtIndex:0];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width*4, self.view.frame.size.height);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) changeTitle:(NSString *)title {
    
    [footer.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == titleFooter) && (constraint.firstAttribute == NSLayoutAttributeTop)) {
            constraint.constant = 150;
        }
        if (![titleFooter.text isEqualToString:@"Prowlist"]){
            if ((constraint.firstItem == startWIth) && (constraint.firstAttribute == NSLayoutAttributeTop)) {
                constraint.constant = 80;
            }
        }
    }];
    
    [UIView animateWithDuration:.5 animations:^{
        [titleFooter layoutIfNeeded];
        [footer layoutSubviews];
        
        
        
    } completion:^(BOOL finished) {
        
        titleFooter.text = title;
        
        [footer.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
            if ((constraint.firstItem == titleFooter) && (constraint.firstAttribute == NSLayoutAttributeTop)) {
                constraint.constant = 20;
            }
            
            if ([titleFooter.text isEqualToString:@"Prowlist"]){
                if ((constraint.firstItem == startWIth) && (constraint.firstAttribute == NSLayoutAttributeTop)) {
                    constraint.constant = 0;
                }
            } else {
                if ((constraint.firstItem == startWIth) && (constraint.firstAttribute == NSLayoutAttributeTop)) {
                    constraint.constant = 80;
                }
            }
        }];
        
        
        
        [UIView animateWithDuration:.5 animations:^{
            [titleFooter layoutIfNeeded];
            [footer layoutSubviews];

        } completion:^(BOOL finished) {}];
        
        
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


- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    previousPage = 0;
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    [self changeTitle:[sections objectAtIndex:page]];
    
    if (previousPage != page) {
        previousPage = page;
        /* Page did change */
    }
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //NSLog(@"Scrolling... %f", self.scrollView.contentOffset.x);
    //if(self.scrollView.contentOffset.x < 0){
        [self.mainHeader.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
            if ((constraint.firstItem == self.mainHeader) && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
                if (constraint.constant>0){
                    constraint.constant = 560 + (self.scrollView.contentOffset.x/4);
                }
            }
        }];
    //}
    
    previousPage = 0;
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    
    [pageIndicator selectItem:(int)page];
    
    if (previousPage != page) {
        previousPage = page;
        /* Page did change */
    }
}


- (IBAction)startProwlist:(id)sender {
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

@end

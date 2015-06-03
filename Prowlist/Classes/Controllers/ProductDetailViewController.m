//
//  ProductDetailViewController.m
//  Prowlist
//
//  Created by Sebastian Romero on 6/2/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import "ProductDetailViewController.h"

@interface ProductDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *imageWrapp;

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super initializeScroll];
    // Do any additional setup after loading the view.
}


-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [super addMenu];
    [self showHeader];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)goBack:(id)sender {
    [self removeMenu];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.profileMenuShown){
        [self hideMenu];
    }
    [self.imageWrapp.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == self.imageWrapp) && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            if (constraint.constant>0){
                if(340 +(self.scrollView.contentOffset.y*-1) >= 50){
                    constraint.constant = 340 +(self.scrollView.contentOffset.y*-1);
                }
            }
        }
    }];
    /*
    if(self.scrollView.contentOffset.y > self.scrollView.frame.size.height - 360){
        [self showHeader];
    } else {
        [self hideHeader];
    }*/
}

@end

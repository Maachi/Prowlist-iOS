//
//  DetailCityViewController.m
//  Prowlist
//
//  Created by Sebastian Romero on 5/9/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import "DetailCityViewController.h"

@interface DetailCityViewController (){
    
    __weak IBOutlet UIView *thumbWrapper;
    __weak IBOutlet UIImageView *imageThumb;
    BOOL loaded;
}

@end

@implementation DetailCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeScroll];
    [self styleView];
}


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self displayView];
}


- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    loaded = YES;
}


- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if(!loaded) {
        [self.scrollView setContentOffset:CGPointMake(0, self.scrollPosition) animated:NO];
    }
}


-(void) styleView {
    [self.theme styleRoudCornersThumb:thumbWrapper];
    [self.theme styleRoudCornersThumb:imageThumb];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}
- (IBAction)closeAction:(id)sender {
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

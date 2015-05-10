//
//  WelcomeViewController.m
//  Prowlist
//
//  Created by Sebastian Romero on 5/7/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//
#import "CellTransitionSegue.h"
#import "WelcomeViewController.h"
#import "CellBase.h"

@interface WelcomeViewController (){
    __weak IBOutlet UIView *mainWrapper;
    __weak IBOutlet UIView *contentWrapper;
    
    CellBase *selectedCell;
}

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeScroll];
}


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadStyleGuide];
    if(!self.walkthroughShown){
        self.walkthroughShown = YES;
        [self showWalkthroughController];
    }
    for (int i = 0; i<4; i++){
        [self loadPlaceInView:i];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    if ([segue isMemberOfClass:[CellTransitionSegue class]])
    {
        CellTransitionSegue *cellResizeSegue = (CellTransitionSegue *)segue;
        cellResizeSegue.selectedCell = selectedCell;
        cellResizeSegue.scrollView = self.scrollView;
        cellResizeSegue.mainView = self.view;
    }
}


- (void) showWalkthroughController
{
    UIStoryboard *storyBoard = [self storyboard];
    UIViewController *modalLoginViewController  = [storyBoard instantiateViewControllerWithIdentifier:@"WalkthroughViewController"];
    [self presentViewController:modalLoginViewController animated:NO completion:nil];
    
}


-(void) loadStyleGuide {
    UIView *styleGuide = (UIView *)[[[NSBundle mainBundle] loadNibNamed:@"StyleGuide" owner:self options:nil] firstObject];
    CGRect frame = styleGuide.frame;
    frame.size.width = contentWrapper.frame.size.width - 60;
    frame.size.height = 400;
    frame.origin.x = 30;
    frame.origin.y = 0;
    styleGuide.frame = frame;
    [contentWrapper addSubview:styleGuide];
}




-(void) loadPlaceInView:(int)index{
    CellBase *cell = (CellBase *)[[[NSBundle mainBundle] loadNibNamed:@"CellBase" owner:self options:nil] firstObject];
    CGRect frame = cell.frame;
    frame.size.width = contentWrapper.frame.size.width - 60;
    frame.origin.x = 30;
    frame.origin.y = (index*(frame.size.height+20)) + 410;
    cell.frame = frame;
    
    [cell setOnSelect:^(CellBase *referenceCell) {
        selectedCell = referenceCell;
        [self performSegueWithIdentifier:@"showCityDetail" sender:self];
    }];
    
    
    [contentWrapper addSubview:cell];
}


@end

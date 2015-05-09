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

@interface WelcomeViewController ()<UIScrollViewDelegate>{
    __weak IBOutlet UIImageView *mainBackground;
    __weak IBOutlet UIScrollView *mainScrollView;
    __weak IBOutlet UIView *mainWrapper;
    __weak IBOutlet UIView *contentWrapper;
    
    CellBase *selectedCell;
}

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    mainScrollView.delegate = self;
}


-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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
        cellResizeSegue.scrollView = mainScrollView;
        cellResizeSegue.mainView = self.view;
    }
}




-(void) loadPlaceInView:(int)index{
    CellBase *cell = (CellBase *)[[[NSBundle mainBundle] loadNibNamed:@"CellBase" owner:self options:nil] firstObject];
    CGRect frame = cell.frame;
    frame.size.width = contentWrapper.frame.size.width - 60;
    frame.origin.x = 30;
    frame.origin.y = (index*(frame.size.height+20));
    cell.frame = frame;
    
    [cell setOnSelect:^(CellBase *referenceCell) {
        selectedCell = referenceCell;
        [self performSegueWithIdentifier:@"showCityDetail" sender:self];
    }];
    
    
    [contentWrapper addSubview:cell];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView{
    //NSLog(@"Scrolling... %f", _scrollView.contentOffset.y);
    [mainBackground.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == mainBackground) && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            if (constraint.constant>0){
                if(560 +(_scrollView.contentOffset.y*-1) >= 50){
                    constraint.constant = 560 +(_scrollView.contentOffset.y*-1);
                }
            }
        }
    }];
}

@end

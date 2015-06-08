//
//  DetailVenueViewController.m
//  Prowlist
//
//  Created by Sebastian Romero on 6/6/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import "DetailVenueViewController.h"
#import "CellBase.h"
#import "VenueContent.h"

@interface DetailVenueViewController (){
    __weak IBOutlet UIView *mainWrapper;
    __weak IBOutlet UIView *contentWrapper;
    __weak IBOutlet UIScrollView *horizontalScroll;
    __weak IBOutlet UIView *sliderWrapper;
    
    __weak IBOutlet UIImageView *firstBackground;
    CellBase *selectedCell;
    
}
@end

@implementation DetailVenueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super initializeScroll];
    [self addElementContent];
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self addMenu];
}


-(void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) addElementContent {
    self.contentScroll = (VenueContent *)[[[NSBundle mainBundle] loadNibNamed:@"VenueContent" owner:self options:nil] firstObject];
    self.contentScroll.parent = self;
    self.contentScroll.backgroundColor = [UIColor clearColor];
    [self.scrollWrapper addSubview:self.contentScroll];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
}

@end

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
    
    __weak IBOutlet UIButton *backButton;
    __weak IBOutlet UIImageView *firstBackground;
    CellBase *selectedCell;
    
    NSDictionary *data;
    
}
@end

@implementation DetailVenueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super initializeScroll];
    [self addElementContent];
    
    data = @{
             @"name" : @"Axiom Hotel, Algo más",
             @"smallDescription": @"Zombie ipsum reversus ab viral inferno, nam rick grimes malum cerebro.",
             @"detailDescription" : @"Zombie ipsum reversus ab viral inferno, nam rick grimes malum cerebro, zombie ipsum reversus ab viral inferno, nam rick grimes malum cerebro",
             @"logoImage" : @"",
             @"photo":@"london-mockup",
             @"height":@470,
             @"stays" : @1222,
             @"perks" : @5,
             @"latitude":@22222,
             @"longitude":@2222,
             @"address":@"Cll 90 SStreed Av",
             @"tags" : @[
                     @{
                         @"label" : @"Near You",
                         @"tint" : @[@247.0, @207.0, @23.0],
                         @"textColor" : @[@0, @0, @0],
                         },
                     @{
                         @"label" : @"Fast",
                         @"tint" : @[@128.0, @168.0, @204.0],
                         @"textColor" : @[@0, @0, @0],
                         },
                     @{
                         @"label" : @"San Francisco",
                         @"tint" : @[@247.0, @207.0, @23.0],
                         @"textColor" : @[@0, @0, @0],
                         }
                     ],
             @"controllerStyle" : @2,
            };
    
    self.mainHeader.image = [UIImage imageNamed:[data objectForKey:@"photo"]];
    
    
    
    
   
    
    
    if([[data objectForKey:@"controllerStyle"] integerValue] == 2){
        self.controllerStyle = ProwlistControllerStyleLight;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
         [self.theme tintButtonWithColor:backButton color:[UIColor blackColor] imageNamed:@"back-arrow" state:UIControlStateNormal];
    } else {
        self.controllerStyle = ProwlistControllerStyleDefault;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }
    
    
    
}


-(void) showHeader{
    [super showHeader];
    if(self.controllerStyle ==  ProwlistControllerStyleLight){
        [self.theme tintButtonWithColor:backButton color:[UIColor whiteColor] imageNamed:@"back-arrow" state:UIControlStateNormal];
    }
}

-(void) hideHeader {
    [super hideHeader];
    if(self.controllerStyle ==  ProwlistControllerStyleLight){
        [self.theme tintButtonWithColor:backButton color:[UIColor blackColor] imageNamed:@"back-arrow" state:UIControlStateNormal];
    }
    
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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

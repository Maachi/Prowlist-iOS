//
//  ProductDetailViewController.m
//  Prowlist
//
//  Created by Sebastian Romero on 6/2/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ActionSheetStringPicker.h"

@interface ProductDetailViewController () {
    NSArray *data;
}
@property (weak, nonatomic) IBOutlet UIView *imageWrapp;

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super initializeScroll];
    [super formControllerEvents];
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

- (IBAction)selectType:(UIButton *)sender {
   __block NSArray *wines = [NSArray arrayWithObjects:@"Dow Vintage Port", @"Prats & Symington Douro Chryseia", @"Quinta do Vale Meão Douro ", @"Brewer-Clifton Pinot Noir Sta. Rita Hills", @"Castello di Volpaia Chianti Classico Riserva", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@"Select the brand of wine you want"
                                            rows:wines
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           [sender setTitle: selectedValue forState: UIControlStateNormal];
                                           
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
}



- (IBAction)placeOrder:(id)sender {
    [[[UIAlertView alloc] initWithTitle:@"Incomplete order."
                               message:@"We need to know more information about this order, since its a configurable product."
                              delegate:self
                     cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.profileMenuShown){
        [self hideMenu];
    }
    [self.imageWrapp.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == self.imageWrapp) && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            if (constraint.constant>0){
                if(280 +(self.scrollView.contentOffset.y*-1) >= 50){
                    constraint.constant = 280 +(self.scrollView.contentOffset.y*-1);
                }
            }
        }
    }];
    
    if(self.scrollView.contentOffset.y < 20 && self.scrollView.contentOffset.y < -20){
        [self hideHeader];
    } else if (self.scrollView.contentOffset.y < -20) {
        [self showHeader];
    } else {
        [self showHeader];
    }
}

@end

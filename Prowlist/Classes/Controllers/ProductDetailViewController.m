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
    NSDictionary *data;
    __weak IBOutlet UIView *priceMarker;
    __weak IBOutlet UIView *nameMarker;
    __weak IBOutlet UILabel *nameProduct;
    __weak IBOutlet UILabel *priceProduct;
    __weak IBOutlet UILabel *venueName;
}
@property (weak, nonatomic) IBOutlet UIView *imageWrapp;

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super initializeScroll];
    [super formControllerEvents];
    
    data = @{
             @"nameProduct" : @"Hola Mundo",
             @"price" : @"$129"
            };
    
    [self setPrice:[data objectForKey:@"price"]];
}



-(void) setPrice:(NSString *)price {
    priceProduct.text = price;
    CGSize stringsize =  [price sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:priceProduct.font.fontName size:priceProduct.font.pointSize]}];
    
    [priceMarker.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == priceMarker) && (constraint.firstAttribute == NSLayoutAttributeWidth)) {
            if (constraint.constant>0){
                constraint.constant = stringsize.width + 15;
            }
        }
    }];
    
    
}


-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [super addMenu];
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
    [[[UIAlertView alloc] initWithTitle:@"Order incomplete."
                               message:@"This is a configurable object and more information is required, Prowlist can suggest a desirable setup for you. \n \n Do you want Prowlist selects a configuration based in you profile?"
                              delegate:self
                     cancelButtonTitle:@"Cancel"
                      otherButtonTitles:@"Suggest", nil] show];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [super scrollViewDidScroll:scrollView];
    /*if(self.profileMenuShown){
        [self hideMenu];
    }*/
    [self.imageWrapp.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == self.imageWrapp) && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
            if (constraint.constant>0){
                if(280 +(self.scrollView.contentOffset.y*-1) >= 50){
                    constraint.constant = 280 +(self.scrollView.contentOffset.y*-1);
                }
            }
        }
    }];
    /*
    if(self.scrollView.contentOffset.y < 20 && self.scrollView.contentOffset.y < -20){
        [self hideHeader];
    } else if (self.scrollView.contentOffset.y < -20) {
        [self showHeader];
    } else {
        [self showHeader];
    }*/
}

@end

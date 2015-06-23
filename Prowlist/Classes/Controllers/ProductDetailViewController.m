//
//  ProductDetailViewController.m
//  Prowlist
//
//  Created by Sebastian Romero on 6/2/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ActionSheetStringPicker.h"

@interface ProductDetailViewController ()<UITextFieldDelegate> {
    NSDictionary *data;
    __weak IBOutlet UIView *priceMarker;
    __weak IBOutlet UIView *nameMarker;
    __weak IBOutlet UILabel *nameProduct;
    __weak IBOutlet UILabel *priceProduct;
    __weak IBOutlet UILabel *venueName;
    __weak IBOutlet UITextField *specialGuides;
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
    [self setNProduct:[data objectForKey:@"nameProduct"]];
    
    [self.theme styleTextField:specialGuides];
    specialGuides.delegate = self;
}




-(void) setNProduct:(NSString *)nameP {
    nameProduct.text = nameP;
    CGSize stringsize =  [nameP sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:nameProduct.font.fontName size:nameProduct.font.pointSize]}];
    
    [nameMarker.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if ((constraint.firstItem == nameMarker) && (constraint.firstAttribute == NSLayoutAttributeWidth)) {
            if (constraint.constant>0){
                constraint.constant = stringsize.width + 15;
            }
        }
    }];
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
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
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


-(BOOL)textFieldShouldBeginEditing:(UITextField*)textField {
    if (textField){
        
        self.lastScrollPosition = self.scrollView.contentOffset;
        
        CGPoint center = CGPointMake(textField.bounds.origin.x + textField.bounds.size.width/2,
                                           textField.bounds.origin.y + textField.bounds.size.height/2);
        CGPoint point = [textField convertPoint:center toView:self.scrollView];
        [self.scrollView setContentOffset:CGPointMake(0, point.y - (self.scrollView.bounds.size.height-240)) animated:YES];
    }
    return YES;
}



-(BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    [self.scrollView setContentOffset:self.lastScrollPosition animated:YES];
    
    return YES;
}

@end

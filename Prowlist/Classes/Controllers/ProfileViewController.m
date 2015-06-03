//
//  ProfileViewController.m
//  Prowlist
//
//  Created by Sebastian Romero on 6/1/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import "ProfileViewController.h"
#import "VENTokenField.h"

@interface ProfileViewController ()<VENTokenFieldDelegate, VENTokenFieldDataSource>
@property (strong, nonatomic) NSMutableArray *names;
@property (nonatomic) BOOL viewLoaded;
@property (weak, nonatomic) IBOutlet VENTokenField *likesTagsField;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super initializeScroll];
    [super formControllerEvents];
    [self.theme styleRoudCornersThumb:self.thumbFrame];
    
    [self.theme styleRoudCornersThumb:self.thumbImage];
    
    
    self.names = [[NSMutableArray alloc] initWithArray:@[]];
    self.likesTagsField.delegate = self;
    self.likesTagsField.dataSource = self;
    self.likesTagsField.placeholderText = NSLocalizedString(@"Enter your likes", nil);
    self.likesTagsField.toLabelText = NSLocalizedString(@"Your Likes:", nil);
    [self.likesTagsField setColorScheme:[UIColor colorWithRed:128/255.0f green:168/255.0f blue:204/255.0f alpha:1.0f]];
    self.likesTagsField.inputTextFieldTextColor = [UIColor whiteColor];
}


-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


-(void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if(!_viewLoaded){
        self.names = [[NSMutableArray alloc] initWithArray:@[@"California", @"Blue", @"Mexico", @"Products", @"Travel", @"Relax", @"Mexican Food", @"Gin and Tonic", @"Jazz", @"Rock"]];
        [self.likesTagsField reloadData];
    }
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
- (IBAction)saveAndClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark - VENTokenFieldDelegate

- (void)tokenField:(VENTokenField *)tokenField didEnterText:(NSString *)text
{
    [self.names addObject:text];
    [self.likesTagsField reloadData];
}

- (void)tokenField:(VENTokenField *)tokenField didDeleteTokenAtIndex:(NSUInteger)index
{
    [self.names removeObjectAtIndex:index];
    [self.likesTagsField reloadData];
}


#pragma mark - VENTokenFieldDataSource

- (NSString *)tokenField:(VENTokenField *)tokenField titleForTokenAtIndex:(NSUInteger)index
{
    return self.names[index];
}

- (NSUInteger)numberOfTokensInTokenField:(VENTokenField *)tokenField
{
    return [self.names count];
}

- (NSString *)tokenFieldCollapsedText:(VENTokenField *)tokenField
{
    return [NSString stringWithFormat:@"%tu people", [self.names count]];
}

@end

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
#import "GBInfiniteScrollView.h"

@interface WelcomeViewController ()<GBInfiniteScrollViewDataSource, GBInfiniteScrollViewDelegate>{
    __weak IBOutlet UIView *mainWrapper;
    __weak IBOutlet UIView *contentWrapper;
    __weak IBOutlet UIScrollView *horizontalScroll;
    
    __weak IBOutlet UIImageView *firstBackground;
    CellBase *selectedCell;
}

@property (nonatomic, strong) GBInfiniteScrollView *infiniteScrollView;
@property(nonatomic) BOOL debug;
@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}



- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(!self.walkthroughShown){
        self.walkthroughShown = YES;
        [self showWalkthroughController];
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





- (void)setUp
{
    self.debug = YES;
    BOOL verboseDebug = NO;
    
    self.data = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 18; i++) {
        [self.data addObject:@(i)];
    }
    
    
    self.infiniteScrollView = [[GBInfiniteScrollView alloc] initWithFrame:self.view.bounds];
    self.infiniteScrollView.infiniteScrollViewDataSource = self;
    self.infiniteScrollView.infiniteScrollViewDelegate = self;
    self.infiniteScrollView.debug = self.debug;
    self.infiniteScrollView.verboseDebug = verboseDebug;
    self.infiniteScrollView.interval = 3.0f;
    self.infiniteScrollView.pageIndex = 0;
    self.infiniteScrollView.scrollDirection = GBScrollDirectionHorizontal;
    
    [self.view addSubview:self.infiniteScrollView];
    
    [self.infiniteScrollView reloadData];
    
}



#pragma mark - UIScrollViewDelegate


- (void)infiniteScrollViewDidScrollNextPage:(GBInfiniteScrollView *)infiniteScrollView
{
    if (self.debug) {
        NSLog(@"Did scroll next page");
    }
}

- (void)infiniteScrollViewDidScrollPreviousPage:(GBInfiniteScrollView *)infiniteScrollView
{
    if (self.debug) {
        NSLog(@"Did scroll previous page");
    }
}

- (BOOL)infiniteScrollViewShouldScrollNextPage:(GBInfiniteScrollView *)infiniteScrollView
{
    if (self.debug) {
        NSLog(@"Should scroll next page");
    }
    
    return YES;
}

- (BOOL)infiniteScrollViewShouldScrollPreviousPage:(GBInfiniteScrollView *)infiniteScrollView
{
    if (self.debug) {
        NSLog(@"Should scroll previous page");
    }
    
    return YES;
}

- (void)infiniteScrollView:(GBInfiniteScrollView *)infiniteScrollView didTapAtIndex:(NSInteger)pageIndex
{
    if (self.debug) {
        NSLog(@"Did tap at page %lu", (unsigned long)index);
    }
}

- (NSInteger)numberOfPagesInInfiniteScrollView:(GBInfiniteScrollView *)infiniteScrollView
{
    return self.data.count;
}


- (GBInfiniteScrollViewPage *)infiniteScrollView:(GBInfiniteScrollView *)infiniteScrollView pageAtIndex:(NSUInteger)index
{
    NSLog(@"Page at index %lu", (unsigned long)index);
    
    //id record = [self.data objectAtIndex:index];
    GBInfiniteScrollViewPage *page = [infiniteScrollView dequeueReusablePage];
    
    if (page == nil) {
        page = [[GBInfiniteScrollViewPage alloc] initWithFrame:self.view.bounds style:GBInfiniteScrollViewPageStyleText];
    }
    page.contentView.backgroundColor = [self randomColor];
    
    return page;
}


- (UIColor *)randomColor
{
    CGFloat hue = (arc4random() % 256 / 256.0f);
    CGFloat saturation = (arc4random() % 128 / 256.0f) + 0.5f;
    CGFloat brightness = (arc4random() % 128 / 256.0f) + 0.5f;
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0f];
    
    return color;
}


- (CGFloat)fontSizeForNumber:(int)number
{
    CGFloat scale = 0;
    
    if (number >= 100.0f) {
        scale = 1;
    } else if (number >= 1000.0f) {
        scale = 2;
    }
    
    return 192.0f - (64.0f * scale);
}

@end

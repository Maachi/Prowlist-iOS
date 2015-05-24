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
#import "Slide.h"
#import "GBInfiniteScrollView.h"
#import "PageIndicator.h"

@interface WelcomeViewController ()<GBInfiniteScrollViewDataSource, GBInfiniteScrollViewDelegate>{
    __weak IBOutlet UIView *mainWrapper;
    __weak IBOutlet UIView *contentWrapper;
    __weak IBOutlet UIScrollView *horizontalScroll;
    __weak IBOutlet UIView *sliderWrapper;
    
    __weak IBOutlet UIImageView *firstBackground;
    CellBase *selectedCell;
    __weak IBOutlet PageIndicator *pageIndicator;
    
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
    pageIndicator.pages = 4;
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
    
    for (int i = 0; i < 4; i++) {
        [self.data addObject:@(i)];
    }
    
    
    self.infiniteScrollView = [[GBInfiniteScrollView alloc] initWithFrame:self.view.bounds];
    self.infiniteScrollView.infiniteScrollViewDataSource = self;
    self.infiniteScrollView.infiniteScrollViewDelegate = self;
    //aself.infiniteScrollView.debug = self.debug;
    self.infiniteScrollView.verboseDebug = verboseDebug;
    self.infiniteScrollView.pageIndex = 0;
    self.infiniteScrollView.scrollDirection = GBScrollDirectionHorizontal;
    self.infiniteScrollView.delegate = self;
    
    [sliderWrapper addSubview:self.infiniteScrollView];
    
    [self.infiniteScrollView reloadData];
    
}



#pragma mark - UIScrollViewDelegate


- (void)infiniteScrollViewDidScrollNextPage:(GBInfiniteScrollView *)infiniteScrollView
{
}

- (void)infiniteScrollViewDidScrollPreviousPage:(GBInfiniteScrollView *)infiniteScrollView
{
}

- (BOOL)infiniteScrollViewShouldScrollNextPage:(GBInfiniteScrollView *)infiniteScrollView
{
    if(pageIndicator.pages){
        [pageIndicator selectItem:(int)self.infiniteScrollView.currentPageIndex];
    }
    
    return YES;
}

- (BOOL)infiniteScrollViewShouldScrollPreviousPage:(GBInfiniteScrollView *)infiniteScrollView
{
    if(pageIndicator.pages){
        [pageIndicator selectItem:(int)self.infiniteScrollView.currentPageIndex];
    }
    
    return YES;
}

- (void)infiniteScrollView:(GBInfiniteScrollView *)infiniteScrollView didTapAtIndex:(NSInteger)pageIndex
{
}

- (NSInteger)numberOfPagesInInfiniteScrollView:(GBInfiniteScrollView *)infiniteScrollView
{
    return self.data.count;
}


-(void)infiniteScrollViewDidPan:(UIPanGestureRecognizer*)pan
{
    if(pageIndicator.pages){
        [pageIndicator selectItem:(int)self.infiniteScrollView.currentPageIndex];
    }
}



- (GBInfiniteScrollViewPage *)infiniteScrollView:(GBInfiniteScrollView *)infiniteScrollView pageAtIndex:(NSUInteger)index
{
    
    /*if(pageIndicator.pages){
        [pageIndicator selectItem:(int)index];
    }*/
    
    //id record = [self.data objectAtIndex:index];
    GBInfiniteScrollViewPage *page = [infiniteScrollView dequeueReusablePage];
    
    if (page == nil) {
        page = [[GBInfiniteScrollViewPage alloc] initWithFrame:self.view.bounds style:GBInfiniteScrollViewPageStyleText];
    }
    
    Slide *slideView = (Slide *)[[[NSBundle mainBundle] loadNibNamed:@"SlideView" owner:self options:nil] firstObject];
    CGRect frame = slideView.frame;
    frame.size.width = page.contentView.frame.size.width;
    frame.size.height = page.contentView.frame.size.height;
    slideView.frame = frame;
    slideView.mainScroll = self.infiniteScrollView;
    slideView.parentController = self;
    [slideView initialize];
    
    //page.contentView.backgroundColor = [self randomColor];
    [page.contentView addSubview:slideView];
    return page;
}

@end

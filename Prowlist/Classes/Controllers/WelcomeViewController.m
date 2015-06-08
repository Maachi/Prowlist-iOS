//
//  WelcomeViewController.m
//  Prowlist
//
//  Created by Sebastian Romero on 5/7/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//
#import "WelcomeViewController.h"
#import "VenueCell.h"

@interface WelcomeViewController ()<UITableViewDataSource, UITableViewDelegate>{
    __weak IBOutlet UITableView *tableView;
}
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [tableView setContentInset:UIEdgeInsetsMake(-20,0,0,0)];
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [tableView registerNib:[UINib nibWithNibName:@"VenueCell" bundle:nil] forCellReuseIdentifier:@"VenueCell"];
}



- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self addMenu];
    if(!self.walkthroughShown){
        self.walkthroughShown = YES;
        [self showWalkthroughController];
    }
}


-(void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) showWalkthroughController
{
    UIStoryboard *storyBoard = [self storyboard];
    UIViewController *modalLoginViewController  = [storyBoard instantiateViewControllerWithIdentifier:@"WalkthroughViewController"];
    [self presentViewController:modalLoginViewController animated:NO completion:nil];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float scrollViewHeight = scrollView.frame.size.height;
    float scrollContentSizeHeight = scrollView.contentSize.height;
    float scrollOffset = scrollView.contentOffset.y;
    //NSLog(@"Scrolling... %f %f %f", scrollView.contentOffset.y, scrollOffset + scrollViewHeight, scrollContentSizeHeight);
    if(scrollView.contentOffset.y<=0){
        
        VenueCell *cell = (VenueCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [cell resizeImageCellWithValue:scrollView.contentOffset.y];
        //[tableView setContentInset:UIEdgeInsetsMake((-20 + scrollView.contentOffset.y),0,0,0)];
    } else if(scrollOffset + scrollViewHeight >= scrollContentSizeHeight) {
        /*NSLog(@"This is it.... %f", (scrollOffset + scrollViewHeight)-scrollContentSizeHeight);
        VenueCell *cell = (VenueCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [cell resizeImageCellWithValue:(scrollOffset + scrollViewHeight)-scrollContentSizeHeight];*/
    }
}



#pragma mark - UITableView

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath: (NSIndexPath*) indexPath
{
    CGFloat rowHeight = 220;
    if (indexPath.row == 0){
        rowHeight = 300;
    }
    return rowHeight;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(UITableViewCell *) tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"VenueCell";
    
    VenueCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    if (cell == nil) {
        cell = [[VenueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if(indexPath.row == 0){
        cell.backgroundColor = [UIColor blueColor];
    } else {
        cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.title = @"Hola Mundo";
    [cell render];
    
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //selectedFriend = (Friend *)[friends objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showVenueDetail" sender:self];
}

@end

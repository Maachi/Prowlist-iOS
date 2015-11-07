//
//  WelcomeViewController.m
//  Prowlist
//
//  Created by Sebastian Romero on 5/7/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//
#import "WelcomeViewController.h"
#import "VenueCell.h"
#import "ProwlistLocation.h"
#import "Session.h"
#import "Venue.h"

@interface WelcomeViewController ()<UITableViewDataSource, UITableViewDelegate, ProwlistLocationDelegate>{
    __weak IBOutlet UITableView *tableView;
    __weak IBOutlet UIView *headerWelcome;
    ProwlistLocation *prowlistLocation;
    NSArray *data;
    NSDate *lastTimeRequestLocation;
}
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    data = [Venue all];
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
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}


-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self addMenu];
    Session *session = [Session find:@"key == %@", @"WALKTHROUGH_VIEW_SHOWN"];
    if(session){
        self.walkthroughShown = YES;
    }
    if(!self.walkthroughShown){
        self.walkthroughShown = YES;
        [self showWalkthroughController];
    } else {
        if(!prowlistLocation){
            prowlistLocation = [[ProwlistLocation alloc] initLocation];
            prowlistLocation.intervalTimes = 5;
            prowlistLocation.delegate = self;
            lastTimeRequestLocation = [NSDate date];
        }
        long timeIntervalInMinutes = (long)([[NSDate date] timeIntervalSinceDate:lastTimeRequestLocation] / 60);
        if (timeIntervalInMinutes>ProwlistUserRefreshCacheTimeFast){
            if(!prowlistLocation.isBroadcasting){
                [prowlistLocation startBroadCasting];
            }
        }
        
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


#pragma ProwlistLocationDelegate

- (void) locationStopped {
    
}


- (void) locationNotEnabled {
    [self showMessageToUser:NSLocalizedString(@"The location services are required, please go to settings and grant access permissions.", nil) withTitle:NSLocalizedString(@"Location services required.", nil)];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.profileMenuShown){
        [self hideMenu];
    }
    
    
    
    float scrollViewHeight = scrollView.frame.size.height;
    float scrollContentSizeHeight = scrollView.contentSize.height;
    float scrollOffset = scrollView.contentOffset.y;
    //NSLog(@"Scrolling... %f %f %f", scrollView.contentOffset.y, scrollOffset + scrollViewHeight, scrollContentSizeHeight);
    if(scrollView.contentOffset.y<=0){
        
        VenueCell *cell = (VenueCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [cell resizeImageCellWithValue:scrollView.contentOffset.y];
        //[tableView setContentInset:UIEdgeInsetsMake((-20 + scrollView.contentOffset.y),0,0,0)];
        
        [headerWelcome.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
            if ((constraint.firstItem == headerWelcome) && (constraint.firstAttribute == NSLayoutAttributeHeight)) {
                if (constraint.constant>0){
                    if((scrollView.contentOffset.y*-1) < 85){
                        constraint.constant = 80 + (scrollView.contentOffset.y*-1);
                    }
                }
            }
        }];
        
    } else if(scrollOffset + scrollViewHeight >= scrollContentSizeHeight) {
        float overLap = (scrollOffset + scrollViewHeight)-scrollContentSizeHeight;
        VenueCell *cell = (VenueCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:data.count-1 inSection:0]];
        [cell resizeImageCellWithValue:overLap];
    }
}



#pragma mark - UITableView

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath: (NSIndexPath*) indexPath
{
    CGFloat rowHeight = 220;
    Venue *venue = (Venue *)[data objectAtIndex:indexPath.row];
    if (venue.height){
        rowHeight = [venue.height floatValue];
    }
    return rowHeight;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return [data count];
}

-(UITableViewCell *) tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"VenueCell";
    Venue *current = (Venue *)[data objectAtIndex:indexPath.row];
    VenueCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    if (cell == nil) {
        cell = [[VenueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    
    cell.titleLabel.text = current.name;
    cell.smallDescriptionLabel.text = current.smallDescription;
    
    //[cell changeColorWithColor:[current objectForKey:@"tint"]];
    [cell buildTagsInView:current.tags];
    
    if(current.detailPhoto){
        cell.imagePath = current.detailPhoto;
    }
    [cell render];
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //selectedFriend = (Friend *)[friends objectAtIndex:indexPath.row];
    if(self.profileMenuShown){
        [self hideMenu];
    }
    [self performSegueWithIdentifier:@"showVenueDetail" sender:self];
}

@end

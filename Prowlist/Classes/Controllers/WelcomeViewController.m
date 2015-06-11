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
    __weak IBOutlet UIView *headerWelcome;
    
    NSArray *data;
}
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    data = @[
             @{
                 @"name" : @"Axiom Hotel",
                 @"smallDescription": @"Zombie ipsum reversus ab viral inferno, nam rick grimes malum cerebro.",
                 @"tint" : @[@255, @255, @255],
                 @"photo":@"losangeles-mockup",
                 @"height":@470,
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
                         ]
                 },
             @{
                 @"name" : @"Axiom Hotel",
                 @"smallDescription": @"Zombie ipsum reversus ab viral inferno, nam rick grimes malum cerebro.",
                 @"tint" : @[@255, @255, @255],
                 @"photo":@"sf-mockup",
                 @"height":@200,
                 @"tags" : @[
                         @{
                             @"label" : @"Near You",
                             @"tint" : @[@247.0, @207.0, @23.0],
                             @"textColor" : @[@0, @0, @0],
                             }
                         ]
                 },
             @{
                 @"name" : @"London view",
                 @"smallDescription": @"",
                 @"tint" : @[@0, @0, @0],
                 @"photo":@"london-mockup",
                 @"height":@120,
                 @"tags" : @[
                         @{
                             @"label" : @"Near You",
                             @"tint" : @[@247.0, @207.0, @23.0],
                             @"textColor" : @[@0, @0, @0],
                             },
                         @{
                             @"label" : @"Fast",
                             @"tint" : @[@247.0, @207.0, @23.0],
                             @"textColor" : @[@0, @0, @0],
                             },
                         @{
                             @"label" : @"San Francisco",
                             @"tint" : @[@247.0, @207.0, @23.0],
                             @"textColor" : @[@0, @0, @0],
                             }
                         ]
                 },
             @{
                 @"name" : @"Axiom Hotel",
                 @"smallDescription": @"Zombie ipsum reversus ab viral inferno, nam rick grimes malum cerebro.",
                 @"tint" : @[@255, @255, @255],
                 @"photo":@"chicago-mockup",
                 @"height":@200,
                 @"tags" : @[
                         @{
                             @"label" : @"Near You",
                             @"tint" : @[@0, @0, @0],
                             }
                         ]
                 }
             ];
    
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
    if ([[data objectAtIndex:indexPath.row] objectForKey:@"height"]){
        rowHeight = [[[data objectAtIndex:indexPath.row] objectForKey:@"height"] floatValue];
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
    NSDictionary *current = [data objectAtIndex:indexPath.row];
    VenueCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    if (cell == nil) {
        cell = [[VenueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    
    cell.titleLabel.text = [current objectForKey:@"name"];
    cell.smallDescriptionLabel.text = [current objectForKey:@"smallDescription"];
    
    [cell changeColorWithColor:[current objectForKey:@"tint"]];
    [cell buildTagsInView:[current objectForKey:@"tags"]];
    
    if([current objectForKey:@"photo"]){
        cell.image.image = [UIImage imageNamed:[current objectForKey:@"photo"]];
    }
    
    cell.title = @"Hola Mundo";
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

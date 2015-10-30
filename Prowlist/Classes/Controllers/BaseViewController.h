//
//  BaseViewController.h
//  Prowlist
//
//  Created by Sebastian Romero on 5/7/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProwlistTheme.h"
#import "MenuBase.h"
#import "ProwlistRequest.h"

@class ContentBase;
@class Session;


/**
 *  Enumerates user cache time
 */
enum ProwlistUserRefreshCacheTime
{
    ProwlistUserRefreshCacheTimeFast = 1,
    ProwlistUserRefreshCacheTimeInterval = 5,
    ProwlistUserRefreshCacheTimeModerate = 30,
    ProwlistUserRefreshCacheTimeDay = 1440,
    ProwlistUserRefreshCacheTimeMonth = 438290639
};

enum ProwlistControllerStyle
{
    ProwlistControllerStyleDefault = 1,
    ProwlistControllerStyleLight = 2
};


@interface BaseViewController : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *mainHeader;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollWrapper;
@property (strong, nonatomic) id <ProwlistTheme> theme;
@property (nonatomic) BOOL profileMenuShown;
@property (nonatomic) BOOL walkthroughShown;
@property (nonatomic) float scrollPosition;
@property (strong, nonatomic) ContentBase *contentScroll;
@property (weak, nonatomic) IBOutlet UIView *header;
@property (strong, nonatomic) MenuBase *menuView;
@property (nonatomic) enum ProwlistControllerStyle controllerStyle;


@property (strong, nonatomic) Session *token;

@property (nonatomic) CGPoint lastScrollPosition;

- (void) initializeScroll;
- (void) displayView;
- (void) showProfileViewController;
- (void) showPaymentsViewContoller;
- (void) showFriendsViewContoller;
- (void) hideMenu;
- (void) showProfileMenu;
- (void) addMenu;
- (void) removeMenu;

- (void) showHeader;
- (void) hideHeader;


- (void) addEventsMenu;
- (void) formControllerEvents;
- (void) showMessageToUser:(NSString *)message withTitle:(NSString *)title;
@end

//
//  BaseViewController.h
//  Prowlist
//
//  Created by Sebastian Romero on 5/7/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProwlistTheme.h"
#import "ContentBase.h"

@interface BaseViewController : UIViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *mainHeader;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollWrapper;
@property (strong, nonatomic) id <ProwlistTheme> theme;
@property (nonatomic) BOOL walkthroughShown;
@property (nonatomic) float scrollPosition;
@property (strong, nonatomic) ContentBase *contentScroll;

- (void) initializeScroll;
- (void) displayView;

@end

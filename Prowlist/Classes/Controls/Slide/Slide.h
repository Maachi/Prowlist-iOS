//
//  Slide.h
//  Prowlist
//
//  Created by Sebastian Romero on 5/14/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "GBInfiniteScrollView.h"

@interface Slide : UIView <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UIView *mainWrapper;
@property (assign, nonatomic) GBInfiniteScrollView *mainScroll;
@property (assign, nonatomic) BaseViewController *parentController;
@property (weak, nonatomic) IBOutlet UILabel *title;


-(void) initialize;

@end

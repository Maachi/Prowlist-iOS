//
//  ContentBase.h
//  Prowlist
//
//  Created by Sebastian Romero on 5/28/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ContentBase : UIView
@property (weak, nonatomic) IBOutlet UIView *moreInformation;
@property (assign, nonatomic) BaseViewController *parent;
-(void) showMoreInformation;
-(void) hideMoreInformation;
@end

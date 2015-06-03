//
//  MenuBase.h
//  Prowlist
//
//  Created by Sebastian Romero on 5/31/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProwlistTheme.h"
@class BaseViewController;

@interface MenuBase : UIView
@property (strong, nonatomic) id <ProwlistTheme> theme;
@property (weak, nonatomic) IBOutlet UIView *thumb;
@property (weak, nonatomic) IBOutlet UIImageView *thumbImage;
@property (assign, nonatomic) BaseViewController *parent;
@end

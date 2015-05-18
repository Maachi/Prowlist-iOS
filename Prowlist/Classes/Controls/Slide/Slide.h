//
//  Slide.h
//  Prowlist
//
//  Created by Sebastian Romero on 5/14/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Slide : UIView <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UIView *mainWrapper;


-(void) initialize;

@end

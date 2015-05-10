//
//  PageIndicator.h
//  Prowlist
//
//  Created by Sebastian Romero on 5/10/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageIndicator : UIView {
    
}
@property (nonatomic) int pages;
- (void ) selectItem:(int) index;
@end

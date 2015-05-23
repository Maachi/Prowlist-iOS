//
//  ProwlistTheme.h
//  Prowlist
//
//  Created by Sebastian Romero on 5/9/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ProwlistTheme <NSObject>

@required


- (void) styleRoudCornersThumb:(UIView *)view;
- (void) roundCorners:(UIView *)view;

@end



@interface ProwlistThemeManager : NSObject


/**
 * @public static
 * This method returns the current theme instance.
 **/
+ (id <ProwlistTheme>)sharedTheme;

@end
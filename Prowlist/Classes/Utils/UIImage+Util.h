//
//  UIImage+Util.h
//  Prowlist
//
//  Created by Sebastian Romero on 13/06/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Util)

/**
 *  Tints the image with the given color
 *  @param color
 *  @return reference of the image
 */
- (UIImage *)imageWithColor:(UIColor *)color;


@end
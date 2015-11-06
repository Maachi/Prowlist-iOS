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
- (void) roundCornersButton:(UIView *)view;

-(void) styleTextField:(UITextField *)textField;

-(UIButton *) tintButtonWithColor:(UIButton *)button color:(UIColor*)color imageNamed:(NSString *)name state:(UIControlState)state;


@optional

/**
 *  <#Description#>
 *  @param colorArray <#colorArray description#>
 *  @return <#return value description#>
 */
- (UIColor *) arrayToColor:(NSArray *)colorArray;

/**
 *  <#Description#>
 *  @param colorDictionary <#colorDictionary description#>
 *  @return <#return value description#>
 */
- (UIColor *) arrayToColorWithDictionary:(NSDictionary *)colorDictionary;

@end



@interface ProwlistThemeManager : NSObject


/**
 * @public static
 * This method returns the current theme instance.
 **/
+ (id <ProwlistTheme>)sharedTheme;

@end
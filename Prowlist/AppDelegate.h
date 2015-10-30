//
//  AppDelegate.h
//  Prowlist
//
//  Created by Sebastian Romero on 5/6/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Session;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Session *token;

@end


//
//  ProwlistTheme.m
//  Prowlist
//
//  Created by Sebastian Romero on 5/9/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import "ProwlistTheme.h"
#import "BlackTheme.h"

@implementation ProwlistThemeManager


+ (id <ProwlistTheme>)sharedTheme
{
    static id <ProwlistTheme> sharedTheme = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTheme = [[BlackTheme alloc] init];
    });
    return sharedTheme;
}

@end

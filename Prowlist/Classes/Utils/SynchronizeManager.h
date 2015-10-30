//
//  SynchronizeManager.h
//  Prowlist
//
//  Created by Sebastian Romero on 29/10/15.
//  Copyright © 2015 Maachi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Session;

@interface SynchronizeManager : NSObject

@property (strong, nonatomic) Session *token;
+ (id)getInstance;


- (void) startSynchronizationInBackground;
- (void) getNearVenues;

@end

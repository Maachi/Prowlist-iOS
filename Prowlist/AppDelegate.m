//
//  AppDelegate.m
//  Prowlist
//
//  Created by Sebastian Romero on 5/6/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import "AppDelegate.h"
#import "Session.h"
#import "Location.h"
#import "ProwlistRequest.h"
#import "SynchronizeManager.h"

@interface AppDelegate () {
    SynchronizeManager *synchronizeManager;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setSession];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma User Session


- (void) initilizeSynchronizeManager {
    synchronizeManager = [SynchronizeManager getInstance];
    synchronizeManager.token = _token;
    [synchronizeManager startSynchronizationInBackground];
}


- (void) setSession {
    _token = [Session find:@"key=='PROWLIST_USER_TOKEN'"];
    if(!_token){
        ProwlistRequest *request = [[ProwlistRequest alloc] init];
        [request signup:^(NSError *error, AFHTTPRequestOperation *operation, id responseObject) {
            if(!error){
                _token = [Session create];
                _token.key = @"PROWLIST_USER_TOKEN";
                _token.value = [responseObject objectForKey:@"token"];
                _token.date = [NSDate date];
                [_token save];
                [self initilizeSynchronizeManager];
            }
        }];
    } else {
        [self initilizeSynchronizeManager];
        for (Location *location in [Location all]){
            if([location.idLocation integerValue] < 1){
                ProwlistRequest *request = [[ProwlistRequest alloc] init];
                request.token = _token.value;
                [request updateMember:[location serialize] response:^(NSError *error, AFHTTPRequestOperation *operation, id responseObject) {
                    if(!error){
                        if([responseObject objectForKey:@"last_location"]){
                            
                        }
                    }
                }];
            }
        }
    }
}

@end

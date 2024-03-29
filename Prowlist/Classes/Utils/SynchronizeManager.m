//
//  SynchronizeManager.m
//  Prowlist
//
//  Created by Sebastian Romero on 29/10/15.
//  Copyright © 2015 Maachi. All rights reserved.
//

#import "SynchronizeManager.h"
#import "ProwlistRequest.h"
#import "Venue.h"
#import "Session.h"

@interface SynchronizeManager (){
}
@end

@implementation SynchronizeManager


+ (id)getInstance {
    static SynchronizeManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}



- (void) startSynchronizationInBackground {
    [self getNearVenues];
}


- (void) getNearVenues {
    ProwlistRequest *request = [[ProwlistRequest alloc] init];
    request.token = _token.value;
    [request getNearVenues:^(NSError *error, AFHTTPRequestOperation *operation, id responseObject) {
        if(!error){
            if([responseObject objectForKey:@"items"]){
                NSArray *venues = (NSArray *)[responseObject objectForKey:@"items"];
                [Venue processVenuesResponseFromServer:venues];
            }
        }
    }];
}

@end

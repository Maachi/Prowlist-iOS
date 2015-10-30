//
//  ProwlistRequest.h
//  Prowlist
//
//  Created by Sebastian Romero on 28/09/15.
//  Copyright © 2015 Maachi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@protocol SecureRequest <NSObject>

@required
/**
 * The client need to define the maximun number of attempts allowed
 **/
- (NSInteger) userMaximumNumberOfAttempts;
/**
 * This method will be called once the user has reach the maximun number of attemps
 **/
- (void) userHasReachedMaximumNumberOfAttempts:(NSInteger)attempts;

@end


@interface ProwlistRequest : NSObject
/**
 * Keeps the request token in the request
 **/
@property (strong, nonatomic) NSString *token;
@property (assign, nonatomic) id<SecureRequest> delegate;


- (void) signup:(void (^)(NSError *error, AFHTTPRequestOperation *operation, id responseObject))response;

- (void) updateMember:(NSDictionary *)form response:(void (^)(NSError *error, AFHTTPRequestOperation *operation, id responseObject))response;

- (void) getNearVenues:(void (^)(NSError *error, AFHTTPRequestOperation *operation, id responseObject))response;

@end

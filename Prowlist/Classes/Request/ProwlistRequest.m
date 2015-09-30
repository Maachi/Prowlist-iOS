//
//  ProwlistRequest.m
//  Prowlist
//
//  Created by Sebastian Romero on 28/09/15.
//  Copyright © 2015 Maachi. All rights reserved.
//

#import "ProwlistRequest.h"

@interface ProwlistRequest(){
    NSInteger tries;
}

@end


@implementation ProwlistRequest

- (BOOL) isValidForDelegation {
    if(!tries){
        tries = 1;
    } else {
        tries++;
    }
    if (self.delegate){
        if(tries > [self.delegate userMaximumNumberOfAttempts]){
            [self.delegate userHasReachedMaximumNumberOfAttempts:tries];
            return NO;
        }
    }
    return YES;
}



-(NSString *) getServiceWithName:(NSString *)name{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Prowlist-Config" ofType:@"plist"];
    NSDictionary *settings = [[NSDictionary alloc] initWithContentsOfFile:path];
    return [NSString stringWithFormat:@"%@%@", [settings[@"servers"] objectForKey:settings[@"environment"]], settings[@"api"][name]];
}



- (NSString *) tokenForTheRequest {
    return [NSString stringWithFormat:@"Token %@", _token];
}


- (void) request:(NSString *) url
      withParams:(NSDictionary *)params
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    if(![self isValidForDelegation]){
        return;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    if (_token){
        [manager.requestSerializer setValue:_token forHTTPHeaderField:@"Prowlist-User"];
    }
    [manager POST:url parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject){
              if (success){
                  success(operation, responseObject);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if(failure){
                  failure(operation, error);
              }
          }];
}


- (void) request:(NSString *) url
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    if(![self isValidForDelegation]){
        return;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    if (_token){
        [manager.requestSerializer setValue:_token forHTTPHeaderField:@"Prowlist-User"];
    }
    [manager GET:url parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject){
             if (success){
                 success(operation, responseObject);
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if(failure){
                 failure(operation, error);
             }
         }];
}


#pragma Services interaction

- (void) signup:(void (^)(NSError *error, AFHTTPRequestOperation *operation, id responseObject))response {
    NSString *service = [self getServiceWithName:@"signup"];
    [self request:service success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(response){
            response(nil, operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(response){
            response(error, operation, nil);
        }
    }];
}


- (void) updateMember:(NSDictionary *)form response:(void (^)(NSError *error, AFHTTPRequestOperation *operation, id responseObject))response {
    NSString *service = [self getServiceWithName:@"member-update"];
    [self request:service withParams:form success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(response){
            response(nil, operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(response){
            response(error, operation, nil);
        }
    }];
}

@end

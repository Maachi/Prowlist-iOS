//
//  Location.m
//  Prowlist
//
//  Created by Sebastian Romero on 19/09/15.
//  Copyright © 2015 Maachi. All rights reserved.
//

#import "Location.h"

@implementation Location



-(NSDictionary *) serialize {
    return @{
             @"city": self.city,
             @"country" : self.country,
             @"latitude" : self.latitude,
             @"longitude" : self.longitude
            };
}

@end

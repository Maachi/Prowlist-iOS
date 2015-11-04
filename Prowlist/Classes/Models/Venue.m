//
//  Venue.m
//  Prowlist
//
//  Created by Sebastian Romero on 19/09/15.
//  Copyright © 2015 Maachi. All rights reserved.
//

#import "Venue.h"
#import "Location.h"
#import "Tag.h"

@implementation Venue

+ (void) processVenuesResponseFromServer:(NSArray *)venues {
    Venue *venueObject;
    if (venues){
        for (NSDictionary *venue in venues) {
            NSLog(@"Hola venue %@", venue);
            venueObject = [Venue find:[NSString stringWithFormat:@"idVenue==%@", [venue objectForKey:@"id"]]];
            if (!venueObject){
                venueObject = [Venue create];
            }
            venueObject.name = [venue objectForKey:@"name"];
            venueObject.venueDescription = [venue objectForKey:@"description"];
            venueObject.smallDescription = [venue objectForKey:@"small_description"];
            venueObject.idVenue = [venue objectForKey:@"id"];
            if (![[venue objectForKey:@"location"] isEqual:[NSNull null]]){
                venueObject.latitude = [[venue objectForKey:@"location"] objectForKey:@"latitude"];
                venueObject.longitude = [[venue objectForKey:@"location"] objectForKey:@"longitude"];
            }
            if (![[venue objectForKey:@"location"] isEqual:[NSNull null]]){
                venueObject.latitude = [[venue objectForKey:@"location"] objectForKey:@"latitude"];
                venueObject.longitude = [[venue objectForKey:@"location"] objectForKey:@"longitude"];
            }
            [venueObject save];
        }
    }
}

@end

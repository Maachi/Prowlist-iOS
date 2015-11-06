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
            venueObject = [Venue find:[NSString stringWithFormat:@"idVenue==%@", [venue objectForKey:@"id"]]];
            if (!venueObject){
                venueObject = [Venue create];
            }
            venueObject.name = [venue objectForKey:@"name"];
            venueObject.venueDescription = [venue objectForKey:@"description"];
            venueObject.smallDescription = [venue objectForKey:@"small_description"];
            venueObject.idVenue = [venue objectForKey:@"id"];
            venueObject.height = [venue objectForKey:@"height"];
            if (![[venue objectForKey:@"location"] isEqual:[NSNull null]]){
                venueObject.latitude = [[venue objectForKey:@"location"] objectForKey:@"latitude"];
                venueObject.longitude = [[venue objectForKey:@"location"] objectForKey:@"longitude"];
            }
            if (![[venue objectForKey:@"logo_file"] isEqual:[NSNull null]]){
                venueObject.logoPicture = [venue objectForKey:@"logo_file"];
            }
            if (![[venue objectForKey:@"image_relative_path"] isEqual:[NSNull null]]){
                venueObject.detailPhoto = [venue objectForKey:@"image_relative_path"];
            }
            if (![[venue objectForKey:@"products_count"] isEqual:[NSNull null]]){
                venueObject.perksCount = [venue objectForKey:@"products_count"];
            }
            if (![[venue objectForKey:@"controller_style"] isEqual:[NSNull null]]){
                venueObject.statusBarDetailColor = [venue objectForKey:@"controller_style"];
            }
            if (![[venue objectForKey:@"tags"] isEqual:[NSNull null]]){
                [venueObject addTags:[Tag processTag:[venue objectForKey:@"tags"]]];
            }
            [venueObject save];
        }
    }
}

@end

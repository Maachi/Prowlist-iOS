//
//  Venue.h
//  Prowlist
//
//  Created by Sebastian Romero on 19/09/15.
//  Copyright © 2015 Maachi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ObjectiveRecord.h"

@class Location, Tag;

NS_ASSUME_NONNULL_BEGIN

@interface Venue : NSManagedObject

/**
 *  This method process the remote response inside this function and create the respective set ofof venues by it self.
 *  @param venues Array of venues, check the api response to check it structure
 */
+ (void) processVenuesResponseFromServer:(NSArray *)venues;

@end

NS_ASSUME_NONNULL_END

#import "Venue+CoreDataProperties.h"

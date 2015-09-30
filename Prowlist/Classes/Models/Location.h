//
//  Location.h
//  Prowlist
//
//  Created by Sebastian Romero on 19/09/15.
//  Copyright © 2015 Maachi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ObjectiveRecord.h"

NS_ASSUME_NONNULL_BEGIN

@interface Location : NSManagedObject


-(NSDictionary *) serialize;

@end

NS_ASSUME_NONNULL_END

#import "Location+CoreDataProperties.h"

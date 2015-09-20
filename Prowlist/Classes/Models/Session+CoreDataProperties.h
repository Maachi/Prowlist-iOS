//
//  Session+CoreDataProperties.h
//  Prowlist
//
//  Created by Sebastian Romero on 19/09/15.
//  Copyright © 2015 Maachi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Session.h"

NS_ASSUME_NONNULL_BEGIN

@interface Session (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *value;
@property (nullable, nonatomic, retain) NSString *key;
@property (nullable, nonatomic, retain) NSDate *date;

@end

NS_ASSUME_NONNULL_END

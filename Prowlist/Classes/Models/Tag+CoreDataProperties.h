//
//  Tag+CoreDataProperties.h
//  Prowlist
//
//  Created by Sebastian Romero on 19/09/15.
//  Copyright © 2015 Maachi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Tag.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tag (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *label;
@property (nullable, nonatomic, retain) id tint;
@property (nullable, nonatomic, retain) id textColor;
@property (nullable, nonatomic, retain) NSNumber *idTag;

@end

NS_ASSUME_NONNULL_END

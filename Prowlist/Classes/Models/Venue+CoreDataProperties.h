//
//  Venue+CoreDataProperties.h
//  Prowlist
//
//  Created by Sebastian Romero on 19/09/15.
//  Copyright © 2015 Maachi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Venue.h"

NS_ASSUME_NONNULL_BEGIN

@interface Venue (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *smallDescription;
@property (nullable, nonatomic, retain) NSString *venueDescription;
@property (nullable, nonatomic, retain) NSString *photo;
@property (nullable, nonatomic, retain) NSString *detailPhoto;
@property (nullable, nonatomic, retain) NSString *logoPicture;
@property (nullable, nonatomic, retain) NSNumber *staysCount;
@property (nullable, nonatomic, retain) NSNumber *perksCount;
@property (nullable, nonatomic, retain) NSNumber *latitude;
@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) NSNumber *idVenue;
@property (nullable, nonatomic, retain) NSNumber *height;
@property (nullable, nonatomic, retain) NSString *statusBarDetailColor;
@property (nullable, nonatomic, retain) id tintColor;
@property (nullable, nonatomic, retain) NSSet<Tag *> *tags;
@property (nullable, nonatomic, retain) Location *location;

@end

@interface Venue (CoreDataGeneratedAccessors)

- (void)addTagsObject:(Tag *)value;
- (void)removeTagsObject:(Tag *)value;
- (void)addTags:(NSSet<Tag *> *)values;
- (void)removeTags:(NSSet<Tag *> *)values;

@end

NS_ASSUME_NONNULL_END

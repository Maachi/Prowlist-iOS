//
//  Profile+CoreDataProperties.h
//  Prowlist
//
//  Created by Sebastian Romero on 19/09/15.
//  Copyright © 2015 Maachi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Profile.h"

NS_ASSUME_NONNULL_BEGIN

@interface Profile (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *lastname;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSDate *birth;
@property (nullable, nonatomic, retain) NSString *photo;
@property (nullable, nonatomic, retain) NSNumber *synchronized;
@property (nullable, nonatomic, retain) NSString *heroPhoto;
@property (nullable, nonatomic, retain) NSNumber *idUser;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *likes;
@property (nullable, nonatomic, retain) Location *location;
@property (nullable, nonatomic, retain) Location *cityBirth;

@end

@interface Profile (CoreDataGeneratedAccessors)

- (void)addLikesObject:(NSManagedObject *)value;
- (void)removeLikesObject:(NSManagedObject *)value;
- (void)addLikes:(NSSet<NSManagedObject *> *)values;
- (void)removeLikes:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END

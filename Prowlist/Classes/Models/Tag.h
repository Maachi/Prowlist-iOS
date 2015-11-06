//
//  Tag.h
//  Prowlist
//
//  Created by Sebastian Romero on 19/09/15.
//  Copyright © 2015 Maachi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ObjectiveRecord.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tag : NSManagedObject

/**
 *  <#Description#>
 *  @param tags <#tags description#>
 *  @return <#return value description#>
 */
+ (NSSet *) processTag:(NSArray *)tags;

@end

NS_ASSUME_NONNULL_END

#import "Tag+CoreDataProperties.h"

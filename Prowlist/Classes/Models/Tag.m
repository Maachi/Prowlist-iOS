//
//  Tag.m
//  Prowlist
//
//  Created by Sebastian Romero on 19/09/15.
//  Copyright © 2015 Maachi. All rights reserved.
//

#import "Tag.h"

@implementation Tag

+ (NSSet *) processTag:(NSArray *)tags {
    NSMutableSet *processTags = [[NSMutableSet alloc] init];
    if (tags){
        for (NSDictionary *tag in tags) {
            if (tag){
                Tag *tagObject;
                tagObject = [Tag find:[NSString stringWithFormat:@"label=='%@'", [tag objectForKey:@"name"]]];
                if (!tagObject){
                    tagObject = [Tag create];
                }
                tagObject.label = [tag objectForKey:@"name"];
                if (![[tag objectForKey:@"color"] isEqual:[NSNull null]]){
                    tagObject.tint = [tag objectForKey:@"color"];
                }
                if (![[tag objectForKey:@"text_color"] isEqual:[NSNull null]]){
                    tagObject.textColor = [tag objectForKey:@"text_color"];
                }
                [tagObject save];
                [processTags addObject:tagObject];
            }
        }
    }
    return [[NSSet alloc] initWithSet:processTags];
}

@end

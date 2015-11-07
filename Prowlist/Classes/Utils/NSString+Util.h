//
//  NSString+Util.h
//  Prowlist
//
//  Created by Sebastian Romero on 20/09/15.
//  Copyright © 2015 Maachi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Util)

-(BOOL)isBlank;
-(BOOL)contains:(NSString *)string;
-(NSArray *)splitOnChar:(char)ch;
-(NSString *)substringFrom:(NSInteger)from to:(NSInteger)to;
-(NSString *)stringByStrippingWhitespace;
-(BOOL) isEmail;
-(NSString *)urlencode;
-(NSString *)firstName;
-(NSString *)lastname;
-(NSDate *)toDate;
-(NSString *) formatTime;
- (NSString *) imagePathService;

@end
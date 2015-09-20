//
//  NSString+Util.m
//  Prowlist
//
//  Created by Sebastian Romero on 20/09/15.
//  Copyright © 2015 Maachi. All rights reserved.
//

#import "NSString+Util.h"

@implementation NSString (Util)


-(BOOL)isBlank {
    if([[self stringByStrippingWhitespace] isEqualToString:@""])
        return YES;
    return NO;
}


-(NSString *) formatTime {
    NSArray *arrayTime = [self componentsSeparatedByString:@":"];
    NSInteger hours = [[arrayTime objectAtIndex:0] integerValue];
    NSString *cTime = @"am";
    if(hours > 12){
        hours = hours - 12;
        cTime = @"pm";
    }
    return [NSString stringWithFormat:@"%ld:%@ %@", (long)hours, [arrayTime objectAtIndex:1], cTime];
}


-(NSDate *)toDate {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    return [dateFormat dateFromString:self];
}

-(NSString *)lastname {
    NSArray *nameAndLastName = [self componentsSeparatedByString:@" "];
    if(nameAndLastName.count <= 1){
        return nil;
    }
    NSString *lastName = [nameAndLastName objectAtIndex:nameAndLastName.count - 1];
    return [lastName stringByStrippingWhitespace];
}


-(NSString *) firstName {
    NSArray *nameAndLastName = [self componentsSeparatedByString:@" "];
    NSMutableString *fullName = [NSMutableString stringWithString:@""];
    for (int i=0; i<nameAndLastName.count - 1; i++){
        [fullName appendString:[nameAndLastName objectAtIndex:i]];
        [fullName appendString:@" "];
    }
    return [[NSString stringWithString:fullName] stringByStrippingWhitespace];
}

-(BOOL)contains:(NSString *)string {
    NSRange range = [self rangeOfString:string];
    return (range.location != NSNotFound);
}

-(NSString *)stringByStrippingWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(NSArray *)splitOnChar:(char)ch {
    NSMutableArray *results = [[NSMutableArray alloc] init];
    int start = 0;
    for(int i=0; i<[self length]; i++) {
        
        BOOL isAtSplitChar = [self characterAtIndex:i] == ch;
        BOOL isAtEnd = i == [self length] - 1;
        
        if(isAtSplitChar || isAtEnd) {
            //take the substring &amp; add it to the array
            NSRange range;
            range.location = start;
            range.length = i - start + 1;
            
            if(isAtSplitChar)
                range.length -= 1;
            
            [results addObject:[self substringWithRange:range]];
            start = i + 1;
        }
        
        //handle the case where the last character was the split char.  we need an empty trailing element in the array.
        if(isAtEnd && isAtSplitChar)
            [results addObject:@""];
    }
    
    return results;
}

-(NSString *)substringFrom:(NSInteger)from to:(NSInteger)to {
    NSString *rightPart = [self substringFromIndex:from];
    return [rightPart substringToIndex:to-from];
}


-(BOOL) isEmail {
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}


- (NSString *)urlencode {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    long sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

@end

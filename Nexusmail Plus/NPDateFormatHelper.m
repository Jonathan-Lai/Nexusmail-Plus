//
//  NPDateFormatHelper.m
//  Nexusmail Plus
//
//  Created by Jonathan Lai on 2015-12-27.
//  Copyright © 2015 Hoi Fung Lai. All rights reserved.
//

#import "NPDateFormatHelper.h"

@implementation NPDateFormatHelper

+ (NSString *)stringFromDate:(NSDate *)date {
    static NSDateFormatter *dateFormatterTimeOnly = nil;
    static NSDateFormatter *dateFormatter = nil;
    static NSDateFormatter *dateFormatterWithYear = nil;
    static NSCalendar *calendar = nil;
    
    if (nil == dateFormatter) {
        dateFormatterTimeOnly = [[NSDateFormatter alloc] init];
        [dateFormatterTimeOnly setDateFormat:@"h:mm a"];
        
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM d"];
        
        dateFormatterWithYear = [[NSDateFormatter alloc] init];
        [dateFormatterWithYear setDateFormat:@"MMM d, yyyy"];
        
        calendar = [NSCalendar currentCalendar];
    }
    
    NSDateComponents *currentDateComponents = [calendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSDateComponents *messageDateComponents = [calendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:date];
    
    if (messageDateComponents.year != currentDateComponents.year) {
        return [dateFormatterWithYear stringFromDate:date];
    } else if (messageDateComponents.day != currentDateComponents.day) {
        return [dateFormatter stringFromDate:date];
    } else {
        return [dateFormatterTimeOnly stringFromDate:date];
    }
}

@end

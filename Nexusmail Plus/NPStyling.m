//
//  NPStyling.m
//  Nexusmail Plus
//
//  Created by Jonathan Lai on 2015-12-28.
//  Copyright © 2015 Hoi Fung Lai. All rights reserved.
//

#import "NPStyling.h"

@implementation NPStyling

#pragma mark - Colors

+ (UIColor *)blueColor {
    return [UIColor colorWithRed:(33.0f/255.0f) green:(150.0f/255.0f) blue:(243.0f/255.0f) alpha:1.0f];
}

#pragma mark - Fonts

+ (UIFont *)largeFont {
    return [UIFont systemFontOfSize:19];
}

+ (UIFont *)mediumFont {
    return [UIFont systemFontOfSize:17];
}

+ (UIFont *)smallFont {
    return [UIFont systemFontOfSize:15];
}

+ (UIFont *)largeBoldFont {
    return [UIFont boldSystemFontOfSize:19];
}

+ (UIFont *)mediumBoldFont {
    return [UIFont boldSystemFontOfSize:17];
}

+ (UIFont *)smallBoldFont {
    return [UIFont boldSystemFontOfSize:15];
}

@end

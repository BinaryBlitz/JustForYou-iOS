//
//  BBConstantAndColor.m
//  JustForYou
//
//  Created by Антон on 29.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBConstantAndColor.h"

@implementation BBConstantAndColor

#pragma mark - Helper Numbers

+ (NSString *)getNumberEndingWith:(NSInteger)numberInArray andEndings:(NSArray *)endingArray {
    NSString *ending = @"";
    
    numberInArray = numberInArray % 100;
    if (numberInArray>=11 && numberInArray<=19) {
        ending = endingArray[2];
    } else {
        int i = numberInArray % 10;
        switch (i) {
            case (1): ending = endingArray[0]; break;
            case (2):
            case (3):
            case (4): ending = endingArray[1]; break;
            default: ending=endingArray[2];
        }
    }
    return ending;
}

#pragma mark - Colors

+ (UIColor *)applicationOrangeColorWithAlpha:(CGFloat)alpha {
    return [self colorForR:255.0f G:87.0f B:34.0f alpha:alpha];
}

+ (UIColor *)applicationOrangeColor {
    return [self colorForR:255.0f G:87.0f B:34.0f alpha:1.0f];
}

+ (UIColor *)applicationDarkColor {
    return [self colorForR:46.0f G:58.0f B:64.0f alpha:1.0f];
}

+ (UIColor *)applicationGrayColor {
    return [self colorForR:128.0f G:128.0f B:128.0f alpha:1.0f];
}

+ (UIColor *)applicationGreenColor {
    return [self colorForR:125.0f G:182.0f B:98.0f alpha:1.0f];
}

+ (UIColor *)applicationWhiteBackgroundColor {
    return [self colorForR:249.0f G:249.0f B:249.0f alpha:1.0f];
}

+ (UIColor *)colorForR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:alpha];
}

+ (UIColor *)applicationGreenBankColor {
    return [self colorForR:171.0f G:240.0f B:0.0f alpha:1.0f];
}

+ (UIColor *)colorForIdBlock:(NSInteger)blockId {
    if (blockId == 1) {
        return [self programBrownColor];
    } else if (blockId == 2) {
        return [self programGreenColor];
    } else if (blockId == 3) {
        return [self programBlueColor];
    } else if (blockId == 4) {
        return [self programRedColor];
    } else if (blockId == 5) {
        return [self programPurpleColor];
    }
    return [self programYellowColor];
}

+ (UIColor *)programGreenColor {
    return [self colorForR:148.0f G:164.0f B:76.0f alpha:1.0f];
}

+ (UIColor *)programBrownColor {
    return [self colorForR:221.0f G:160.0f B:121.0f alpha:1.0f];
}

+ (UIColor *)programBlueColor {
    return [self colorForR:89.0f G:161.0f B:209.0f alpha:1.0f];
}

+ (UIColor *)programRedColor {
    return [self colorForR:237.0f G:67.0f B:60.0f alpha:1.0f];
}

+ (UIColor *)programPurpleColor {
    return [self colorForR:168.0f G:81.0f B:144.0f alpha:1.0f];
}

+ (UIColor *)programYellowColor {
    return [self colorForR:254.0f G:195.0f B:60.0f alpha:1.0f];
}


#pragma mark - Constant

+ (kModelIPhone)modelDevice {
    CGFloat heightDevice = [[UIScreen mainScreen] bounds].size.height;
    if (heightDevice == 480) {
        return kModelIPhone4;
    } else if (heightDevice == 568) {
        return kModelIPhone5;
    } else if (heightDevice == 667) {
        return kModelIPhone6;
    } else {
        return kModelIPhone6plus;
    }
}


@end
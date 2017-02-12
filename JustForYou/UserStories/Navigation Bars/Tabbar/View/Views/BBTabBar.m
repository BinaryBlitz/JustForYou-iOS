//
//  BBTabBar.m
//  JustForYou
//
//  Created by Антон on 24.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBTabBar.h"

@interface BBTabBar()

@property (nonatomic) NSInteger countItems;

@end

@implementation BBTabBar

-(void)layoutSubviews {
    [super layoutSubviews];
    self.countItems = [self.items count];
    self.tintColor = [UIColor whiteColor]; // color image for selected item
    
    self.selectionIndicatorImage = [self imageWithColor:[BBConstantAndColor applicationOrangeColor]]; // background color for selected item
    [self setImageInsetInTabbar];
}


- (UIImage *)imageWithColor:(UIColor *)color {
    CGSize size = [self sizeForItem];
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (CGSize) sizeForItem {
    return CGSizeMake(CGRectGetWidth(self.frame)/self.countItems, CGRectGetHeight(self.frame));
}

-(void) setImageInsetInTabbar {
    UITabBarItem *item;
    UIImage *icon;
    
    for (int i = 0; i < self.countItems; i++) {
        item = self.items[i];
        icon = item.image;
        [item setImage:[icon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
}


@end

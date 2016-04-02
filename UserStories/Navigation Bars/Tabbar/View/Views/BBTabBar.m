//
//  BBTabBar.m
//  JustForYou
//
//  Created by Антон on 24.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBTabBar.h"

static NSInteger topInset = 8; // custom inset for icons in tabbar
static NSInteger sideInset = 10;

@interface BBTabBar()

@property (nonatomic) NSInteger countItems;

@end

@implementation BBTabBar

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
//    if ([self.tabbarDelegate respondsToSelector:@selector(tabBar:didPressItem:)]) {
//        NSInteger itemNumber = [tabBar.items indexOfObject:item];
//        [self.tabbarDelegate tabBar:self didPressItem:itemNumber];
//    }
}

//-(instancetype)initWithCoder:(NSCoder *)aDecoder {
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        self.delegate = self;
//    }
//    return self;
//}

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
        item.imageInsets = UIEdgeInsetsMake(topInset, 0, -topInset, 0);
//        item.imageInsets = UIEdgeInsetsMake(topInset, sideInset, -topInset, -sideInset);
    }
}


@end

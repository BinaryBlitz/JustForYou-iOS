//
//  BBConstantAndColor.h
//  JustForYou
//
//  Created by Антон on 29.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Typedef Key

// Для старта с нужного контроллера
typedef enum : NSUInteger {
    BBRegistrationModule,
    BBLoadBlockModule,
    BBLoadOrdersModule,
    BBLoadProfileModule,
    BBLoadSupportModule
}BBLoadModule;


// Кнопочки в таббаре
typedef enum : NSUInteger {
    BBTabbarItemPrograms,
    BBTabbarItemOrders,
    BBTabbarItemProfile,
    BBTabbarItemSupport
} BBTabbarItem;


typedef enum : NSUInteger {
    BBLeftOrientationBarButtonItem,
    BBRightOrientationBarButtonItem
}BBOrientetionBarButtonItem;

#pragma mark - interface class

@interface BBConstantAndColor : NSObject

+ (UIColor *)colorForR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha;

+ (UIColor *)applicationOrangeColor;

+ (UIColor *)applicationDarkColor;

@end

#pragma mark - Constant

static CGFloat bottomOffsetForBlockTableView = 13.0f;


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
    BBLoadSupportModule,
    BBLoadProfileModule,
    BBLoadBasketModule
}BBLoadModule;


// Кнопочки в таббаре
typedef enum : NSUInteger {
    BBTabbarItemPrograms,
    BBTabbarItemOrders,
    BBTabbarItemProfile,
    BBTabbarItemSupport
} BBTabbarItem;


// стиль ячейки: карточкой или обычный
typedef enum : NSUInteger {
    kStandartContentCell,
    kCardContentCell
}BBKeyStyleContentCell;

// какие углы закруглять у ячейки таблицы
typedef enum : NSUInteger {
    kNoneCornerRadius,
    kTopCornerRadius,
    kBottomCornerRadius,
    kAllCornerRadius
}BBKeyCornerRadius;


typedef enum : NSUInteger {
    BBLeftOrientationBarButtonItem,
    BBRightOrientationBarButtonItem
}BBOrientetionBarButtonItem;

// Индекс SegmentedControl-а в карточке программы
typedef enum : NSUInteger {
    BBDescriptionSegmentedIndex,
    BBMenuSegmentedIndex
}BBCardProgramSegmentedIndex;


typedef enum : NSUInteger {
    kModelIPhone4,
    kModelIPhone5,
    kModelIPhone6,
    kModelIPhone6plus
}kModelIPhone;

#pragma mark - interface class

@interface BBConstantAndColor : NSObject

+ (UIColor *)colorForR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha;

+ (UIColor *)applicationOrangeColor;

+ (UIColor *)applicationOrangeColorWithAlpha:(CGFloat)alpha;

+ (UIColor *)applicationDarkColor;

+ (UIColor *)applicationGreenColor;

+ (UIColor *)applicationGrayColor;

+ (UIColor *)applicationWhiteBackgroundColor;

+ (kModelIPhone)modelDevice;

@end

#pragma mark - Constant

static CGFloat bottomOffsetForBlockTableView = 13.0f;
static CGFloat cornerRadiusCell = 4.0f;
static CGFloat sideOffsetCell = 14.0f;
static CGFloat borderWightLineCell = 1.0f;
static CGFloat bottomOffsetCells = 10.0f;


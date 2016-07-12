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

// тип контролера для экрана замены
typedef enum : NSUInteger {
    kViewReplacementType,
    kAddReplacementType
}BBTypeReplacementController;

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
    BBMenuSegmentedIndex,
    BBForWhomSegmentedIndex
}BBCardProgramSegmentedIndex;

// модель телефона
typedef enum : NSUInteger {
    kModelIPhone4,
    kModelIPhone5,
    kModelIPhone6,
    kModelIPhone6plus
}kModelIPhone;


// тип экрана в блоке профиль
typedef enum : NSUInteger {
    kNoneModule,
    kMyPayCardModule,
    kMyProgramModule,
    kMyAddressModule,
    kMyAddressForOrderModule,
    kMyHystoryPaymentModule,
    kReplacementModule,
    kSharesModule,
    kAboutModule
}BBKeyModuleForUniversalModule;


// Время дня
typedef enum : NSUInteger {
    kMorningPartOfDay,
    kDayPartOfDay,
    kEveningPartOfDay
}BBPartOfDay;


// Статус создания доставки
typedef enum : NSUInteger {
    kStatusNone,
    kStatusCreate,
    kStatusError
}BBStatusCreateDelivery;


//тип action у alert в контроллере
typedef enum : NSUInteger {
    kPopController,
    kContinueButton,
    kPayOkButton,
    kPayCancelButton
}BBKeyForOkButtonAlert;

// Сделать запрос и обновить данные или сделать запрос и положить их в базу
typedef enum : NSUInteger {
    kStateUpdateData,
    kStateCreateData
}BBKeyStateData;

#pragma mark - interface class

@interface BBConstantAndColor : NSObject

#pragma mark - Helper Numbers

+ (NSString *)getNumberEndingWith:(NSInteger)numberInArray andEndings:(NSArray *)endingArray;

#pragma mark - Colors

+ (UIColor *)colorForR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha;

+ (UIColor *)applicationOrangeColor;

+ (UIColor *)applicationOrangeColorWithAlpha:(CGFloat)alpha;

+ (UIColor *)applicationDarkColor;

+ (UIColor *)applicationGreenColor;

+ (UIColor *)applicationGrayColor;

+ (UIColor *)applicationWhiteBackgroundColor;

+ (UIColor *)applicationGreenBankColor;

+ (UIColor *)colorForIdBlock:(NSInteger)blockId;

+ (kModelIPhone)modelDevice;

@end

#pragma mark - Numerical Constant

static CGFloat bottomOffsetForBlockTableView = 13.0f;
static CGFloat cornerRadiusCell = 4.0f;
static CGFloat sideOffsetCell = 14.0f;
static CGFloat borderWightLineCell = 1.0f;
static CGFloat bottomOffsetCells = 10.0f;
static CGFloat alphaBackgroundLoader = 0.7f;


#pragma mark - Title And Message Alert

static NSString *kNoteTitle = @"Внимание";
static NSString *kErrorTitle = @"Ошибка";

static NSString *kNextButton = @"Продолжить";

static NSString *kErrorServer = @"Ошибка сервера. Повторите позже или обратитесь в службу поддержки";
static NSString *kErrorClient = @"Ошибка сервера. Возможно неверно введены данные";
static NSString *kErrorConnectNetwork = @"Ошибка соединения. Проверьте пожалуйста подключение к интернету";

static NSString *messagePayAlert = @"Выберите карту которой хотите оплатить";
static NSString *paymentSuccessfull = @"Оплата успешно произведена";
static NSString *paymentError = @"Произошла ошибка оплаты. Проверьте баланс своей карты или попробуйте позже";

#pragma mark - Name Title Module

static NSString *kNameTitleRegistrationModule = @"Регистрация";
static NSString *kNameTitleAuthorizateModule = @"Вход";
static NSString *kNameTitleGreetingModule = @"JustForYou";

static NSString *kNameTitleProgramModule = @"Программы";
static NSString *kNameTitleBasketModule = @"Корзина";
static NSString *kNameTitleMyProgramModule = @"Мои программы";
static NSString *kNameTitleReplaceProgramModule = @"Замена";
static NSString *kNameTitlePaymentModule = @"Оплата";


static NSString *kNameTitleOrdersModule = @"Заказы";
static NSString *kNameTitleNewOrderModule = @"Новый заказ";

static NSString *kNameTitleSupportModule = @"Поддержка";

static NSString *kNameTitleProfileModule = @"Профиль";
static NSString *kNameTitleAddressModule = @"Адреса";
static NSString *kNameTitleHystoryPaymentsModule = @"История платежей";
static NSString *kNameTitleReplacementModule = @"Замены";
static NSString *kNameTitleSharesModule = @"Акции";

static NSString *kNameTitleSettingsModule = @"Настройки";
static NSString *kNameTitleMyPayCardModule = @"Мои карты";
static NSString *kNameTitleAboutModule = @"Что такое Just For You?";

static NSString *kNameTitleMapModule = @"Выберите адрес";

static NSString *kNameTitleNoneModule = @"";


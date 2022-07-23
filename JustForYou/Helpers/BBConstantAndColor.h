#import <Foundation/Foundation.h>

@class BBProgram;

#pragma mark - Typedef Key

// Для старта с нужного контроллера
typedef enum : NSUInteger {
  BBRegistrationModule,
  BBLoadBlockModule,
  BBLoadOrdersModule,
  BBLoadSupportModule,
  BBLoadProfileModule,
  BBLoadBasketModule
} BBLoadModule;

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
} BBTypeReplacementController;

// стиль ячейки: карточкой или обычный
typedef enum : NSUInteger {
  kStandartContentCell,
  kCardContentCell
} BBKeyStyleContentCell;

// какие углы закруглять у ячейки таблицы
typedef enum : NSUInteger {
  kNoneCornerRadius,
  kTopCornerRadius,
  kBottomCornerRadius,
  kAllCornerRadius
} BBKeyCornerRadius;

typedef enum : NSUInteger {
  BBLeftOrientationBarButtonItem,
  BBRightOrientationBarButtonItem
} BBOrientetionBarButtonItem;

// Индекс SegmentedControl-а в карточке программы
typedef enum : NSUInteger {
  BBForWhomSegmentedIndex,
  BBDescriptionSegmentedIndex,
  BBMenuSegmentedIndex
} BBCardProgramSegmentedIndex;

// модель телефона
typedef enum : NSUInteger {
  kModelIPhone4,
  kModelIPhone5,
  kModelIPhone6,
  kModelIPhone6plus
} kModelIPhone;

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
} BBKeyModuleForUniversalModule;

// Время дня
typedef enum : NSUInteger {
  kMorningPartOfDay,
  kDayPartOfDay,
  kEveningPartOfDay
} BBPartOfDay;

// Статус создания доставки
typedef enum : NSUInteger {
  kStatusNone,
  kStatusCreate,
  kStatusError
} BBStatusCreateDelivery;

//тип action у alert в контроллере
typedef enum : NSUInteger {
  kPopController,
  kContinueButton,
  kPayOkButton,
  kPayCancelButton
} BBKeyForOkButtonAlert;

// Сделать запрос и обновить данные или сделать запрос и положить их в базу
typedef enum : NSUInteger {
  kStateUpdateData,
  kStateCreateData
} BBKeyStateData;

#pragma mark - interface class

@interface BBConstantAndColor : NSObject

#pragma mark - Helper Numbers

+ (NSString *)getNumberEndingWith:(NSInteger)numberInArray andEndings:(NSArray *)endingArray;

#pragma mark - Helper Formated String

+ (NSString *)formatedStringForOneDayWithProgram:(BBProgram *)program;
+ (NSString *)formatedStringForAnyDayWithProgram:(BBProgram *)program;

#pragma mark - Colors

+ (UIColor *)colorForR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha;

+ (UIColor *)applicationOrangeColor;

+ (UIColor *)applicationOrangeColorWithAlpha:(CGFloat)alpha;

+ (UIColor *)applicationDarkColor;

+ (UIColor *)applicationGreenColor;

+ (UIColor *)applicationGrayColor;

+ (UIColor *)applicationWhiteBackgroundColor;

+ (UIColor *)applicationGreenBankColor;

+ (kModelIPhone)modelDevice;

@end

#pragma mark - Numerical Constant

static CGFloat bottomOffsetForBlockTableView = 13.0f;
static CGFloat cornerRadiusCell = 4.0f;
static CGFloat sideOffsetCell = 14.0f;
static CGFloat borderWightLineCell = 1.0f;
static CGFloat bottomOffsetCells = 10.0f;
static CGFloat alphaBackgroundLoader = 0.7f;
static CGFloat sizeNavigationBar = 64.0f;
static CGFloat animateTime = 0.25f;
static CGFloat sizeNavButton = 25.0f;

static NSString *kNotificationLogOutUser = @"kNotificationLogOutUser";
static NSString *kNotificationResetBlocks = @"kNotificationResetBlocks";

#pragma mark - Title And Message Alert

static NSString *kNoteTitle = @"Внимание";
static NSString *kErrorTitle = @"Ошибка";

static NSString *kNextButton = @"Продолжить";

static NSString *kErrorServer = @"Ошибка сервера. Повторите позже или обратитесь в службу поддержки";
static NSString *kErrorClient = @"Ошибка сервера. Возможно неверно введены данные";
static NSString *kErrorConnectNetwork = @"Ошибка соединения. Проверьте пожалуйста подключение к интернету";

static NSString *messagePayAlert = @"Выберите карту которой хотите оплатить";
static NSString *paymentSuccessfull = @"Благодарим Вас за покупку!";
static NSString *deliveryError = @"Программа %@ была приобретена, но произошла ошибка при оформлении доставки. Переоформите доставку в разделе \"Заказы\" ";
static NSString *paymentError = @"Произошла ошибка оплаты. Проверьте баланс своей карты или попробуйте позже";

static NSString *kErrorSendEmail = @"Не удалось отправить письмо";
static NSString *kErrorCallManager = @"Произошла внутренняя ошибка приложения";

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
static NSString *kNameTitlNeweAddressModule = @"Новый адрес";
static NSString *kNameTitleHystoryPaymentsModule = @"История платежей";
static NSString *kNameTitleReplacementModule = @"Замены";
static NSString *kNameTitleSharesModule = @"Акции";

static NSString *kNameTitleSettingsModule = @"Настройки";
static NSString *kNameTitleMyPayCardModule = @"Мои карты";
static NSString *kNameTitleAboutModule = @"Что такое Just For You?";

static NSString *kNameTitleMapModule = @"Выберите адрес";

static NSString *kNameTitleNoneModule = @"";

#pragma mark - URL Social Group

static NSString *kFacebookSocialGroup = @"https://m.facebook.com/%D0%97%D0%B4%D0%BE%D1%80%D0%BE%D0%B2%D0%BE%D0%B5-%D0%BF%D0%B8%D1%82%D0%B0%D0%BD%D0%B8%D0%B5-Just-for-You-344877778958831/";

static NSString *kInstagramSocialGroup = @"https://www.instagram.com/justforyou_ru/";

static NSString *kNumberPhoneManager = @"+74957075353";

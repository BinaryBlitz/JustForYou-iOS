//
//  BBNewOrderPresenter.m
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBNewOrderPresenter.h"

#import "BBNewOrderViewInput.h"
#import "BBNewOrderInteractorInput.h"
#import "BBNewOrderRouterInput.h"

#import "BBNavigationModuleInput.h"

#import "BBDeliveryAssembly.h"
#import "BBDeliveryModuleInput.h"

#import "BBUniversalAssembly.h"
#import "BBUniversalModuleInput.h"

#import "BBMyProgramsModuleInput.h"

@interface BBNewOrderPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;
@property (strong, nonatomic) id<BBDeliveryModuleInput> deliveryModule;
@property (strong, nonatomic) id<BBUniversalModuleInput> universalModule;

@property (strong, nonatomic) id<BBMyProgramsModuleInput> programsModule;

@property (strong, nonatomic) BBPurchases *purchase;
@property (strong, nonatomic) NSArray *selectionDates;
@property (strong, nonatomic) BBAddress *address;
@property (assign, nonatomic) BBStatusCreateDelivery statusServer;

@property (assign, nonatomic) BOOL deleteDays;

@end

static NSString *kErrorEmptyDays = @"Вы должны выбрать хотя бы один день";
static NSString *kErrorAddress = @"Выбран некорректный адрес";

static NSString *kErrorServerDelivery = @"Произошла ошибка при создании заказа. Попробуйте повторить позже или обратитесь в службу поддержки";
static NSString *kDeliveryCreateMessage = @"Заказ успешно создан";

@implementation BBNewOrderPresenter

#pragma mark - Методы BBNewOrderModuleInput

- (void)configureModule {
    self.selectionDates = [NSArray array];
    self.deleteDays = YES;
}

- (void)pushModuleWithNavigationModule:(id)navigationModule purchase:(BBPurchases *)purchase parentModule:(id)parent {
    self.statusServer = kStatusNone;
    self.navigationModule = navigationModule;
    self.purchase = purchase;
    self.programsModule = parent;
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

- (void)popAdressModuleWithAdress:(BBAddress *)address {
    self.deleteDays = NO;
    self.address = address;
    [self.view adressForAdressTableViewCell:address.address];
    [self.router popViewControllerWithNavigationController:[self.navigationModule currentView]];
}

- (void)selectionDates:(NSArray *)array {
    self.selectionDates = array;
    self.deleteDays = NO;
}

#pragma mark - Методы BBNewOrderViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)viewWillAppear {
    if (self.deleteDays) {
        self.selectionDates = [NSArray array];
    } else {
        self.deleteDays = YES;
    }
    [self.view countsDaysInCalendar:[self.selectionDates count]];
    [self.view purchaseWithPurchase:self.purchase];
}

- (void)countDayCellDidTap {
    [self.deliveryModule pushModuleWithNavigationModule:self.navigationModule parent:self purchase:self.purchase];
}

- (void)adresCellDidTap {
    [self.universalModule pushModuleWithNavigationModule:self.navigationModule parentModule:self keyModule:kMyAddressForOrderModule];
}

- (void)toOrderButtonDidTapWithComment:(NSString *)comment {
    if ([self.selectionDates count] == 0) {
        [self.view presentAlertWithTitle:kNoteTitle message:kErrorEmptyDays];
        return;
    }
    if (!self.address) {
        [self.view presentAlertWithTitle:kNoteTitle message:kErrorAddress];
        return;
    }
    [self.view showBackgroundLoaderViewWithAlpha:alphaBackgroundLoader];
    [self.interactor createDeliveryOnServerWithDays:self.selectionDates address:self.address purchase:self.purchase coment:comment];
}

- (void)alertOkDidTap {
    [self _resetParametrs];
    [self.programsModule popViewControllerWithStatus:self.statusServer];
}


#pragma mark - Методы BBNewOrderInteractorOutput

- (void)errorNetwork {
    [self.view hideBackgroundLoaderViewWithAlpha];
    [self.view presentAlertWithTitle:kNoteTitle message:kErrorConnectNetwork];
}

- (void)errorServer {
    [self.view hideBackgroundLoaderViewWithAlpha];
    self.statusServer = kStatusError;
    [self.view presentFinishAlertWithTitle:kNoteTitle message:kErrorServerDelivery];
}

- (void)deliveriesCreateSuccessfull {
    [self.view hideBackgroundLoaderViewWithAlpha];
    self.statusServer = kStatusCreate;
    [self.view presentFinishAlertWithTitle:kNoteTitle message:kDeliveryCreateMessage];
}

- (void)_resetParametrs {
    self.selectionDates = [NSArray array];
    [self.view adressForAdressTableViewCell:@""];
}

#pragma mark - Lazy Load

-(id<BBDeliveryModuleInput>)deliveryModule {
    if (!_deliveryModule) {
        _deliveryModule = [BBDeliveryAssembly createModule];
    }
    return _deliveryModule;
}

- (id<BBUniversalModuleInput>)universalModule {
    if (!_universalModule) {
        _universalModule = [BBUniversalAssembly createModule];
    }
    return _universalModule;
}


@end
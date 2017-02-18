#import "BBAddressPresenter.h"

#import "BBAddressViewInput.h"
#import "BBAddressInteractorInput.h"
#import "BBAddressRouterInput.h"

#import "BBNavigationModuleInput.h"

#import "BBMapAssembly.h"
#import "BBMapModuleInput.h"

#import "BBUniversalModuleInput.h"

@interface BBAddressPresenter ()

@property (strong, nonatomic) id <BBNavigationModuleInput> navigationModule;
@property (strong, nonatomic) id <BBMapModuleInput> mapModule;
@property (strong, nonatomic) id <BBUniversalModuleInput> universalModule;

@end

static NSString *kErrorAddAddress = @"Вы пытаетесь добавить адрес который уже есть в Вашем списке адресов";

static NSString *kErrorNumberSymbol = @"В данное поле можно вводить только цифры";

static NSString *kEmptyStreet = @"Добавьте улицу";
static NSString *kEmptyHouse = @"Добавьте номер дома";
static NSString *kEmptyEntrance = @"Добавьте подъезд";
static NSString *kEmptyFloor = @"Добавьте этаж";
static NSString *kEmptyApartment = @"Добавьте номер квартиры";

@implementation BBAddressPresenter

#pragma mark - Методы BBAddressModuleInput

- (void)configureModule {
}

- (void)pushModuleWithNavigationModule:(id)navigationModule parentModule:(id)parent {
  self.navigationModule = navigationModule;
  self.universalModule = parent;
  [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

- (void)popMapModuleWithAddress:(BBAddress *)address addressText:(NSString *)addressText {
  [self.router popViewControllerWithNavigationController:[self.navigationModule currentView]];
  if (!address) {
    address = [[BBAddress alloc] init];
    address.street = addressText;
  }
  [self.view updateTableViewWithAddress:address];
}

#pragma mark - Методы BBAddressViewOutput

- (void)didTriggerViewReadyEvent {
  [self.view setupInitialState];
}

- (void)viewWillAppear {
}

- (void)streetCellDidSelect {
  [self.mapModule pushModuleWithNavigationModule:self.navigationModule parentModule:self];
}

- (void)addAddressButtonDidTapWithAddress:(BBAddress *)address {
  if (!address.street || [address.street isEqualToString:@""] || [address.street isEqualToString:@" "]) {
    [self.view presentAlertWithTitle:kNoteTitle message:kEmptyStreet];
  } else if (!address.house || [address.house isEqualToString:@""] || [address.house isEqualToString:@" "]) {
    [self.view presentAlertWithTitle:kNoteTitle message:kEmptyHouse];
  } else if (address.entrance <= 0) {
    [self.view presentAlertWithTitle:kNoteTitle message:kEmptyEntrance];
  } else if (address.floor <= 0) {
    [self.view presentAlertWithTitle:kNoteTitle message:kEmptyFloor];
  } else if (address.apartment <= 0) {
    [self.view presentAlertWithTitle:kNoteTitle message:kEmptyApartment];
  } else {
    [self.view showBackgroundLoaderViewWithAlpha:alphaBackgroundLoader];
    [self.interactor addAddressToUserAddressArrayWithAddressText:address];
  }
}

- (BOOL)apartmentFieldBeginEditingWithSymbol:(NSString *)symbol textInField:(NSString *)text {
  if ([self validateApartmentFieldWithSymbol:symbol]) {
    [self.view presentAlertWithTitle:kNoteTitle message:kErrorNumberSymbol];
    return NO;
  } else {
    [self.view saveApartmentWithString:[NSString stringWithFormat:@"%@%@", text, symbol]];
  }
  return YES;
}

- (BOOL)validateApartmentFieldWithSymbol:(NSString *)symbol {
  NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
  NSArray *components = [symbol componentsSeparatedByCharactersInSet:validationSet];
  if ([components count] > 1) {
    return YES;
  }
  return NO;
}

#pragma mark - Методы BBAddressInteractorOutput

- (void)addressDidSaveWithStatus:(BOOL)status {
  [self.view hideBackgroundLoaderViewWithAlpha];
  if (!status) {
    [self.view presentAlertWithTitle:kNoteTitle message:kErrorAddAddress];
  } else {
    [self.view clearFields];
    [self.router popViewControllerWithNavigationController:[self.navigationModule currentView]];
  }
}

- (void)errorNetwork {
  [self.view hideBackgroundLoaderViewWithAlpha];
  [self.view presentAlertWithTitle:kNoteTitle message:kErrorConnectNetwork];
}

- (void)errorServer {
  [self.view hideBackgroundLoaderViewWithAlpha];
  [self.view presentAlertWithTitle:kNoteTitle message:kErrorServer];
}

#pragma mark - Lazy Load

- (id <BBMapModuleInput>)mapModule {
  if (!_mapModule) {
    _mapModule = [BBMapAssembly createModule];
  }
  return _mapModule;
}


@end

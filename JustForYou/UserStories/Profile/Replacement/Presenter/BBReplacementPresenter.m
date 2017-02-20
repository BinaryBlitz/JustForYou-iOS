#import "BBReplacementPresenter.h"

#import "BBReplacementViewInput.h"
#import "BBReplacementInteractorInput.h"
#import "BBReplacementRouterInput.h"

#import "BBNavigationModuleInput.h"

#import "BBReplacementAssembly.h"

@interface BBReplacementPresenter ()

@property (strong, nonatomic) id <BBNavigationModuleInput> navigationModule;
@property (strong, nonatomic) id <BBReplacementModuleInput> replacementModule;

@property (strong, nonatomic) NSArray *category;
@property (assign, nonatomic) BBTypeReplacementController keyType;

@end

@implementation BBReplacementPresenter

#pragma mark - Методы BBReplacementModuleInput

- (void)configureModule {
}

- (void)pushModuleWithNavigationModule:(id)navigationModule withType:(BBTypeReplacementController)type replacementCatgory:(NSArray *)category {
  self.navigationModule = navigationModule;
  self.category = category;
  self.keyType = type;
  [self.view typeForController:type];
  [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

- (void)pushModuleWithNavigationModule:(id)navigationModule withType:(BBTypeReplacementController)type {
  self.navigationModule = navigationModule;
  self.keyType = type;
  [self.view typeForController:type];
  [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

#pragma mark - Методы BBReplacementViewOutput

- (void)didTriggerViewReadyEvent {
  [self.view setupInitialState];
}

- (void)viewWillAppear {
  [self.view updateTableInsets];
  if (self.keyType == kViewReplacementType) {
    [self.interactor currentReplacementUser];
  } else {
    [self.view updateWithCategory:self.category];
  }
}

- (void)addBarButtonDidTap {
  if ([self.view countReplacementInTableView] < 3) {
    [self.view showBackgroundLoaderViewWithAlpha:alphaBackgroundLoader];
    [self.interactor listReplacementOnServer];
  } else {
    [self.view presentAlertControllerWithMessage:@"Вы не можете добавить еще одну замену. Пожалуйста, удалите одну или несколько замен"];
  }
}

- (void)cellDidSelectWithText:(BBReplacementProduct *)product {
  [self.view showBackgroundLoaderViewWithAlpha:alphaBackgroundLoader];
  [self.interactor addInCurrentArrayReplacementNewElement:product];
}

- (void)deleteElementWithText:(BBReplacementProduct *)product {
  [self.view showBackgroundLoaderViewWithAlpha:alphaBackgroundLoader];
  [self.interactor deleteElementInArrayWithElement:product];
}

#pragma mark - Методы BBReplacementInteractorOutput

- (void)currentReplacementInData:(NSArray *)replacement {
  [self.view currentReplacementArray:replacement];
}

- (void)currentReplacementUpdate {
  [self.view hideBackgroundLoaderViewWithAlpha];
  [self.router popViewControllerWithNavigationController:[self.navigationModule currentView]];
}

- (void)elemetnDidDeleteWithNewArray:(NSArray *)array {
  [self.view hideBackgroundLoaderViewWithAlpha];
  [self.view endUpdateTableViewWithNewReplacement:array];
}

- (void)replacementCategoryInArray:(NSArray *)categories {
  [self.view hideBackgroundLoaderViewWithAlpha];
  [self.replacementModule pushModuleWithNavigationModule:self.navigationModule withType:kAddReplacementType replacementCatgory:categories];
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

- (id <BBReplacementModuleInput>)replacementModule {
  if (!_replacementModule) {
    _replacementModule = [BBReplacementAssembly createModule];
  }
  return _replacementModule;
}

@end

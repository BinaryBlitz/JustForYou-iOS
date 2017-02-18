#import "BBItemService.h"

#import "BBUserService.h"

@interface BBItemService () {
  Completion completionBlock;
}

@end

@implementation BBItemService

#pragma mark - Init Methods

+ (instancetype)sharedService {
  static BBItemService *service = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    service = [[BBItemService alloc] init];
  });
  return service;
}

- (UIBarButtonItem *)basketItemWithCallback:(Completion)completion {
  BBButtonWithIndicator *button = [[BBButtonWithIndicator alloc] initWithFrame:CGRectMake(0, 0, sizeNavButton, sizeNavButton)];
  [button setImage:[[UIImage imageNamed:@"basket"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
          forState:UIControlStateNormal];
  button.label.hidden = YES;
  completionBlock = completion;
  [button addTarget:self action:@selector(_basketButtonAction) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
  return item;
}

#pragma mark - Update Methods

- (void)updateImageInBarButtonItem:(UIBarButtonItem *)item forImage:(NSString *)name {
  BBButtonWithIndicator *button = item.customView;
  [button setImage:[[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
}

- (void)setCountPurchasesInLabelForItem:(UIBarButtonItem *)item button:(BBButtonWithIndicator *)button {
  BBUser *user = [[BBUserService sharedService] currentUser];
  if (user.countPurchases > 0) {
    button.label.text = [NSString stringWithFormat:@"%ld", (long) user.countPurchases];
    [self setHiddenLabelInItem:item hidden:NO];
  } else {
    [self setHiddenLabelInItem:item hidden:YES];
  }
}

- (void)setHiddenLabelInItem:(UIBarButtonItem *)item hidden:(BOOL)hidden {
  BBButtonWithIndicator *button = item.customView;
  button.label.hidden = hidden;
}

#pragma mark - Actions Methods

- (void)_basketButtonAction {
  if (completionBlock) {
    completionBlock();
  }
}


@end

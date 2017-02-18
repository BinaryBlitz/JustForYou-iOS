#import "BBTabbarViewController.h"

#import "BBTabbarViewOutput.h"

#import "BBTabBar.h"

#import "BBItemService.h"
#import "BBUserService.h"

@interface BBTabbarViewController()

@end

static CGFloat sizeLabel = 20.0f;
static CGFloat sizeFont = 12.0f;
static CGFloat labelInset = 5.0f;

@implementation BBTabbarViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.output viewWillAppear];
    [self.tabBar layoutSubviews];
}

#pragma mark - Методы BBTabbarViewInput

- (void)setupInitialState {
    
}

- (void)presentFirstItem {
    [self setSelectedIndex:0];
    self.indicatorLabel.hidden = YES;
    NSInteger count = [[BBUserService sharedService] currentUser].countPurchases;
    if (count > 0) {
        self.indicatorLabel.hidden = NO;
        self.indicatorLabel.text = [NSString stringWithFormat:@"%ld", (long)count];
    }
}

- (void)setItemsBar:(NSArray *)items {
    self.viewControllers = items;
    
    self.tabBar.items[0].image = [UIImage imageNamed:@"home"];
    self.tabBar.items[1].image = [UIImage imageNamed:@"orders"];
    self.tabBar.items[2].image = [UIImage imageNamed:@"support"];
    self.tabBar.items[3].image = [UIImage imageNamed:@"profile"];
    
    self.tabBar.items[0].title = kNameTitleProgramModule;
    self.tabBar.items[1].title = kNameTitleOrdersModule;
    self.tabBar.items[2].title = kNameTitleSupportModule;
    self.tabBar.items[3].title = kNameTitleProfileModule;

    [self.tabBar addSubview:self.indicatorLabel];
    [self.tabBar layoutIfNeeded];
}

#pragma mark - Lazy Load

- (UILabel *)indicatorLabel {
    if (!_indicatorLabel) {
        CGFloat wightItem = CGRectGetWidth(self.view.bounds)/[self.tabBar.items count];
        self.indicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(wightItem*2-sizeLabel-labelInset, labelInset, sizeLabel, sizeLabel)];
        self.indicatorLabel.backgroundColor = [BBConstantAndColor applicationOrangeColor];
        self.indicatorLabel.textColor = [UIColor whiteColor];
        self.indicatorLabel.textAlignment = NSTextAlignmentCenter;
        self.indicatorLabel.font = [UIFont systemFontOfSize:sizeFont];
        self.indicatorLabel.text = @"0";
        self.indicatorLabel.layer.masksToBounds = YES;
        self.indicatorLabel.layer.cornerRadius = CGRectGetHeight(_indicatorLabel.frame)/2;
    }
    return _indicatorLabel;
}


@end

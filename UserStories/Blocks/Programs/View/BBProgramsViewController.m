//
//  BBProgramsViewController.m
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBProgramsViewController.h"

#import "BBProgramsViewOutput.h"

#import "BBProgramView.h"

@interface BBProgramsViewController() <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moreButton;

@property (strong, nonatomic) NSArray *programsArray;

@property (nonatomic) CGFloat wightProgramView;
@property (nonatomic) CGFloat insetfForView;

@property (nonatomic) CGFloat currentPage;
@property (nonatomic) NSInteger countPage;

@property (strong, nonatomic) NSMutableArray *arrayViews;

@end


@implementation BBProgramsViewController

#pragma mark - Методы жизненного цикла

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self _resizeViewOnScrollView];
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.output viewWillAppear];
}

#pragma mark - Actions

- (void)_basketButtonAction {
    [self.output basketButtonDidTap];
}

- (IBAction)moreButtonAction:(id)sender {
    [self.output programDidTapWithProgram:[BBProgram new]];
}

#pragma mark - Методы BBProgramsViewInput

- (void)setupInitialState {
    self.scrollView.delegate = self;
    self.countPage = 2;
    self.secondImageView.alpha = 0.0;
    self.pageControl.numberOfPages = self.countPage;
    self.pageControl.enabled = NO;
    [self _relodViewsInScrollView];
    [self _initRightBarButton];
    [self _initWightProgramView];
}

- (void)programsForTableView:(NSArray *)programs {
//    self.programsArray = programs;
//    self.countPage = [programs count];
//    HQDispatchToMainQueue(^{
//        if ([self.programsArray count] > 0) {
//            [self _relodViewsInScrollView];
//        }
//    });
}

- (void)_relodViewsInScrollView {
//    if ([self.scrollView.subviews count] > 0) {
//        for (UIView *view in self.scrollView.subviews) {
//            [view removeFromSuperview];
//        }
//    }
    self.scrollView.contentSize = CGSizeMake(self.wightProgramView*self.countPage + (self.insetfForView*(self.countPage+3)), self.scrollView.frame.size.height);
    for (int i = 0; i < self.countPage; i++) {
        CGFloat x = self.wightProgramView*i + self.insetfForView*2 + self.insetfForView *i;
        
        BBProgramView *view = [[BBProgramView alloc] init];
        view.program = [self.programsArray objectAtIndex:i];
        view.frame = CGRectMake(x, 0, self.wightProgramView, CGRectGetHeight(self.scrollView.frame));
        [self.scrollView addSubview:view];
        [self.arrayViews addObject:view];
    }
}

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message {
    [self programsForTableView:@[@"dsfws", @"fsw", @"sdcskd"]];
    [self presentAlertControllerWithTitle:title message:message];
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat curX = scrollView.contentOffset.x;
    CGFloat pageWidth = scrollView.frame.size.width;
    
    CGFloat ratio = curX/pageWidth;
    double d, drob;
    drob = modf(ratio, &d);
    
//    NSLog(@"%f, часть какая то = %f", ratio, drob);
    self.secondImageView.alpha = drob;
    
//    NSInteger offsetLooping = 1;
    NSInteger page = round((scrollView.contentOffset.x + (0.5f * self.wightProgramView)) / pageWidth);
    self.pageControl.currentPage = (page % self.countPage);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    CGFloat kMaxIndex = self.countPage;
    CGFloat targetX = scrollView.contentOffset.x + velocity.x * 240;
    CGFloat targetIndex = round(targetX / (self.wightProgramView + self.insetfForView));
    
    if (targetIndex < 0) {
        targetIndex = 0;
    }
    if (targetIndex > kMaxIndex) {
        targetIndex = kMaxIndex;
    }
    targetContentOffset->x = targetIndex * (self.wightProgramView + self.insetfForView);
}



#pragma mark - Init Methods

- (void)_initRightBarButton {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"basket"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(_basketButtonAction)];
    
    self.navigationItem.rightBarButtonItem = item;
}

- (void)_initWightProgramView {
    kModelIPhone model = [BBConstantAndColor modelDevice];
    if (model == kModelIPhone4 || model == kModelIPhone5) {
        self.wightProgramView = 256.0f;
        self.insetfForView = 16.0f;
    } else if (model == kModelIPhone6) {
        self.wightProgramView = 300.0f;
        self.insetfForView = 18.75f;
    } else {
        self.wightProgramView = 332.0f;
        self.insetfForView = 20.5f;
    }
}


#pragma mark - Layout Views

- (void)_resizeViewOnScrollView {
    self.scrollView.contentSize = CGSizeMake(self.wightProgramView*self.countPage + (self.insetfForView*(self.countPage+3)), self.scrollView.frame.size.height);
    for  (int i = 0; i < [self.arrayViews count]; i++) {
        CGFloat x = self.wightProgramView*i + self.insetfForView*2 + self.insetfForView *i;
        
        BBProgramView *view = self.arrayViews[i];
        view.frame = CGRectMake(x, 0, self.wightProgramView, CGRectGetHeight(self.scrollView.frame));
    }
}

#pragma mark - Lazy Load

- (NSMutableArray *)arrayViews {
    if (!_arrayViews) {
        _arrayViews = [NSMutableArray array];
    }
    return _arrayViews;
}

@end
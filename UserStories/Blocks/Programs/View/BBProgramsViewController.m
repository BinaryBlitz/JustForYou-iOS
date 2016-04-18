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

@property (nonatomic) CGFloat wightProgramView;
@property (nonatomic) CGFloat insetfForView;

@end

static NSInteger countPage = 5;

@implementation BBProgramsViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLayoutSubviews {
#warning delete after test
    
    self.scrollView.contentSize = CGSizeMake(self.wightProgramView*countPage + (self.insetfForView*(countPage+3)), self.scrollView.frame.size.height);
    for (int i = 0; i < countPage; i++) {
        CGFloat x = self.wightProgramView*i + self.insetfForView*2 + self.insetfForView *i;
        
        BBProgramView *view = [[BBProgramView alloc] init];
        view.frame = CGRectMake(x, 0, self.wightProgramView, CGRectGetHeight(self.scrollView.frame));
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureProgramViewAction)];
        [view addGestureRecognizer:gesture];
        [self.scrollView addSubview:view];
    }
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Actions

- (void)gestureProgramViewAction {
    [self.output programDidTap];
}

- (void)basketButtonAction {
    
}


#pragma mark - Методы BBProgramsViewInput

- (void)setupInitialState {
    self.scrollView.delegate = self;
    self.secondImageView.alpha = 0.0;
    self.pageControl.numberOfPages = countPage;
    [self _initRightBarButton];
    [self _initWightProgramView];
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Даня - это я пока тренируюсь с aplha так что можешь в этом классе код даже не читать :)
    
    CGFloat curX = scrollView.contentOffset.x;
    CGFloat wight = scrollView.frame.size.width;
    
    CGFloat ratio = curX/wight;
    double d, drob;
    drob = modf(ratio, &d);
    
//    NSLog(@"%f, часть какая то = %f", ratio, drob);
    self.secondImageView.alpha = drob;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat kMaxIndex = countPage;
    CGFloat targetX = scrollView.contentOffset.x + velocity.x;
    CGFloat targetIndex = round(targetX / (self.wightProgramView + self.insetfForView));

    if (targetIndex < 0) {
        targetIndex = 0;
    }
    if (targetIndex > kMaxIndex) {
        targetIndex = kMaxIndex;
    }
    targetContentOffset->x = targetIndex * (self.wightProgramView + self.insetfForView);
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger offsetLooping = 1;
    int page = round((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + offsetLooping;
    self.pageControl.currentPage = (page % countPage);
}

#pragma mark - Init Methods

- (void)_initRightBarButton {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"basket"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(basketButtonAction)];
    
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

@end
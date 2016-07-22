//
//  BBGreetingViewController.m
//  JustForYou
//
//  Created by tercteberc on 17/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBGreetingViewController.h"

#import "BBGreetingViewOutput.h"

@interface BBGreetingViewController() <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (nonatomic) NSInteger countPage;
@property (strong, nonatomic) NSMutableArray *arrayViews;

@end

@implementation BBGreetingViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];
    
	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.scrollView.contentOffset = CGPointZero;
    self.pageControl.currentPage = 0;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self _layoutNextButton];
    [self _resizeViewOnScrollView];
}

#pragma mark - Actions Methods

- (IBAction)nextButtonAction:(id)sender {
    [self.output nextButtonDidTapWithPage:self.pageControl.currentPage];
}

#pragma mark - Методы BBGreetingViewInput

- (void)setupInitialState {
    self.navigationItem.title = kNameTitleGreetingModule;
    self.navigationItem.hidesBackButton = YES;
    self.pageControl.numberOfPages = self.countPage;
    [self _initViewsInScrollView];
}

- (void)countPageInPageControl:(NSInteger)count {
    self.countPage = count;
}

- (void)changePageInScrollView {
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * (self.pageControl.currentPage + 1);
    frame.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

#pragma mark - ScrollView Methods

- (void)_initViewsInScrollView {
    CGFloat widht = CGRectGetWidth(self.scrollView.frame);
    CGFloat height = CGRectGetHeight(self.scrollView.frame);
    self.scrollView.contentSize = CGSizeMake(widht*self.countPage, height);
    
    for (int i = 0; i < self.countPage; i++) {
        CGFloat x = widht*i;
        
        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, widht, height)];
        view.image = [UIImage imageNamed:@"TestIconBlock"];
        [self.scrollView addSubview:view];
        [self.arrayViews addObject:view];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = CGRectGetWidth(scrollView.frame);
    NSInteger page = (scrollView.contentOffset.x + (0.5f * width)) / width;
    self.pageControl.currentPage = (page % self.countPage);
}

#pragma mark - Lazy Load 

- (NSMutableArray *)arrayViews {
    if (!_arrayViews) {
        _arrayViews = [NSMutableArray array];
    }
    return _arrayViews;
}

#pragma mark - Layout Views

- (void)_layoutNextButton {
    self.nextButton.layer.masksToBounds = YES;
    self.nextButton.layer.cornerRadius = CGRectGetHeight(self.nextButton.frame)/2;
}

- (void)_resizeViewOnScrollView {
    CGFloat widht = CGRectGetWidth(self.scrollView.frame);
    CGFloat height = CGRectGetHeight(self.scrollView.frame);
    self.scrollView.contentSize = CGSizeMake(widht*self.countPage, height);
    
    for  (int i = 0; i < [self.arrayViews count]; i++) {
        CGFloat x = widht*i;
        
        UIImageView *view = self.arrayViews[i];
        view.frame = CGRectMake(x, 0, widht, height);
    }
}

@end
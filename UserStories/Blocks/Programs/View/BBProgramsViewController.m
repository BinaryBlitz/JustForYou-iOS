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

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moreButton;

@property (strong, nonatomic) UIImageView *bigImageView;

@property (strong, nonatomic) NSArray *programsArray;
@property (strong, nonatomic) NSMutableArray *idArray;
@property (strong, nonatomic) NSMutableArray *urlsArray;

@property (nonatomic) CGFloat wightProgramView;
@property (nonatomic) CGFloat insetfForView;

@property (nonatomic) CGRect sizeBigImageView;

@property (nonatomic) CGFloat currentPage;
@property (nonatomic) NSInteger countPage;

@property (strong, nonatomic) NSMutableArray *arrayViews;

@end

@implementation BBProgramsViewController

#pragma mark - Методы жизненного цикла

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self _resizeViewOnScrollView];
    CGRect frame = [UIScreen mainScreen].bounds;
    frame.size.height = frame.size.height - sizeNavigationBar;
    self.sizeBigImageView = frame;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.output viewWillAppear];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self didTapBigImage];
}

#pragma mark - Actions

- (void)_basketButtonAction {
    [self.output basketButtonDidTap];
}

- (IBAction)moreButtonAction:(id)sender {
    @try {
        [self.output programDidTapWithProgram:[[self.idArray objectAtIndex:self.pageControl.currentPage] integerValue]];
    } @catch (NSException *exception) {
        [self.output errorOpenProgram];
    } @finally {
        
    }
}

#pragma mark - Методы BBProgramsViewInput

- (void)setupInitialState {
    self.scrollView.delegate = self;
    self.countPage = 1;
    self.pageControl.numberOfPages = self.countPage;
    self.pageControl.enabled = NO;
//    [self _reloadViewsInScrollView];
    [self _initRightBarButton];
    [self _initWightProgramView];
    [self addSmalTapForImage];
}

- (void)addSmalTapForImage {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapSmallImage)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    [self.firstImageView addGestureRecognizer:tap];
}

- (void)didTapSmallImage {
    self.bigImageView.image = self.firstImageView.image;
    self.bigImageView.hidden = NO;
    [UIView animateWithDuration:animateTime animations:^{
        self.bigImageView.frame = self.sizeBigImageView;
    }];
}

- (void)didTapBigImage {
    [UIView animateWithDuration:animateTime animations:^{
        self.bigImageView.frame = CGRectMake(self.view.center.x, self.view.center.y, 0, 0);
    } completion:^(BOOL finished) {
        self.bigImageView.hidden = YES;
    }];
}

- (void)programsForTableView:(NSArray *)programs {
    self.programsArray = programs;
    self.urlsArray = [NSMutableArray array];
    self.countPage = [programs count];
    [self getIdInPrograms];
    HQDispatchToMainQueue(^{
        if ([self.programsArray count] > 0) {
            if (self.countPage < 2) {
                self.pageControl.hidden = YES;
            } else {
                self.pageControl.hidden = NO;
                self.pageControl.numberOfPages = self.countPage;
            }
            [self _reloadViewsInScrollView];
        }
    });
}

- (void)getIdInPrograms {
    self.idArray = [NSMutableArray array];
    for (BBProgram *program in self.programsArray) {
        [self.idArray addObject:[NSNumber numberWithInteger:program.programId]];
    }
}

- (void)_reloadViewsInScrollView {
    if ([self.scrollView.subviews count] > 0) {
        for (UIView *view in self.scrollView.subviews) {
            [view removeFromSuperview];
            [self.arrayViews removeObject:view];
        }
    }
    self.scrollView.contentSize = CGSizeMake(self.wightProgramView*self.countPage + (self.insetfForView*(self.countPage+3)), self.scrollView.frame.size.height);
    for (int i = 0; i < self.countPage; i++) {
        CGFloat x = self.wightProgramView*i + self.insetfForView*2 + self.insetfForView *i;
        
        BBProgramView *view = [[BBProgramView alloc] initWithFrame: CGRectMake(x, 0, self.wightProgramView, CGRectGetHeight(self.scrollView.frame))];
        BBProgram *program = [self.programsArray objectAtIndex:i];
        [view setProgramInUI:program];
        if (program.previewImage) {
            [self.urlsArray addObject:program.previewImage];
        }
        [self.scrollView addSubview:view];
        [self.arrayViews addObject:view];
    }
    if ([self.urlsArray count] > 0) {
        [[BBImageViewService sharedService] setImageForImageView:self.firstImageView placeholder:[UIImage imageNamed:@"testBack"] stringURL:self.urlsArray[0]];
    }
    self.scrollView.contentOffset = CGPointZero;
}

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message {
    [self presentAlertControllerWithTitle:title message:message];
}

- (void)updateImageViewsWithIndex:(NSInteger)index {
    if (index+1 == [self.urlsArray count]) {
        [[BBImageViewService sharedService] setImageForImageView:self.firstImageView placeholder:[UIImage imageNamed:@"testBack"] stringURL:self.urlsArray[index]];
        return;
    }
    if (index < [self.urlsArray count]) {
        [[BBImageViewService sharedService] setImageForImageView:self.firstImageView placeholder:[UIImage imageNamed:@"testBack"] stringURL:self.urlsArray[index+1]];
    }
}

- (void)updateBasketButtonImageWithImageName:(NSString *)name {
    self.navigationItem.rightBarButtonItem.image = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.arrayViews count] > 1) {
        CGFloat curX = scrollView.contentOffset.x;
        CGFloat pageWidth = scrollView.frame.size.width;
        
        CGFloat ratio = curX/self.wightProgramView;
        double d, drob;
        drob = modf(ratio, &d);
        
        NSInteger page = round((scrollView.contentOffset.x + (0.5f * self.wightProgramView)) / pageWidth);
        self.pageControl.currentPage = (page % self.countPage);
        if ([self.urlsArray count] > 0) {
            [[BBImageViewService sharedService] setImageForImageView:self.firstImageView placeholder:nil stringURL:self.urlsArray[self.pageControl.currentPage]];
        }
        
    }
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
    if ([self.scrollView.subviews count] > 0) {
        self.scrollView.contentSize = CGSizeMake(self.wightProgramView*self.countPage + (self.insetfForView*(self.countPage+3)), self.scrollView.frame.size.height);
        for  (int i = 0; i < [self.arrayViews count]; i++) {
            CGFloat x = self.wightProgramView*i + self.insetfForView*2 + self.insetfForView *i;
            
            BBProgramView *view = self.arrayViews[i];
            view.frame = CGRectMake(x, 0, self.wightProgramView, CGRectGetHeight(self.scrollView.frame));
        }
    }
}

#pragma mark - Lazy Load

- (NSMutableArray *)arrayViews {
    if (!_arrayViews) {
        _arrayViews = [NSMutableArray array];
    }
    return _arrayViews;
}

- (UIImageView *)bigImageView {
    if (!_bigImageView) {
        _bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.center.x, self.view.center.y, 0, 0)];
        _bigImageView.backgroundColor = [UIColor whiteColor];
        _bigImageView.contentMode = UIViewContentModeScaleAspectFit;
        _bigImageView.hidden = YES;
        _bigImageView.userInteractionEnabled = YES;
        [self.view addSubview:_bigImageView];
        [self.view bringSubviewToFront:_bigImageView];
        UITapGestureRecognizer *bigTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapBigImage)];
        bigTap.numberOfTouchesRequired = 1;
        bigTap.numberOfTapsRequired = 1;
        [_bigImageView addGestureRecognizer:bigTap];
    }
    return _bigImageView;
}

@end
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

@end

static CGFloat inset = 20.f;

@implementation BBProgramsViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLayoutSubviews {
#warning delete after test
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 3, self.scrollView.frame.size.height);
    BBProgramView *view = [[BBProgramView alloc] initWithFrame:CGRectMake(inset, 0, CGRectGetWidth(self.scrollView.frame) - (inset*2), CGRectGetHeight(self.scrollView.frame))];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(testAction)];
    [view addGestureRecognizer:gesture];    
    [self.scrollView addSubview:view];
    
    BBProgramView *view2 = [[BBProgramView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.frame) + inset, 0, CGRectGetWidth(self.scrollView.frame) - (inset*2), CGRectGetHeight(self.scrollView.frame))];
    [self.scrollView addSubview:view2];
    
    BBProgramView *view3 = [[BBProgramView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.frame) * 2 + inset, 0, CGRectGetWidth(self.scrollView.frame) - (inset*2), CGRectGetHeight(self.scrollView.frame))];
    [self.scrollView addSubview:view3];
    
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Actions

- (void)testAction {
    [self.output programDidTap];
}

- (void)basketButtonAction {
    
}


#pragma mark - Методы BBProgramsViewInput

- (void)setupInitialState {
    self.scrollView.delegate = self;
    self.secondImageView.alpha = 0.0;
    [self _createAndSetRightBarButton];
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Даня - это я пока тренируюсь с aplha так что можешь в этом классе код даже не читать :)
    
    CGFloat curX = scrollView.contentOffset.x;
    CGFloat wight = scrollView.frame.size.width;
    
    CGFloat ratio = curX/wight;
    double d, drob;
    drob = modf(ratio, &d);
    
    NSLog(@"%f, часть какая то = %f", ratio, drob);
    self.secondImageView.alpha = drob;
}


- (void)_createAndSetRightBarButton {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"basket"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(basketButtonAction)];
    
    self.navigationItem.rightBarButtonItem = item;
}

@end
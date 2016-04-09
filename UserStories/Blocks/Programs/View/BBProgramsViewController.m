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

@implementation BBProgramsViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLayoutSubviews {
#warning delete after test
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 3, self.scrollView.frame.size.height);
    BBProgramView *view = [[BBProgramView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame))];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(testAction)];
    [view addGestureRecognizer:gesture];
    [self.scrollView addSubview:view];
    
    BBProgramView *view2 = [[BBProgramView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame))];
    [self.scrollView addSubview:view2];
    
    BBProgramView *view3 = [[BBProgramView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.frame) * 2, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame))];
    [self.scrollView addSubview:view3];
    
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.output didTriggerViewReadyEvent];
}

- (void)testAction {
    [self.output programDidTap];
}

#pragma mark - Методы BBProgramsViewInput

- (void)setupInitialState {
    self.scrollView.delegate = self;
    self.secondImageView.alpha = 0.0;

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


@end
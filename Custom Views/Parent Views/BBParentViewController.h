//
//  BBParentViewController.h
//  JustForYou
//
//  Created by Антон on 28.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBLoaderView.h"

@interface BBParentViewController : UIViewController

@property (strong, nonatomic) UIAlertController *alertController;
@property (strong, nonatomic) BBLoaderView *loaderView;

- (void)showLoaderView;
- (void)hideLoaderView;

- (void)showBackgroundLoaderView;
- (void)hideBackgroundLoaderView;

- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message;

@end

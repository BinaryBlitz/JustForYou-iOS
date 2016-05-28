//
//  BBParentViewController.h
//  JustForYou
//
//  Created by Антон on 28.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBParentViewController : UIViewController

@property (strong, nonatomic) UIAlertController *alertController;

- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message;

@end

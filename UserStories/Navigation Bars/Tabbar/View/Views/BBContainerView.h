//
//  BBContainerView.h
//  JustForYou
//
//  Created by Антон on 24.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBContainerView : UIView

@property (weak, nonatomic) UIViewController* parentVC;

- (void)displayView:(id)view;

@end

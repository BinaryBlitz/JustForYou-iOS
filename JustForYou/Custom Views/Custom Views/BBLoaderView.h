//
//  BBLoaderView.h
//  JustForYou
//
//  Created by Антон on 31.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBLoaderView : UIView

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

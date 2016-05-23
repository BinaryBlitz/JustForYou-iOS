//
//  BBAddBasketViewPopover.h
//  JustForYou
//
//  Created by Антон on 23.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBAddBasketViewDelegate;

@interface BBAddBasketViewPopover : UIView

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIView *popoverView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIView *separatorView;
@property (weak, nonatomic) IBOutlet UIButton *okButton;

@property (strong, nonatomic) id<BBAddBasketViewDelegate> delegate;

@end

@protocol BBAddBasketViewDelegate <NSObject>

- (void)okButtonDidTapWithCountDays:(NSInteger)count;

@end

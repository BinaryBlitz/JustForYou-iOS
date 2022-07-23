//
//  BBEmptyTableBackgroundView.h
//  JustForYou
//
//  Created by Алексей on 09.08.17.
//  Copyright © 2017 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBEmptyTableBackgroundView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonWidthConstraint;
@property (strong, nonatomic) void (^buttonHandler)(void);

- (IBAction)buttonDidTap:(id)sender;

@end

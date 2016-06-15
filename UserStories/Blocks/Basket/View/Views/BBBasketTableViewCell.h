//
//  BBBasketTableViewCell.h
//  JustForYou
//
//  Created by Антон on 07.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBProgram.h"
#import "BBOrderProgram.h"

@protocol BBBasketCellDelegate;

@interface BBBasketTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UILabel *subnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@property (strong, nonatomic) id<BBBasketCellDelegate> delegate;


@property (strong, nonatomic) BBOrderProgram *orderProgram;
@property (strong, nonatomic) BBProgram *program;

@end


@protocol BBBasketCellDelegate <NSObject>

- (void)closeButtonDidTapWithBasketCell:(BBBasketTableViewCell *)cell;

@end

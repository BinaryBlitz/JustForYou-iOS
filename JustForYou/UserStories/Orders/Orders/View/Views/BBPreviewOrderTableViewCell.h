//
//  BBPreviewOrderTableViewCell.h
//  JustForYou
//
//  Created by Антон on 29.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBOrder.h"

@protocol BBPreviewOrderCellDelegate;

@interface BBPreviewOrderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameProgramLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptLabel;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UILabel *adresLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *deleteButton;

@property (strong, nonatomic) id<BBPreviewOrderCellDelegate> delegate;

@property (strong, nonatomic) BBOrder *order;

@end

@protocol BBPreviewOrderCellDelegate <NSObject>

- (void)deleteButtonDidTapWithOrder:(BBOrder *)order;

@end
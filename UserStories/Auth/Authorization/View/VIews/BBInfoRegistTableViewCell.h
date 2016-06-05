//
//  BBInfoRegistTableViewCell.h
//  JustForYou
//
//  Created by Антон on 29.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBUnderlineButton.h"

typedef enum : NSUInteger{
    kBigInfoRegistCellStyle,
    kFinishRegistCellStyle
}BBKeyStyleInfoRegistCell;

@protocol BBInfoRegistrateCellDelegate;

@interface BBInfoRegistTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet BBUnderlineButton *sendAgainButton;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendCodeButton;

@property (nonatomic) BBKeyStyleInfoRegistCell keyStyleCell;
@property (weak, nonatomic) id<BBInfoRegistrateCellDelegate> delegate;

@end


@protocol BBInfoRegistrateCellDelegate <NSObject>

- (void)sendCodeButtonDidTap;
- (void)sengAgainButtonDidTap;

@end
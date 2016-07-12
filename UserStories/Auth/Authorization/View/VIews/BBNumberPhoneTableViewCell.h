//
//  BBNumberPhoneTableViewCell.h
//  JustForYou
//
//  Created by Антон on 26.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBNumberCellDelegate;

@interface BBNumberPhoneTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *numberTextField;

@property (strong, nonatomic) id<BBNumberCellDelegate> delegate;

@property (nonatomic) BOOL validationOk;

@end

@protocol BBNumberCellDelegate <NSObject>

- (void)numberPhoneValidate;

@end

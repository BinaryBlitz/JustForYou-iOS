//
//  BBCommentTableViewCell.h
//  JustForYou
//
//  Created by Антон on 07.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBCommentTableViewCellDelegate;

@interface BBCommentTableViewCell : UITableViewCell <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) id<BBCommentTableViewCellDelegate> delegate;

@end

@protocol BBCommentTableViewCellDelegate <NSObject>

@end
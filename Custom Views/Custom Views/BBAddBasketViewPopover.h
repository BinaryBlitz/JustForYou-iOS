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


@property (strong, nonatomic) id<BBAddBasketViewDelegate> delegate;

@end

@protocol BBAddBasketViewDelegate <NSObject>



@end

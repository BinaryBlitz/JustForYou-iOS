//
//  BBSearchTableViewController.h
//  JustForYou
//
//  Created by Антон on 31.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBSearchTableControllerDelegate;

@interface BBSearchTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *filterArray;
@property (strong, nonatomic) id<BBSearchTableControllerDelegate> delegate;

@end

@protocol BBSearchTableControllerDelegate <NSObject>

- (void)didSelectCellWithAddress:(BBAddress *)address;

@end
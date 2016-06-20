//
//  BBTableAlertController.m
//  JustForYou
//
//  Created by Антон on 20.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBTableAlertController.h"

@interface BBTableAlertController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIViewController *contentController;
@property (strong, nonatomic) UITableView *tableView;

@property (assign, nonatomic) CGRect rectContent;

@property (strong, nonatomic) NSArray *contentArray;

@end

static CGFloat heightContentCell = 50.0f;

@implementation BBTableAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentArray = [self _payCardsUser];
    if ([self.contentArray count] > 0 && [self.contentArray count] < 4) {
        self.rectContent = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), (heightContentCell * [self.contentArray count]));
    } else if ([self.contentArray count] == 0){
        self.rectContent = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), heightContentCell);
    } else {
        self.rectContent = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), heightContentCell * 4);
    }
    [self _reloadContent];
    self.view.tintColor = [BBConstantAndColor applicationOrangeColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_reloadContent {
   
    [self setValue:self.contentController forKey:@"contentViewController"];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Отмена" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Оплатить новой" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if ([self.delegate respondsToSelector:@selector(payNewCardDidTap)]) {
            [self.delegate payNewCardDidTap];
        }
    }];
    [self addAction:action];
    [self addAction:cancelAction];
}


#pragma mark - UITableView Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return heightContentCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.contentArray count] == 0) {
        return 1;
    }
    return [self.contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if ([self.contentArray count] == 0) {
        cell.textLabel.text = @"У вас нет привязанных карт";
        cell.textLabel.textColor = [BBConstantAndColor applicationGrayColor];
        cell.selected = NO;
    } else {
        cell.textLabel.textColor = [UIColor blackColor];
        BBPayCard *payCard = [self.contentArray objectAtIndex:indexPath.row];
        cell.textLabel.text = payCard.number;
        cell.selected = YES;
    }
    cell.backgroundColor = [BBConstantAndColor applicationWhiteBackgroundColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.contentArray count] > 0) {
        if ([self.delegate respondsToSelector:@selector(cellDidSelectWithPayCard:)]) {
            [self.delegate cellDidSelectWithPayCard:[self.contentArray objectAtIndex:indexPath.row]];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (NSArray *)_payCardsUser {
    return [[BBDataBaseService sharedService] curentPayCards];
}

#pragma mark - Lazy Load

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.rectContent style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        if ([self.contentArray count] == 0) {
            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        } else {
            _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
        _tableView.userInteractionEnabled = YES;
        _tableView.allowsSelection = YES;
        _tableView.backgroundColor = [BBConstantAndColor applicationWhiteBackgroundColor];
        
        if ([self.contentArray count] < 4) {
            _tableView.scrollEnabled = NO;
        }
    }
    return _tableView;
}

- (UIViewController *)contentController {
    if (!_contentController) {
        _contentController = [[UIViewController alloc] init];
        [_contentController setPreferredContentSize:self.rectContent.size];
        [_contentController.view addSubview:self.tableView];
        [_contentController.view bringSubviewToFront:self.tableView];
        _contentController.view.userInteractionEnabled = YES;
    }
    return _contentController;
}

@end

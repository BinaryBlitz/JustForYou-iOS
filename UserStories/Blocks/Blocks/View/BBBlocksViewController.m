//
//  BBBlocksViewController.m
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBBlocksViewController.h"

#import "BBBlocksViewOutput.h"

#import "BBBlock.h"

@interface BBBlocksViewController() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *blocks;

@end

static CGFloat correlationCoefficientForCell = 1.12f;

@implementation BBBlocksViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];
    
    [self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.output viewWillAppear];
}

#pragma mark - Actions

- (void)_basketButtonAction {
    [self.output basketButtonDidTap];
}

#pragma mark - Методы BBBlocksViewInput

- (void)setupInitialState {
    self.navigationItem.title = kNameTitleProgramModule;
    [self.tableView setContentInset:UIEdgeInsetsMake(bottomOffsetForBlockTableView, 0, 0, 0)];
    [self _initRightBarButton];
    [self _registrateIdentifireCell];
}

- (void)blocksForTableView:(NSArray *)blocks {
    self.blocks = blocks;
    HQDispatchToMainQueue(^{
        [self.tableView reloadData];
    });
}

#pragma mark - TableView

- (void) _registrateIdentifireCell {
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameBlockCell bundle:nil] forCellReuseIdentifier:kBlockCellIdentifire];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.blocks) {
        return [self.blocks count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (CGRectGetWidth(self.tableView.frame) / correlationCoefficientForCell);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBBlockTableViewCell *blockCell = [self.tableView dequeueReusableCellWithIdentifier:kBlockCellIdentifire];
    
    return blockCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    BBBlockTableViewCell *blockCell = (BBBlockTableViewCell *)cell;
    if ([self.blocks count] > 0) {
        BBBlock *block = [self.blocks objectAtIndex:indexPath.row];
        blockCell.nameBlock.text = block.name;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.output didSelectRow];
}

#pragma mark - Init Methods

- (void)_initRightBarButton {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"basket"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(_basketButtonAction)];
    
    self.navigationItem.rightBarButtonItem = item;
}

@end
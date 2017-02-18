#import "BBSearchTableViewController.h"

@interface BBSearchTableViewController ()

@end

@implementation BBSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _settingsTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)_settingsTableView {
    [self _registrateCellIdentifire];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)_registrateCellIdentifire {
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameAddressCell bundle:nil] forCellReuseIdentifier:kAddressCellIdentifire];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.filterArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBAddressTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kAddressCellIdentifire];
    cell.address = [self.filterArray objectAtIndex:indexPath.row];
    [cell updateTextLabelWithAddress];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    BBAddressTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(didSelectCellWithAddress:)]) {
        [self.delegate didSelectCellWithAddress:cell.address];
    }
}

@end

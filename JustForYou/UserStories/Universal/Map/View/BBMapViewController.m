#import "BBMapViewController.h"

#import "BBMapViewOutput.h"

#import "BBTextField.h"

#import "BBSearchTableViewController.h"
#import "BBUnderlineButton.h"

@interface BBMapViewController () <GMSMapViewDelegate, UITextFieldDelegate, UISearchDisplayDelegate, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating, BBSearchTableControllerDelegate>

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet BBTextField *addressTextField;
@property (weak, nonatomic) IBOutlet UIImageView *myLocationImageView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (strong, nonatomic) BBAddress *currentAddres;

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) BBSearchTableViewController *searchResultsController;

@property (strong, nonatomic) UIBarButtonItem *myLocationButton;

@end

static CGFloat cornerRadiusTextField = 5.0f;

@implementation BBMapViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.output viewWillAppear];
  [[BBAppAnalitics sharedService] sendControllerWithName:kNameTitleMapModule];
}

- (void)viewWillLayoutSubviews {
  [self _layoutAddressTextField];
  [self _layoutMyLocationImageView];
  [self _layoutAddButton];
}

#pragma mark - Actions Methods

- (void)_myLocationButtonAction {
  [self.output myLocationButtonDidTap];
}

- (IBAction)addButtonAction:(id)sender {
  [self.output addButtonDidTapWithAddress:self.addressTextField.text];
}

#pragma mark - Методы BBMapViewInput

- (void)setupInitialState {
  self.navigationItem.title = kNameTitleMapModule;
  self.navigationItem.rightBarButtonItem = self.myLocationButton;
  self.addressTextField.delegate = self;
  [self _settingMapView];
}

- (void)moveCameraToCoordinateWithMyLocation {
  [self moveCameraToCoordinate:self.mapView.myLocation.coordinate];
}

- (void)moveCameraToCoordinate:(CLLocationCoordinate2D)coordinate {
  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:coordinate.latitude
                                                          longitude:coordinate.longitude
                                                               zoom:17];
  HQDispatchToMainQueue(^{
    [self.mapView animateToCameraPosition:camera];
  });
}

- (void)updateTextFieldAddressWithAddress:(BBAddress *)address {
  HQDispatchToMainQueue(^{
    self.addressTextField.text = [address formatedDescription];
  });
}

- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position {
  [self.output mapViewIdleAtCameraPosition:position];
}

- (void)presentSearchController {
  self.searchController.active = YES;
  [self presentViewController:self.searchController animated:YES completion:nil];
}

- (void)updateResultSearchControllerWithArray:(NSArray *)arrayAddress {
  self.searchResultsController.filterArray = arrayAddress;
  HQDispatchToMainQueue(^{
    [self.searchResultsController.tableView reloadData];
  });
}

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message {
  [self presentAlertControllerWithTitle:title message:message];
}

#pragma mark - Search Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  [searchBar resignFirstResponder];
}

#pragma mark - UISearchControllerDelegate

- (void)presentSearchController:(UISearchController *)searchController {
  self.searchController.searchBar.text = self.addressTextField.text;
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
  [self.output updateSearchResultsWithText:searchController.searchBar.text];
}

#pragma mark - BBSearchTableControllerDelegate

- (void)didSelectCellWithAddress:(BBAddress *)address {
  self.searchController.active = NO;
  [self moveCameraToCoordinate:address.coordinate];
}

#pragma mark - TextField Methods

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  [self.output textFieldDidBeginEditing];
}

#pragma mark - Load Methods

- (void)_settingMapView {

  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:55.754194
                                                          longitude:37.620139
                                                               zoom:17];
  self.mapView.camera = camera;
  self.mapView.myLocationEnabled = YES;
  self.mapView.delegate = self;
}

#pragma mark - Layout Methods

- (void)_layoutAddressTextField {
  self.addressTextField.layer.masksToBounds = YES;
  self.addressTextField.layer.cornerRadius = cornerRadiusTextField;
}

- (void)_layoutMyLocationImageView {
  self.myLocationImageView.image = [self.myLocationImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.myLocationImageView.tintColor = [BBConstantAndColor applicationOrangeColor];
}

- (void)_layoutAddButton {
  self.addButton.layer.masksToBounds = YES;
  [self.addButton.layer setCornerRadius:CGRectGetHeight(self.addButton.frame) / 2];
}

#pragma mark - Lazy Load

- (UIBarButtonItem *)myLocationButton {
  if (!_myLocationButton) {
    _myLocationButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"myLocationIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(_myLocationButtonAction)];
  }
  return _myLocationButton;
}

- (UISearchController *)searchController {
  if (!_searchController) {
    _searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultsController];
    _searchController.searchBar.placeholder = @"Начните вводить адрес";
    _searchController.hidesNavigationBarDuringPresentation = NO;
    [_searchController.searchBar setValue:@"Отмена" forKey:@"_cancelButtonText"];

    _searchController.delegate = self;
    _searchController.searchResultsUpdater = self;
  }
  return _searchController;
}

- (BBSearchTableViewController *)searchResultsController {
  if (!_searchResultsController) {
    _searchResultsController = [[BBSearchTableViewController alloc] initWithStyle:UITableViewStylePlain];
    _searchResultsController.delegate = self;
  }
  return _searchResultsController;
}

@end

//
//  BBMapViewController.m
//  JustForYou
//
//  Created by tercteberc on 25/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBMapViewController.h"

#import "BBMapViewOutput.h"

#import "BBTextField.h"

#import "BBSearchTableViewController.h"


@interface BBMapViewController() <GMSMapViewDelegate, UITextFieldDelegate, UISearchDisplayDelegate, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating, BBSearchTableControllerDelegate>

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet BBTextField *addressTextField;

@property (strong, nonatomic) BBAddress *currentAddres;

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) BBSearchTableViewController *searchResultsController;


@property (strong, nonatomic) UIBarButtonItem *myLocationButton;

@end

@implementation BBMapViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];
    
	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.output viewWillAppear];
}

- (void)viewWillLayoutSubviews {
    [self _layoutAddressTextField];
}

#pragma mark - Actions Methods

- (void)_myLocationButtonAction {
    [self.output myLocationButtonDidTap];
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
    
    [self.mapView animateToCameraPosition:camera];
}

- (void)updateTextFieldAddressWithAddress:(BBAddress *)address {
    self.addressTextField.text = [address formatedDescription];
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
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:55.75708318
                                                            longitude:37.60244361
                                                                 zoom:17];
    self.mapView.camera = camera;
    self.mapView.myLocationEnabled = YES;
    self.mapView.delegate = self;
}

#pragma mark - Layout Methods

- (void)_layoutAddressTextField {
    self.addressTextField.layer.masksToBounds = YES;
    self.addressTextField.layer.cornerRadius = 5.0f;
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
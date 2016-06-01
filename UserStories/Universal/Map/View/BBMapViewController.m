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

#import <LMGeocoder.h>

#import "BBAddressService.h"

#import "BBSearchTableViewController.h"

@import GoogleMaps;


#import "BBServerService.h"

@interface BBMapViewController() <GMSMapViewDelegate, UITextFieldDelegate, UISearchDisplayDelegate, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet BBTextField *addressTextField;


//Fetch result controller
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

- (void)viewWillLayoutSubviews {
    [self _layoutAddressTextField];
}

#pragma mark - Actions Methods

- (void)_myLocationButtonAction {
     [self moveCameraToCoordinate:self.mapView.myLocation.coordinate];
}

#pragma mark - Методы BBMapViewInput

- (void)setupInitialState {
    self.navigationItem.title = kNameTitleMapModule;
    self.navigationItem.rightBarButtonItem = self.myLocationButton;
    self.addressTextField.delegate = self;
    [self _settingMapView];
    
}

- (void)_settingMapView {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:55.75708318
                                                            longitude:37.60244361
                                                                 zoom:17];
    self.mapView.camera = camera;
    self.mapView.myLocationEnabled = YES;
    self.mapView.delegate = self;
}

- (void)moveCameraToCoordinate:(CLLocationCoordinate2D)coordinate {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:coordinate.latitude
                                                            longitude:coordinate.longitude
                                                                 zoom:17];
    
    [self.mapView animateToCameraPosition:camera];
}

#warning delte this code

- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position {
//    if (self.needUpdate) {
        [[LMGeocoder sharedInstance] reverseGeocodeCoordinate:position.target
                                                      service:kLMGeocoderGoogleService
                                            completionHandler:^(NSArray *results, NSError *error) {
                                                if (results.count && !error) {
                                                    LMAddress *address = [results firstObject];
                                                    
                                                    BBAddress *adr = [BBAddressService addressFromAddress:address];
                                                    
                                                    self.addressTextField.text = [adr formatedDescription];
                                                    
//                                                    self.selectedAddress = adr;
                                                }
                                            }];
//    } else {
//        self.needUpdate = YES;
//    }
}


#pragma mark - Search Delegate


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}


#pragma mark - UISearchControllerDelegate

- (void)presentSearchController:(UISearchController *)searchController {
    
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    // do something before the search controller is presented
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    // do something after the search controller is presented
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    // do something before the search controller is dismissed
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    // do something after the search controller is dismissed
}


#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchText = searchController.searchBar.text;
    
    if (!searchText || searchText.length < 3) {
        return;
    }
//    
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    [geocoder geocodeAddressString:searchText
//                 completionHandler:^(NSArray* placemarks, NSError* error){
//                     if (placemarks && placemarks.count > 0) {
//                         CLPlacemark *topResult = [placemarks objectAtIndex:0];
//                         MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
//                         
////                         MKCoordinateRegion region = self.mapView.region;
////                         region.center = placemark.region.center;
////                         region.span.longitudeDelta /= 8.0;
////                         region.span.latitudeDelta /= 8.0;
//                         
////                         [self.mapView setRegion:region animated:YES];
////                         [self.mapView addAnnotation:placemark];
//                     }
//                 }
//     ];
    
//    [[BBServerService sharedService] searchCoordinatesForAddress:searchText];
//    self.searchResultsController.filterArray = searchResults;
//    [self.searchResultsController.tableView reloadData];
}



#pragma mark - TextField Methods

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self presentViewController:self.searchController animated:YES completion:nil];
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
    }
    return _searchResultsController;
}

@end
//
//  ViewController.m
//  MapboxPodClient
//
//  Created by Mario Diana on 1/1/21.
//  Copyright © 2021 Mario Diana. All rights reserved.
//

#import "ViewController.h"
#import "DemoWebMapSource.h"

#import <Mapbox-iOS-SDK/Mapbox.h>

@interface ViewController ()
@property (nonatomic, weak) RMMapView* mapView;
@property (nonatomic, assign) CLLocationCoordinate2D home;
@end


@implementation ViewController

- (void)loadView

{
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
    UIView *view = [[UIView alloc] initWithFrame:[mainWindow bounds]];
    [view setBackgroundColor:[UIColor whiteColor]];
    self.view = view;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    id<RMTileSource> tileSource = [[DemoWebMapSource alloc] init];
    
    RMMapView* mapView =
        [[RMMapView alloc] initWithFrame:[[self view] bounds] andTilesource:tileSource];
    
    mapView.zoom = 13.0;
    
    [[self view] addSubview:mapView];
    self.mapView = mapView;
    
    // Statue of Liberty.
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(40.689247, -74.044502);
    self.home = coordinate;
    
    [[self mapView] setCenterCoordinate:[self home]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

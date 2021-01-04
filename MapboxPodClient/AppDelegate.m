//
//  AppDelegate.m
//  MapboxPodClient
//
//  Created by Mario Diana on 1/1/21.
//  Copyright © 2021 Mario Diana. All rights reserved.
//

#import "AppDelegate.h"
#import <Mapbox-iOS-SDK/Mapbox.h>

// The key in the Info.plist file. The value needs to be in a file in the SRCROOT
// directory, called "token". The contents of that file are loaded with a build
// phase script.
NSString* const kMGLMapboxAccessTokenKey = @"MGLMapboxAccessToken";

@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString* accessToken =
        [[[NSBundle mainBundle] infoDictionary] objectForKey:kMGLMapboxAccessTokenKey];
    
    [[RMConfiguration sharedInstance] setAccessToken:accessToken];
    
    UIViewController* rootVC = [[NSClassFromString(@"ViewController") alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [[self window] setRootViewController:rootVC];
    [[self window] setBackgroundColor:[UIColor lightGrayColor]];
    [[self window] makeKeyAndVisible];
    
    return YES;
}

@end

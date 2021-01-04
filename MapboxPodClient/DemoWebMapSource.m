//
//  DemoWebMapSource.m
//  MapboxPodClient
//
//  Created by Mario Diana on 1/3/21.
//  Copyright © 2021 Mario Diana. All rights reserved.
//

#import "DemoWebMapSource.h"

#import <UIKit/UIKit.h>
#import <Mapbox-iOS-SDK/Mapbox.h>

@implementation DemoWebMapSource

- (NSURL *)URLForTile:(RMTile)tile
{
    NSURL* baseURL = [NSURL URLWithString:@"https://a.tile.openstreetmap.org"];
    NSURL* url =
        [baseURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%hd", tile.zoom]];
    
    url = [url URLByAppendingPathComponent:[NSString stringWithFormat:@"%u", tile.x]];
    url = [url URLByAppendingPathComponent:[NSString stringWithFormat:@"%u.png", tile.y]];
    
    return url;
}

- (UIImage *)imageForTile:(RMTile)tile inCache:(RMTileCache *)tileCache
{
    UIImage* image = [tileCache cachedImage:tile withCacheKey:[self uniqueTilecacheKey]];
    
    if (image) {
        return image;
    }
    
    NSURL* url = [self URLForTile:tile];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    NSError* error = nil;
    
    NSData* data = [self fetchDataSynchronouslyWithRequest:request error:&error];
    
    if (error) {
        NSLog(@"Error retrieving tile: %@", [error localizedDescription]);
        return nil;
    }
    
    image = [UIImage imageWithData:data];
    [tileCache addImage:image forTile:tile withCacheKey:[self uniqueTilecacheKey]];
    
    return [UIImage imageWithData:data];
}

- (NSData *)fetchDataSynchronouslyWithRequest:(NSURLRequest *)request error:(NSError **)error
{
    __block NSData* result = nil;
    __block NSError* networkError = nil;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSURLSession* session =
        [NSURLSession sharedSession];
        [[session dataTaskWithRequest:request
                    completionHandler:^(NSData* data, NSURLResponse* response, NSError* e) {
                         
            NSHTTPURLResponse* http = (NSHTTPURLResponse *)response;
            networkError = e;

            // Open Street Maps sends back an OK.
            if ([http statusCode] == 200) {
                result = data;
            }

            dispatch_semaphore_signal(semaphore);

            }] resume];
         
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    *error = networkError;
         
    return result;
}

- (NSString *)uniqueTilecacheKey
{
    return @"DemoWebMapSourceTilecacheKey";
}

- (NSString *)shortName
{
    return @"DemoWebMapSource";
}

- (NSString *)shortAttribution
{
    return @"Open Street Maps";
}

@end

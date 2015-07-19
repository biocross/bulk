//
//  GMDirectionService.m
//  speakeasy
//
//  Created by Djengo on 8/02/13.
//  Copyright (c) 2013 Djengo. Under MIT Licence.
//  http://opensource.org/licenses/MIT

#import "GMDirectionService.h"

static NSString *API_KEY = @"AIzaSyBtzvU1miyidUsF5GAMsM0Zj8VC2n5qLpk";
static GMDirectionService *sharedInstance = nil;

@implementation GMDirectionService

+ (GMDirectionService*)sharedInstance
{
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
        }
        return sharedInstance;
    }
}

- (void)getDirectionsFrom:(NSString*)origin to:(NSString*)destination succeeded:(void(^)(GMDirection *directionResponse))success failed: (void (^)(NSError *error))failure{
    
    [[GMHTTPClient sharedInstance] getPath:@"https://maps.googleapis.com/maps/api/directions/json"
                                parameters:@{
                                                @"origin": origin,
                                                @"destination": destination,
                                                @"key": API_KEY
                                            }
                                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", operation.description);
        if (success)
            success([GMDirection initWithDirectionResponse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure)
            failure(error);
    }];
}

@end
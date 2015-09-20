//
//  ProwlistLocation.m
//  Prowlist
//
//  Created by Sebastian Romero on 20/09/15.
//  Copyright © 2015 Maachi. All rights reserved.
//

#import "ProwlistLocation.h"
#import "Location.h"

@interface ProwlistLocation(){
    NSInteger count;
    Location *locationObject;
}
@end

@implementation ProwlistLocation


- (instancetype) initLocation {
    if(self = [super init]) {
        count = 0;
        if(_intervalTimes){
            _intervalTimes = 0;
        }
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.pausesLocationUpdatesAutomatically = NO;
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locationManager requestWhenInUseAuthorization];
        }
        if ([CLLocationManager locationServicesEnabled]) {
            [_locationManager startUpdatingLocation];
        }
    }
    [self performSelector:@selector(checkPermission) withObject:nil afterDelay:2];
    return self;
}


- (void) checkPermission {
    if ([CLLocationManager locationServicesEnabled]) {
        if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
            if (_delegate){
                if([_delegate respondsToSelector:@selector(locationNotEnabled)]){
                    [_delegate locationNotEnabled];
                }
            }
        }
    }
}



#pragma CLLocationManagerDelegate


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:_locationManager.location.coordinate.latitude longitude:_locationManager.location.coordinate.longitude];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error){
        if (!error){
            if(placemarks.count > 0) {
                for (CLPlacemark *placemark in placemarks){
                    NSDictionary *locationInformation = [placemark addressDictionary];
                    if ([locationInformation objectForKey:@"City"] && [locationInformation objectForKey:@"Country"]){
                        if(count == _intervalTimes){
                            locationObject = [Location find:@"city == %@ AND country == %@", [locationInformation objectForKey:@"City"], [locationInformation objectForKey:@"Country"]];
                            if(!locationObject){
                                locationObject = [Location create];
                                locationObject.city = [locationInformation objectForKey:@"City"];
                                locationObject.country = [locationInformation objectForKey:@"Country"];
                                if ([locationInformation objectForKey:@"State"]){
                                    locationObject.state = [locationInformation objectForKey:@"State"];
                                }
                                [locationObject save];
                            }
                            [_locationManager stopUpdatingLocation];
                            if (_delegate){
                                if([_delegate respondsToSelector:@selector(locationStopped)]){
                                    [_delegate locationStopped];
                                }
                            }
                        }
                    }
                    count++;
                }
            }
        }
    }];
}


@end

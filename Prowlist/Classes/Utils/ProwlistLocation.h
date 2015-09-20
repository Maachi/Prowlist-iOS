//
//  ProwlistLocation.h
//  Prowlist
//
//  Created by Sebastian Romero on 20/09/15.
//  Copyright © 2015 Maachi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@protocol ProwlistLocationDelegate <NSObject>

@optional
- (void) locationStopped;
- (void) locationNotEnabled;
@end

@interface ProwlistLocation : NSObject<CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic) NSInteger intervalTimes;
@property (strong, nonatomic) id <ProwlistLocationDelegate> delegate;
- (instancetype) initLocation;
@end

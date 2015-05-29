//
//  VenueContent.h
//  Prowlist
//
//  Created by Sebastian Romero on 5/28/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ContentBase.h"

@interface VenueContent : ContentBase
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet MKMapView *mapInfo;

@end

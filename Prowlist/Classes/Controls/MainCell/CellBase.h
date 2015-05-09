//
//  CellBase.h
//  Prowlist
//
//  Created by Sebastian Romero on 5/8/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellBase : UIView

@property (nonatomic, copy) void (^onSelect)(id reference);

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *shortDescription;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

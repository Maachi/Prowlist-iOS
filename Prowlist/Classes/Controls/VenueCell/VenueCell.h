//
//  VenueCell.h
//  Prowlist
//
//  Created by Sebastian Romero on 7/06/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VenueCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *imageWrapper;

@property (strong, nonatomic) NSString *title;
@property (weak, nonatomic) IBOutlet UIView *content;
-(void) resizeImageCellWithValue:(CGFloat)value;
-(void) render;

@end

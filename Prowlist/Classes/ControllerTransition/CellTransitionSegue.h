//
//  CellTransitionSegue.h
//  Prowlist
//
//  Created by Sebastian Romero on 5/8/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CellTransitionSegue : UIStoryboardSegue

@property (strong, nonatomic) UIView *selectedCell;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *mainView;



@end
//
//  CellBase.m
//  Prowlist
//
//  Created by Sebastian Romero on 5/8/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import "CellBase.h"


@implementation CellBase

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)onTouchUpInside:(id)sender {
    if(self.onSelect){
        self.onSelect(self);
    }
}

@end

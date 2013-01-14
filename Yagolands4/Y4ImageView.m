//
//  Y4ImageView.m
//  Yagolands4
//
//  Created by Simone Gentili on 13/01/13.
//  Copyright (c) 2013 SENSORARIO. All rights reserved.
//

#import "Y4ImageView.h"

@implementation Y4ImageView

@synthesize tag;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)incrementaTappate
{
    ++self.numeroTappate;
}

@end

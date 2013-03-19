//
//  Y4TempiDiCostruzione.m
//  Yagolands4
//
//  Created by Simone Gentili on 11/03/13.
//  Copyright (c) 2013 SENSORARIO. All rights reserved.
//

#import "Y4TempiDiCostruzione.h"

@implementation Y4TempiDiCostruzione

- (id)init
{
    
    self = [super init];
    if (self) {
        [self setCentroDelvillaggio:4];
        [self setCaserma:4];
    }
    return self;
    
}

- (int)getTempoCentroDelvillaggio
{

    return self.centroDelvillaggio;

}

@end

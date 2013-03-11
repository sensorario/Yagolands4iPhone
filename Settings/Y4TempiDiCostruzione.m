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
        [self setCentroDelvillaggio:7];
        [self setCaserma:8];
    }
    return self;
    
}

- (int)getTempoCentroDelvillaggio
{
    
    NSLog(@"Recupero il tempo di costruzione del Centro del Villaggio.");
    return self.centroDelvillaggio;

}

@end

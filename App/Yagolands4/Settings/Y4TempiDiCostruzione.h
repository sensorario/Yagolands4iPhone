//
//  Y4TempiDiCostruzione.h
//  Yagolands4
//
//  Created by Simone Gentili on 11/03/13.
//  Copyright (c) 2013 SENSORARIO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Y4TempiDiCostruzione : NSObject

/* Tempi di costruzione degli edifici: */
@property (nonatomic) NSInteger * centroDelvillaggio;
@property (nonatomic) NSInteger * caserma;

- (int)getTempoCentroDelvillaggio;

@end

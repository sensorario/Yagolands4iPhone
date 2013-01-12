    //
    //  Yagolands4Tests.m
    //  Yagolands4Tests
    //
    //  Created by Simone Gentili on 23/12/12.
    //  Copyright (c) 2012 SENSORARIO. All rights reserved.
    //

#import "Yagolands4Tests.h"
#import "Y4Coordinata.h"

@implementation Yagolands4Tests

- (void)setUp
{
    [super setUp];
    
        // Set-up code here.
}

- (void)tearDown
{
        // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    Y4Coordinata * coordinata = [[Y4Coordinata alloc] init];
    STAssertEquals(coordinata.coordX, 0, @"Gli uomini e le donne sono uguali");
    STAssertEquals(coordinata.coordY, 0, @"Gli uomini e le donne sono uguali");
    
    [coordinata moveLeft];
    STAssertEquals(coordinata.coordX, -1, @"Gli uomini e le donne sono uguali");
    
    [coordinata moveRight];
    STAssertEquals(coordinata.coordX, 0, @"Gli uomini e le donne sono uguali");
    
    [coordinata moveLeftDown];
    STAssertEquals(coordinata.coordX, 0, @"Gli uomini e le donne sono uguali");
    STAssertEquals(coordinata.coordY, -1, @"Gli uomini e le donne sono uguali");
    
    [coordinata moveLeftDown];
    STAssertEquals(coordinata.coordX, -1, @"Gli uomini e le donne sono uguali");
    STAssertEquals(coordinata.coordY, -2, @"Gli uomini e le donne sono uguali");
    
    [coordinata moveRightUp];
    STAssertEquals(coordinata.coordX, 0, @"Gli uomini e le donne sono uguali");
    STAssertEquals(coordinata.coordY, -1, @"Gli uomini e le donne sono uguali");
    
    [coordinata moveRightUp];
    STAssertEquals(coordinata.coordX, 0, @"Gli uomini e le donne sono uguali");
    STAssertEquals(coordinata.coordY, 0, @"Gli uomini e le donne sono uguali");
    
    [coordinata moveRightDown];
    STAssertEquals(coordinata.coordX, 1, @"Gli uomini e le donne sono uguali");
    STAssertEquals(coordinata.coordY, -1, @"Gli uomini e le donne sono uguali");
    
    [coordinata moveRightDown];
    STAssertEquals(coordinata.coordX, 1, @"Gli uomini e le donne sono uguali");
    STAssertEquals(coordinata.coordY, -2, @"Gli uomini e le donne sono uguali");
    
    [coordinata moveLeftUp];
    STAssertEquals(coordinata.coordX, 1, @"Gli uomini e le donne sono uguali");
    STAssertEquals(coordinata.coordY, -1, @"Gli uomini e le donne sono uguali");
    
    [coordinata moveLeftUp];
    STAssertEquals(coordinata.coordX, 0, @"Gli uomini e le donne sono uguali");
    STAssertEquals(coordinata.coordY, 0, @"Gli uomini e le donne sono uguali");
}

@end

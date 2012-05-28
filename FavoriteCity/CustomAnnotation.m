//
//  CustomAnnotation.m
//  Test
//
//  Created by MacPro on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomAnnotation.h"

@implementation CustomAnnotation
@synthesize coordinate;
@synthesize description;
@synthesize address;

-(void)dealloc
{
    [address release];
    [description release];
    [super dealloc];
}
-(NSString *)title
{
    return self.description;
}
-(NSString *)subtitle
{
    return  self.address;
}
-(id)initWithLocation:(CLLocationCoordinate2D )coord description:(NSString*)descriptionLocation address:(NSString*)addressLocation
{
    self = [super init];
    if (self) {
        coordinate = coord;
        self.description =descriptionLocation;
        self.address = addressLocation;
    }
    return self;
}
@end

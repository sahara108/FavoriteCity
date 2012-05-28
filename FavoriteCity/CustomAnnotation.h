//
//  CustomAnnotation.h
//  Test
//
//  Created by MacPro on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface CustomAnnotation : NSObject<MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
    NSString *description;
    NSString *address;
   
  
}
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *description;
@property (nonatomic,retain) NSString *address;
- (id)initWithLocation:(CLLocationCoordinate2D )coord description:(NSString*)descriptionLocation address:(NSString*)addressLocation;

@end

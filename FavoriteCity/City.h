//
//  City.h
//  FavoriteCity
//
//  Created by Khanh on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface City : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSNumber * log;

@end

//
//  CityProvider.h
//  FavoriteCity
//
//  Created by Khanh on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CityProvider;

@protocol CityProviderParseXMLDelegate <NSObject>

-(void) CityProviderDidFinishParseXML:(CityProvider *)provider;
-(void) CityProviderDidFinishParseXMLWithError:(CityProvider *)provider error:(NSError *) error;

@end

@protocol CityProviderParseJSonDelegate <NSObject>

-(void)CityProviderDidFinishParseJSon:(CityProvider *)provider;

@end
@interface CityProvider : NSObject<NSXMLParserDelegate>
{
    
    NSString *URL;
    id<CityProviderParseXMLDelegate> delegate;
    BOOL loadingData;
    NSXMLParser *xmlParser;
    
}
@property (nonatomic, assign) BOOL loadingData;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic,assign) id<CityProviderParseXMLDelegate> delegate;
@property (nonatomic, assign) id<CityProviderParseJSonDelegate> delegateJson;
@property (nonatomic, retain) NSMutableArray *resultContent;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, retain) NSXMLParser *xmlParser;
@property (nonatomic, retain) NSString *currentKey;


-(void)configURL;
-(void)requestData;



@end;
//
//  CityProvider.m
//  FavoriteCity
//
//  Created by Khanh on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CityProvider.h"
#import "SBJson.h"

@implementation CityProvider

@synthesize connection;
@synthesize receivedData;
@synthesize resultContent;
@synthesize delegate;
@synthesize loadingData;
@synthesize index;
@synthesize currentKey;
@synthesize xmlParser;
@synthesize delegateJson;

-(void)dealloc
{
    delegateJson = nil;
    [currentKey release];
    [xmlParser release];
    [connection release];
    [receivedData release];
    [resultContent release];
    delegate = nil;
    [super dealloc];
}
-(id)init
{
    self = [super init];
    if (self) {
        index =0;
    }
    return self;
}
-(void)parserXML
{
    
}
-(void)configURL
{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter =[[[NSDateFormatter alloc]init]autorelease];
    [formatter setDateFormat:@"YYYYMMdd"];
    NSString *str = @"http://api.sba.gov/geodata/all_data_for_county_of/orange%20county/ca.json";
    URL = [NSString stringWithFormat:@"%@",str];
  
//    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    self.resultContent =[NSMutableArray array];
    NSLog(@"%@",URL);
    
}
-(void)requestData
{
    NSString * urlString = URL;
    if ([urlString length] > 0) {
        self.loadingData = YES;
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *theRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
        self.connection = [NSURLConnection connectionWithRequest:theRequest delegate:self];
        if (self.connection) {
            self.receivedData = [NSMutableData data];
        } else {
            self.loadingData = NO;
        }
    }
    
}
-(void)cancelDownload
{
    if (self.loadingData)
	{
		[self.connection cancel];
		self.loadingData = NO;
		
		self.receivedData = nil;
		self.connection = nil;
	}
}
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
	[self.receivedData appendData:data];
}

- (void) connection:(NSURLConnection *)connection12 didReceiveResponse:(NSURLResponse *)response 
{
    
//	[self.receivedData setLength:0];
    if ([response respondsToSelector:@selector(statusCode)])
    {
        //DBLog(@"Header:%@", [[((NSHTTPURLResponse *)response) allHeaderFields] description]);
        int statusCode = [((NSHTTPURLResponse *)response) statusCode];
        if (statusCode >= 400 && statusCode != 404)
        {
            [connection12 cancel];  // stop connecting; no more delegate messages
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat: NSLocalizedString(@"Server returned status code %d",@""), statusCode]
                                                                  forKey:NSLocalizedDescriptionKey];
            NSError *statusError = [NSError errorWithDomain:NSUnderlyingErrorKey code:statusCode userInfo:errorInfo];
            [self connection:connection12 didFailWithError:statusError];
        }
    }
    
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	self.loadingData = NO;
	self.receivedData = nil;
	self.connection = nil;
    NSLog(@"error code%d",[error code]);
    self.resultContent = nil;
    [self.delegate CityProviderDidFinishParseXMLWithError:self error:error];
}
- (void) connectionDidFinishLoading:(NSURLConnection *)connection 
{
    
    
    self.loadingData = NO;
	self.connection = nil;
    NSString *csv = [[NSString alloc] initWithData:self.receivedData encoding:NSASCIIStringEncoding];
    //    csv =[csv stringByReplacingOccurrencesOfString:@"\"" withString:@"\'"];
    SBJsonParser *jParser = [[SBJsonParser alloc] init];
	id jResult = [jParser objectWithString:csv];
    [csv release];
    [jParser release];
    
    if ([jResult isKindOfClass:[NSMutableArray class]]) {
        for (int i =0;i<[jResult count]; i ++) {
            NSDictionary *dictCity = [jResult objectAtIndex:i];
            if (dictCity) {
                NSDictionary *dictResult = [NSDictionary dictionaryWithObjectsAndKeys:
                                            [dictCity objectForKey:@"name"],@"name",
                                            [dictCity objectForKey:@"primary_latitude"],@"primary_latitude",
                                            [dictCity objectForKey:@"primary_longitude"],@"primary_longitude",
                                            [dictCity objectForKey:@"state_name"],@"state_name",
                                            nil];
                [self.resultContent addObject: dictResult];
            }
        }
    }
    if ([delegateJson respondsToSelector:@selector(CityProviderDidFinishParseJSon:)]) {
        [delegateJson CityProviderDidFinishParseJSon:self];
    }
//	self.loadingData = NO;
//	self.connection = nil;
//    if (xmlParser) {
//        xmlParser.delegate = nil;
//        [xmlParser release];
//        xmlParser = nil;
//    }
//	xmlParser = [[NSXMLParser alloc] initWithData:receivedData];
//    [xmlParser setDelegate:self];
//    [xmlParser parse];
//	self.receivedData = nil;
//    if ([delegate respondsToSelector:@selector(SearchPlaceDidFinishParsing:)]) {
//        [delegate SearchPlaceDidFinishParsing:self];
//    }
   	
}

#pragma mark -
#pragma mark XMLParse Delegate

//
//-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
//{
//    self.currentKey = elementName;
//    NSLog(@"%@",elementName);
//    if (attributeDict) {
//        NSDictionary *dict = [attributeDict objectForKey:@"site"];
//        if (dict) {
//            NSLog(@"%@",[dict objectForKey:@"url"]);
//        }
//        NSLog(@"%@",[attributeDict objectForKey:@"county_name"]);
//    }
//}
//- (void)parser:(NSXMLParser *)parser foundInternalEntityDeclarationWithName:(NSString *)name value:(NSString *)value
//{
//    NSLog(@"name = %@ , value = %@",name,value);
//}
//- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string 
//{
//    if ([self.currentKey isEqualToString:@"name"]) {
//        NSLog(@"%@",string);
//    }
//    else if ([currentKey isEqual:@"error"]) {
//        // Rate limit exceeded. Clients may not make more than 150 requests per hour.
//    }
//}
//- (void)parser:(NSXMLParser *)parser foundNotationDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID
//{
//    NSLog(@"%@",name);
//}
//
//- (void)parser:(NSXMLParser *)parser foundUnparsedEntityDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID notationName:(NSString *)notationName
//{
//    NSLog(@"%@",name);
//}
//
//- (void)parser:(NSXMLParser *)parser foundAttributeDeclarationWithName:(NSString *)attributeName forElement:(NSString *)elementName type:(NSString *)type defaultValue:(NSString *)defaultValue
//{
//    NSLog(@"%@",attributeName);
//}
//- (void)parser:(NSXMLParser *)parser foundElementDeclarationWithName:(NSString *)elementName model:(NSString *)model
//{
//    NSLog(@"%@",elementName);
//}
//- (void)parser:(NSXMLParser *)parser foundExternalEntityDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID
//{
//    NSLog(@"%@",name);
//}
//- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
//     NSLog(@"%@",elementName);
//}
//
//- (void)parserDidEndDocument:(NSXMLParser *)parser {
//	
//}

@end


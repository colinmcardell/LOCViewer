//
//  LOCObject.m
//  LOCViewer
//
//  Created by Colin McArdell on 6/30/13.
//  Copyright (c) 2013 Colin McArdell. All rights reserved.
//

#import "LOCObject.h"

@implementation LOCObject

+ (NSUInteger)modelVersion
{
	return 1;
}

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
	return @{@"objectID": @"id"};
}

@end

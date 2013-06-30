//
//  LOCPicture.m
//  LOCViewer
//
//  Created by Colin McArdell on 6/30/13.
//  Copyright (c) 2013 Colin McArdell. All rights reserved.
//

#import "LOCPicture.h"

@implementation LOCPicture

#pragma mark MTLJSONSerializing

+ (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    });

    return dateFormatter;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [[super JSONKeyPathsByPropertyKey] mtl_dictionaryByAddingEntriesFromDictionary:@{
            @"createdPublishedDate": @"created_published_date",
            @"imageURL": @"image.square",
            @"callNumber": @"call_number",
            @"reproductionNumber": @"reproduction_number",
            @"itemURL": @"links.item",
            @"objectID": @"pk"
            }];
}

+ (NSValueTransformer *)imageURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)itemURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)createdJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *string) {
        return [self.dateFormatter dateFromString:string];
    } reverseBlock:^id(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

@end

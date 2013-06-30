//
//  LOCSearchFeed.m
//  LOCViewer
//
//  Created by Colin McArdell on 6/30/13.
//  Copyright (c) 2013 Colin McArdell. All rights reserved.
//

#import "LOCSearchFeed.h"
#import "LOCPicture.h"

@implementation LOCSearchFeed

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [[super JSONKeyPathsByPropertyKey] mtl_dictionaryByAddingEntriesFromDictionary:@{
            @"currentPage": @"pages.current",
            @"perPage": @"pages.perpage",
            @"totalPages": @"pages.total",
            @"query": @"search.query"
            }];
}

+ (NSValueTransformer *)resultsTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[LOCPicture class]];
}

@end

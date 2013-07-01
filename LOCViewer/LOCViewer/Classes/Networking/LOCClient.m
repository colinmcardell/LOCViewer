//
//  LOCClient.m
//  LOCViewer
//
//  Created by Colin McArdell on 6/30/13.
//  Copyright (c) 2013 Colin McArdell. All rights reserved.
//

#import "LOCClient.h"
#import <Overcoat/OVCQuery.h>
#import "LOCRequestOperation.h"

#import "LOCSearchFeed.h"

static NSString * const kLOCAPIBaseURLString = @"http://www.loc.gov";

@implementation LOCClient

+ (LOCClient *)sharedClient {
    static LOCClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kLOCAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        [self registerHTTPOperationClass:[LOCRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    
    return self;
}

- (void)executeSearch:(NSString *)searchString
      completionBlock:(void (^)(OVCRequestOperation *operation, id object, NSError *error))block
{
    OVCQuery *searchFeed = [OVCQuery queryWithMethod:OVCQueryMethodGet
                                                path:@"/pictures/search/"
                                          parameters:@{@"q" : searchString, @"fo" : @"json"}
                                          modelClass:[LOCSearchFeed class]];
    [self executeQuery:searchFeed completionBlock:^(OVCRequestOperation *operation, id object, NSError *error) {
        if (block) {
            block(operation, object, error);
        }
    }];
}

- (void)fetchNextPageOfSearchFeed:(LOCSearchFeed *)searchFeed
                  completionBlock:(void (^)(OVCRequestOperation *operation, id object, NSError *error))block
{
    if ([searchFeed currentPage] + 1 > [searchFeed totalPages]) {
        if (block) {
            // Need to make this error mean something
            NSError *error = [NSError errorWithDomain:@"" code:1 userInfo:nil];
            block(nil, nil, error);
            return;
        }
    }
    
    NSString *query = [searchFeed query];
    NSNumber *nextPageValue = [NSNumber numberWithInteger:[searchFeed currentPage] + 1];
    
    OVCQuery *nextPage = [OVCQuery queryWithMethod:OVCQueryMethodGet
                                              path:@"/pictures/search/"
                                        parameters:@{@"q": query, @"sp": nextPageValue, @"fo" : @"json"}
                                        modelClass:[LOCSearchFeed class]];
    [self executeQuery:nextPage completionBlock:^(OVCRequestOperation *operation, id object, NSError *error) {
        if (block) {
            block(operation, object, error);
        }
    }];
}

@end

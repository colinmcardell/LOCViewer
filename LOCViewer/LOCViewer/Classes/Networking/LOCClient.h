//
//  LOCClient.h
//  LOCViewer
//
//  Created by Colin McArdell on 6/30/13.
//  Copyright (c) 2013 Colin McArdell. All rights reserved.
//

#import "OVCClient.h"

@class LOCSearchFeed;

typedef void(^LOCClientCompletionBlock)(id responseObject);

@interface LOCClient : OVCClient

+ (LOCClient *)sharedClient;

- (void)executeSearch:(NSString *)searchString
      completionBlock:(void (^)(OVCRequestOperation *operation, id object, NSError *error))block;

- (void)fetchNextPageOfSearchFeed:(LOCSearchFeed *)searchFeed
                  completionBlock:(void (^)(OVCRequestOperation *operation, id object, NSError *error))block;

@end

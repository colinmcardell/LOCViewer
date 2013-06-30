//
//  LOCSearchFeed.h
//  LOCViewer
//
//  Created by Colin McArdell on 6/30/13.
//  Copyright (c) 2013 Colin McArdell. All rights reserved.
//

#import "LOCObject.h"

@interface LOCSearchFeed : LOCObject

@property (nonatomic, readonly) NSInteger currentPage;
@property (nonatomic, readonly) NSInteger perPage;
@property (nonatomic, readonly) NSInteger totalPages;
@property (nonatomic, copy, readonly) NSString *query;

@property (nonatomic, copy) NSArray *results;

@end

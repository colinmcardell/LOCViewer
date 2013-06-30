//
//  LOCPicture.h
//  LOCViewer
//
//  Created by Colin McArdell on 6/30/13.
//  Copyright (c) 2013 Colin McArdell. All rights reserved.
//

#import "LOCObject.h"

@interface LOCPicture : LOCObject

@property (nonatomic, copy, readonly) NSDate *created;
@property (nonatomic, copy, readonly) NSString *createdPublishedDate;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *callNumber;
@property (nonatomic, copy, readonly) NSString *creator;
@property (nonatomic, copy, readonly) NSString *medium;
@property (nonatomic, copy, readonly) NSString *reproductionNumber;
@property (nonatomic, copy, readonly) NSURL *imageURL;
@property (nonatomic, copy, readonly) NSURL *itemURL;

@end

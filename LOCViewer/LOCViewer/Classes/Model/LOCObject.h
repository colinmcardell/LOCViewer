//
//  LOCObject.h
//  LOCViewer
//
//  Created by Colin McArdell on 6/30/13.
//  Copyright (c) 2013 Colin McArdell. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface LOCObject : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *objectID;

@end

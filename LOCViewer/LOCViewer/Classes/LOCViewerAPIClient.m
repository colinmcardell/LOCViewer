#import "LOCViewerAPIClient.h"
#import "AFJSONRequestOperation.h"

static NSString * const kLOCViewerAPIBaseURLString = @"http://www.loc.gov";

@implementation LOCViewerAPIClient

+ (LOCViewerAPIClient *)sharedClient {
    static LOCViewerAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kLOCViewerAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

@end

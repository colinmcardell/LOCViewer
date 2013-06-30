#import "AFHTTPClient.h"

@interface LOCViewerAPIClient : AFHTTPClient

+ (LOCViewerAPIClient *)sharedClient;

@end

#import "NTLNTwitterUserClient.h"
#import "NTLNTwitterUserXMLReader.h"
#import "NTLNAccount.h"
#import "NTLNHttpClientPool.h"



@implementation NTLNTwitterUserClient

@synthesize delegate;
@synthesize users;

- (void)dealloc {
	[users release];
	[delegate release];
	[super dealloc];
}

#pragma mark -
#pragma mark iOS Dev Team
//
//. All iOS Dev code added here
//
//.     Want to call function from MYFLLocalTweetViewController
//.     Will grab location using CoreLocation
//.     Notice #import of <CoreLocation/CoreLocation.h> in header file
//
//.     Reading tutorial here http://mobileorchard.com/hello-there-a-corelocation-tutorial/
//.     Added instance variable of delegate, MYLocationDelegate instead of calling self.
//

//@synthesize _MYLocationDelegate = MYLocationDelegate; 
//.     Looks like clashing variable names with <CLLocationManagerDelegate> and <NTLNTwitterUserClientDelegate>

@synthesize locationManager;

//.     init only necessary when self is the delegate. Try to fix by using instance variable method as used with <NTLNTwitterUserClientDelegate>
//
//- (id) init {
//    self = [super init];
//    if (self != nil) {
//        self.locationManager = [[[CLLocationManager alloc] init] autorelease];
//        self.locationManager.delegate = self; // send loc updates to myself
//    }
//    return self;
//}





-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}

- (void)getUserLocationWithGPS{
        

}






#pragma mark -
#pragma mark User Info
- (void)getUserInfo:(NSString*)q {
	NSString *url = [NSString stringWithFormat:@"http://twitter.com/users/show/%@.xml", q];
	[super requestGET:url];
}

- (void)getUserInfoForScreenName:(NSString*)screen_name {
	[self getUserInfo:screen_name];
}

- (void)getUserInfoForUserId:(NSString*)user_id {
	[self getUserInfo:user_id];
}

- (void)getFollowingsWithScreenName:(NSString*)screen_name page:(int)page {
	NSString *url = [NSString stringWithFormat:@"http://twitter.com/statuses/friends/%@.xml", screen_name];
	if (page > 1) {
		url = [NSString stringWithFormat:@"%@?page=%d", url, page];
	}
	[super requestGET:url];
}

- (void)getFollowersWithScreenName:(NSString*)screen_name page:(int)page {
	NSString *url = [NSString stringWithFormat:@"http://twitter.com/statuses/followers/%@.xml", screen_name];
	if (page > 1) {
		url = [NSString stringWithFormat:@"%@?page=%d", url, page];
	}
	[super requestGET:url];
}

- (void)requestSucceeded {
	if (statusCode == 200) {
		if (contentTypeIsXml) {
			NTLNTwitterUserXMLReader *xr = [[NTLNTwitterUserXMLReader alloc] init];
			[xr parseXMLData:recievedData];
			users = [xr.users retain];
			[xr release];
		}
	}
	
	[delegate twitterUserClientSucceeded:self];
	[[NTLNHttpClientPool sharedInstance] releaseClient:self];
}

- (void)requestFailed:(NSError*)error {
	[delegate twitterUserClientFailed:self];
	[[NTLNHttpClientPool sharedInstance] releaseClient:self];
}

@end

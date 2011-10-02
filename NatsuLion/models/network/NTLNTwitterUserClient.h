#import <UIKit/UIKit.h>
#import "NTLNUser.h"
#import "NTLNHttpClient.h"
#import "NTLNOAuthHttpClient.h"

#import <CoreLocation/CoreLocation.h>

@class NTLNTwitterUserClient;

@protocol NTLNTwitterUserClientDelegate
- (void)twitterUserClientSucceeded:(NTLNTwitterUserClient*)sender;
- (void)twitterUserClientFailed:(NTLNTwitterUserClient*)sender;
@end

#ifdef ENABLE_OAUTH
@interface NTLNTwitterUserClient : NTLNOAuthHttpClient {
#else
@interface NTLNTwitterUserClient : NTLNHttpClient <CLLocationManagerDelegate> {
#endif
    @private
        NSObject<NTLNTwitterUserClientDelegate> *delegate;
    //    iOS Dev
//        NSObject<CLLocationManagerDelegate> *_MYLocationDelegate; //delegate defined for self on @interface
        CLLocationManager *locationManager;
        
        
        
        
        
        
        NSMutableArray *users;
    }

    @property (readwrite, retain) NSObject<NTLNTwitterUserClientDelegate> *delegate;
//    iOS Dev
//    @property (readwrite, retain) NSObject<CLLocationManagerDelegate> *_MYLocationDelegate;  //see @synthesize call in implementation
    @property (readwrite, retain) CLLocationManager *locationManager;
        
        

    #pragma mark -
    #pragma mark iOS Dev
    //    iOs Dev
    //
    //    
    - (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;    
    - (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;
    //- (void)getUserLocationWithGPS;
        
        
    //
    - (void)getUserInfoForScreenName:(NSString*)screen_name;
    - (void)getUserInfoForUserId:(NSString*)user_id;
    - (void)getFollowingsWithScreenName:(NSString*)screen_name page:(int)page;
    - (void)getFollowersWithScreenName:(NSString*)screen_name page:(int)page;

    @property (readonly) NSMutableArray *users;

@end

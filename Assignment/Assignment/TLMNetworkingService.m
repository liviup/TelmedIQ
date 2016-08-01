//
//  TLMNetworkingService.m
//  Assignment
//
//  Created by Liviu Patrasco on 7/29/16.
//  Copyright © 2016 Liviu Patrasco. All rights reserved.
//

#import "TLMNetworkingService.h"
#import <AFNetworking.h>
#import "TLMGalleryItem.h"

static NSString *const GALLERY_API_INFO_FILENAME = @"GalleryAPIInfo";
static NSString *const GALLERY_API_INFO_FILE_EXT = @"plist";
static NSString *const CLIENT_ID_PROPERTY_KEY = @"Client ID";
static NSString *const GALLERY_API_PROPERTY_KEY = @"Gallery API";

@interface TLMNetworkingService ()

@property (nonatomic, strong) NSString *clientId;
@property (nonatomic, strong) NSString *galleryAPI;

@end

@implementation TLMNetworkingService

+ (instancetype)sharedService {
    static TLMNetworkingService *INSTANCE;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        INSTANCE = [[TLMNetworkingService alloc] init];
        [INSTANCE loadGalleryAPIInfo];
    });
    return INSTANCE;
}

- (void)loadFeedDataOnSuccess:(TLMNetworkingServiceSuccessBlock)onSuccess
                 onFailure:(TLMNetworkingServiceErrorBlock)onFailure {
    
    if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
        onFailure([NSError errorWithDomain:NSURLErrorDomain code:kCFURLErrorNotConnectedToInternet userInfo:nil]);
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Client-ID %@", self.clientId] forHTTPHeaderField:@"Authorization"];

    [manager GET:self.galleryAPI parameters:nil progress:nil success:^(NSURLSessionTask *task, NSDictionary *responseObject) {
        
        if (onSuccess) {
            onSuccess(responseObject);
        }
        NSLog(@"JSON: %@", responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (onFailure) {
            onFailure(error);
        }
    }];
}

#pragma mark - Private methods

- (void)loadGalleryAPIInfo {
    
    NSDictionary *pList = [NSDictionary dictionaryWithContentsOfFile:
                           [[NSBundle mainBundle]
                            pathForResource:GALLERY_API_INFO_FILENAME ofType:GALLERY_API_INFO_FILE_EXT]];
    
    self.clientId = [pList objectForKey:CLIENT_ID_PROPERTY_KEY];
    self.galleryAPI = [pList objectForKey:GALLERY_API_PROPERTY_KEY];
}

@end

//
//  TLMNetworkingService.h
//  Assignment
//
//  Created by Liviu Patrasco on 7/29/16.
//  Copyright © 2016 Liviu Patrasco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TLMData;

typedef void(^TLMNetworkingServiceSuccessBlock)(NSDictionary *responseData);
typedef void(^TLMNetworkingServiceErrorBlock)(NSError *error);

@interface TLMNetworkingService : NSObject
+ (instancetype)sharedService;

- (void)loadFeedDataOnSuccess:(TLMNetworkingServiceSuccessBlock)onSuccess
                  onFailure:(TLMNetworkingServiceErrorBlock)onFailure;
@end

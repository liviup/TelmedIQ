//
//  TLMNetworkingService.h
//  Assignment
//
//  Created by Liviu Patrasco on 7/29/16.
//  Copyright © 2016 Liviu Patrasco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TLMData;

/**
 * @brief Success block called when network call was successful.
 */
typedef void(^TLMNetworkingServiceSuccessBlock)(NSDictionary *responseData);

/**
 * @brief Error block called if network call failed.
 */
typedef void(^TLMNetworkingServiceErrorBlock)(NSError *error);

/**
 * @brief Provides basic networking service for the application.
 */
@interface TLMNetworkingService : NSObject

/**
 * @brief Singleton instance of service object.
 */
+ (instancetype)sharedService;

/**
 * @method loadFeedDataOnSuccess:onFailure:
 *
 * @brief Loads gallery feed data and calls onSuccess on success or onFailure on failure.
 */
- (void)loadFeedDataOnSuccess:(TLMNetworkingServiceSuccessBlock)onSuccess
                  onFailure:(TLMNetworkingServiceErrorBlock)onFailure;
@end

//
//  TLMDataSource.m
//  Assignment
//
//  Created by Liviu Patrasco on 7/28/16.
//  Copyright © 2016 Liviu Patrasco. All rights reserved.
//

#import "TLMDataSource.h"
#import "TLMGalleryItem.h"
#import <Realm/Realm.h>
#import "TLMNetworkingService.h"

@interface TLMDataSource ()

/**
 * @brief Array holds data retrieved from server.
 *
 * @property data Array with data to display.
 */
@property (nonatomic, strong) RLMResults<TLMGalleryItem *> *data;

@end

@implementation TLMDataSource

- (instancetype)initWithDelegate:(id<TLMDataSourceDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

- (void)reload {
    
    __weak typeof(self) weakSelf = self;
    [[TLMNetworkingService sharedService] loadFeedDataOnSuccess:^(NSDictionary *responseData) {
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        
        [realm transactionWithBlock:^{
            
            NSArray *items = [responseData objectForKey:@"data"];
            [realm deleteAllObjects];
            
            for (NSDictionary *item in items) {
                TLMGalleryItem *galleryItem = [[TLMGalleryItem alloc] init];
                galleryItem.itemId = item[@"id"];
                galleryItem.title = item[@"title"];
                galleryItem.link = item[@"link"];
                galleryItem.datetime = [NSDate dateWithTimeIntervalSince1970:[item[@"datetime"] longLongValue]];
                galleryItem.score = [item[@"score"] integerValue];
                galleryItem.nsfw = [item[@"nsfw"] boolValue];
                galleryItem.type = item[@"type"];
                [TLMGalleryItem createOrUpdateInDefaultRealmWithValue:galleryItem];
            }
            [weakSelf updateResults];
        }];
        
    } onFailure:^(NSError *error) {
        
        if (error.code == kCFURLErrorNotConnectedToInternet || [[TLMGalleryItem allObjects] count] > 0) {
            
            [weakSelf updateResults];
        }
        
        NSLog(@"%@", error);
    }];
}

- (TLMGalleryItem *)itemAtIndex:(NSUInteger)index {
    return [self.data objectAtIndex:index];
}

- (NSInteger)numberOfItems {
    return self.data.count;
}

#pragma mark - Private methods

- (void)updateResults {
    RLMRealm *realm = [RLMRealm defaultRealm];
    self.data = [[TLMGalleryItem objectsInRealm:realm where:@"type BEGINSWITH[c] 'image'"] sortedResultsUsingProperty:@"datetime" ascending:NO];
    [self.delegate dataSourceDidLoad];
}

@end


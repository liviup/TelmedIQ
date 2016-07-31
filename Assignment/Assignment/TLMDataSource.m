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
            for (NSDictionary *item in items) {
                TLMGalleryItem *galleryItem = [[TLMGalleryItem alloc] init];
                galleryItem.itemId = item[@"id"];
                galleryItem.title = item[@"title"];
                galleryItem.link = item[@"link"];
                galleryItem.datetime = [NSDate dateWithTimeIntervalSince1970:[item[@"datetime"] longLongValue]];
                galleryItem.score = [item[@"score"] integerValue];
                galleryItem.nsfw = [item[@"nsfw"] boolValue];
                [TLMGalleryItem createOrUpdateInDefaultRealmWithValue:galleryItem];
            }
            weakSelf.data = [TLMGalleryItem allObjects];
            [weakSelf.delegate dataSourceDidLoad];
        }];
        
    } onFailure:^(NSError *error) {
        if (error.code == kCFURLErrorNotConnectedToInternet || [[TLMGalleryItem allObjects] count] > 0) {
            weakSelf.data = [TLMGalleryItem allObjects];
            [weakSelf.delegate dataSourceDidLoad];
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


@end


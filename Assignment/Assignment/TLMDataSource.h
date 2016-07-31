//
//  TLMDataSource.h
//  Assignment
//
//  Created by Tatiana Patrasco on 7/28/16.
//  Copyright © 2016 Liviu Patrasco. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TLMDataSourceDelegate <NSObject>

- (void)dataSourceDidLoad;

@end

@class TLMGalleryItem;

@interface TLMDataSource : NSObject
@property (nonatomic, weak) id<TLMDataSourceDelegate> delegate;
- (instancetype)initWithDelegate:(id<TLMDataSourceDelegate>)delegate;
- (void)reload;
- (TLMGalleryItem *)itemAtIndex:(NSUInteger)index;
- (NSInteger)numberOfItems;
@end

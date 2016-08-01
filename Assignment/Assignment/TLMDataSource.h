//
//  TLMDataSource.h
//  Assignment
//
//  Created by Tatiana Patrasco on 7/28/16.
//  Copyright © 2016 Liviu Patrasco. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TLMDataSourceDelegate <NSObject>

/*!
 * @brief Notifies the delegate of dataSource did load items from network.
 */
- (void)dataSourceDidLoad;

@end

@class TLMGalleryItem;

@interface TLMDataSource : NSObject

/**
 * @brief The delegate gets notified when dataSource reloads.
 */
@property (nonatomic, weak) id<TLMDataSourceDelegate> delegate;

/**
 * @brief Designated initializer.
 *
 * @param delegate The delegate that will be notified when dataSource reloads data.
 */
- (instancetype)initWithDelegate:(id<TLMDataSourceDelegate>)delegate;

/**
 * @brief Reloads data if network is available. On load complete notifies the delegate.
 */
- (void)reload;

/**
 * @brief Accessor method to get items at specified index.
 *
 * @param index The index of the item to return from available data. 
 * 0 <= index < numberOfItems
 * 
 * @return The item at the given 'index'
 */
- (TLMGalleryItem *)itemAtIndex:(NSUInteger)index;

/**
 * @brief How many items are available.
 *
 * @return number of items available.
 */
- (NSInteger)numberOfItems;

@end

//
//  TLMGalleryItem.h
//  Assignment
//
//  Created by Liviu Patrasco on 7/28/16.
//  Copyright © 2016 Liviu Patrasco. All rights reserved.
//

#import <Realm/Realm.h>

@interface TLMGalleryItem : RLMObject

@property NSString *itemId;
@property NSString *title;
@property NSString *itemDescription;
@property NSTimeInterval datetime;
@property NSString *type;
@property BOOL animated;
@property NSUInteger width;
@property NSUInteger height;
@property NSUInteger size;
@property NSUInteger views;
@property NSUInteger bandwidth;
@property BOOL vote;//???
@property BOOL favorite;
@property BOOL nsfw;
@property NSString *section;
@property NSString *accountUrl;
@property NSString *accountId;
@property BOOL inGallery;
@property NSString *topic;
@property NSInteger topicId;
@property NSString *link;
@property BOOL isAd;
@property NSUInteger commentCount;
@property NSUInteger ups;
@property NSUInteger downs;
@property NSUInteger points;
@property NSUInteger score;
@property BOOL isAlbum;

@end

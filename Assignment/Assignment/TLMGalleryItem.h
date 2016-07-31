//
//  TLMGalleryItem.h
//  Assignment
//
//  Created by Liviu Patrasco on 7/28/16.
//  Copyright © 2016 Liviu Patrasco. All rights reserved.
//

#import <Realm/Realm.h>
#import <UIKit/UIKit.h>

@interface TLMGalleryItem : RLMObject

@property NSString *itemId;
@property NSString *title;
@property NSString *itemDescription;
@property NSDate *datetime;
@property NSString *type;
@property BOOL animated;
@property NSInteger width;
@property NSInteger height;
@property NSInteger size;
@property NSInteger views;
@property NSInteger bandwidth;
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
@property NSInteger commentCount;
@property NSInteger ups;
@property NSInteger downs;
@property NSInteger points;
@property NSInteger score;
@property BOOL isAlbum;

@end

//
//  TLMGalleryItem.m
//  Assignment
//
//  Created by Liviu Patrasco on 7/28/16.
//  Copyright © 2016 Liviu Patrasco. All rights reserved.
//

#import "TLMGalleryItem.h"

@implementation TLMGalleryItem

+ (NSString *)primaryKey {
    return @"itemId";
}

+ (NSArray *)ignoredProperties {
    return @[@"image"];
}

@end

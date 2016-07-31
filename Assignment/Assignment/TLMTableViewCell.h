//
//  TLMTableViewCell.h
//  Assignment
//
//  Created by Tatiana Patrasco on 7/29/16.
//  Copyright © 2016 Liviu Patrasco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLMGalleryItem;

@interface TLMTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *linkLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak) IBOutlet UILabel *nsfwLabel;
@property (nonatomic, weak) IBOutlet UIImageView *previewImageView;

- (void)configureWithGalleryItem:(TLMGalleryItem *)item;

@end

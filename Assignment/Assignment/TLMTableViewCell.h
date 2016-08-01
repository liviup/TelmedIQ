//
//  TLMTableViewCell.h
//  Assignment
//
//  Created by Liviu Patrasco on 7/29/16.
//  Copyright © 2016 Liviu Patrasco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLMGalleryItem;

/**
 * @brief Tableview cell, displays a gallery item preview image with some text info about it.
 */
@interface TLMTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *linkLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak) IBOutlet UILabel *nsfwLabel;
@property (nonatomic, weak) IBOutlet UIImageView *previewImageView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, weak) IBOutlet UIButton *favoriteButton;

/**
 * @brief Toggles the favorite property of the item.
 */
- (IBAction)toggleFavorite:(UIButton *)sender;

/**
 * @brief Activity view with a spinner.
 */
- (void)configureWithGalleryItem:(TLMGalleryItem *)item;

@end

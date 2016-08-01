//
//  DetailViewController.h
//  Assignment
//
//  Created by Liviu Patrasco on 7/28/16.
//  Copyright © 2016 Liviu Patrasco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLMGalleryItem;

/**
 * @brief Detail view for gallery item.
 */
@interface DetailViewController : UIViewController

/**
 * @property detailItem Gallery item to display details for.
 */
@property (strong, nonatomic) TLMGalleryItem *detailItem;

/**
 * @property imageView ImageView diplays the image of the detailItem.
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end


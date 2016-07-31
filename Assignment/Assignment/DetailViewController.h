//
//  DetailViewController.h
//  Assignment
//
//  Created by Liviu Patrasco on 7/28/16.
//  Copyright © 2016 Liviu Patrasco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLMGalleryItem;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) TLMGalleryItem *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end


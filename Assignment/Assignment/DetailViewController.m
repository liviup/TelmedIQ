//
//  DetailViewController.m
//  Assignment
//
//  Created by Liviu Patrasco on 7/28/16.
//  Copyright © 2016 Liviu Patrasco. All rights reserved.
//

#import "DetailViewController.h"
#import "TLMGalleryItem.h"
#import <UIImageView+AFNetworking.h>

@interface DetailViewController ()

/**
 * @brief Heart button to un/favorite item.
 */
@property (nonatomic, weak) IBOutlet UIButton *favoriteButton;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem && !self.detailItem.nsfw) {
        [self.imageView setImageWithURL:[NSURL URLWithString:self.detailItem.link] placeholderImage:[UIImage imageNamed:@"placeholder_600x400"]];
        self.favoriteButton.selected = self.detailItem.favorite;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (IBAction)toggleFavorite:(UIButton *)sender {
    sender.selected = !sender.selected;
    RLMRealm *realm = [RLMRealm defaultRealm];
    TLMGalleryItem *item = self.detailItem;
    [realm transactionWithBlock:^{
        item.favorite = sender.selected;
    }];
}

@end

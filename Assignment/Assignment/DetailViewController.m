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

static NSString *const kKeyPathToObserve = @"favorite";

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
        
        [_detailItem removeObserver:self forKeyPath:kKeyPathToObserve];
        _detailItem = newDetailItem;
        [_detailItem addObserver:self forKeyPath:@"favorite" options:NSKeyValueObservingOptionNew context:nil];
        
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(TLMGalleryItem *)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:kKeyPathToObserve]) {
        self.favoriteButton.selected = object.favorite;
    }
}

@end

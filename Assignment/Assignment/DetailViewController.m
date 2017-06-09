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
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        
        [_detailItem removeObserver:self forKeyPath:kKeyPathToObserve];
        _detailItem = newDetailItem;
        [_detailItem addObserver:self forKeyPath:kKeyPathToObserve options:NSKeyValueObservingOptionNew context:nil];
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem && !self.detailItem.nsfw) {
        [self setImageWithItem:self.detailItem];
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

- (void)setImageWithItem:(TLMGalleryItem *)item {
    NSURL *url = item.link ? [NSURL URLWithString:item.link] : nil;
    if (url) {
        [self.spinner startAnimating];
        self.spinner.hidden = NO;
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
        
        __weak __typeof(self)weakSelf = self;
        [self.imageView setImageWithURLRequest:request
                                     placeholderImage:[UIImage imageNamed:@"placeholder_600x400"]
                                              success:^(NSURLRequest *request, NSHTTPURLResponse * _Nullable response, UIImage *image) {
                                                  weakSelf.imageView.image = image;
                                                  [weakSelf.spinner stopAnimating];
                                                  weakSelf.spinner.hidden = YES;
                                              }
                                              failure:^(NSURLRequest *request, NSHTTPURLResponse * _Nullable response, NSError *error) {
                                                  [weakSelf.spinner stopAnimating];
                                                  weakSelf.spinner.hidden = YES;
                                              }];
    }
}

@end

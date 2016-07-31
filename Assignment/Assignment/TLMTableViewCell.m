//
//  TLMTableViewCell.m
//  Assignment
//
//  Created by Tatiana Patrasco on 7/29/16.
//  Copyright © 2016 Liviu Patrasco. All rights reserved.
//

#import "TLMTableViewCell.h"
#import "TLMGalleryItem.h"
#import <UIImageView+AFNetworking.h>

#define PLACEHOLDER_IMAGE [UIImage imageNamed:@"placeholder"]

@interface TLMTableViewCell ()
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) TLMGalleryItem *item;
@end

@implementation TLMTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"h:mm a MMM d, yyyy";
}

- (void)prepareForReuse {
    self.titleLabel.text = nil;
    self.linkLabel.text = nil;
    self.dateLabel.text = nil;
    self.scoreLabel.text = nil;
    self.nsfwLabel.text = nil;
    self.favoriteButton.selected = NO;
    [self.previewImageView setImage:PLACEHOLDER_IMAGE];
}

- (void)configureWithGalleryItem:(TLMGalleryItem *)item {
    self.item = item;
    self.titleLabel.text = item.title;
    self.linkLabel.text = item.link;
    self.dateLabel.text = [self.dateFormatter stringFromDate:item.datetime];
    self.scoreLabel.text = [NSString stringWithFormat:@"%@:%lu", NSLocalizedString(@"Score", @"Score"), (long)item.score];
    self.nsfwLabel.text = item.nsfw ? NSLocalizedString(@"true", @"True value") : NSLocalizedString(@"false", @"False value");
    self.favoriteButton.selected = item.favorite;
    
    if (item.nsfw) {
        self.previewImageView.image = PLACEHOLDER_IMAGE;
    } else {
        [self setImageWithItem:item];
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
        [self.previewImageView setImageWithURLRequest:request
                                     placeholderImage:PLACEHOLDER_IMAGE
                                              success:^(NSURLRequest *request, NSHTTPURLResponse * _Nullable response, UIImage *image) {
                                                  weakSelf.previewImageView.image = image;
                                                  [weakSelf.spinner stopAnimating];
                                                  weakSelf.spinner.hidden = YES;
                                              }
                                              failure:^(NSURLRequest *request, NSHTTPURLResponse * _Nullable response, NSError *error) {
                                                  [weakSelf.spinner stopAnimating];
                                                  weakSelf.spinner.hidden = YES;
                                              }];
    }
}

- (IBAction)toggleFavorite:(UIButton *)sender {
    sender.selected = !sender.selected;
    RLMRealm *realm = [RLMRealm defaultRealm];
    TLMGalleryItem *item = self.item;
    [realm transactionWithBlock:^{
        item.favorite = sender.selected;
    }];
}

@end

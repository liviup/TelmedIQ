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

@interface TLMTableViewCell ()
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation TLMTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"h:mm MMM d, yyyy";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse {
    self.titleLabel.text = nil;
    self.linkLabel.text = nil;
    self.dateLabel.text = nil;
    self.scoreLabel.text = nil;
    self.nsfwLabel.hidden = YES;
    [self.previewImageView setImage:nil];
}

- (void)configureWithGalleryItem:(TLMGalleryItem *)item {
    self.titleLabel.text = item.title;
    self.linkLabel.text = item.link;
    self.dateLabel.text = [self.dateFormatter stringFromDate:item.datetime];
    self.scoreLabel.text = [NSString stringWithFormat:@"%lu", (long)item.score];
    self.nsfwLabel.hidden = !item.nsfw;
    NSURL *url = [NSURL URLWithString:item.link];
    if (url) {
        [self.previewImageView setImageWithURL: url];
    }
}

@end

//
//  TLMTableViewCell.m
//  Assignment
//
//  Created by Tatiana Patrasco on 7/29/16.
//  Copyright © 2016 Liviu Patrasco. All rights reserved.
//

#import "TLMTableViewCell.h"
#import "TLMGalleryItem.h"

@interface TLMTableViewCell ()

@end

@implementation TLMTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithGalleryItem:(TLMGalleryItem *)item {
    self.titleLabel.text = item.title;
    self.linkLabel.text = item.link;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"h:mm MMM d, yyyy";
    self.dateLabel.text = [formatter stringFromDate:item.datetime];
}

@end

//
//  TLMSpinnerViewController.m
//  Assignment
//
//  Created by Tatiana Patrasco on 7/29/16.
//  Copyright © 2016 Liviu Patrasco. All rights reserved.
//

#import "TLMSpinnerViewController.h"

@interface TLMSpinnerViewController ()
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *spinnerView;
@end

@implementation TLMSpinnerViewController

- (void)presentInView:(UIView *)view {
    [self.view removeFromSuperview];
    [view addSubview:self.view];
    CGRect frame = self.view.frame;
    frame.origin.x = (view.bounds.size.width - self.view.bounds.size.width) / 2;
    frame.origin.y = (view.bounds.size.height - self.view.bounds.size.height) / 2 - 70;
    self.view.frame = frame;
    self.view.layer.cornerRadius = 6;
    self.view.clipsToBounds = YES;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self.spinnerView startAnimating];
}

- (void)stopSpinning {
    [self.spinnerView stopAnimating];
    [self.view removeFromSuperview];
}

@end

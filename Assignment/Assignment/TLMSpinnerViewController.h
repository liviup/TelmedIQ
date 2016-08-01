//
//  TLMSpinnerViewController.h
//  Assignment
//
//  Created by Tatiana Patrasco on 7/29/16.
//  Copyright © 2016 Liviu Patrasco. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * @brief Activity view with a spinner.
 */
@interface TLMSpinnerViewController : UIViewController

/**
 * @brief Presents self in the given view.
 */
- (void)presentInView:(UIView *)view;

/**
 * @brief Stops the spinner and removes from superView.
 */
- (void)stopSpinning;

@end

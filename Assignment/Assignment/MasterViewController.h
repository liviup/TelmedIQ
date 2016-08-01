//
//  MasterViewController.h
//  Assignment
//
//  Created by Liviu Patrasco on 7/28/16.
//  Copyright © 2016 Liviu Patrasco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

/**
 * @brief Master view with a table view of feed of gallery items.
 */
@property (strong, nonatomic) DetailViewController *detailViewController;

@end


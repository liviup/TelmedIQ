//
//  DetailViewController.h
//  Assignment
//
//  Created by Tatiana Patrasco on 7/28/16.
//  Copyright © 2016 Liviu Patrasco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end


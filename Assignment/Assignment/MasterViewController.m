//
//  MasterViewController.m
//  Assignment
//
//  Created by Liviu Patrasco on 7/28/16.
//  Copyright © 2016 Liviu Patrasco. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "TLMDataSource.h"
#import "TLMGalleryItem.h"
#import "TLMSpinnerViewController.h"
#import "TLMTableViewCell.h"

static NSInteger const kCellViewHeight = 200;
static NSString *const kDetailSegueID = @"showDetail";
static NSString *const kCellIdentifier = @"TLMPreviewCell";

@interface MasterViewController () <TLMDataSourceDelegate>

@property TLMDataSource *dataSource;
@property (nonatomic, strong) TLMSpinnerViewController *spinner;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TLMTableViewCell" bundle:nil] forCellReuseIdentifier:kCellIdentifier];

    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    self.dataSource = [[TLMDataSource alloc] initWithDelegate:self];

    self.spinner = [[TLMSpinnerViewController alloc] init];
    [self reload];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)reload {
    
    [self.spinner presentInView:self.tableView];
    [self.dataSource reload];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:kDetailSegueID]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        TLMGalleryItem *item = [self.dataSource itemAtIndex:indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:item];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfItems];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];

    [cell configureWithGalleryItem:[self.dataSource itemAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:kDetailSegueID sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellViewHeight;
}

- (void)dataSourceDidLoad {
    [self.tableView reloadData];
    [self.spinner stopSpinning];
}

@end

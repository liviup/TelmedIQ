//
//  AssignmentTests.m
//  AssignmentTests
//
//  Created by Liviu Patrasco on 7/28/16.
//  Copyright © 2016 Liviu Patrasco. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TLMDataSource.h"
#import "TLMNetworkingService.h"
#import <Realm/Realm.h>
#import "TLMGalleryItem.h"

@interface AssignmentTests : XCTestCase <TLMDataSourceDelegate>
@property (nonatomic, strong) TLMDataSource *dataSource;
@end

@implementation AssignmentTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLoadingDataSource {
    
    TLMDataSource *dataSource = [[TLMDataSource alloc] initWithDelegate:self];
    self.dataSource = dataSource;
    [dataSource reload];
}

- (void)testFavoritingItem {
    RLMRealm *realm = [RLMRealm defaultRealm];
    TLMGalleryItem *item = [[TLMGalleryItem allObjects] firstObject];
    XCTAssertFalse(item.favorite, @"Item should not be favorite item");
    [realm beginWriteTransaction];
    item.favorite = YES;
    [realm commitWriteTransaction];
    XCTAssertTrue(item.favorite, @"Item should be favorite item");
}

- (void)dataSourceDidLoad {
    XCTAssertTrue(self.dataSource.numberOfItems > 0);
}

@end

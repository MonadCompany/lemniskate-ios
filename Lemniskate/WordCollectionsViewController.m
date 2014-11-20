//
//  ViewController.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 20/11/14.
//  Copyright (c) 2014 MenadCompany. All rights reserved.
//

#import "WordCollectionsViewController.h"
#import "AddCollectionViewController.h"

@interface WordCollectionsViewController ()
@property (nonatomic, strong) NSArray *dummyData;
@end

static NSString *const WCCellIdentifier = @"WCCellIdentifier";

@implementation WordCollectionsViewController

#pragma mark - Getters

- (NSArray *)dummyData
{
    if (!_dummyData) {
        _dummyData = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
    }
    
    return _dummyData;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[self.view bounds] style:UITableViewStylePlain];
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:WCCellIdentifier];
    }
    return _tableView;
}

- (NSString *)title
{
    return @"∞";
}

#pragma mark - UIViewController lifecycle

- (void)loadView
{
    [super loadView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(addBarButtonItemTap:)];
    
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dummyData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WCCellIdentifier];
    
    cell.textLabel.text = self.dummyData[indexPath.row];
    
    return cell;
}

#pragma mark - Action handlers

- (void)addBarButtonItemTap:(UIBarButtonItem *)sender
{
    AddCollectionViewController *addCollectionVC = [AddCollectionViewController new];
//    addCollectionVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [self presentViewController:addCollectionVC animated:YES completion:nil];

    [self.navigationController pushViewController:addCollectionVC animated:YES];
}

@end

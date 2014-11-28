//
//  AddCollectionViewController.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 20/11/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "AddCollectionViewController.h"
#import "LabeledFieldTableViewCell.h"

static NSString *const WCCellIdentifier = @"WCCellIdentifier";

@implementation AddCollectionViewController

#pragma mark - Getters

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[self.view bounds] style:UITableViewStylePlain];
        _tableView.dataSource = self;
        [_tableView registerClass:[LabeledFieldTableViewCell class] forCellReuseIdentifier:WCCellIdentifier];
    }
    return _tableView;
}

- (NSString *)title
{
    return @"New collection";
}

#pragma mark - UIViewController lifecycle

- (void)loadView
{
    [super loadView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self
                                                                                           action:@selector(doneBarButtonItemTap:)];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(cancelBarButtonItemTap:)];
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LabeledFieldTableViewCell *cell = (LabeledFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:WCCellIdentifier];
    
    cell.label.text = @"Sample";
    
    return cell;
}

#pragma mark - Action handlers

- (void)cancelBarButtonItemTap:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneBarButtonItemTap:(UIBarButtonItem *)sender
{
    
}

@end

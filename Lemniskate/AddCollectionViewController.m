//
//  AddCollectionViewController.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 20/11/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "AddCollectionViewController.h"
#import "LabeledFieldTableViewCell.h"
#import "WordCollection.h"
#import "AppDelegate.h"

@interface AddCollectionViewController ()

@property (nonatomic, strong) LabeledFieldTableViewCell *nameCell;
@property (nonatomic, strong) LabeledFieldTableViewCell *commentCell;

@end

static NSString *const WCCellIdentifier = @"WCCellIdentifier";

@implementation AddCollectionViewController

#pragma mark - Getters

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[self.view bounds] style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.allowsSelection = NO;
        [_tableView registerClass:[LabeledFieldTableViewCell class] forCellReuseIdentifier:WCCellIdentifier];
    }
    return _tableView;
}

- (NSString *)title
{
    return @"New collection";
}

- (LabeledFieldTableViewCell *)nameCell {
    if (!_nameCell) {
        _nameCell = (LabeledFieldTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:WCCellIdentifier];
        _nameCell.label.text = @"Name";
    }
    return _nameCell;
}

- (LabeledFieldTableViewCell *)commentCell {
    if (!_commentCell) {
        _commentCell = (LabeledFieldTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:WCCellIdentifier];
        _commentCell.label.text = @"Comment";
    }
    return _commentCell;
}

#pragma mark - UIViewController lifecycle

- (void)loadView
{
    [super loadView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(cancelBarButtonItemTap:)];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self
                                                                                           action:@selector(doneBarButtonItemTap:)];

    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // this is probably not okay =/
    if (indexPath.row == 0) {
        return self.nameCell;
    } else {
        return self.commentCell;
    }
}

#pragma mark - Action handlers

- (void)cancelBarButtonItemTap:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneBarButtonItemTap:(UIBarButtonItem *)sender
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    // add new collection
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"WordCollection" inManagedObjectContext:delegate.managedObjectContext];
    WordCollection *wc = (WordCollection *)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:delegate.managedObjectContext];
    wc.name = self.nameCell.field.text;
    wc.comment = self.commentCell.field.text;
    
    NSError *error = nil;
    [wc.managedObjectContext save:&error];
    
    // and pop out
    [self.navigationController popViewControllerAnimated:YES];
}

@end

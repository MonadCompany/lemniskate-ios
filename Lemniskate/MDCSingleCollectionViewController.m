//
//  OneLemniCollectionViewController.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 30/11/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "MDCSingleCollectionViewController.h"
#import "MDCAppDelegate.h"
#import "LemniWord.h"
#import "MDCAddLemniWordViewController.h"
#import "MDCCollectionWithHeaderForm.h"

@interface MDCSingleCollectionViewController ()
@property (nonatomic, strong) NSFetchedResultsController *dataController;
@property (nonatomic, strong) MDCCollectionWithHeaderForm *collectionView;
@end

static NSString *const WCCellIdentifier = @"WCCellIdentifier";

@implementation MDCSingleCollectionViewController

#pragma mark - Getters

- (NSFetchedResultsController *)dataController
{
    if (!_dataController) {
        MDCAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"LemniWord"];
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"spelling" ascending:YES];
        [fetchRequest setSortDescriptors:@[sortDescriptor]];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"collection == %@", self.collection];
        [fetchRequest setPredicate: predicate];
        
        _dataController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                              managedObjectContext:delegate.managedObjectContext
                                                                sectionNameKeyPath:nil
                                                                         cacheName:nil];
        
        [_dataController setDelegate:self];
        
        // Perform Fetch
        NSError *error = nil;
        [_dataController performFetch:&error];
        
        if (error) {
            NSLog(@"Unable to perform fetch.");
            NSLog(@"%@, %@", error, error.localizedDescription);
        }
    }
    
    return _dataController;
}

- (NSString *)title
{
    return @"";
}

- (MDCCollectionWithHeaderForm *)collectionView {
    if (!_collectionView) {
        _collectionView = [MDCCollectionWithHeaderForm viewWithFrame:[self.view bounds] collection:self.collection delegate:self];
    }
    return _collectionView;
}


#pragma mark - ViewController Lifecycle

- (void)loadView
{
    [super loadView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(addBarButtonItemTap:)];
    [self.view addSubview:self.collectionView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.dataController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[self.dataController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [self.dataController sections][section];
        return [sectionInfo numberOfObjects];
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WCCellIdentifier];
    LemniWord *word = (LemniWord *)[self.dataController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = word.spelling;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
//    [self.tableView reloadData];
}

#pragma mark - Action handlers

- (void)addBarButtonItemTap:(UIBarButtonItem *)sender
{
    MDCAddLemniWordViewController *viewController = [[MDCAddLemniWordViewController alloc] initWithCollection:self.collection];
    viewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Navigation


@end

//
//  ViewController.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 20/11/14.
//  Copyright (c) 2014 MenadCompany. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "MDCAllCollectionsViewController.h"
#import "MDCAddCollectionViewController.h"
#import "MDCSingleCollectionViewController.h"
#import "MDCLabeledFieldTableViewCell.h"
#import "MDCCollectionTableViewCell.h"
#import "MDCAppDelegate.h"
#import "LemniCollection.h"
#import "MDCControlConstants.h"

@interface MDCAllCollectionsViewController ()
@property (nonatomic, strong) NSFetchedResultsController *dataController;
@end

@implementation MDCAllCollectionsViewController

#pragma mark - Getters

- (NSFetchedResultsController *)dataController
{
    if (!_dataController) {
        MDCAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"LemniCollection"];
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        [fetchRequest setSortDescriptors:@[sortDescriptor]];
        
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

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[self.view bounds] style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.rowHeight = MDCCollectionViewHeight;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSString *)title
{
    return @"";
}

#pragma mark - UIViewController lifecycle

- (void)loadView
{
    [super loadView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                          target:self
                                                                                          action:@selector(editBarButtonItemTap:)];
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
    LemniCollection *collection = (LemniCollection *)[self.dataController objectAtIndexPath:indexPath];

    UITableViewCell *cell = [MDCCollectionTableViewCell cellWithCollection:collection];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}



#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            if ([self.tableView numberOfSections]) {
                [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                                 withRowAnimation:UITableViewRowAnimationAutomatic];
            } else {
                [self.tableView insertSections:[NSIndexSet indexSetWithIndex:0]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath
{
    LemniCollection *collection = (LemniCollection *)[self.dataController objectAtIndexPath:indexPath];
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self navigateToCollection:collection];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    LemniCollection *collection = (LemniCollection *)[self.dataController objectAtIndexPath:indexPath];
    [self navigateToCollection:collection];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObject *managedObject = [self.dataController objectAtIndexPath:indexPath];
        MDCAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        [delegate.managedObjectContext deleteObject:managedObject];
        
        [delegate.managedObjectContext save:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0) {
        return 0.1; // TODO is this right? Looks like the only way to hide header
    }
    return UITableViewAutomaticDimension;
}


#pragma mark - Action handlers

- (void)addBarButtonItemTap:(UIBarButtonItem *)sender
{
    MDCAddCollectionViewController *viewController = [MDCAddCollectionViewController new];
    viewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)editBarButtonItemTap:(UIBarButtonItem *)sender
{
    [self setEditing:![self isEditing] animated:YES];
}

#pragma mark - Custom Logic

- (void)navigateToCollection:(LemniCollection *)collection {
    MDCSingleCollectionViewController *viewController = [MDCSingleCollectionViewController new];
    viewController.collection = collection;
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end

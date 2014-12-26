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
#import "MDCAddWordViewController.h"
#import "MDCEditWordViewController.h"
#import "MDCCollectionWithHeaderForm.h"
#import "MDCWordTableViewCell.h"
#import "LemniWordPicture.h"

@interface MDCSingleCollectionViewController ()
@property (nonatomic, strong) NSFetchedResultsController *dataController;
@property (nonatomic, strong) MDCCollectionWithHeaderForm *collectionForm;
@end

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
    return self.collection.name;
}

- (MDCCollectionWithHeaderForm *)collectionForm {
    if (!_collectionForm) {
        _collectionForm = [MDCCollectionWithHeaderForm viewWithFrame:[self.view bounds] collection:self.collection delegate:self];
    }
    return _collectionForm;
}


#pragma mark - ViewController Lifecycle

- (void)loadView
{
    [super loadView];
    
    self.navigationItem.titleView = [[UILabel alloc] init];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(addBarButtonItemTap:)];
    [self.view addSubview:self.collectionForm];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionForm.tableView reloadData];
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
    MDCWordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MDCWordTableCellViewReuseIdentifier];
    LemniWord *word = (LemniWord *)[self.dataController objectAtIndexPath:indexPath];

    [cell setWord:word];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath
{
    LemniWord *word = (LemniWord *)[self.dataController objectAtIndexPath:indexPath];
    [self.collectionForm.tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self navigateToWord:word];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    LemniWord *word = (LemniWord *)[self.dataController objectAtIndexPath:indexPath];
    [self navigateToWord:word];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.collectionForm.tableView endUpdates];
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.collectionForm.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.collectionForm.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            if ([tableView numberOfSections]) {
                [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                                 withRowAnimation:UITableViewRowAnimationAutomatic];
            } else {
                [tableView insertSections:[NSIndexSet indexSetWithIndex:0]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationAutomatic];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}

#pragma mark - Action handlers

- (void)addBarButtonItemTap:(UIBarButtonItem *)sender
{

    MDCAddWordViewController *viewController = [MDCAddWordViewController controllerWithCollection:self.collection];
    viewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Navigation

- (void)navigateToWord:(LemniWord *)word
{
    MDCEditWordViewController *viewController = [MDCEditWordViewController controllerWithWord:word];
    viewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end

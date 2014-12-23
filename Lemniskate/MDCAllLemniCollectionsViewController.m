//
//  ViewController.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 20/11/14.
//  Copyright (c) 2014 MenadCompany. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "MDCAllLemniCollectionsViewController.h"
#import "MDCAddLemniCollectionViewController.h"
#import "MDCOneLemniCollectionViewController.h"
#import "MDCAppDelegate.h"
#import "LemniCollection.h"

@interface MDCAllLemniCollectionsViewController ()
@property (nonatomic, strong) NSFetchedResultsController *dataController;
@end

static NSString *const WCCellIdentifier = @"WCCellIdentifier";

@implementation MDCAllLemniCollectionsViewController

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
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:WCCellIdentifier];
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

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WCCellIdentifier];
    cell.textLabel.text = collection.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}


#pragma mark - TableView Delegate

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
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"TODO"
                                                        message:@"Not implemented yet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        // Update data source array here, something like [array removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Action handlers

- (void)addBarButtonItemTap:(UIBarButtonItem *)sender
{
    MDCAddLemniCollectionViewController *viewController = [MDCAddLemniCollectionViewController new];
    viewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)editBarButtonItemTap:(UIBarButtonItem *)sender
{
    [self setEditing:![self isEditing] animated:YES];
}

#pragma mark - Custom Logic

- (void)navigateToCollection:(LemniCollection *)collection {
    MDCOneLemniCollectionViewController *viewController = [MDCOneLemniCollectionViewController new];
    viewController.collection = collection;
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end

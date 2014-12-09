//
//  AddLemniCollectionViewController.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 20/11/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "AddLemniCollectionViewController.h"
#import "LemniCollection.h"
#import "AppDelegate.h"
#import "NewLemniCollectionForm.h"

@interface AddLemniCollectionViewController ()
@property (nonatomic, strong) NewLemniCollectionForm *form;
@end

@implementation AddLemniCollectionViewController

#pragma mark - Getters

- (NSString *)title
{
    return @"New collection";
}

- (NewLemniCollectionForm *)form
{
    if (!_form) {
        _form = [[NewLemniCollectionForm alloc] initWithFrame:[self.view bounds]];
    }
    return _form;
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

    [self.view addSubview:self.form];
}

#pragma mark - Action handlers

- (void)cancelBarButtonItemTap:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneBarButtonItemTap:(UIBarButtonItem *)sender
{
    NSString *name = self.form.name;
    if ([name length] == 0) {
        return;
    }

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    // add new collection
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"LemniCollection"
                                              inManagedObjectContext:delegate.managedObjectContext];

    LemniCollection *collection = (LemniCollection *)[[NSManagedObject alloc] initWithEntity:entity
                                                              insertIntoManagedObjectContext:delegate.managedObjectContext];
    collection.name = name;
    collection.comment = self.form.comment;
    collection.created = [NSDate new];
   
    // save it
    NSError *error = nil;
    [collection.managedObjectContext save:&error];
    
    // and pop out
    [self.navigationController popViewControllerAnimated:YES];
}

@end

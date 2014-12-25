//
//  AddLemniCollectionViewController.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 20/11/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "MDCAddCollectionViewController.h"
#import "LemniCollection.h"
#import "MDCAppDelegate.h"
#import "MDCNewLemniCollectionForm.h"

@interface MDCAddCollectionViewController () <MDCPhotoPickerDelegate>
@property (nonatomic, strong) MDCNewLemniCollectionForm *form;
@end

@implementation MDCAddCollectionViewController

#pragma mark - Getters

- (NSString *)title
{
    return @"New collection";
}

- (MDCNewLemniCollectionForm *)form
{
    if (!_form) {
        _form = [[MDCNewLemniCollectionForm alloc] initWithFrame:[self.view bounds]];
        [_form setPhotoPickerDelegate:self];
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

#pragma mark - DZNPhotoPickerControllerDelegate

- (void)presentPhotoPicker:(DZNPhotoPickerController *)picker {
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)hidePhotoPicker {
    [self dismissViewControllerAnimated:YES completion:nil];
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

    MDCAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    // add new collection
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"LemniCollection"
                                              inManagedObjectContext:delegate.managedObjectContext];

    LemniCollection *collection = (LemniCollection *)[[NSManagedObject alloc] initWithEntity:entity
                                                              insertIntoManagedObjectContext:delegate.managedObjectContext];
    collection.name = name;
    collection.comment = self.form.comment;
    collection.background = UIImagePNGRepresentation(self.form.background);
    collection.created = [NSDate new];
   
    // save it
    NSError *error = nil;
    [collection.managedObjectContext save:&error];
    
    // and pop out
    [self.navigationController popViewControllerAnimated:YES];
}

@end

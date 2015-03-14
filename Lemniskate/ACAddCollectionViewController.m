//
//  AddLemniCollectionViewController.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 20/11/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "ACAddCollectionViewController.h"
#import "LemniCollection.h"
#import "ACAppDelegate.h"
#import "ACCollectionForm.h"

@interface ACAddCollectionViewController () <MDCPhotoPickerDelegate>
@property (nonatomic, strong) ACCollectionForm *form;
@end

@implementation ACAddCollectionViewController

#pragma mark - Getters

- (NSString *)title
{
    return @"New collection";
}

- (ACCollectionForm *)form
{
    if (!_form) {
        _form = [[ACCollectionForm alloc] initWithFrame:[self.view bounds]];
        [_form setPhotoPickerDelegate:self];
    }
    return _form;
}


#pragma mark - UIViewController

- (void)loadView
{
    [super loadView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(cancelBarButtonItemTap:)];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                           target:self
                                                                                           action:@selector(doneBarButtonItemTap:)];

    [self.view addSubview:self.form];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - DZNPhotoPickerControllerDelegate

- (void)presentChildViewController:(UIViewController *)viewController
{
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)hidePhotoPicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)initialSearchTerm
{
    return self.form.name;
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

    ACAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
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

//
//  AddLemniWordViewController.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 09/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "AddLemniWordViewController.h"
#import "NewLemniWordForm.h"
#import "AppDelegate.h"
#import "LemniWord.h"
#import "LemniCollection.h"

@interface AddLemniWordViewController ()
@property (nonatomic, strong) LemniCollection *collection;
@property (nonatomic, strong) NewLemniWordForm *form;
@end

@implementation AddLemniWordViewController

#pragma mark - Initialization

- (instancetype)initWithCollection:(LemniCollection *)collection
{
    self = [super init];
    if (self) {
        self.collection = collection;
    }

    return self;
}

+ (instancetype)controllerWithCollection:(LemniCollection *)collection
{
    return [[self alloc] initWithCollection:collection];
}

#pragma mark - Getters

- (NSString *)title
{
    return self.form.spelling; // how this will be dynamic? should this be observable?
}

- (NewLemniWordForm *)form {
    if (!_form) {
        _form = [[NewLemniWordForm new] initWithFrame:[self.view bounds]];
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
    NSString *name = self.form.spelling;
    if ([name length] == 0) {
        return;
    }

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];

    //todo: how this should be in case of editing?
    // add new collection
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"LemniWord"
                                              inManagedObjectContext:delegate.managedObjectContext];

    LemniWord *word = (LemniWord *)[[NSManagedObject alloc] initWithEntity:entity
                                            insertIntoManagedObjectContext:delegate.managedObjectContext];

    //todo: can following be made with Observable?
    word.spelling      = self.form.spelling;
    word.pronunciation = self.form.pronunciation;
    word.meaning       = self.form.meaning;
    word.collection    = self.collection;

    // save it
    NSError *error = nil;
    [word.managedObjectContext save:&error];

    // and pop out
    [self.navigationController popViewControllerAnimated:YES];
}

@end

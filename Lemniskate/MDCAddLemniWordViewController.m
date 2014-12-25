//
//  AddLemniWordViewController.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 09/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "MDCAddLemniWordViewController.h"
#import "MDCNewLemniWordForm.h"
#import "MDCAppDelegate.h"
#import "LemniWord.h"
#import "LemniCollection.h"

@interface MDCAddLemniWordViewController ()
@property (nonatomic, strong) LemniCollection *collection;
@property (nonatomic, strong) MDCNewLemniWordForm *form;
@end

@implementation MDCAddLemniWordViewController

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
    return self.form.word.spelling; // how this will be dynamic? should this be observable?
}

- (MDCNewLemniWordForm *)form {
    if (!_form) {
        _form = [[MDCNewLemniWordForm alloc] initWithFrame:[self.view bounds]];
        
        MDCAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"LemniWord"
                                                  inManagedObjectContext:delegate.managedObjectContext];
        LemniWord *word = (LemniWord *)[[NSManagedObject alloc] initWithEntity:entity
                                                insertIntoManagedObjectContext:delegate.managedObjectContext];
        
        word.collection = self.collection;
        [_form setWord:word];
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
    NSString *name = self.form.word.spelling;
    if ([name length] == 0) {
        return;
    }

    // save word from form
    NSError *error = nil;
    [self.form.word.managedObjectContext save:&error];
    NSLog(@"Saved word, error: %@", error);

    // and pop out
    [self.navigationController popViewControllerAnimated:YES];
}

@end

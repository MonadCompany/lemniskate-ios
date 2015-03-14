//
//  ACEditWordViewController.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 25/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "ACEditWordViewController.h"
#import "LemniWord.h"
#import "ACWordForm.h"

@interface ACEditWordViewController () <MDCPhotoPickerDelegate, MDCTextViewTableViewCellDelegate>
@property (nonatomic, strong) LemniWord *word;
@property (nonatomic, strong) ACWordForm *form;
@end

@implementation ACEditWordViewController

#pragma mark - Initialization

- (instancetype)initWithWord:(LemniWord *)word
{
    self = [super init];
    if (self) {
        self.word = word;
    }
    return self;
}

+ (instancetype)controllerWithWord:(LemniWord *)word
{
    return [[self alloc] initWithWord:word];
}

#pragma mark - Getters

- (NSString *)title
{
    return self.form.word.spelling;
}

- (ACWordForm *)form {
    if (!_form) {
        _form = [[ACWordForm alloc] initWithFrame:[self.view bounds]];
        [_form setWord:self.word];
        [_form setPhotoPickerDelegate:self];
        [_form setTextViewDelegate:self];
    }
    return _form;
}

#pragma mark - UIViewController lifecycle

- (void)loadView
{
    [super loadView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                           target:self
                                                                                           action:@selector(saveBarButtonItemTap:)];
    [self.view addSubview:self.form];
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
    return self.form.word.spelling;
}

#pragma mark - MDCTextViewTableViewCellDelegate

- (void)presentTextViewViewController:(ACTextViewViewController *)controller
{
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Action handlers

- (void)cancelBarButtonItemTap:(UIBarButtonItem *)sender
{
    // cancell all changes
    NSManagedObject *object = self.form.word;
    [object.managedObjectContext refreshObject:object mergeChanges:NO];
    
    // and pop out
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveBarButtonItemTap:(UIBarButtonItem *)sender
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

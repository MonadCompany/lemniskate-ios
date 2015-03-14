//
//  ACTextViewViewController.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 27/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "ACTextViewViewController.h"

@interface ACTextViewViewController ()
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) NSString *initialText;
@end

@implementation ACTextViewViewController

- (instancetype)initWithText:(NSString *)text
{
    self = [super init];
    self.initialText = text;
    return self;
}

#pragma mark - Getters

- (UITextView *)textView
{
    if (!_textView) {
        CGRect bounds = [self.view bounds];
        CGRect padded = CGRectMake(bounds.origin.x + 5,
                                   bounds.origin.y + 5,
                                   bounds.size.width - 10,
                                   bounds.size.height - 10);
        _textView = [[UITextView alloc] initWithFrame:padded];
        _textView.returnKeyType = UIReturnKeyDone;
        _textView.font = [UIFont systemFontOfSize:18];
    }
    return _textView;
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.textView.text = self.initialText;
    [self.view addSubview:self.textView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.textView becomeFirstResponder];
}

#pragma mark - Action Handlers

- (void)cancelBarButtonItemTap:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneBarButtonItemTap:(UIBarButtonItem *)sender
{
    [self.delegate finishedEditing:self.textView.text];
    [self.navigationController popViewControllerAnimated:YES];
}

@end

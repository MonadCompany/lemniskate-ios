//
//  MDCPracticeViewController.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 26/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "MDCPracticeViewController.h"
#import "ZLSwipeableView.h"
#import "LemniCollection.h"
#import "MDCWordCardView.h"

@interface MDCPracticeViewController () <ZLSwipeableViewDataSource, ZLSwipeableViewDelegate>
@property (nonatomic, strong) ZLSwipeableView *swipeableView;
@end


@implementation MDCPracticeViewController

#pragma mark - Initialization

- (instancetype)initWithType:(MDCPracticeType)type collection:(LemniCollection *)collection
{
    self = [super init];
    if (self) {
        self.collection = collection;
    }
    return self;
}

+ (instancetype)controllerWithType:(MDCPracticeType)type collection:(LemniCollection *)collection
{
    return [[self alloc] initWithType:type collection:collection];
}

#pragma mark - Getters

- (ZLSwipeableView *)swipeableView {
    if (!_swipeableView) {
        _swipeableView = [[ZLSwipeableView alloc] initWithFrame:self.view.bounds];
        _swipeableView.dataSource = self;
        _swipeableView.delegate = self;
    }
    return _swipeableView;
}

#pragma mark - UIViewController lifecycle

- (void)loadView
{
    [super loadView];
    [self.view addSubview:self.swipeableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}


#pragma mark - ZLSwipeableViewDataSource

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
//    CGFloat hue        = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
//    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
//    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
//    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
//    
//    UIView *view = [[UIView alloc] initWithFrame:swipeableView.frame];
//    [view setBackgroundColor:color];
    
    CGRect selfBouds = [self.view bounds];
    CGRect cardBounds = CGRectMake(50, 50, selfBouds.size.height - 100, selfBouds.size.width - 100);
    
    MDCWordCardView *view = [[MDCWordCardView alloc] initWithFrame:cardBounds];
    [view setWord:[self.collection.words anyObject]];
    return view;
}

#pragma mark - ZLSwipeableViewDelegate

- (void)swipeableView:(ZLSwipeableView *)swipeableView didSwipeLeft:(UIView *)view
{
    NSLog(@"did swipe left");
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView didSwipeRight:(UIView *)view
{
    NSLog(@"did swipe right");
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView didCancelSwipe:(UIView *)view
{
    NSLog(@"did cancel swipe");
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView didStartSwipingView:(UIView *)view atLocation:(CGPoint)location {
//    NSLog(@"did start swiping at location: x %f, y%f", location.x, location.y);
}
- (void)swipeableView:(ZLSwipeableView *)swipeableView swipingView:(UIView *)view atLocation:(CGPoint)location  translation:(CGPoint)translation {
//    NSLog(@"swiping at location: x %f, y %f, translation: x %f, y %f", location.x, location.y, translation.x, translation.y);
}
- (void)swipeableView:(ZLSwipeableView *)swipeableView didEndSwipingView:(UIView *)view atLocation:(CGPoint)location {
//    NSLog(@"did start swiping at location: x %f, y%f", location.x, location.y);
}

@end

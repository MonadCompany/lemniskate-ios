//
//  RotationalViewController.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 26/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "UINavigationController_RotationAdditions.h"

@implementation UINavigationController (ForcedRotation)

- (NSUInteger)supportedInterfaceOrientations
{
//    NSLog(@"supportedInterfaceOrientations = %lu", (unsigned long)[self.topViewController supportedInterfaceOrientations]);
    return [self.topViewController supportedInterfaceOrientations];
}

- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // You do not need this method if you are not supporting earlier iOS Versions
    return [self.topViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

@end

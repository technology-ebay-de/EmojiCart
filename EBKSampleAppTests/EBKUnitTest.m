//
//  EBKUnitTest.m
//  EBKSampleApp
//
//  Created by Calo, Ignazio on 20/05/2016.
//  Copyright © 2016 eBay Kleinanzeigen. All rights reserved.
//

#import "EBKUnitTest.h"
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

@implementation EBKUnitTest

- (KIFUITestActor *)testerActor
{
    return tester;
}

- (void)snapshotVerifyView:(UIView *)view withIdentifier:(NSString *)identifier
{
    FBSnapshotVerifyView(view, identifier);
}

- (UIViewController *)rootViewController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    if ([topController isKindOfClass:UINavigationController.class]) {
        topController = ((UINavigationController *)topController).topViewController;
    }
    return topController;
}

@end

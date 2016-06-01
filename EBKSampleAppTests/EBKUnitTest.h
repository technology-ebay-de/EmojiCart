//
//  EBKUnitTest.h
//  EBKSampleApp
//
//  Created by Calo, Ignazio on 20/05/2016.
//  Copyright © 2016 eBay Kleinanzeigen. All rights reserved.
//

#import <FBSnapshotTestCase/FBSnapshotTestCase.h>
#import <KIF/KIF.h>

@interface EBKUnitTest : FBSnapshotTestCase

- (UIViewController *)rootViewController;

- (KIFUITestActor *)testerActor;
- (void)snapshotVerifyView:(UIView *)view withIdentifier:(NSString *)identifier;

@end
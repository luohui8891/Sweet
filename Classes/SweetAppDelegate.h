//
//  SweetAppDelegate.h
//  Sweet
//
//  Created by apple on 11-8-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SweetViewController;

@interface SweetAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SweetViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SweetViewController *viewController;

@end


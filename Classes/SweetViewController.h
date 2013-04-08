//
//  SweetViewController.h
//  Sweet
//
//  Created by apple on 11-8-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "SweetTakePhoto.h"
#import "SweetPhotoProcess.h"
#import "SweetHeader.h"
#import "SweetResult.h"

@interface SweetViewController : UIViewController {
    // IBOutlet
    UIButton * btnSweet;
    UIButton * btnIntro;
    UIButton * btnAbout;
    UIButton * btnSet;
    
    // index
    NSInteger iPhotoIndex;
    
    // controller
    SweetTakePhoto *imagePickerController;
    SweetPhotoProcess * photoProcess;
    SweetResult *resultController;
    UINavigationController * navc;
    
    NSMutableArray * processedImage;
    
}

@property(nonatomic, retain) IBOutlet UIButton * btnSweet;
@property(nonatomic, retain) IBOutlet UIButton * btnIntro;
@property(nonatomic, retain) IBOutlet UIButton * btnAbout;
@property(nonatomic, retain) IBOutlet UIButton * btnSet;

- (IBAction)sweet:(id)sender;
@end


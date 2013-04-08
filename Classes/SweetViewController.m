//
//  SweetViewController.m
//  Sweet
//
//  Created by apple on 11-8-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SweetViewController.h"
#import "SweetTakePhoto.h"
@implementation SweetViewController
@synthesize  btnSweet,
             btnIntro,
             btnAbout,
             btnSet;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    iPhotoIndex = 0;
    if (processedImage == nil) {
        processedImage = [[NSMutableArray alloc] init];
    }
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
    self.btnSweet = nil;
    self.btnIntro = nil;
    self.btnAbout = nil;
    self.btnSet   = nil;
    [super viewDidUnload];
}


- (void)dealloc {
    [imagePickerController release];
    [super dealloc];
}
#pragma mark -
#pragma mark IBAction
- (IBAction)sweet:(id)sender{
    [self takePhoto];
}

#pragma mark -
#pragma mark 

- (void) takePhoto{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        if (imagePickerController == nil) {
            imagePickerController=[[SweetTakePhoto alloc] init];
            imagePickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
            imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            imagePickerController.delegate = self;
            imagePickerController.showsCameraControls = NO;
            imagePickerController.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        }
        imagePickerController.iPhotoIndex = iPhotoIndex;
		[self presentModalViewController:imagePickerController animated:YES];
	}
}

#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController 
      willShowViewController:(UIViewController *)viewController 
                    animated:(BOOL)animated{
    NSLog(@"willShowViewController");
    [viewController viewDidAppear:NO];

	
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{	
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [imagePickerController dismissModalViewControllerAnimated:NO];
	NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    NSLog(@"didFinishPickingMediaWithInfo");
	if ([mediaType isEqualToString:@"public.image"]){
        NSLog(@"public.image");
		UIImage *originalImage;
        originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (photoProcess == nil) {
            photoProcess = [[SweetPhotoProcess alloc] init];
            photoProcess.delegate = self;
        }
        photoProcess.iPhotoIndex = iPhotoIndex;
        photoProcess.processImage = originalImage;
        [self.view addSubview:photoProcess.view];
        [photoProcess viewDidAppear:NO];
            //[imagePickerController pushViewController:photoProcess animated:YES];
	}
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
	//
}

#pragma mark SweetPhotoProcessDelegate
- (void)processCompleted:(NSDictionary *) info{
    if ([[info objectForKey:@"kResult"] isEqualToString:@"retake"]) {
        [photoProcess.view removeFromSuperview];
		[self presentModalViewController:imagePickerController animated:NO];
    } else if ([[info objectForKey:@"kResult"] isEqualToString:@"ok"]) {
        [processedImage insertObject:[info objectForKey:@"kImage"] atIndex:iPhotoIndex];
        if (iPhotoIndex == MaxIndex-1) {
            [photoProcess.view removeFromSuperview];
            if (resultController == nil) {
                resultController = [[SweetResult alloc] init];
            }
            resultController.iPhotoCount = iPhotoIndex;
            resultController.imageList = processedImage;
            [self.view addSubview:resultController.view];
            [resultController viewDidAppear:NO];
        } else {
            [photoProcess.view removeFromSuperview];
            iPhotoIndex++;
            imagePickerController.iPhotoIndex = iPhotoIndex;
            [self presentModalViewController:imagePickerController animated:NO];
        }
    }
}

@end

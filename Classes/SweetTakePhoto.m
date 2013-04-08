//
//  SweetTakePhoto.m
//  Sweet
//
//  Created by apple on 11-8-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SweetTakePhoto.h"


@implementation SweetTakePhoto
@synthesize iPhotoIndex;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    if (nil == poseImageList) {
        NSError * error;
        currentPoseImagePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingFormat:@"/%@",@"SweetPoseHeart"];
        poseImageList = [[NSArray alloc] initWithArray:[[NSFileManager defaultManager] subpathsOfDirectoryAtPath:currentPoseImagePath error:error]]; 
        if (poseImageList == nil) {
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
			return;
        }
    }
    [self resetTopView];
    [self resetBottomView];
    [self resetPose];
}


- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"%d",self.iPhotoIndex);

    [self resetTopView];
    [self resetBottomView];
    [self resetPose];
    
}

- (void)resetTopView{
    if (topView == nil) {
        topView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, screenWidth, viewHeight)];
        topView.backgroundColor = [UIColor grayColor];
        [self.view addSubview:topView];
        [topView release];
    }
    if (tipsLabel == nil) {
        tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(edge, edge, labelWidth, viewHeight-2*edge)];
        tipsLabel.text = NSLocalizedString(@"Process",nil);
        tipsLabel.backgroundColor = [UIColor clearColor];
        [topView addSubview:tipsLabel];
        [tipsLabel release];
    }
    if (percentLabel == nil) {
        percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth-labelWidth-edge, edge, labelWidth, viewHeight-2*edge)];
        percentLabel.backgroundColor = [UIColor clearColor];
        [topView addSubview:percentLabel];
        [percentLabel release];
    }
    percentLabel.text = [NSString stringWithFormat:@"%d / %d", (iPhotoIndex+1), MaxIndex];
    if ( currentProcess == nil){
        currentProcess = [[UIProgressView alloc] initWithFrame:CGRectMake(labelWidth+2*edge, 20.0f, screenWidth-2*labelWidth-4*edge, 10)];
        [topView addSubview:currentProcess];
        [currentProcess release];
    }
    currentProcess.progress = (iPhotoIndex+1)*1.0/MaxIndex;
}

- (void)resetBottomView{
    
    if (bottomView == nil) {
        bottomView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, screenHeight-bottomViewHeight, screenWidth, bottomViewHeight)];
        bottomView.backgroundColor = [UIColor grayColor];
        [self.view addSubview:bottomView];
        [bottomView release];
    }
    if (takePhotoBtn==nil) {
        CGFloat btnWidth = 100.0f;
        takePhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        takePhotoBtn.frame = CGRectMake((screenWidth-btnWidth)/2, 2*edge, btnWidth, bottomViewHeight-4*edge);
        takePhotoBtn.backgroundColor = [UIColor redColor];
        [takePhotoBtn addTarget:self
                         action:@selector(takePhoto:)
               forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:takePhotoBtn];
    }
    if (turnBtn == nil) {
        CGFloat btnWidth = 40.0f;
        turnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        turnBtn.frame = CGRectMake(screenWidth-btnWidth-2*edge, 2*edge, btnWidth, bottomViewHeight-4*edge);
        turnBtn.backgroundColor = [UIColor redColor];
        [turnBtn addTarget:self
                         action:@selector(turnCamera:)
               forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:turnBtn];
    }

}

- (void)resetPose{
    if (poseImgv == nil) {
        poseImgv = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, viewHeight, screenWidth, screenHeight-viewHeight-bottomViewHeight)];
        poseImgv.backgroundColor = [UIColor clearColor];
        self.cameraOverlayView = poseImgv;
        //[self.view addSubview:poseImgv];
    }
    if ([poseImageList count] >= iPhotoIndex) {
        NSString * imageName = [poseImageList objectAtIndex:iPhotoIndex];
        NSString * imagePath = [[[[NSBundle mainBundle] resourcePath] stringByAppendingFormat:@"/%@",@"SweetPoseHeart"] stringByAppendingFormat:@"/%@", imageName];
        poseImgv.image = [UIImage imageWithContentsOfFile:imagePath];
    }
    
    
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    topView = nil;
    tipsLabel = nil;
    percentLabel = nil;
    currentProcess = nil;
    bottomView = nil;
    takePhotoBtn = nil;
    turnBtn = nil;
    poseImgv = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [tipsLabel release];
    [percentLabel release];
    [currentProcess release];
    [topView release];
    
    [takePhotoBtn release];
    [turnBtn release];
    [bottomView release];
    
    [poseImgv release];
    [poseImageList release];
    poseImageList = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark Action
- (void)takePhoto:(id)sender{
    [self takePicture];
}

- (void)turnCamera:(id)sender{
    if (self.cameraDevice == UIImagePickerControllerCameraDeviceRear) {
        self.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    } else if (self.cameraDevice == UIImagePickerControllerCameraDeviceFront) {
        self.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    }
    
}

@end

//
//  SweetPhotoProcess.m
//  Sweet
//
//  Created by apple on 11-8-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SweetPhotoProcess.h"
#import "SweetTakePhoto.h"

@implementation SweetPhotoProcess
@synthesize processImage, iPhotoIndex,delegate;

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
//    [self resetBottomView];
//    [self resetMiddleView];
//    [self resetTopView];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self resetBottomView];
    [self resetMiddleView];
    [self resetTopView];
}

- (void)resetTopView{
    if (topView == nil) {
        topView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, screenWidth, viewHeight)];
        topView.backgroundColor = [UIColor blueColor];
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
    if (retakeBtn==nil) {
        CGFloat btnWidth = 40.0f;
        retakeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        retakeBtn.frame = CGRectMake(2*edge, 2*edge, btnWidth, btnWidth);
        retakeBtn.backgroundColor = [UIColor blueColor];
        [retakeBtn  addTarget:self
                       action:@selector(retakePhoto:)
             forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:retakeBtn];
    }
    if (okBtn == nil) {
        CGFloat btnWidth = 40.0f;
        okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        okBtn.frame = CGRectMake(screenWidth-btnWidth-2*edge, 2*edge, btnWidth, btnWidth);
        okBtn.backgroundColor = [UIColor blueColor];
        [okBtn addTarget:self
                  action:@selector(ok:)
        forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:okBtn];
    }
    
}

- (void)resetMiddleView{
    if (scrollView == nil) {
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 
                                                                    screenWidth, screenHeight-bottomViewHeight)];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.bouncesZoom = YES;
        scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
        scrollView.delegate = self;
        [scrollView setBackgroundColor:[UIColor blackColor]];
        scrollView.contentSize = scrollView.frame.size;
        [self.view  addSubview:scrollView];
        [scrollView release];
    }
    if (imageView == nil) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 
                                                                  screenWidth, screenHeight-bottomViewHeight)];
        [scrollView addSubview:imageView];
        [imageView release];
    }
    UIImage * img = [[UIImage alloc] initWithCGImage:[processImage CGImage] scale:1.0f orientation:UIImageOrientationLeftMirrored];
    imageView.image = img;
    [img release];
    scrollView.maximumZoomScale = 2.0;
    scrollView.minimumZoomScale = 1.0;
    scrollView.zoomScale = 1.0;

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
    NSLog(@"Photo Process viewDidUnload");
    topView = nil;
    tipsLabel = nil;
    percentLabel = nil;
    currentProcess = nil;
    bottomView = nil;
    retakeBtn = nil;
    okBtn = nil;
    scrollView = nil;
    imageView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    NSLog(@"Photo Process dealloc");
    [okBtn release];
    [retakeBtn release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIScrollView delegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageView;
	//return nil;
}

#pragma mark Action

- (void)retakePhoto:(id)sender{
    NSLog(@"retakePhoto");
    NSDictionary * info = [NSDictionary dictionaryWithObjectsAndKeys:@"retake",@"kResult",nil];
    if (delegate) {
        [delegate processCompleted:info];
    }
}

- (void)ok:(id)sender{
    NSDictionary * info = [NSDictionary dictionaryWithObjectsAndKeys:@"ok",@"kResult",imageView.image,@"kImage", nil];
    if (delegate) {
        [delegate processCompleted:info];
    }
}

@end

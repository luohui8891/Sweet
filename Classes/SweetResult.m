    //
//  SweetResult.m
//  Sweet
//
//  Created by apple on 11-8-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SweetResult.h"
#import "SweetHeader.h"


@implementation SweetResult
@synthesize imageList, iPhotoCount;

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    if (effectsList) {
        effectsList =  [[NSArray alloc] initWithContentsOfFile:EffectsPath];
    }
    [self resetTopView];
    [self resetBottomView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([imageList count]>0 && [imageList count] == iPhotoCount) {
        NSArray * templates = [[NSArray alloc] initWithContentsOfFile:TemplatePath];
        for (int i = 0 ; i<iPhotoCount; ++i) {
            UIImageView * imgv = [[UIImageView alloc] initWithImage:[imageList objectAtIndex:i]];
            NSDictionary * temp = [templates objectAtIndex:i];
            CGRect tempFram = CGRectMake([[temp valueForKey:@"x"] doubleValue], 
                                         [[temp valueForKey:@"y"] doubleValue], 
                                         [[temp valueForKey:@"width"] doubleValue], 
                                         [[temp valueForKey:@"height"] doubleValue]);
        }
    }
}

- (void)resetTopView{
    if (topView == nil) {
        topView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, screenWidth, viewHeight)];
        topView.backgroundColor = [UIColor grayColor];
        [self.view addSubview:topView];
        [topView release];
    }
    if (backBtn == nil) {
        backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        backBtn.frame = CGRectMake(edge, edge, labelWidth, viewHeight-2*edge);
        backBtn.titleLabel.text = NSLocalizedString(@"Back",nil);
        backBtn.backgroundColor = [UIColor redColor];
        [topView addSubview:backBtn];
    }
    if (saveBtn == nil) {
        saveBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        saveBtn.frame = CGRectMake(edge, edge, labelWidth, viewHeight-2*edge);
        saveBtn.titleLabel.text = NSLocalizedString(@"Save",nil);
        saveBtn.backgroundColor = [UIColor redColor];
        [topView addSubview:saveBtn];
    }
}

- (void)resetBottomView{
    if (bottomView == nil) {
        bottomView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, screenHeight-bottomViewHeight, screenWidth, bottomViewHeight)];
        bottomView.backgroundColor = [UIColor grayColor];
        [self.view addSubview:bottomView];
        [bottomView release];
    }
    if (effectBtnList==nil) {
        if (effectsList && [effectsList count]<1) {
            effectBtnList = [[ButtonListView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, screenWidth, bottomViewHeight)];
            [effectBtnList setupColumns:[effectsList count] andRows:1 andListLength:[effectsList count]];
            effectBtnList.theButtonListViewDelegate = self;
            [bottomView addSubview:effectBtnList];
            [effectBtnList release];
        }
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
    backBtn = nil;
    saveBtn = nil;
    bottomView = nil;
    effectBtnList = nil;
    
    backgroundImgView = nil;
    foregroundImgView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    if (topView) {
        for ( UIView * v in [topView subviews]) [v removeFromSuperview];
        [topView release];
        topView = nil;
    }
   
    if (bottomView) {
        for ( UIView * v in [bottomView subviews]) [v removeFromSuperview];
        [bottomView release];
        bottomView = nil;
    }
    
    if (backgroundImgView) {
        [backgroundImgView release];
        backgroundImgView = nil;
    }
    
    if (foregroundImgView) {
        [foregroundImgView release];
        foregroundImgView = nil;
    }
    
    if (self.imageList) {
        self.imageList = nil;
    }
    if (effectsList) {
        [effectsList release];
        effectsList = nil;
    }

    [super dealloc];
}

#pragma mark -
#pragma mark ButtonListViewDelegate
-(void) onItemClick:(int)theIndex ofItem:(UIButton *)theBtnItem{
    
}

-(void) onItemWillDisplay:(int)theIndex ofItem:(UIButton *)theBtnItem{
    [theBtnItem setTitle:[NSString stringWithFormat:@"%d", theIndex] forState:UIControlStateNormal];
}


@end

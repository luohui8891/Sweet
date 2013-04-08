//
//  SweetTakePhoto.h
//  Sweet
//
//  Created by apple on 11-8-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SweetHeader.h"

@interface SweetTakePhoto : UIImagePickerController {
    NSInteger iPhotoIndex;
    // ib
    UIView * topView;
    UILabel * tipsLabel;
    UILabel * percentLabel;
    UIProgressView * currentProcess;
    UIView * bottomView;
    UIButton * takePhotoBtn;
    UIButton * turnBtn;
    UIImageView * poseImgv;
    // data
    NSMutableArray * poseImageList;
    NSString * currentPoseImagePath;

}
@property (nonatomic, assign) NSInteger iPhotoIndex;

- (IBAction)takePhoto:(id)sender;
@end

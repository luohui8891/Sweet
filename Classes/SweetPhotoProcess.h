//
//  SweetPhotoProcess.h
//  Sweet
//
//  Created by apple on 11-8-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SweetHeader.h"
@protocol SweetPhotoProcessDelegate <NSObject>
- (void)processCompleted:(NSDictionary *) info;
@end

@interface SweetPhotoProcess : UIViewController {
    NSInteger iPhotoIndex;
    // ib
    UIView * topView;
    UILabel * tipsLabel;
    UILabel * percentLabel;
    UIProgressView * currentProcess;
    UIView * bottomView;
    UIButton * retakeBtn;
    UIButton * okBtn;
    UIScrollView * scrollView;
    UIImageView * imageView;
    
    UIImage * processImage;
    //delegate
    id<SweetPhotoProcessDelegate> delegate;
}

@property (nonatomic,retain) UIImage * processImage;
@property (nonatomic, assign) NSInteger iPhotoIndex;
@property (nonatomic, assign) id<SweetPhotoProcessDelegate> delegate;
@end

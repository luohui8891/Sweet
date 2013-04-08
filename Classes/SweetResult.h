//
//  SweetResult.h
//  Sweet
//
//  Created by apple on 11-8-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonListView.h"

@interface SweetResult : UIViewController {
    // ib
    UIView * topView;
    UIButton * backBtn;
    UIButton * saveBtn;

    UIView * bottomView;
    ButtonListView * effectBtnList;
    
    UIImageView * backgroundImgView;
    UIImageView * foregroundImgView;
    
    // data
    NSArray * imageList;
    NSArray * effectsList;
    NSInteger iPhotoCount;
}
@property (nonatomic, retain) NSArray * imageList;
@property (nonatomic, assign) NSInteger iPhotoCount;
@end

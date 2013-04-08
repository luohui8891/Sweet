//
//  ButtonListView.h
//  ButtonListView
//
//  Created by Andy on 11-4-4.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ButtonListViewDelegate

-(void) onItemClick:(int)theIndex ofItem:(UIButton *)theBtnItem;
-(void) onItemWillDisplay:(int)theIndex ofItem:(UIButton *)theBtnItem;

@end


@interface CommonButton : UIButton
{
    
}

@end



@interface ButtonListView:UIView<UIScrollViewDelegate> {
@public
    int columns;
    int rows;
    int listLength;
    int selectedIndex;
    id<ButtonListViewDelegate> theButtonListViewDelegate;

@private
    UIScrollView *buttonItemsContainer;
    NSMutableArray * buttonArray;

    int itemWidth;
    int itemHeight;
    int gridLine;   // 按钮间距
}

-(void) initWithColumns:(int)theColumns andRows:(int)theRows andListLength:(int)theListLength;
-(void) reDisplay;
@property (nonatomic, assign)     id<ButtonListViewDelegate> theButtonListViewDelegate;


@end

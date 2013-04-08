//
//  ButtonListView.m
//  ButtonListView
//
//  Created by Andy on 11-4-4.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ButtonListView.h"

@implementation CommonButton

-(id) init
{
    self = [super init];
    if (self) {
        // init
        
    }
    return self;
}

@end




@implementation ButtonListView
@synthesize theButtonListViewDelegate;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
        buttonItemsContainer = [[UIScrollView alloc] initWithFrame:frame];
        buttonItemsContainer.showsHorizontalScrollIndicator = YES;
        buttonItemsContainer.showsVerticalScrollIndicator = YES;
        buttonItemsContainer.scrollEnabled = YES;
        buttonItemsContainer.pagingEnabled = NO;
        buttonItemsContainer.bounces = YES;
        buttonItemsContainer.delegate = self;
        [self addSubview:buttonItemsContainer];
        [buttonItemsContainer release];
        buttonArray = [[NSMutableArray alloc] init];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
    [super dealloc];
    [buttonItemsContainer release];
    [buttonArray release];
}

-(void) resetItemSize
{
    itemWidth = (self.frame.size.width - gridLine * (columns + 1)) / columns;
    itemWidth = MAX(1, itemWidth);
    
    itemHeight = (self.frame.size.height - gridLine * (rows + 1)) / rows;
    itemHeight = MAX(1, itemHeight);
}

-(CGSize) getItemSize
{
    CGSize itemSize = CGSizeMake(itemWidth, itemHeight);
    return itemSize;
}

-(CGPoint) getItemLocationOfIndex:(int)theIndex
{
    theIndex = MAX(0, theIndex);
    // 该序号所在的行列
    int myRow = theIndex / columns;
    int myColumn = theIndex % columns;
    
    int locX = (itemWidth + gridLine) * myColumn + gridLine;
    int locY = (itemHeight + gridLine) * myRow + gridLine;
    CGPoint itemLocation = CGPointMake(locX, locY);
    return itemLocation;
}

-(CGRect) getItemFrameOfIndex:(int)theIndex
{
    theIndex = MAX(0, theIndex);
    // 该序号所在的行列
    int myRow = theIndex / columns;
    int myColumn = theIndex % columns;
    
    int locX = (itemWidth + gridLine) * myColumn + gridLine;
    int locY = (itemHeight + gridLine) * myRow + gridLine;
    CGRect itemFrame = CGRectMake(locX, locY, itemWidth, itemHeight);
    return itemFrame;
}

-(void) btnItemClick:(id)sender
{
    CommonButton *btn = (CommonButton *)sender;
//    NSLog(@"btnClick %d", btn.tag);

    selectedIndex = btn.tag;
    [theButtonListViewDelegate onItemClick:selectedIndex ofItem:btn];
//    [self updateButtonItemsCountainer ];
}

-(void) setupBasicControl
{    
    [self resetItemSize];
    buttonItemsContainer.contentSize = CGSizeMake(buttonItemsContainer.frame.size.width, 
                                                  ceil(listLength*1.0 / columns) * (itemHeight+ gridLine) + gridLine);
    for( CommonButton * btn in buttonArray ){
        [btn removeFromSuperview];
        //[buttonArray removeObject:btn];
    }
    [buttonArray removeAllObjects];
    for (int i=0; i<listLength; i++) {
        //CommonButton *btnTemp = [[CommonButton alloc] initWithFrame:[self getItemFrameOfIndex:i]];
        CommonButton *btnTemp = [CommonButton buttonWithType:UIButtonTypeCustom];
        btnTemp.frame = [self getItemFrameOfIndex:i];
        btnTemp.showsTouchWhenHighlighted = YES;
        //btnTemp.backgroundColor = [UIColor orangeColor];
        btnTemp.tag = i;
        //[btnTemp setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        [theButtonListViewDelegate onItemWillDisplay:i ofItem:btnTemp];
        [btnTemp addTarget:self action:@selector(btnItemClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonItemsContainer addSubview:btnTemp];
        [buttonArray addObject:btnTemp];
        //[btnTemp release];
    }
}

-(void) reDisplay{
    for (int i=0; i<listLength; i++) {
        CommonButton *btnTemp = [buttonArray objectAtIndex:i];
        [theButtonListViewDelegate onItemWillDisplay:i ofItem:btnTemp];
    }
}

-(void) updateButtonItemsCountainer
{
    for (int i=0; i<listLength; i++) {
        CommonButton *btn = [buttonItemsContainer viewWithTag:i];
        [theButtonListViewDelegate onItemWillDisplay:i ofItem:btn];
    }
}

-(void) initButtonItmesContainer
{
    [self resetItemSize];
    [self setupBasicControl];
    
    
}

-(void) setupColumns:(int)theColumns andRows:(int)theRows andListLength:(int)theListLength
{
    columns = theColumns;
    rows = theRows;
    listLength = theListLength;
    
    itemWidth = 1;
    itemHeight = 1;
    gridLine = 10;

    
    [self setupBasicControl];
}




@end

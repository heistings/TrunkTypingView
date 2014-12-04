//
//  TrunkTypingView.h
//  TrunkTypingView
//
//  Created by waterforest on 14-12-3.
//  Copyright (c) 2014年 sohu-inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TrunkTypingViewContentVerticalAlignment) {
    TrunkTypingViewContentVerticalAlignmentCenter  = 0,
    TrunkTypingViewContentVerticalAlignmentTop     = 1,
    TrunkTypingViewContentVerticalAlignmentBottom  = 2,
};

typedef NS_ENUM(NSInteger, TrunkTypingViewFootType) {
    TrunkTypingViewFootTypeLeftUp       = 0,
    TrunkTypingViewFootTypeLeftDown     = 1,
    TrunkTypingViewFootTypeRightUp      = 2,
    TrunkTypingViewFootTypeRightDown    = 3
};

@protocol TrunkTypingViewDelegate;

//______________________________________________________

@interface TrunkTypingView : UIView

@property (nonatomic, weak) id<TrunkTypingViewDelegate> delegate;

@property (nonatomic) TrunkTypingViewFootType footType; // Default TrunkTypingViewFootTypeLeftDown
@property (nonatomic) CGPoint foot; // Default CGPointZero

@property (nonatomic) TrunkTypingViewContentVerticalAlignment leftButtonVerticalAlignment; // Default TrunkTypingViewContentVerticalAlignmentTop
@property (nonatomic) TrunkTypingViewContentVerticalAlignment rightButtonVerticalAlignment; // Default TrunkTypingViewContentVerticalAlignmentTop
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@end

//______________________________________________________


@protocol TrunkTypingViewDelegate <NSObject>

- (void)trunkTypingView:(TrunkTypingView *)view frameWillChange:(CGRect)frame;
- (void)trunkTypingView:(TrunkTypingView *)view frameDidChange:(CGRect)frame;

@end

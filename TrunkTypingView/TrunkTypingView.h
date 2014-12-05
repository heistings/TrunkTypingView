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

@property (nonatomic) TrunkTypingViewFootType footType; // Default TrunkTypingViewFootTypeLeftUp
@property (nonatomic) CGPoint foot; // Default CGPointZero

@property (nonatomic) TrunkTypingViewContentVerticalAlignment leftButtonVerticalAlignment; // Default TrunkTypingViewContentVerticalAlignmentTop
@property (nonatomic) TrunkTypingViewContentVerticalAlignment rightButtonVerticalAlignment; // Default TrunkTypingViewContentVerticalAlignmentTop
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong, readonly) UITextView *textView;

/**
 * Adjusted for [UIFont systemFontOfSize:16], you should set a appropriate value if you changed trunkTypingView.textView.font.
 */
@property (nonatomic) UIFont *font;
@property (nonatomic) CGFloat textViewBoudsOffset; // Default 4, adjusted for [UIFont systemFontOfSize:16]

@property (nonatomic) int maxNumberOfLines; // Default 1, if reached, typing view will no longer grow up.

@end

//______________________________________________________


@protocol TrunkTypingViewDelegate <NSObject>

@optional
- (BOOL)trunkTypingViewShouldBeginEditing:(TrunkTypingView *)view;
- (BOOL)trunkTypingViewShouldEndEditing:(TrunkTypingView *)view;
- (void)trunkTypingViewDidBeginEditing:(TrunkTypingView *)view;
- (void)trunkTypingViewDidEndEditing:(TrunkTypingView *)view;

- (void)trunkTypingView:(TrunkTypingView *)view frameWillChange:(CGRect)frame;
- (void)trunkTypingView:(TrunkTypingView *)view frameDidChange:(CGRect)frame;

@end

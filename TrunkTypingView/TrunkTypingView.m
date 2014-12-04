//
//  TrunkTypingView.m
//  TrunkTypingView
//
//  Created by waterforest on 14-12-3.
//  Copyright (c) 2014年 sohu-inc. All rights reserved.
//

#import "TrunkTypingView.h"

@interface TrunkTypingView ()<UITextViewDelegate> {
    UITextView *textView;
}

@end

//______________________________________________________


@implementation TrunkTypingView
@synthesize leftButton = _leftButton;
@synthesize rightButton = _rightButton;

- (void)initProperties
{
    _footType = TrunkTypingViewFootTypeLeftUp;
    _foot = CGPointZero;
    
    _leftButtonVerticalAlignment = TrunkTypingViewContentVerticalAlignmentTop;// Default TrunkTypingViewContentVerticalAlignmentTop
    _rightButtonVerticalAlignment = TrunkTypingViewContentVerticalAlignmentTop;// Default TrunkTypingViewContentVerticalAlignmentTop
    
    _textViewBoudsOffset = 4;
    _textViewDefaultHeight = 36;
}

- (void)initTextViewFrame
{
    textView.frame = CGRectMake(0, (self.frame.size.height - self.textViewDefaultHeight) / 2, self.frame.size.width, self.textViewDefaultHeight);
    CGSize contentSize = textView.contentSize;
    contentSize.height = self.textViewDefaultHeight;
    textView.contentSize = contentSize;

    [self autoresize];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initProperties];
        
        self.backgroundColor = [UIColor blueColor];
        
        textView = [[UITextView alloc] initWithFrame:CGRectZero];
        textView.delegate = self;
        textView.font = [UIFont systemFontOfSize:16];
        textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textView.layer.borderWidth = 0.5;
        textView.layer.cornerRadius = 5.0;
        [self addSubview:textView];
        
        [self initTextViewFrame];
    }
    return self;
}

#pragma mark - Private
- (void)autoresizeSelf
{
    CGFloat height = textView.contentSize.height; // new height
    
    CGRect frame = self.frame;
    frame.size.height = height + self.textViewBoudsOffset * 2;
    
    if (_leftButton) {
        frame.size.height = MAX(frame.size.height, _leftButton.frame.size.height);
    }
    
    if (_rightButton) {
        frame.size.height = MAX(frame.size.height, _rightButton.frame.size.height);
    }
    
    switch (self.footType) {
        case TrunkTypingViewFootTypeLeftUp:
            frame.origin = self.foot;
            break;
            
        case TrunkTypingViewFootTypeLeftDown:
            frame.origin.x = self.foot.x;
            frame.origin.y = self.foot.y - frame.size.height;
            break;
            
        case TrunkTypingViewFootTypeRightUp:
            frame.origin.x = self.foot.x - frame.size.width;
            frame.origin.y = self.foot.y;
            break;
            
        case TrunkTypingViewFootTypeRightDown:
            frame.origin.x = self.foot.x - frame.size.width;
            frame.origin.y = self.foot.y - frame.size.height;
            break;
            
        default:
            break;
    }

    self.frame = frame;
}

- (void)autoresizeLeftButton
{
    if (_leftButton) {
        switch (self.leftButtonVerticalAlignment) {
            case TrunkTypingViewContentVerticalAlignmentCenter:
                _leftButton.center = CGPointMake(_leftButton.frame.size.width / 2, self.frame.size.height / 2);
                break;
            case TrunkTypingViewContentVerticalAlignmentBottom:
                _leftButton.center = CGPointMake(_leftButton.frame.size.width / 2, self.frame.size.height - _leftButton.frame.size.height / 2);
                break;
            case TrunkTypingViewContentVerticalAlignmentTop:
                _leftButton.center = CGPointMake(_leftButton.frame.size.width / 2, _leftButton.frame.size.height / 2);
                break;
            default:
                break;
        }
    }
}

- (void)autoresizeRightButton
{
    if (_rightButton) {
        switch (_rightButtonVerticalAlignment) {
            case TrunkTypingViewContentVerticalAlignmentCenter:
                _rightButton.center = CGPointMake(self.frame.size.width - _rightButton.frame.size.width / 2, self.frame.size.height / 2);
                break;
            case TrunkTypingViewContentVerticalAlignmentTop:
                _rightButton.center = CGPointMake(self.frame.size.width - _rightButton.frame.size.width / 2, _rightButton.frame.size.height / 2);
                break;
            case TrunkTypingViewContentVerticalAlignmentBottom:
                _rightButton.center = CGPointMake(self.frame.size.width - _rightButton.frame.size.width / 2, self.frame.size.height - _rightButton.frame.size.height / 2);
                break;
            default:
                break;
        }
    }
}

- (void)autoresizeTextView
{
    CGFloat height = textView.contentSize.height; // new height
    textView.frame = CGRectMake(_leftButton?_leftButton.frame.size.width:0, (self.frame.size.height - height) / 2, self.frame.size.width - (_leftButton?_leftButton.frame.size.width:0) - (_rightButton ? _rightButton.frame.size.width:0), height);
}

- (void)autoresize
{
    [self autoresizeSelf];
    [self autoresizeLeftButton];
    [self autoresizeRightButton];
    [self autoresizeTextView];
}

#pragma mark - Property
- (void)setFoot:(CGPoint)foot
{
    _foot = foot;
    [self autoresize];
}

- (void)setLeftButton:(UIButton *)leftButton
{
    if (_leftButton) {
        [_leftButton removeFromSuperview];
    }
    
    _leftButton = leftButton;
    [self addSubview:_leftButton];
    
    [self autoresize];
}

- (void)setRightButton:(UIButton *)rightButton
{
    if (_rightButton) {
        [_rightButton removeFromSuperview];
    }
    
    _rightButton = rightButton;
    [self addSubview:_rightButton];
    
    [self autoresize];
}

- (UITextView *)textView
{
    return textView;
}

- (void)setFont:(UIFont *)font
{
    textView.font = font;
    
    [self autoresize];
}

- (void)setTextViewDefaultHeight:(CGFloat)textViewDefaultHeight
{
    _textViewDefaultHeight = textViewDefaultHeight;
    
    [self initTextViewFrame];
}

- (UIFont *)font
{
    return textView.font;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    [self autoresize];
}

@end

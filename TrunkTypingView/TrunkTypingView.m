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
    
    CGFloat maxHeight;
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
    _maxNumberOfLines = 1;
}

- (void)initTextViewFrame
{
    // Use internalTextView for height calculations, thanks to Gwynne <http://blog.darkrainfall.org/>
    NSString *saveText = textView.text, *newText = [textView.text isEqualToString:@""] ? textView.text :  @"-";
    
    textView.delegate = nil;
    textView.hidden = YES;
    
    
    textView.text = newText;
    
    maxHeight = [self measureHeight];
    
    textView.text = saveText;
    textView.hidden = NO;
    textView.delegate = self;
    
    [self sizeToFit];
    
    textView.frame = CGRectMake(0, (self.frame.size.height - maxHeight) / 2, self.frame.size.width, maxHeight);
    
    CGSize contentSize = textView.contentSize;
    contentSize.height = maxHeight;
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
- (CGFloat)textViewHeightThatFits
{
    return MIN(textView.contentSize.height, maxHeight);
}

- (void)autoresizeSelf
{
    CGFloat height = [self textViewHeightThatFits]; // new height
        
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
    CGFloat height = [self textViewHeightThatFits]; // new height
    textView.frame = CGRectMake(_leftButton?_leftButton.frame.size.width:0, (self.frame.size.height - height) / 2, self.frame.size.width - (_leftButton?_leftButton.frame.size.width:0) - (_rightButton ? _rightButton.frame.size.width:0), height);
}

- (void)autoresize
{
    [self autoresizeSelf];
    [self autoresizeLeftButton];
    [self autoresizeRightButton];
    [self autoresizeTextView];
}

// Code from apple developer forum - @Steve Krulewitz, @Mark Marszal, @Eric Silverberg
- (CGFloat)measureHeight
{
    if ([self respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)])
    {
        return ceilf([textView sizeThatFits:textView.frame.size].height);
    }
    else {
        return textView.contentSize.height;
    }
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
    
    [self initTextViewFrame];
}

- (UIFont *)font
{
    return textView.font;
}

-(void)setMaxNumberOfLines:(int)n
{
    // Use internalTextView for height calculations, thanks to Gwynne <http://blog.darkrainfall.org/>
    NSString *saveText = textView.text, *newText = @"-";
    
    textView.delegate = nil;
    textView.hidden = YES;
    
    for (int i = 1; i < n; ++i)
        newText = [newText stringByAppendingString:@"\n|W|"];
    
    textView.text = newText;
    
    maxHeight = [self measureHeight];
    
    textView.text = saveText;
    textView.hidden = NO;
    textView.delegate = self;
    
    [self sizeToFit];
    
    _maxNumberOfLines = n;
}

- (void)setFrame:(CGRect)frame
{
    if ([self.delegate respondsToSelector:@selector(trunkTypingView:frameWillChange:)]) {
        [self.delegate trunkTypingView:self frameWillChange:frame];
    }
    
    [super setFrame:frame];
    
    if ([self.delegate respondsToSelector:@selector(trunkTypingView:frameDidChange:)]) {
        [self.delegate trunkTypingView:self frameDidChange:frame];
    }
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(trunkTypingViewShouldBeginEditing:)]) {
        return [self.delegate trunkTypingViewShouldBeginEditing:self];
    }
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(trunkTypingViewShouldEndEditing:)]) {
        [self.delegate trunkTypingViewShouldEndEditing:self];
    }
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(trunkTypingViewDidBeginEditing:)]) {
        [self.delegate trunkTypingViewDidBeginEditing:self];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(trunkTypingViewDidEndEditing:)]) {
        [self.delegate trunkTypingViewDidEndEditing:self];
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self autoresize];
}

@end

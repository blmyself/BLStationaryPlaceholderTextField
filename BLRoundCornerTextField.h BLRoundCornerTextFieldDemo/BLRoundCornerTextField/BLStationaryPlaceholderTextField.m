//
//  BLStationaryPlaceholderTextField.m
//  BLStationaryPlaceholderTextFieldDemo
//
//  Created by BaiLin on 15/10/26.
//  Copyright (c) 2015年 BaiLin. All rights reserved.
//

#import "BLStationaryPlaceholderTextField.h"

#define DEFAULT_TEXT_RECT CGRectInset(bounds, 8, 0)

@implementation BLStationaryPlaceholderTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self setup];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if(self) {
        [self setup];
    }
    return self;
}

- (UIColor *)rgbColorWithRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue Alpha:(CGFloat)alpha{
    UIColor * returnColor = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
    return returnColor;
}


- (void)setup{
    
    if (self.borderStyle == UITextBorderStyleNone) {
        self.layer.cornerRadius = 6.0f;
        self.layer.borderColor = [self rgbColorWithRed:123 Green:123 Blue:123 Alpha:1.0f].CGColor;
        self.layer.borderWidth = 0.5f;
    }

}

- (void)setShowPlaceHoderInLeftView:(BOOL)showPlaceHoderInLeftView{
    _showPlaceHoderInLeftView = showPlaceHoderInLeftView;
    
    //placehoder文字显示为leftview
    if (self.showPlaceHoderInLeftView && (self.placeholder.length>0)) {
        
        UILabel * leftLabel  = [[UILabel alloc] init];
        leftLabel.text = self.placeholder;
        leftLabel.backgroundColor = [UIColor clearColor];
        leftLabel.textColor = self.textColor;
        leftLabel.textAlignment = NSTextAlignmentCenter;
        [leftLabel sizeToFit];
        CGRect lableFrame = leftLabel.frame;
        lableFrame.size.width += 10;
        leftLabel.frame = lableFrame;
        self.leftView = leftLabel;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        //不在显示placehoder
        self.placeholder = @"";
    }
}

//控制文本所在的的位置，左右缩8(只要重写了此方法 bounds就是从头开始的，所以要自己设置间隔)
- (CGRect)textRectForBounds:(CGRect)bounds
{
    
    if (self.leftView) {
        return CGRectMake(self.leftView.frame.size.width, bounds.origin.y, bounds.size.width, bounds.size.height);
    }else{
        return CGRectInset(bounds, 8, 0);
    }
    
    return bounds;
}

//控制编辑文本时所在的位置，左右缩8
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    if (self.leftView) {
        return CGRectMake(self.leftView.frame.size.width, bounds.origin.y, bounds.size.width, bounds.size.height);
    }else{
        return CGRectInset(bounds, 8, 0);
    }
}


- (CGRect)caretRectForPosition:(UITextPosition *)position{
    CGRect originalRect = [super caretRectForPosition:position];
    
    //UITextField，如果有leftView需要调整一下光杆的上下位置
    if (self.leftView) {
        originalRect.origin.y += 2;
    }
    
    return originalRect;
}


@end

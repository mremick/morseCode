//
//  circularButton.m
//  morseCode
//
//  Created by Matt Remick on 1/26/14.
//  Copyright (c) 2014 Matt Remick. All rights reserved.
//

#import "circularButton.h"

@interface circularButton()

@property (strong,nonatomic) CAShapeLayer *circularLayer;
@property (strong,nonatomic) UIColor *buttonColor;

@end

@implementation circularButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawCircularButton:(UIColor *)color
{
    self.backgroundColor = color;
    
    [self setTitleColor:color forState:UIControlStateNormal];
    
    self.circularLayer = [CAShapeLayer layer];
    
    [self.circularLayer setBounds:CGRectMake(0.0f, 0.0f, [self bounds].size.width, [self bounds].size.height)];
    [self.circularLayer setPosition:CGPointMake(CGRectGetMidX([self bounds]), CGRectGetMidY([self bounds]))];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [self.circularLayer setPath:[path CGPath]];
    
    [self.circularLayer setStrokeColor:[color CGColor]];
    
    [self.circularLayer setLineWidth:2.0f];
    [self.circularLayer setFillColor:[[UIColor clearColor] CGColor]];
    
    [[self layer] addSublayer:self.circularLayer];
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (highlighted)
    {
        self.titleLabel.textColor = [UIColor whiteColor];
        [self.circularLayer setFillColor:self.backgroundColor.CGColor];
    }
    else
    {
        [self.circularLayer setFillColor:[UIColor clearColor].CGColor];
        self.titleLabel.textColor = self.backgroundColor;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

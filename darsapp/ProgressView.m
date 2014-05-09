//
//  ProgressView.m
//  darsapp
//
//  Created by inf227al on 8/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "ProgressView.h"

@implementation ProgressView

- (void)drawRect:(CGRect)rect
{
    CGRect progressIndicatorFrame = CGRectMake(-1, 0, 321, 47);
    [self drawCanvas1WithProgressIndicatorFrame: progressIndicatorFrame];

}


- (void)drawCanvas1WithProgressIndicatorFrame: (CGRect)progressIndicatorFrame;
{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    //// Gradient Declarations
    CGFloat outerRectGradientLocations[] = {0, 0, 1};
    CGGradientRef outerRectGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)UIColor.blackColor.CGColor, (id)[UIColor colorWithRed: 0.5 green: 0.5 blue: 0.5 alpha: 1].CGColor, (id)UIColor.whiteColor.CGColor], outerRectGradientLocations);
    CGFloat gradientLocations[] = {0, 0.98, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)UIColor.blackColor.CGColor, (id)[UIColor colorWithRed: 0.5 green: 0.5 blue: 0.5 alpha: 1].CGColor, (id)UIColor.whiteColor.CGColor], gradientLocations);
    
    //// Shadow Declarations
    UIColor* darkShadow = UIColor.blackColor;
    CGSize darkShadowOffset = CGSizeMake(0.1, 1.1);
    CGFloat darkShadowBlurRadius = 1.5;
    UIColor* ligthShadow = UIColor.lightGrayColor;
    CGSize ligthShadowOffset = CGSizeMake(0.1, 1.1);
    CGFloat ligthShadowBlurRadius = 0;
    
    
    //// Subframes
    CGRect progressBar = CGRectMake(CGRectGetMinX(progressIndicatorFrame), CGRectGetMinY(progressIndicatorFrame), CGRectGetWidth(progressIndicatorFrame), 34);
    CGRect activePressFrame = CGRectMake(CGRectGetMinX(progressBar) + floor(CGRectGetWidth(progressBar) * 0.01869 + 0.5), CGRectGetMinY(progressBar) + 10, floor(CGRectGetWidth(progressBar) * 0.94393 + 0.5) - floor(CGRectGetWidth(progressBar) * 0.01869 + 0.5), 14);
    
    
    //// ProgressBar
    {
        //// Border Drawing
        CGRect borderRect = CGRectMake(CGRectGetMinX(progressBar) + floor(CGRectGetWidth(progressBar) * 0.00000 + 0.5), CGRectGetMinY(progressBar), floor(CGRectGetWidth(progressBar) * 1.00000 + 0.5) - floor(CGRectGetWidth(progressBar) * 0.00000 + 0.5), 34);
        UIBezierPath* borderPath = [UIBezierPath bezierPathWithRoundedRect: borderRect cornerRadius: 4];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, darkShadowOffset, darkShadowBlurRadius, [darkShadow CGColor]);
        CGContextBeginTransparencyLayer(context, NULL);
        [borderPath addClip];
        CGContextDrawLinearGradient(context, outerRectGradient,
                                    CGPointMake(CGRectGetMidX(borderRect), CGRectGetMinY(borderRect)),
                                    CGPointMake(CGRectGetMidX(borderRect), CGRectGetMaxY(borderRect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        
        ////// Border Inner Shadow
        CGContextSaveGState(context);
        UIRectClip(borderPath.bounds);
        CGContextSetShadowWithColor(context, CGSizeZero, 0, NULL);
        
        CGContextSetAlpha(context, CGColorGetAlpha([ligthShadow CGColor]));
        CGContextBeginTransparencyLayer(context, NULL);
        {
            UIColor* opaqueShadow = [ligthShadow colorWithAlphaComponent: 1];
            CGContextSetShadowWithColor(context, ligthShadowOffset, ligthShadowBlurRadius, [opaqueShadow CGColor]);
            CGContextSetBlendMode(context, kCGBlendModeSourceOut);
            CGContextBeginTransparencyLayer(context, NULL);
            
            [opaqueShadow setFill];
            [borderPath fill];
            
            CGContextEndTransparencyLayer(context);
        }
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
        
        
        
        //// ProgressTrack Drawing
        CGRect progressTrackRect = CGRectMake(CGRectGetMinX(progressBar) + floor(CGRectGetWidth(progressBar) * 0.01869 + 0.5), CGRectGetMinY(progressBar) + 10, floor(CGRectGetWidth(progressBar) * 0.94393 + 0.5) - floor(CGRectGetWidth(progressBar) * 0.01869 + 0.5), 14);
        UIBezierPath* progressTrackPath = [UIBezierPath bezierPathWithRoundedRect: progressTrackRect cornerRadius: 7];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, darkShadowOffset, darkShadowBlurRadius, [darkShadow CGColor]);
        CGContextBeginTransparencyLayer(context, NULL);
        [progressTrackPath addClip];
        CGContextDrawLinearGradient(context, gradient,
                                    CGPointMake(CGRectGetMidX(progressTrackRect), CGRectGetMinY(progressTrackRect)),
                                    CGPointMake(CGRectGetMidX(progressTrackRect), CGRectGetMaxY(progressTrackRect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        
        ////// ProgressTrack Inner Shadow
        CGContextSaveGState(context);
        UIRectClip(progressTrackPath.bounds);
        CGContextSetShadowWithColor(context, CGSizeZero, 0, NULL);
        
        CGContextSetAlpha(context, CGColorGetAlpha([ligthShadow CGColor]));
        CGContextBeginTransparencyLayer(context, NULL);
        {
            UIColor* opaqueShadow = [ligthShadow colorWithAlphaComponent: 1];
            CGContextSetShadowWithColor(context, ligthShadowOffset, ligthShadowBlurRadius, [opaqueShadow CGColor]);
            CGContextSetBlendMode(context, kCGBlendModeSourceOut);
            CGContextBeginTransparencyLayer(context, NULL);
            
            [opaqueShadow setFill];
            [progressTrackPath fill];
            
            CGContextEndTransparencyLayer(context);
        }
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
        
        
        
        //// ProgressActiveGroup
        {
            //// ProgressTrackActive Drawing
            UIBezierPath* progressTrackActivePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(activePressFrame) + 3, CGRectGetMinY(activePressFrame) + 3, floor((CGRectGetWidth(activePressFrame) - 3) * 0.99660 + 0.5), 10) byRoundingCorners: UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii: CGSizeMake(5, 5)];
            [progressTrackActivePath closePath];
            [UIColor.greenColor setFill];
            [progressTrackActivePath fill];
        }
    }
    
    
    //// Cleanup
    CGGradientRelease(outerRectGradient);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}


@end

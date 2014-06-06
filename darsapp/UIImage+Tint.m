//
//  UIImage+Tint.m
//  darsapp
//
//  Created by inf227al on 6/06/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "UIImage+Tint.h"

@implementation UIImage (ImageTint)

- (UIImage *)imageTintedWithColor:(UIColor *)color
{
    if (color) {
        // Construct new image the same size as this one.
        UIImage *image;
        UIGraphicsBeginImageContextWithOptions([self size], NO, 0.0); // 0.0 for scale means "scale for device's main screen".
        CGRect rect = CGRectZero;
        rect.size = [self size];
        
        // tint the image
        [self drawInRect:rect];
        [color set];
        UIRectFillUsingBlendMode(rect, kCGBlendModeMultiply);
        
        // restore alpha channel
        [self drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0f];
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    
    return self;
}
@end
//
//  KaleidoImageFactory.m
//  VideoThing
//
//  Created by Ostap Horbach on 7/21/15.
//  Copyright (c) 2015 Ostap Horbach. All rights reserved.
//

#import "KaleidoImageFactory.h"

@implementation KaleidoImageFactory

+ (CIImage *)kaleidoImageFromImage:(CIImage *)image withRect:(CGRect)rect
{
    CIImage *kaleidoImageFromImage;
    
//    CGFloat scale = self.window.screen.scale;
//    CGRect destRect = CGRectApplyAffineTransform(self.bounds, CGAffineTransformMakeScale(scale, scale));
    
    EAGLContext *eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    CIContext *coreImageContext = [CIContext contextWithEAGLContext:eaglContext];
    
    CGRect firstRect = rect;
    firstRect.size.width /= 2;
    firstRect.size.height /= 2;
    
    CGRect secondRect = firstRect;
    secondRect.origin.x = firstRect.size.width;
    secondRect.origin.y = firstRect.size.height;
    
    CGRect thirdRect = secondRect;
    thirdRect.origin.x = firstRect.origin.x;
    
    CGRect fourthRect = secondRect;
    fourthRect.origin.y = firstRect.origin.y;
    
    CIImage *firstImage = [image imageByApplyingTransform:CGAffineTransformTranslate(CGAffineTransformMakeScale(1, -1), 0, image.extent.size.height)];
    CIImage *secondImage = [image imageByApplyingTransform:CGAffineTransformTranslate(CGAffineTransformMakeScale(-1, 1), -image.extent.size.width, 0)];
    CIImage *thirdImage = image;
    CIImage *fourthImage = [image imageByApplyingTransform:CGAffineTransformTranslate(CGAffineTransformMakeScale(-1, -1), -image.extent.size.width, image.extent.size.height)];
    
    [coreImageContext drawImage:firstImage inRect:firstRect fromRect:image.extent];
    [coreImageContext drawImage:secondImage inRect:secondRect fromRect:image.extent];
    [coreImageContext drawImage:thirdImage inRect:thirdRect fromRect:image.extent];
    [coreImageContext drawImage:fourthImage inRect:fourthRect fromRect:image.extent];
    
//    [coreImageContext createCGImage:<#(CIImage *)#> fromRect:<#(CGRect)#>]
    
    return kaleidoImageFromImage;
}

@end

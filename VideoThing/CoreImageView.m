//
//  CoreImageView.m
//  VideoThing
//
//  Created by Ostap Horbach on 7/20/15.
//  Copyright (c) 2015 Ostap Horbach. All rights reserved.
//

#import "CoreImageView.h"

@interface CoreImageView ()

@property (nonatomic, strong) CIContext *coreImageContext;

@end

@implementation CoreImageView

- (id)initWithFrame:(CGRect)frame
{
    EAGLContext *eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    return [self initWithFrame:frame context:eaglContext];
}

- (id)initWithFrame:(CGRect)frame context:(EAGLContext *)context
{
    self = [super initWithFrame:frame context:context];
    if (self) {
        _coreImageContext = [CIContext contextWithEAGLContext:context];
        self.enableSetNeedsDisplay = NO;
    }
    return self;
}

- (void)awakeFromNib
{
    EAGLContext *eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    self.context = eaglContext;
    self.coreImageContext = [CIContext contextWithEAGLContext:eaglContext];
    self.enableSetNeedsDisplay = NO;
}

- (void)drawRect:(CGRect)rect
{
    if (self.image) {
        CGFloat scale = self.window.screen.scale;
        CGRect destRect = CGRectApplyAffineTransform(self.bounds, CGAffineTransformMakeScale(scale, scale));
        CGRect firstRect = destRect;
        firstRect.size.width /= 2;
        firstRect.size.height /= 2;
        
        CGRect secondRect = firstRect;
        secondRect.origin.x = firstRect.size.width;
        secondRect.origin.y = firstRect.size.height;
        
        CGRect thirdRect = secondRect;
        thirdRect.origin.x = firstRect.origin.x;
        
        CGRect fourthRect = secondRect;
        fourthRect.origin.y = firstRect.origin.y;
        
        CIImage *firstImage = [self.image imageByApplyingTransform:CGAffineTransformTranslate(CGAffineTransformMakeScale(1, -1), 0, self.image.extent.size.height)];
        CIImage *secondImage = [self.image imageByApplyingTransform:CGAffineTransformTranslate(CGAffineTransformMakeScale(-1, 1), -self.image.extent.size.width, 0)];
        CIImage *thirdImage = self.image;
        CIImage *fourthImage = [self.image imageByApplyingTransform:CGAffineTransformTranslate(CGAffineTransformMakeScale(-1, -1), -self.image.extent.size.width, self.image.extent.size.height)];

        
        [self.coreImageContext drawImage:firstImage inRect:firstRect fromRect:self.image.extent];
        [self.coreImageContext drawImage:secondImage inRect:secondRect fromRect:self.image.extent];
        [self.coreImageContext drawImage:thirdImage inRect:thirdRect fromRect:self.image.extent];
        [self.coreImageContext drawImage:fourthImage inRect:fourthRect fromRect:self.image.extent];
    }
}

- (void)setImage:(CIImage *)image
{
    _image = image;
    [self display];
}

@end

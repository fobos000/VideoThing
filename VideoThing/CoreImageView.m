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

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        EAGLContext *eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        self.coreImageContext = [CIContext contextWithEAGLContext:eaglContext];
        self.enableSetNeedsDisplay = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if (self.image) {
        CGFloat scale = self.window.screen.scale;
        CGRect destRect = CGRectApplyAffineTransform(self.bounds, CGAffineTransformMakeScale(scale, scale));
        [self.coreImageContext drawImage:self.image inRect:destRect fromRect:self.image.extent];
    }
}

- (void)setImage:(CIImage *)image
{
    _image = image;
    [self display];
}

@end

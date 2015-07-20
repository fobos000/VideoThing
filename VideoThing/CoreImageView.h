//
//  CoreImageView.h
//  VideoThing
//
//  Created by Ostap Horbach on 7/20/15.
//  Copyright (c) 2015 Ostap Horbach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>
#import <GLKit/GLKit.h>

@interface CoreImageView : GLKView

@property (nonatomic, strong) CIImage *image;

@end

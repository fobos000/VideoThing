//
//  KaleidoImageFactory.h
//  VideoThing
//
//  Created by Ostap Horbach on 7/21/15.
//  Copyright (c) 2015 Ostap Horbach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>

@interface KaleidoImageFactory : NSObject

+ (CIImage *)kaleidoImageFromImage:(CIImage *)image withRect:(CGRect)rect;

@end

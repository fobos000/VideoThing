//
//  CameraBufferSource.h
//  VideoThing
//
//  Created by Ostap Horbach on 7/20/15.
//  Copyright (c) 2015 Ostap Horbach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface CameraBufferSource : NSObject

@property (nonatomic) BOOL running;
@property (nonatomic, copy) void (^callback)(CMSampleBufferRef buffer);

@end

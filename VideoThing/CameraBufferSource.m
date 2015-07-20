//
//  CameraBufferSource.m
//  VideoThing
//
//  Created by Ostap Horbach on 7/20/15.
//  Copyright (c) 2015 Ostap Horbach. All rights reserved.
//

#import "CameraBufferSource.h"

@interface CameraBufferSource () <AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) AVCaptureSession *captureSession;

@end

@implementation CameraBufferSource

- (id)init
{
    self = [super init];
    if (self) {
        _captureSession = [[AVCaptureSession alloc] init];
        
        NSError *error;
        AVCaptureDeviceInput *deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self backCameraIfAvailable] error:&error];
        if (error) {
            return nil;
        }
        
        if ([_captureSession canAddInput:deviceInput]) {
            [_captureSession addInput:deviceInput];
            AVCaptureVideoDataOutput *dataOutput = [[AVCaptureVideoDataOutput alloc] init];
            [dataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
            [_captureSession addOutput:dataOutput];
            [_captureSession commitConfiguration];
        }
    }
    return self;
}

- (AVCaptureDevice *)backCameraIfAvailable
{
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice *captureDevice = nil;
    for (AVCaptureDevice *device in videoDevices) {
        if (device.position == AVCaptureDevicePositionBack) {
            captureDevice = device;
            break;
        }
    }
    return captureDevice;
}

- (void)setRunning:(BOOL)running
{
    _running = running;
    if (running) {
        [self.captureSession startRunning];
    } else {
        [self.captureSession stopRunning];
    }
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    if (self.callback) {
        self.callback(sampleBuffer);
    }
}

@end

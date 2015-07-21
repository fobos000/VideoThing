//
//  ViewController.m
//  VideoThing
//
//  Created by Ostap Horbach on 7/20/15.
//  Copyright (c) 2015 Ostap Horbach. All rights reserved.
//

#import "ViewController.h"
#import "CameraBufferSource.h"
#import "CoreImageView.h"
#import "KaleidoImageFactory.h"

@interface ViewController ()

@property (nonatomic, strong) CameraBufferSource *cameraBufferSource;
@property (nonatomic, strong) IBOutlet CoreImageView *outputView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    self.cameraBufferSource = [[CameraBufferSource alloc] init];
    
    __weak ViewController *weakSelf = self;
    self.cameraBufferSource.callback = ^(CMSampleBufferRef buffer) {
        CIImage *image = [CIImage imageWithCVPixelBuffer:CMSampleBufferGetImageBuffer(buffer)];
        image = [image imageByApplyingTransform:CGAffineTransformMakeRotation(-M_PI_2)];
        weakSelf.outputView.image = image;
    };
    self.cameraBufferSource.running = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapRecognized:(UITapGestureRecognizer *)sender {
    UIImage *snapshot = self.outputView.snapshot;
    
    UIImageWriteToSavedPhotosAlbum(snapshot,
                                   nil,
                                   nil,
                                   nil);
}

- (void)didSaveImage
{
    
}

@end

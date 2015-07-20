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

@interface ViewController ()

@property (nonatomic, strong) CameraBufferSource *cameraBufferSource;
@property (strong, nonatomic) IBOutlet CoreImageView *outputView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    self.cameraBufferSource = [[CameraBufferSource alloc] init];
    
    __weak ViewController *weakSelf = self;
    self.cameraBufferSource.callback = ^(CMSampleBufferRef buffer){
        CIImage *image = [CIImage imageWithCVPixelBuffer:CMSampleBufferGetImageBuffer(buffer)];
        weakSelf.outputView.image = image;
    };
    self.cameraBufferSource.running = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  FirstViewController.m
//  Test
//
//  Created by Killua Liu on 4/16/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.resumeButton.enabled = NO;
    self.cancelButton.enabled = NO;
    
    [self addObserver:self forKeyPath:@"resumeData" options:NSKeyValueObservingOptionNew context:NULL];
    [self addObserver:self forKeyPath:@"downloadTask" options:NSKeyValueObservingOptionNew context:NULL];
    
    NSURL *url = [NSURL URLWithString:@"http://cdn.tutsplus.com/mobile/uploads/2013/12/sample.jpg"];
    self.downloadTask = [self.session downloadTaskWithURL:url];
    [self.downloadTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSURLSession *)session
{
    if (!_session) {
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    }
    return _session;
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSData *data = [NSData dataWithContentsOfURL:location];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.cancelButton.enabled = NO;
        self.progressView.hidden = YES;
        self.imageView.image = [UIImage imageWithData:data];
    });
    
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtURL:location error:&error];
    if (error) {
        NSLog(@"%@", error.userInfo);
    }
    
    [session finishTasksAndInvalidate];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    float progress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressView.progress = progress;
    });
}

- (IBAction)resume:(id)sender {
    if (!_resumeData) return;
    
    self.resumeButton.enabled = NO;
    self.downloadTask = [_session downloadTaskWithResumeData:_resumeData];
    [self.downloadTask resume];
    self.resumeData = nil;
}

- (IBAction)cancel:(id)sender {
    if (!_downloadTask) return;
    
    self.cancelButton.enabled = NO;
    
    [self.downloadTask cancelByProducingResumeData:^(NSData *resumeData) {
        if (!resumeData) return;
        self.resumeData = resumeData;
        self.downloadTask = nil;
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"resumeData"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.resumeButton.enabled = (_resumeData != nil);
        });
    } else if ([keyPath isEqualToString:@"downloadTask"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.cancelButton.enabled = (_downloadTask != nil);
        });
    }
}

@end

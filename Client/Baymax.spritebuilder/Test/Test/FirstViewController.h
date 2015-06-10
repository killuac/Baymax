//
//  FirstViewController.h
//  Test
//
//  Created by Killua Liu on 4/16/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <NSURLSessionDelegate, NSURLSessionDownloadDelegate>

@property (strong, nonatomic) NSURLSessionDownloadTask *downloadTask;
@property (strong, nonatomic) NSData *resumeData;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *resumeButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;

- (IBAction)resume:(id)sender;
- (IBAction)cancel:(id)sender;

@end


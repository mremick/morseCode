//
//  torchController.h
//  morseCode
//
//  Created by Matt Remick on 1/21/14.
//  Copyright (c) 2014 Matt Remick. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol torchDelegate <NSObject>

- (void)letterHasChanged:(int)index;
- (void)progressHudStatus:(CGFloat)progress;

@end

@import AVFoundation;

@interface torchController : NSObject


- (void)turnOnFlash:(AVCaptureDevice *)device;
- (void)turnOffFlash:(AVCaptureDevice *)device;
- (void)turnStringIntoTorch:(NSArray *)array;
- (void)cancelAllBackgroundOperations;

@property (unsafe_unretained) id <torchDelegate> delegate; 

@end

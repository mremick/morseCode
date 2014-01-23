//
//  torchController.m
//  morseCode
//
//  Created by Matt Remick on 1/21/14.
//  Copyright (c) 2014 Matt Remick. All rights reserved.
//

#import "torchController.h"

@import AVFoundation;

#define DOT_PAUSE .1
#define DASH_PAUSE .3
#define SYMBOL_PAUSE .1
#define WORD_PAUSE .5

@interface torchController()

@property (strong,nonatomic) NSOperationQueue *backgroundQueue;
@property (strong,nonatomic) AVCaptureDevice *captureDevice;


@end


@implementation torchController

- (void)turnOnFlash:(AVCaptureDevice *)device
{
    [device lockForConfiguration:nil];
    [device setTorchMode:AVCaptureTorchModeOn];
    [device setFlashMode:AVCaptureFlashModeOn];
}

- (void)turnOffFlash:(AVCaptureDevice *)device
{
    [device lockForConfiguration:nil];
    [device setTorchMode:AVCaptureTorchModeOff];
    [device setFlashMode:AVCaptureFlashModeOn];
}

- (void)flash:(NSMutableArray *)array
{
    
    __block int i = 0;
    __block CGFloat hudProgress = 0;
    
    //method to return a letter
    //self.letterLabel.text = [self.slicedText objectAtIndex:i];
    
    
    self.backgroundQueue = [[NSOperationQueue alloc] init];
    [self.backgroundQueue setMaxConcurrentOperationCount:1];
    
    
    [self.delegate letterHasChanged:i];
    
    for (NSString *symbol in array) {
        
        if ([symbol isEqualToString:@"."]) {
            
            [self.backgroundQueue addOperationWithBlock:^{
                [self turnOnFlash:self.captureDevice];
                usleep(1000000);
                [self turnOffFlash:self.captureDevice];
                usleep(1000000);
                NSLog(@"SYMBOL:%@",symbol);
                hudProgress ++;
                [self.delegate progressHudStatus:hudProgress/array.count];
            }];
            
            
        }
        
        else if ([symbol isEqualToString:@"-"]) {
            
            [self.backgroundQueue addOperationWithBlock:^{
                [self turnOnFlash:self.captureDevice];
                usleep(300000);
                [self turnOffFlash:self.captureDevice];
                usleep(300000);
                NSLog(@"SYMBOL:%@",symbol);
                hudProgress++;
                [self.delegate progressHudStatus:hudProgress/array.count];

            }];
            
            
        }
        
        else if ([symbol isEqualToString:@" "]) {
            
            [self.backgroundQueue addOperationWithBlock:^{
                [self turnOnFlash:self.captureDevice];
                usleep(100000);
                [self turnOffFlash:self.captureDevice];
                usleep(100000);
                NSLog(@"SYMBOL:%@",symbol);
                hudProgress++;
                [self.delegate progressHudStatus:hudProgress/array.count];

            }];
            
            
        }
        
        else if ([symbol isEqualToString:@"*"]) {
            
            [self.backgroundQueue addOperationWithBlock:^{
                [self turnOnFlash:self.captureDevice];
                usleep(500000);
                [self turnOffFlash:self.captureDevice];
                usleep(500000);
                NSLog(@"SYMBOL:%@",symbol);
                hudProgress++;
                [self.delegate progressHudStatus:hudProgress/array.count];

            }];
            
            
        }
        
        else if ([symbol isEqualToString:@"^"]) {
            
            [self.backgroundQueue addOperationWithBlock:^{
                [self turnOnFlash:self.captureDevice];
                usleep(100000);
                [self turnOffFlash:self.captureDevice];
                usleep(100000);
                i++;
                hudProgress++;
                [self.delegate progressHudStatus:hudProgress/array.count];

                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self.delegate letterHasChanged:i];
                }];
                
                
                
                
                
                NSLog(@"I:%d",i);
                NSLog(@"SYMBOL:%@",symbol);
                
                
            }];
            
            
        }
        
        
    }
    
}

- (void)turnStringIntoTorch:(NSArray *)array
{
    
    NSLog(@"turn string into torch was called");
    
    self.captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

    
    if ([self.captureDevice hasFlash] && [self.captureDevice hasTorch]) {
        NSMutableArray *eachCharacter = [NSMutableArray new];
        
        for (NSString *letter in array) {
            
            for (int i = 0; i < letter.length; i++) {
                NSString *character = [letter substringWithRange:NSMakeRange(i, 1)];
                [eachCharacter addObject:character];
                
            }
        }
        
        
        
        NSLog(@"EACH CHARACTER: %@",eachCharacter);
        
        //[torch turnOnFlash:captureDevice];
        
        [self flash:eachCharacter];
        
    }
}

- (void)cancelAllBackgroundOperations
{
    //needs to be accessed from the view controller 
    [self.backgroundQueue cancelAllOperations];
}



@end

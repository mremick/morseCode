//
//  ReceiveViewController.h
//  morseCode
//
//  Created by Matt Remick on 1/25/14.
//  Copyright (c) 2014 Matt Remick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFMagicEvents.h"

@interface ReceiveViewController : UIViewController

@property (strong, nonatomic) CFMagicEvents *cfMagicEvents;
@property (nonatomic) int lightSeen;
@property (nonatomic) int lightNotSeen; 

@end

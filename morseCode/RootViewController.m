//
//  RootViewController.m
//  morseCode
//
//  Created by Matt Remick on 1/26/14.
//  Copyright (c) 2014 Matt Remick. All rights reserved.
//

#import "RootViewController.h"
#import "circularButton.h"
#import <QuartzCore/QuartzCore.h>


@interface RootViewController ()
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIButton *receiveButton;
@property (weak, nonatomic) IBOutlet circularButton *button;

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    
    self.sendButton.layer.cornerRadius = 100;
    self.receiveButton.layer.cornerRadius = 100;
    
    //self.sendButton.layer.borderColor = [UIColor blueColor].CGColor;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ReceiveViewController.m
//  morseCode
//
//  Created by Matt Remick on 1/25/14.
//  Copyright (c) 2014 Matt Remick. All rights reserved.
//

#import "ReceiveViewController.h"
#import "CFMagicEvents.h"

@interface ReceiveViewController ()
@property (weak, nonatomic) IBOutlet UITextField *receiveTextField;
- (IBAction)startReceiving:(id)sender;
@property (strong,nonatomic) NSMutableArray *timeIntervals;

@end

@implementation ReceiveViewController

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
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveOnMagicEventDetected:) name:@"onMagicEventDetected" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveOnMagicEventNotDetected:) name:@"onMagicEventNotDetected" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)receiveOnMagicEventDetected:(NSNotification *) notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //YOUR CODE HERE
        [self turnIntToSymbol:self.lightSeen];
        self.lightSeen = 0;
        self.lightNotSeen++;
    });
}

-(void)receiveOnMagicEventNotDetected:(NSNotification *) notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //YOUR CODE HERE
        [self turnIntToSymbol:self.lightNotSeen];
        self.lightNotSeen = 0;
        self.lightSeen++;
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startReceiving:(id)sender {
    
    _cfMagicEvents  = [[CFMagicEvents alloc] init];
    [_cfMagicEvents startCapture];
    
    NSLog(@"start receiving selected");
}

- (void)turnIntToSymbol:(int)timeInterval{
    NSLog(@"interval:%d",timeInterval);
}
@end

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
@property (strong,nonatomic) NSMutableArray *symbolsArray;
@property (strong,nonatomic) NSString *symbolsTogether;

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
    self.symbolsArray = [NSMutableArray new];
    self.symbolsTogether = [NSString new];
    
    
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
        //NSLog(@"light seen interval:%d",self.lightSeen);
        [self turnIntToSymbolForLight:self.lightSeen];
        self.lightSeen = 0;
        [self turnIntToSymbolForDrkness:self.lightNotSeen];

        self.lightNotSeen++;
    });
}

-(void)receiveOnMagicEventNotDetected:(NSNotification *) notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //YOUR CODE HERE
        //NSLog(@"light not seen interval:%d",self.lightNotSeen);
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

- (void)turnIntToSymbolForLight:(int)timeInterval{
    //NSLog(@"light interval:%d",timeInterval);
    //NSLog(@"light interval: %d",timeInterval);
    if (timeInterval > 2 && timeInterval <= 8) {
        NSLog(@".");
        if ([self.symbolsTogether length] == 0) {
            self.symbolsTogether = @".";
        }
        
        else {
            [self.symbolsTogether stringByAppendingString:@"."];
        }
    }
    
    else if (timeInterval >= 9) {
        NSLog(@"-");
        if ([self.symbolsTogether length] == 0) {
            self.symbolsTogether = @"-";
        }
        
        else {
            [self.symbolsTogether stringByAppendingString:@"-"];

        }

    }
}

- (void)turnIntToSymbolForDrkness:(int)timeInterval{
    //NSLog(@"darkness interval interval:%d",timeInterval);
    
    if (timeInterval > 4 && timeInterval <= 50) {
        NSLog(@" ");
        [self.symbolsArray addObject:self.symbolsTogether];
        [self.symbolsArray addObject:@" "];
        self.symbolsTogether = nil;
        self.symbolsTogether = [NSString new];
    }
    
    else if (timeInterval == 50) {
        [_cfMagicEvents stopCapture];
        NSLog(@"ARRAY: %@",self.symbolsArray);
    }
    
    
}
@end

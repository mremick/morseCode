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
@property (weak, nonatomic) IBOutlet UIButton *receiveButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (nonatomic) BOOL animate; 

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
    
    self.receiveButton.layer.cornerRadius = 60;
    self.cancelButton.layer.cornerRadius = 60;
    
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
        
        [self checkForEnd:self.lightNotSeen];
        
        if (self.lightSeen) {
            [self turnIntToSymbolForLight:self.lightSeen];
            
        }
        
        self.lightSeen = 0;
        
        
        self.lightNotSeen++;
        //YOUR CODE HERE
        
    });
}

-(void)receiveOnMagicEventNotDetected:(NSNotification *) notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //YOUR CODE HERE
        //NSLog(@"light not seen interval:%d",self.lightNotSeen);
        //NSLog(@"light not seen");
        //NSLog(@"light NOT seen interval:%d",self.lightNotSeen);
        //NSLog(@"see light method");
        
        if (self.lightNotSeen) {
            [self turnIntToSymbolForDrkness:self.lightNotSeen];
            
        }
        
        
        //NSLog(@"light seen");
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
    [self rotateLabelDown];
    self.animate = YES;
}

- (void)turnIntToSymbolForLight:(int)timeInterval{
    //NSLog(@"light interval:%d",timeInterval);
   // NSLog(@"light interval: %d",timeInterval);
    if (timeInterval > 1 && timeInterval <= 4) {
        NSLog(@".");
        if ([self.symbolsTogether length] == 0) {
            self.symbolsTogether = @".";
        }
        
        else {
            [self.symbolsTogether stringByAppendingString:@"."];
        }
    }
    
    else if (timeInterval >= 5 && timeInterval <=9) {
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
    
    if (timeInterval > 5 && timeInterval <= 50) {
        NSLog(@" ");
        [self.symbolsArray addObject:self.symbolsTogether];
        [self.symbolsArray addObject:@" "];
        self.symbolsTogether = nil;
        self.symbolsTogether = [NSString new];
    }
    
    
    
    
}

- (void)checkForEnd:(int)darknessTime
{
    
    if (darknessTime > 100) {
        [_cfMagicEvents stopCapture];
        NSLog(@"ARRAY: %@",self.symbolsArray);
        self.animate = NO;
    }
}

-(void)rotateLabelDown
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.receiveButton.transform = CGAffineTransformMakeRotation(M_PI);
                     }
                     completion:^(BOOL finished){
                         [self rotateLabelUp];
                     }];
}

-(void)rotateLabelUp
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.receiveButton.transform = CGAffineTransformMakeRotation(0);
                     }
                     completion:^(BOOL finished){
                         
                         if (self.animate) {
                             [self rotateLabelDown];
                         }
                     }];
}
@end

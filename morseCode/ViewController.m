//
//  ViewController.m
//  morseCode
//
//  Created by Matt Remick on 1/20/14.
//  Copyright (c) 2014 Matt Remick. All rights reserved.
//

#import "ViewController.h"
#import "NSString+morseCode.h"
#import "torchController.h"
#import <M13ProgressSuite/M13ProgressViewRing.h>

@import AVFoundation;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (strong,nonatomic) NSMutableArray *slicedText;
- (IBAction)cancel:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *letterLabel;
- (IBAction)send:(id)sender;

@property (strong,nonatomic) M13ProgressViewRing *progressHud;

@property (strong,nonatomic) torchController *torch;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.textField.delegate = self;
    
    self.sendButton.layer.cornerRadius = 60;
    self.cancelButton.layer.cornerRadius = 60;
    
    [self.torch allocInitBackgroundQueue];
    
}

- (void)letterHasChanged:(int)index
{
    self.letterLabel.text = [self.slicedText objectAtIndex:index];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)send:(id)sender
{
    self.progressHud = [[M13ProgressViewRing alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 50, self.view.bounds.size.height/2 - 100, 100,100)];
    [self.progressHud setProgress:0.0 animated:YES];
    
    
    [self.view addSubview:self.progressHud];
    
    
    [self sliceText:self.textField.text];
    //NSLog(@"%@",[self.textField.text symbolsForString]);
    
    self.torch = [[torchController alloc] init];
    self.torch.delegate = self; 
    
    
    [self.torch turnStringIntoTorch:[self.textField.text symbolsForString]];
    
    self.textField.text = @"";
        
    [self.textField resignFirstResponder];

}

- (void)sliceText:(NSString *)text
{
    self.slicedText = [NSMutableArray new];
    
    for (int i = 0; i < text.length; i++) {
        NSString *character = [text substringWithRange:NSMakeRange(i, 1)];
        [self.slicedText addObject:character];
        
    }
    
    NSLog(@"SLICED TEXT:%@",self.slicedText);
}

- (void)progressHudStatus:(CGFloat)progress
{
    NSLog(@"PROGRESS:%f",progress);
    
    [self.progressHud setProgress:progress animated:YES];
    
    if (progress == 1.000000) {
        [self.progressHud setHidden:YES];
        [self performSelector:@selector(clearText) withObject:nil afterDelay:0.5];
        
    }
}


- (void)clearText
{
    self.letterLabel.text = @"";
    NSLog(@"TEXT SHOULD BE CLEAR");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];
    
    return YES;
}


- (IBAction)cancel:(id)sender {
    
    [self.torch cancelAllBackgroundOperations];
    self.textField.text = @"";
    self.letterLabel.text = @"";
}
@end

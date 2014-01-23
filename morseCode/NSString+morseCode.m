//
//  NSString+morseCode.m
//  morseCode
//
//  Created by Matt Remick on 1/20/14.
//  Copyright (c) 2014 Matt Remick. All rights reserved.
//

#import "NSString+morseCode.h"

@implementation NSString (morseCode)

- (NSArray *)symbolsForString
{
    NSMutableArray *tempArray = [NSMutableArray new];
    
    NSString *noSpaces = [self stringByReplacingOccurrencesOfString:@" " withString:@"*"];
    
    
    
    for (int i = 0; i < noSpaces.length; i++) {
            
        [tempArray addObject:[self symbolForLetter:[noSpaces substringWithRange:NSMakeRange(i, 1)]]];
        [tempArray addObject:@"^"];
            
    }
    
    [tempArray removeObjectAtIndex:[tempArray count] - 1]; 
    return [NSArray arrayWithArray:tempArray];
    
}

- (NSString *)symbolForLetter:(NSString *)letter
{
    
    NSString *symbol = nil;
        
    NSDictionary *symbolsDictionary = [[NSDictionary alloc] initWithObjects:@[@". -",@"- . . .",@"- . - .",@"- . .",@".",@". . -.",@"- - .",@"- - .",@". .",@". - - -",@"- . -",@". - . .",@"- -",@"- .",@"- - -",@". - - .",@"- - . -",@". - .",@". . .",@"-",@". . -",@". . . -",@". - -",@"- . . -",@"- . - -",@"- - . .",@"*",@"^"] forKeys:@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"*",@"^"]];
        
        
        
    letter = [letter uppercaseString];
        
        
        
    symbol = [symbolsDictionary objectForKey:letter];
    
    
        
    if (!symbol) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"An unallowed character has been found"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
        [alert show];
        return @"";

    }
    
    else {
        return symbol;
    }
        
    //NSLog(@"SYMBOL:%@",symbol);
    
    

    
}




@end

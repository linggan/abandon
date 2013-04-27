//
//  rootViewController.m
//  abandonDraft
//
//  Created by Gwendolyn Weston on 4/10/13.
//  Copyright (c) 2013 Coefficient Zero. All rights reserved.
//

#import "rootViewController.h"

@implementation rootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getRecordView:(id)sender {
    [self callNewScreen:@"record"];
}

- (IBAction)getReviewView:(id)sender {
    [self callNewScreen:@"review"];
}

- (IBAction)getPracticeView:(id)sender {
    [self callNewScreen:@"practice"];
}

-(void)callNewScreen: (NSString *)screenName{
    [[self delegate] callNewScreen:screenName];
}

@end

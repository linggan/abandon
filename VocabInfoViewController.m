//
//  VocabInfoViewController.m
//  abandonDraft
//
//  Created by Gwendolyn Weston on 4/28/13.
//  Copyright (c) 2013 Coefficient Zero. All rights reserved.
//

#import "VocabInfoViewController.h"

@interface VocabInfoViewController ()

@end

@implementation VocabInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)SetHanzi:(NSString *)hanzi andPinyin: (NSString *)pinyin andEnglish:(NSString *)english{
    [[self hanzi] setText:hanzi];
    [[self pinyin] setText:pinyin];
    [[self english] setText:english];
}

- (IBAction)didSelectDone:(id)sender {
    [self.delegate didDismissPresentedViewController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

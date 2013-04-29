//
//  ReviewGridViewController.m
//  abandonDraft
//
//  Created by Gwendolyn Weston on 4/26/13.
//  Copyright (c) 2013 Coefficient Zero. All rights reserved.
//

#import "ReviewGridViewController.h"
#import "MGScrollView.h"
#import "CharacterGridBox.h"
#import "VocabExportViewController.h"
#import "VocabInfoViewController.h"

@implementation ReviewGridViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getWords:self];
    
    MGScrollView *scroller = [MGScrollView scrollerWithSize:self.view.bounds.size];
    [self.view addSubview:scroller];
    [scroller setDelegate:self];
    
    MGBox *grid = [MGBox boxWithSize:self.view.bounds.size];
    grid.contentLayoutMode = MGLayoutGridStyle;
    [scroller.boxes addObject:grid];
    
    UIButton *MakeNewVocabList = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [MakeNewVocabList setFrame:CGRectMake(0, 0, 320, 44)];
    [MakeNewVocabList setTitle:@"export new vocab list" forState:UIControlStateNormal];
    [MakeNewVocabList addTarget:self action:@selector(exportVocabList) forControlEvents:UIControlEventTouchDown];
    CharacterGridBox *buttonBox01 = [[CharacterGridBox alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [buttonBox01 addSubview:MakeNewVocabList];
    [[grid boxes] addObject:buttonBox01];
    
            
    for (id word in _wordList){
        NSString *hanzi = [word valueForKey:@"chinese"];
        CharacterGridBox *wordTile = [[CharacterGridBox alloc]initWithFrame: CGRectMake(0, 0, 44*(hanzi.length), 44)AndCharacter:hanzi];
        [[grid boxes] addObject:wordTile];
        
        wordTile.onTap = ^{
             VocabInfoViewController *viewController = [[VocabInfoViewController alloc]init];
            //[viewController SetHanzi:hanzi andPinyin:[word valueForKey:@"pinyin"] andEnglish:[word valueForKey:@"english"]];
             viewController.delegate = self;
             viewController.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
             [self presentViewController:viewController animated:YES completion:NULL];
             
        };

    }
    
    [grid layoutWithSpeed:0.3 completion:nil];
    [scroller layoutWithSpeed:0.3 completion:nil];
    [scroller scrollToView:grid withMargin:10];
}

-(void)getWords:(id)ViewController{
    [[self dataDelegate] getWords:self];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [(id)scrollView snapToNearestBox];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [(id)scrollView snapToNearestBox];
    }
}

-(void)exportVocabList{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"New Vocab List!" message:@"Give it a nice name, yeah?" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeAlphabet;
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    VocabExportViewController *viewController = [[VocabExportViewController alloc]init];
    viewController.delegate = self;
    viewController.dataDelegate = self.dataDelegate;
    
    [viewController setVocabListName:[[alertView textFieldAtIndex:0] text]];
    viewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:viewController animated:YES completion:NULL];

}

- (void)didDismissPresentedViewController
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end

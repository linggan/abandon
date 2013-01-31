//
//  testViewController.h
//  abandonDraft
//
//  Created by Gwendolyn Weston on 1/20/13.
//  Copyright (c) 2013 Coefficient Zero. All rights reserved.
//

#import <UIKit/UIKit.h>

//figure out how to test input: ask user to configure in chinese keyboard

@interface testViewController : UIViewController{
    NSArray *wordList;
}

@property (weak, nonatomic) IBOutlet UILabel *chineseWord;
@property (weak, nonatomic) IBOutlet UITextField *pinyinInput;
@property (weak, nonatomic) IBOutlet UITextField *wordInput;


@end

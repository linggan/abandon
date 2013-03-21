//
//  recordViewController.h
//  abandonDraft
//
//  Created by Gwendolyn Weston on 1/20/13.
//  Copyright (c) 2013 Coefficient Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol recordViewControllerDelegate;

@interface recordViewController : UIViewController
<AVAudioRecorderDelegate, AVAudioRecorderDelegate>

@property (retain, nonatomic) AVAudioRecorder *audioRecorder;
@property (retain, nonatomic) NSArray *wordList;
@property int timesPressed;
@property int currentIndex;
@property BOOL recording;


@property (weak, nonatomic) IBOutlet UILabel *CurrentWord;
@property (weak, nonatomic) IBOutlet UILabel *Chinese;
@property (weak, nonatomic) IBOutlet UILabel *English;
@property (weak, nonatomic) IBOutlet UILabel *finished;
@property (nonatomic, assign) id<recordViewControllerDelegate> delegate;

- (IBAction)Record:(id)sender;
@end

@protocol recordViewControllerDelegate <NSObject>
-(void)getWordsFromQueue:(recordViewController*)recordViewController;
-(void)deleteWordFromQueue:(recordViewController*)recordViewController;
@end

//
//  recordViewController.h
//  abandonDraft
//
//  Created by Gwendolyn Weston on 1/20/13.
//  Copyright (c) 2013 Coefficient Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "coreDataDelegate.h"

@protocol recordViewControllerDelegate <NSObject>
-(void)deleteWordFromQueue:(NSString *)Word;
-(void)storeAAC:(NSString *)URL ForWord:(NSString *)Word InLanguage:(NSString *)Language;
@end

@interface recordViewController : UIViewController
<AVAudioRecorderDelegate>

@property (retain, nonatomic) AVAudioRecorder *recorder;
@property (retain, nonatomic) NSArray *wordList;
@property (nonatomic, retain) NSTimer* timer;

@property int timesPressed;
@property int currentIndex;

@property (weak, nonatomic) IBOutlet UILabel *Chinese;
@property (weak, nonatomic) IBOutlet UILabel *English;
@property (weak, nonatomic) IBOutlet UILabel *finished;
@property (weak, nonatomic) IBOutlet UILabel *duration;
@property (nonatomic, retain) IBOutlet UIButton* recordBtn;


@property (nonatomic, assign) id<coreDataDelegate, recordViewControllerDelegate> delegate;

- (IBAction)Record:(id)sender;
@end

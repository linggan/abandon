//
//  recordViewController.h
//  abandonDraft
//
//  Created by Gwendolyn Weston on 1/20/13.
//  Copyright (c) 2013 Coefficient Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

//i'll need to figure out how to queue and differentiate between recorded and unrecorded objects
//pass in array of data objects

//****GET QUEUE OF UNRECORDED WORDS FROM DELEGATE
//****IMPLEMENT DELEGATE METHOD TO DELETE WORDS FROM QUEUE

@interface recordViewController : UIViewController
<AVAudioRecorderDelegate, AVAudioPlayerDelegate> {
    AVAudioRecorder *audioRecorder;
    NSArray *wordList;
}

@property (weak, nonatomic) IBOutlet UILabel *CurrentWord;
@property (weak, nonatomic) IBOutlet UILabel *Chinese;
@property (weak, nonatomic) IBOutlet UILabel *English;

- (IBAction)Record:(id)sender;
@end

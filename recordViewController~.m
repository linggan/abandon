//
//  recordViewController.m
//  abandonDraft
//
//  Created by Gwendolyn Weston on 1/20/13.
//  Copyright (c) 2013 Coefficient Zero. All rights reserved.
//
// lot of this code for recording was taken from stackoverflow:http://stackoverflow.com/questions/1010343/how-do-i-record-audio-on-iphone-with-avaudiorecorder/1011273#1011273
// also some from this repo on  github: https://github.com/rpplusplus/iOSMp3Recorder


#import "recordViewController.h"

#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]


@implementation recordViewController
@synthesize audioRecorder, wordList, CurrentWord, Chinese, English, timesPressed, currentIndex, finished, recording, duration;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTimesPressed:0];
    [self setCurrentIndex:0];
    [self getWordsFromQueue:self];
}

        
- (void)viewDidUnload {
}

//on first press, record chinese and bold pinyin. save record url in object
//on second press, record english and bold translation.  save record url in object
//on third press, stop recording and move onto next word
- (IBAction)Record:(id)sender {
    while(currentIndex<[wordList count]){
        
        recording = true;
        //settings for aac format
        NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
        [recordSetting setValue :[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
        [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
        [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
        
        NSError *err = nil;
        NSURL *url; 

        
        switch (timesPressed) {
            case '0':
                //file name
                url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.aac",DOCUMENTS_FOLDER,[[wordList objectAtIndex:currentIndex] valueForKey:@"chinese"]]];
                
                //initializing arecorder here instead of viewdidload because after init, can't change url where recorder writes to
                //so each time a separate file is recorded, must init a new recorder
                audioRecorder = [[ AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:&err];
                
                [audioRecorder setDelegate:self];
                [audioRecorder prepareToRecord];
                [CurrentWord setText:[[wordList objectAtIndex:currentIndex] valueForKey:@"chinese"]];
                [Chinese setText:[[wordList objectAtIndex:currentIndex] valueForKey:@"pinyin"]];
                [English setText:[[wordList objectAtIndex:currentIndex] valueForKey:@"english"]];
                
                [audioRecorder stop];  //stop recording the word from previous index
                [audioRecorder record];
                [English setFont:[UIFont fontWithName:@"Helvetica" size:16]];
                [Chinese setFont:[UIFont fontWithName:@"Helvetica Bold" size:16]];
                timesPressed++;
                break;
            case '1':
                url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@(eng).aac",DOCUMENTS_FOLDER,[[wordList objectAtIndex:currentIndex] valueForKey:@"chinese"]]];
                
                audioRecorder = [[ AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:&err];
                
                [audioRecorder stop];
                [audioRecorder record];
                [Chinese setFont:[UIFont fontWithName:@"Helvetica" size:16]];
                [English setFont:[UIFont fontWithName:@"Helvetica Bold" size:16]];
                timesPressed=0;
                [self deleteWordFromQueue:self];
                currentIndex++;
                break;
            default:
                break;
        }
    }
    recording = false;
    [finished setText:@"All done!"];
  
}


- (void) timerUpdate
{
    if (recording)
    {
        int m = audioRecorder.currentTime / 60;
        int s = ((int) audioRecorder.currentTime) % 60;
        int ss = (audioRecorder.currentTime - ((int) audioRecorder.currentTime)) * 100;
        
        duration.text = [NSString stringWithFormat:@"%.2d:%.2d %.2d", m, s, ss];
     }
}

-(void)getWordsFromQueue:(recordViewController*)recordViewController{
    [[self delegate] getWordsFromQueue:self];
    
}
-(void)deleteWordFromQueue:(recordViewController*)recordViewController{
    [[self delegate] deleteWordFromQueue:self];
    
}

@end
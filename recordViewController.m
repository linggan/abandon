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
@synthesize recorder, wordList, Chinese, English, timesPressed, currentIndex, finished, duration, timer, recordBtn;


- (void)viewDidLoad {
    [super viewDidLoad];
    //init audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryRecord error:&sessionError];
    [session setActive:YES error:nil];
    
    if(session == nil)
        NSLog(@"Error creating session: %@", [sessionError description]);
    else{
        [session setActive:YES error:nil];
    }
    [self setTimesPressed:0];
    [self setCurrentIndex:0];
    [self getWordsFromQueue:self];
    
    if ([wordList count]<1){
        [[[UIAlertView alloc]
          initWithTitle:@"No words"
          message:@"Heya.  Doesn't seem like you have any words to record."
          delegate:self
          cancelButtonTitle:@"Ok"
          otherButtonTitles: nil] show];
    }

}

        
- (void)viewDidUnload {
}

- (IBAction)Record:(id)sender{
    NSURL *url;
    NSString *URLString;    
    
    if (currentIndex<[wordList count]){
        //NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        //NSString *documentPath = [searchPaths objectAtIndex:0];
        
        NSString *hanzi = [[wordList objectAtIndex:currentIndex] valueForKey:@"chinese"];
        NSString *pinyin = [[wordList objectAtIndex:currentIndex] valueForKey:@"pinyin"];
        NSString *english = [[wordList objectAtIndex:currentIndex] valueForKey:@"english"];

        switch (timesPressed) {
            case 0:
                URLString = [[NSHomeDirectory() stringByAppendingString:@"/Documents/"] stringByAppendingString:[NSString stringWithFormat:@"%@.aac", hanzi]];
                //URLString = [documentPath stringByAppendingString:[NSString stringWithFormat:@"/%@.aac", hanzi]];
                url = [NSURL fileURLWithPath:URLString];
                [self storeAAC: URLString ForWord:hanzi InLanguage:@"Chinese"];
                
                //NSLog(@"%@",[NSString stringWithFormat:@"%@.aac", hanzi]);
                //NSLog(@"destinationString: %@", url);
                                
                [self initRecorderWithUrl:url];
                [recorder stop];  //stop recording the word from previous index
                [recorder record];
                timer = [NSTimer scheduledTimerWithTimeInterval:.01f
                                                         target:self
                                                       selector:@selector(timerUpdate)
                                                       userInfo:nil
                                                        repeats:YES];
                //[CurrentWord setText:hanzi];
                [English setFont:[UIFont fontWithName:@"Gill Sans" size:16]];
                [Chinese setFont:[UIFont fontWithName:@"Gill Sans" size:22]];
                [Chinese setText:[NSString stringWithFormat:@"%@\n%@",hanzi, pinyin]];
                [English setText:english];
                timesPressed++;
                [recordBtn setTitle:@"Chinese" forState:UIControlStateNormal];
                break;
            case 1:
                URLString = [[NSHomeDirectory() stringByAppendingString:@"/Documents/"] stringByAppendingString:[NSString stringWithFormat:@"%@(eng).aac", hanzi]];
                //URLString = [documentPath stringByAppendingString:[NSString stringWithFormat:@"/%@(eng).aac", hanzi]];
                url = [NSURL fileURLWithPath:URLString];
                [self storeAAC: URLString ForWord:hanzi InLanguage:@"English"];
                
                //NSLog(@"%@",[NSString stringWithFormat:@"%@(eng).aac", hanzi]);
                //NSLog(@"destinationString: %@", url);
                
                [self initRecorderWithUrl:url];
                [recorder stop];  //stop recording the word from previous index
                [recorder record];
                timer = [NSTimer scheduledTimerWithTimeInterval:.01f
                                                         target:self
                                                       selector:@selector(timerUpdate)
                                                       userInfo:nil
                                                        repeats:YES];
                [Chinese setFont:[UIFont fontWithName:@"Gill Sans" size:16]];
                [English setFont:[UIFont fontWithName:@"Gill Sans" size:22]];
                timesPressed=0;
                currentIndex++;
                [recordBtn setTitle:@"English" forState:UIControlStateNormal];
                [self deleteWordFromQueue:hanzi];
                break;
            default:
                break;
        }
    }
    
    else{
        [recorder stop];
        //[CurrentWord setText:@"all done!"];
        [Chinese setText:@"all done!"];
        [English setText:@"all done!"];
        [recordBtn setTitle:@"all done!" forState:UIControlStateNormal];
        
    }
}

-(void)initRecorderWithUrl:(NSURL *)url{
    NSDictionary *recordSetting =
    [[NSDictionary alloc] initWithObjectsAndKeys:
     [NSNumber numberWithFloat: 44100.0],                 AVSampleRateKey,
     [NSNumber numberWithInt: kAudioFormatMPEG4AAC], AVFormatIDKey,
     [NSNumber numberWithInt: 1],                         AVNumberOfChannelsKey,
     [NSNumber numberWithInt: AVAudioQualityMax],         AVEncoderAudioQualityKey,
     nil];
    
    NSError *err = nil;
    
    recorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:&err];
    [recorder setDelegate:self];
    [recorder prepareToRecord];
}


- (void) timerUpdate
{
    
    int m = recorder.currentTime / 60;
    int s = ((int) recorder.currentTime) % 60;
    
    duration.text = [NSString stringWithFormat:@"%.2d:%.2d", m, s];
}


-(void)getWordsFromQueue:(id)ViewController{
    [[self delegate] getWordsFromQueue:self];
    
}

-(void)deleteWordFromQueue:(NSString *)Word{
    [[self delegate] deleteWordFromQueue:Word];    
}

-(void)storeAAC:(NSString *)URLString
        ForWord:(NSString *)Word
     InLanguage:(NSString *)Language{
    [[self delegate] storeAAC:URLString ForWord:Word InLanguage:Language];
}


@end
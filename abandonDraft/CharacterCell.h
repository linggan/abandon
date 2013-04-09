//
//  CharacterCell.h
//  abandonDraft
//
//  Created by Gwendolyn Weston on 3/30/13.
//  Copyright (c) 2013 Coefficient Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface CharacterCell : UITableViewCell <AVAudioPlayerDelegate>
@property (copy, nonatomic) NSString *character;
@property (copy, nonatomic) NSString *pinyin;
@property (copy, nonatomic) NSString *english;
@property (copy, nonatomic) NSURL *recording;
@property (nonatomic, retain) UIButton *playButton;

-(void)playRecording:(id)selector;


@end

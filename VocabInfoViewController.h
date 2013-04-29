//
//  VocabInfoViewController.h
//  abandonDraft
//
//  Created by Gwendolyn Weston on 4/28/13.
//  Copyright (c) 2013 Coefficient Zero. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VocabExportViewControllerDelegate <NSObject>
- (void)didDismissPresentedViewController;
@end


@interface VocabInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *hanzi;
@property (weak, nonatomic) IBOutlet UILabel *pinyin;
@property (weak, nonatomic) IBOutlet UILabel *english;
@property (nonatomic, weak) id<VocabExportViewControllerDelegate> delegate;

-(void)SetHanzi: (NSString *)hanzi andPinyin: (NSString *)pinyin andEnglish:(NSString *)english;

- (IBAction)didSelectDone:(id)sender;

@end

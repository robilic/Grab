//
//  PreferencesWindowController.h
//  Grab
//
//  Created by Robert on 9/16/12.
//  Copyright (c) 2012 Robert. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const GRBFileNameStringKey;
extern NSString * const GRBFileSaveLocationKey;
extern NSString * const GRBFileTypeKey;

@interface PreferencesWindowController : NSWindowController {
	IBOutlet NSPopUpButton *screenShotFileTypePopUp;
	IBOutlet NSButton *browseSaveDirectory;
	NSTextField *screenShotFileNameFormat;
  NSTextField *fileSaveLocationLabel;
	// Don't forget the one for the destination folder
}

@property (nonatomic, retain) IBOutlet NSButton *screenShotFileTypePopUp;
@property (nonatomic, retain) IBOutlet NSTextField *screenShotFileNameFormat;
@property (nonatomic, retain) IBOutlet NSTextField *fileSaveLocationLabel;

- (IBAction)changeScreenShotFileType:(id)sender;
- (IBAction)changeScreenShotFileNameFormat:(id)sender;
- (IBAction)browseSaveLocation:(id)sender;

+ (NSURL *)preferenceWindowFileSavePath;
+ (void)setPreferenceWindowFileSavePath:(NSURL *) fileSavePathURL;
+ (NSString *)preferenceWindowFileNameString;
+ (void)setPreferenceWindowFileNameString:(NSString *) fileNameString;

@end

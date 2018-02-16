//
//  AppDelegate.m
//  Grab
//
//  Created by Robert on 8/31/12.
//  Copyright (c) 2012 Robert. All rights reserved.
//

#import "AppDelegate.h"
#import "PreferencesWindowController.h"

@implementation AppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
  
    // this will make the window the size of the whole screen
    [_window
     setFrame:[_window frameRectForContentRect:[[_window screen] frame]]
     display:YES
     animate:YES];
}

- (IBAction)showPreferencesWindow:(id)sender {
    if (!preferencesWindow) {
        preferencesWindow = [[PreferencesWindowController alloc] init];
    }
    
    NSLog(@"Showing preferences window");
    [preferencesWindow showWindow:self];
}

+ (void)initialize
{
	// create a dictionary
	NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];

	// pre-fill our defaults
  NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSURL *defaultFileSavePath = [paths objectAtIndex:0];
  NSData *saveLocationAsData = [NSKeyedArchiver archivedDataWithRootObject:defaultFileSavePath];
  
  [defaultValues setObject:saveLocationAsData forKey:GRBFileSaveLocationKey];
  [defaultValues setObject:@"GRAB-%m-%d-%y-%H%M%S" forKey:GRBFileNameStringKey];
  
	[[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
}

@end

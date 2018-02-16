//
//  PreferencesWindowController.m
//  Grab
//

#import "PreferencesWindowController.h"

NSString * const GRBFileNameStringKey = @"GRBFileNameString";
NSString * const GRBFileSaveLocationKey = @"GRBFileSaveLocation";
NSString * const GRBFileTypeKey = @"GRBFileType";

@interface PreferencesWindowController ()

@end

@implementation PreferencesWindowController

@synthesize screenShotFileNameFormat, fileSaveLocationLabel, screenShotFileTypePopUp;

- (id)init {
    self = [super initWithWindowNibName:@"PreferencesWindowController"];
    return self;
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
	[super windowDidLoad];
	
  [fileSaveLocationLabel setStringValue:[[PreferencesWindowController preferenceWindowFileSavePath] absoluteString]];
  [screenShotFileNameFormat setStringValue:[PreferencesWindowController preferenceWindowFileNameString]];
  [screenShotFileTypePopUp selectItemAtIndex:[[PreferencesWindowController preferenceWindowFileType] integerValue]];
	// Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

//  Actions

- (IBAction)changeScreenShotFileType:(id)sender {
  [PreferencesWindowController setPreferenceWindowFileType:[NSNumber numberWithLong:[sender indexOfSelectedItem]]];
}

- (IBAction)changeScreenShotFileNameFormat:(id)sender {
  [PreferencesWindowController setPreferenceWindowFileNameString:[screenShotFileNameFormat stringValue]];
}

- (IBAction)browseSaveLocation:(id)sender {
	NSURL *saveLocation;
  // Create a File Open Dialog class.
  NSOpenPanel *openDlg = [NSOpenPanel openPanel];
  
  // Enable options in the dialog.
  [openDlg setCanChooseFiles:NO];
	[openDlg setCanChooseDirectories:YES];
  [openDlg setAllowsMultipleSelection:FALSE];
	
  // Display the dialog box.  If the OK pressed,
  // process the files.
  if ( [openDlg runModal] == NSOKButton ) {
    saveLocation = [[openDlg URLs] objectAtIndex:0];
    
    [PreferencesWindowController setPreferenceWindowFileSavePath:saveLocation];
    [fileSaveLocationLabel setStringValue:[saveLocation absoluteString]];
    
    NSLog(@"Choice is %@", saveLocation);
  }
}

//  Setters and Getters

+ (NSURL *)preferenceWindowFileSavePath {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSData *fileSavePathAsData = [defaults objectForKey:GRBFileSaveLocationKey];
  return [NSKeyedUnarchiver unarchiveObjectWithData:fileSavePathAsData];
}

+ (void)setPreferenceWindowFileSavePath:(NSURL *) fileSavePathURL {
  NSData *fileSavePathAsData = [NSKeyedArchiver archivedDataWithRootObject:fileSavePathURL];
  [[NSUserDefaults standardUserDefaults] setValue:fileSavePathAsData forKey:GRBFileSaveLocationKey];
}

+ (NSString *)preferenceWindowFileNameString {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults valueForKey:GRBFileNameStringKey];
}

+ (void)setPreferenceWindowFileNameString:(NSString *) fileNameString {
  [[NSUserDefaults standardUserDefaults] setValue:fileNameString forKey:GRBFileNameStringKey];
}

+ (NSNumber *)preferenceWindowFileType {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  return [defaults valueForKey:GRBFileTypeKey];
}

+ (void)setPreferenceWindowFileType:(NSNumber *)selection {
  [[NSUserDefaults standardUserDefaults] setValue:selection forKey:GRBFileTypeKey];
}

// some kind of 'get file type' function that returns a kuTTypeXXX 

@end

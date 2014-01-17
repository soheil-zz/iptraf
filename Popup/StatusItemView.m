#import "StatusItemView.h"

@implementation StatusItemView

@synthesize statusItem = _statusItem;
@synthesize image = _image;
@synthesize alternateImage = _alternateImage;
@synthesize isHighlighted = _isHighlighted;
@synthesize action = _action;
@synthesize target = _target;

double val = 1.2;

NSTextField *text;

#pragma mark -

- (id)initWithStatusItem:(NSStatusItem *)statusItem
{
    CGFloat itemWidth = [statusItem length];
    CGFloat itemHeight = [[NSStatusBar systemStatusBar] thickness];
    NSRect itemRect = NSMakeRect(0.0, 0.0, itemWidth, itemHeight);
    self = [super initWithFrame:itemRect];
    
    if (self != nil) {
        _statusItem = statusItem;
        _statusItem.view = self;
    }

    text = [[NSTextField alloc] initWithFrame:NSMakeRect(0, -2.5, self.bounds.size.width+900, self.bounds.size.height)];
    //    text.backgroundColor = [NSColor clearColor];
    text.bezeled = NO;
    text.editable = NO;
    text.drawsBackground = NO;
    text.stringValue = @"1.2";
    [self addSubview:text];
    
    [NSTimer scheduledTimerWithTimeInterval:0.04
                                     target:self
                                   selector:@selector(moveText)
                                   userInfo:nil
                                    repeats:YES];
    
    return self;
}

- (void)moveText
{
//    val += .01;
    text.stringValue = [self runScript:@"ssh.sh"];
}

-(NSString *)runScript:(NSString*)scriptName
{
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/sh"];
    
    NSArray *arguments;
    NSString* newpath = [[NSBundle mainBundle] pathForResource:@"ssh" ofType:@"sh"];
    NSLog(@"shell script path: %@",newpath);
    arguments = [NSArray arrayWithObjects:newpath, nil];
    [task setArguments: arguments];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task launch];
    
    NSData *data;
    data = [file readDataToEndOfFile];
    
    NSString *string;
    string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
    return string;
}

#pragma mark -

- (void)drawRect:(NSRect)dirtyRect
{
//	[self.statusItem drawStatusBarBackgroundInRect:dirtyRect withHighlight:self.isHighlighted];
//    
//    NSImage *icon = self.isHighlighted ? self.alternateImage : self.image;
//    NSSize iconSize = [icon size];
//    NSRect bounds = self.bounds;
//    CGFloat iconX = roundf((NSWidth(bounds) - iconSize.width) / 2);
//    CGFloat iconY = roundf((NSHeight(bounds) - iconSize.height) / 2);
//    NSPoint iconPoint = NSMakePoint(iconX, iconY);
//
//	[icon drawAtPoint:iconPoint fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
}

#pragma mark -
#pragma mark Mouse tracking

- (void)mouseDown:(NSEvent *)theEvent
{
    [NSApp sendAction:self.action to:self.target from:self];
}

#pragma mark -
#pragma mark Accessors

- (void)setHighlighted:(BOOL)newFlag
{
    if (_isHighlighted == newFlag) return;
    _isHighlighted = newFlag;
    [self setNeedsDisplay:YES];
}

#pragma mark -

- (void)setImage:(NSImage *)newImage
{
    if (_image != newImage) {
        _image = newImage;
        [self setNeedsDisplay:YES];
    }
}

- (void)setAlternateImage:(NSImage *)newImage
{
    if (_alternateImage != newImage) {
        _alternateImage = newImage;
        if (self.isHighlighted) {
            [self setNeedsDisplay:YES];
        }
    }
}

#pragma mark -

- (NSRect)globalRect
{
    NSRect frame = [self frame];
    frame.origin = [self.window convertBaseToScreen:frame.origin];
    return frame;
}

@end

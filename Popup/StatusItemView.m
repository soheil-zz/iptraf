#import "StatusItemView.h"

@implementation StatusItemView

@synthesize statusItem = _statusItem;
@synthesize image = _image;
@synthesize alternateImage = _alternateImage;
@synthesize isHighlighted = _isHighlighted;
@synthesize action = _action;
@synthesize target = _target;

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
    text.stringValue = @"Rocket #9 take off to the planet (to the planet)\
    Venus\
    Aphrodite lady seashell bikini (garden panty)\
    Venus\
    Let's blast off to a new dimension (in your bedroom)\
    Venus\
    Aphrodite lady seashell bikini (get with me)\
    Venus\
    \
    I can't help the way I'm feeling\
    Goddess of love, please take me to your leader\
    I can't help, I keep on dancing\
    Goddess of love, goddess of love\
    \
    Take me to your planet (to the planet)\
    Take me to your planet (to the planet)\
    Take me to your leader (to the planet)\
    Your leader, your leader (to the planet)\
    Take me to your planet (to the planet)\
    Take me to your planet (to the planet)\
    Take me to your Venus (to the planet)\
    Your Venus, your Venus\
    \
    When you touch me, I die\
    Just a little inside\
    I wonder if this could be love\
    This could be love\
    'Cause you're out of this world\
    Galaxy, space, and time\
    I wonder if this could be love (Venus)\
    \
    Have an oyster, baby, it's Aphrod-isy\
    Act sleazy\
    Venus\
    Worship to the land a girl from the planet (to the planet)\
    To the planet\
    \
    I can't help the way I'm feeling\
    Goddess of love, please take me to your leader\
    I can't help, I keep on dancing\
    Goddess of love, goddess of love\
    \
    Take me to your planet (to the planet)\
    Take me to your planet (to the planet)\
    Take me to your leader (to the planet)\
    Your leader, your leader (to the planet)\
    Take me to your planet (to the planet)\
    Take me to your planet (to the planet)\
    Take me to your Venus (to the planet)\
    Your Venus, your Venus\
    \
    When you touch me, I die\
    Just a little inside\
    I wonder if this could be love\
    This could be love\
    'Cause you're out of this world\
    Galaxy, space, and time\
    I wonder if this could be love, this could be\
    \
    Love (wonder if this could be love, this could be love)\
    Goddess of love (wonder if this could be love)\
    Venus\
    \
    Neptune, go\
    Now serve Pluto\
    Saturn, Jupiter\
    Mercury, Venus, uh ha!\
    Uranus!\
    Don't you know my ass is famous?\
    Mars, now serve for the gods\
    Earth, serve for the stars!\
    \
    When you touch me, I die\
    Just a little inside\
    I wonder if this could be love\
    This could be love\
    'Cause you're out of this world\
    Galaxy, space, and time\
    I wonder if this could be love, this could be\
    \
    Love (wonder if this could be love, this could be love)\
    Goddess of love (wonder if this could be love)\
    Venus\
    \
    \
    \
";
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
    NSRect frame = text.frame;
    frame.origin.x -= .5;
    text.frame = frame;
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

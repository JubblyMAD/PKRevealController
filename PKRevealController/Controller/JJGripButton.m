//
//  JJGripButton.m
//  Multinet
//
//  Created by James Cockburn on 26/04/13.
//
//

#import "JJGripButton.h"

#define DEFAULT_GRIP_ALPHA 0.75f;

@interface JJGripButton ()

@property (strong, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;
@property UIView *target;
@property SEL action;

@end

@implementation JJGripButton


- (id)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self) {
		self.userInteractionEnabled = YES;
		self.alpha = self.defaultAlpha;
		
		self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
		[self addGestureRecognizer:self.tapGestureRecognizer];
		
		self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragView:)];
		self.panGestureRecognizer.cancelsTouchesInView = YES;
		self.panGestureRecognizer.delegate = self;
		[self addGestureRecognizer:self.panGestureRecognizer];
    }
    return self;
}

- (CGFloat)defaultAlpha
{
	return DEFAULT_GRIP_ALPHA;
}

- (void)tapView:(UITapGestureRecognizer *)sender
{
	if (self.target != nil)
	{
		if ([self.target respondsToSelector:self.action])
		{
			[self.target performSelector:self.action withObject:self];
		}
	}
}

- (void)dragView:(UIPanGestureRecognizer *)sender
{
	CGPoint p = [sender translationInView:self];
		
	CGPoint movedPoint = CGPointMake(self.center.x, self.center.y + p.y);
	self.center = movedPoint;
	
	[sender setTranslation:CGPointZero inView:self];
}

- (void)addTarget:(id)target action:(SEL)action
{
	self.target = target;
	self.action = action;
}

#pragma mark UIGestureRecognizer Delegate methods
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
	return YES;
}


@end

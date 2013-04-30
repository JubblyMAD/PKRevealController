//
//  JJGripButton.h
//  Multinet
//
//  Created by James Cockburn on 26/04/13.
//
//

#import <UIKit/UIKit.h>

@interface JJGripButton : UIImageView <UIGestureRecognizerDelegate>

@property (readonly) CGFloat defaultAlpha;

- (void)addTarget:(id)target action:(SEL)action;

@end

/*
 * Copyright (c) 2015 mw. All rights reserved.
 */
#import "ISDemoMouseInputView.h"


@interface ISDemoMouseInputView ()
@property(nonatomic) CGPoint initialScrollLocation;
@end

@implementation ISDemoMouseInputView

#pragma mark - Object lifecycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.clipsToBounds = YES;
        self.touchLabel = [[UILabel alloc] init];
        self.touchLabel.attributedText = [self attributedTextForTouchLabel];
        self.touchLabel.backgroundColor = [UIColor clearColor];
        self.touchLabel.textColor = [UIColor whiteColor];
        self.touchLabel.textAlignment = NSTextAlignmentCenter;
        self.touchLabel.numberOfLines = 3;
        [self addSubview:self.touchLabel];

        UIPanGestureRecognizer *moveGestureRecognizer;
        moveGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleMove:)];
        moveGestureRecognizer.maximumNumberOfTouches = 1;
        [self addGestureRecognizer:moveGestureRecognizer];

        UIPanGestureRecognizer *scrollGestureRecognizer;
        scrollGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleScroll:)];
        scrollGestureRecognizer.minimumNumberOfTouches = 2;
        [self addGestureRecognizer:scrollGestureRecognizer];
    }
    return self;
}

#pragma mark - UIView specific

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.touchLabel sizeToFit];
    self.touchLabel.center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2);
    self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2;
}

#pragma mark - Handle touch

- (void)handleMove:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint touchLocation = [gestureRecognizer locationInView:gestureRecognizer.view];

    if ([self.delegate respondsToSelector:@selector(mouseInputView:didReceiveMoveAtPoint:)]) {
        [self.delegate mouseInputView:self didReceiveMoveAtPoint:touchLocation];
    }
}

- (void)handleScroll:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:gestureRecognizer.view];
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.initialScrollLocation = point;
    }

    CGFloat scrollValue = self.initialScrollLocation.y - point.y;

    if ([self.delegate respondsToSelector:@selector(mouseInputView:didReceiveScrollValue:)]) {
        [self.delegate mouseInputView:self didReceiveScrollValue:scrollValue];
    }
}

#pragma mark - Helpers

- (NSMutableAttributedString *)attributedTextForTouchLabel {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"Move with one finger.\n\nScroll with two fingers."];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18]
                             range:NSMakeRange(0, attributedString.length)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20]
                             range:NSMakeRange(0, 4)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20]
                             range:NSMakeRange(23, 6)];
    return attributedString;
}

@end

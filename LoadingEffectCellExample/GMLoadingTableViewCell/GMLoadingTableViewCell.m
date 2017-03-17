//
//  GMLoadingTableViewCell.m
//  test
//
//  Created by Globak Maxim on 15/03/2017.
//  Copyright © 2017 Globak Maxim. All rights reserved.
//

#import "GMLoadingTableViewCell.h"

@interface GMLoadingTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *loadingView;

@end

@implementation GMLoadingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonInit];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    // Setup default parametrs
    self.animationDuration = 3.0;
    
    // Setup start frame for loading view
    [self resetLoadingView];
    
    // Add gesture recognzer
    UILongPressGestureRecognizer *longPress =
    [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(handleLongPress:)];
    longPress.delegate = self;
    [self addGestureRecognizer:longPress];
}

- (void)resetLoadingView {
    CGRect startLoadingViewFrame = self.bounds;
    startLoadingViewFrame.size.width = 0;
    self.loadingView.frame = startLoadingViewFrame;
}

- (void)startAnimationWithCompletion:(void (^)(void))completion andFailure:(void (^)(void))failure{
    
    __weak GMLoadingTableViewCell *weakSelf = self;
    [UIView animateWithDuration:self.animationDuration animations:^{
        weakSelf.loadingView.frame = weakSelf.bounds;
    } completion:^(BOOL finished) {
        [weakSelf resetLoadingView];
        if (finished) {
            if (completion) completion();
        } else {
            if (failure) failure();
        }
    }];
}

- (void)cancelAnimation {
    [self.loadingView.layer removeAllAnimations];
    [self resetLoadingView];
}

- (void)setLoadingViewColor:(UIColor *)loadingViewColor {
    _loadingViewColor = loadingViewColor;
    self.loadingView.backgroundColor = loadingViewColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
}

#pragma mark - Class methods
+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (NSString *)nibName {
    return @"GMLoadingTableViewCell";
}

#pragma mark - UIGesture

-  (void)handleLongPress:(UILongPressGestureRecognizer*)sender {
    switch (sender.state) {
        case UIGestureRecognizerStatePossible:
            break;
        case UIGestureRecognizerStateBegan: {
            [self startAnimationWithCompletion:self.completionBlock andFailure:self.failureBlock];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            // Cancel animation if touch out of cell
            CGPoint touchPoint = [sender locationInView:self];
            if (!CGRectContainsPoint(self.bounds, touchPoint)) {
                [self cancelAnimation];
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed: {
            [self cancelAnimation];
            break;
        }
    }
}


@end

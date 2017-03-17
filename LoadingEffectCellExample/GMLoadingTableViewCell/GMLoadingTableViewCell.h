//
//  GMLoadingTableViewCell.h
//  test
//
//  Created by Globak Maxim on 15/03/2017.
//  Copyright © 2017 Globak Maxim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMLoadingTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) UIColor *loadingViewColor;
@property (assign, nonatomic) CGFloat animationDuration;

@property (copy, nonatomic) void (^completionBlock)(void);
@property (copy, nonatomic) void (^failureBlock)(void);

+ (NSString *)cellIdentifier;
+ (NSString *)nibName;


@end

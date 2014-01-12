//
//  InAppPurchaseViewController.h
//  DragonsDen
//
//  Created by Danny on 1/4/14.
//  Copyright (c) 2014 Meep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InAppPurchaseViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *goldLabel;
@property (nonatomic, strong) IBOutlet UIButton *musicButton;
@property (nonatomic, strong) IBOutlet UIView *loadingView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, strong) NSArray *products;

- (IBAction)buyAppOne:(id)sender;
- (IBAction)buyAppTwo:(id)sender;
- (IBAction)buyAppThree:(id)sender;
- (IBAction)buyAppFour:(id)sender;
- (IBAction)buyAppFive:(id)sender;
- (IBAction)buyAppSix:(id)sender;
- (IBAction)buyAppSeven:(id)sender;
- (IBAction)restoreNoAd:(id)sender;

@end

//
//  HowToPlayViewController.m
//  DragonsDen
//
//  Created by Danny on 11/3/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import "HowToPlayViewController.h"

@interface HowToPlayViewController ()

@end

@implementation HowToPlayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)close:(id)sender {
  [self.navigationController popToRootViewControllerAnimated:YES];
}

@end

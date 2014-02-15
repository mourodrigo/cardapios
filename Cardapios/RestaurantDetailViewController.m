//
//  RestaurantDetailViewController.m
//  Cardapios
//
//  Created by Rodrigo Bueno Tomiosso on 15/02/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import "RestaurantDetailViewController.h"

@implementation RestaurantDetailViewController
@synthesize outletScrollView, outletBtnMenu;
-(void)viewDidLoad{
    [outletScrollView setContentSize:CGSizeMake(outletScrollView.frame.size.width, outletBtnMenu.frame.origin.y+outletBtnMenu.frame.size.height)];
}

- (IBAction)actionBtnMenu:(id)sender {
}
- (IBAction)actionBtnStar:(id)sender {
}

- (IBAction)actionBtnVoltar:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)actionBtnCall:(id)sender {
}
- (IBAction)actionBtnRoute:(id)sender {
}
@end

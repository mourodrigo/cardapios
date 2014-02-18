//
//  ViewController.m
//  Cardapios
//
//  Created by Rodrigo Bueno Tomiosso on 24/11/13.
//  Copyright (c) 2013 mourodrigo. All rights reserved.
//


#import "IdiomViewController.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "SynchronizeData.h"
@interface IdiomViewController (){
    AppDelegate *delegate;
    SynchronizeData *sinc;
}

@end

@implementation IdiomViewController
@synthesize outletBtnEnglish, outletBtnPortuguese, outletBtnSpanish;

- (void)viewDidLoad
{
    [super viewDidLoad];
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    sinc = [[SynchronizeData alloc]init];
 self.navigationController.navigationBar.hidden = YES;   
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [sinc startSincro];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionBtnPortuguese:(id)sender {
    [delegate setIdiomWithString:@"pt"];
    [self showMainVC];
}
- (IBAction)actionBtnEnglish:(id)sender {
    [delegate setIdiomWithString:@"en"];
    [self showMainVC];
}

- (IBAction)actionBtnSpanish:(id)sender {
    [delegate setIdiomWithString:@"es"];
    [self showMainVC];
}

-(void)showMainVC{
    MainViewController *main = (MainViewController*)[delegate getViewControllerWithIdentifier:@"mainvc"];
    [self.navigationController pushViewController:main animated:YES];
}

@end

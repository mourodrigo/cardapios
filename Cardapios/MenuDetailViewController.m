//
//  MenuDetailViewController.m
//  Cardapios
//
//  Created by Rodrigo Bueno Tomiosso on 20/02/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import "MenuDetailViewController.h"
#import "AppDelegate.h"
@interface MenuDetailViewController (){
    AppDelegate *delegate;
}

@end

@implementation MenuDetailViewController
@synthesize outletNomeRest, outletValue, txtDetailRest, outletPrato;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSDictionary *menu = [[delegate sqliteDoQuery:[NSString stringWithFormat:@"Select * from ZMENU WHERE zidMenu = %d ",delegate.idMenu]] lastObject];
    
    NSDictionary* rest= [[delegate sqliteDoQuery:[NSString stringWithFormat:@"Select * from ZRESTAURANT where ZIDREST = %@", [menu valueForKey:@"ZIDRESTAURANT"]]] lastObject];
    
    
    NSLog(@"menu %@", menu);
    [outletNomeRest setText:[NSString stringWithFormat:@" %@", [rest valueForKey:@"ZNAME"]]];
    [outletPrato setText:[NSString stringWithFormat:@" %@", [menu valueForKey:@"ZNAME"]]];
    txtDetailRest.text = [menu valueForKey:@"ZDESCR"];
    [outletValue setTitle:[NSString stringWithFormat:@"$ %@", [menu valueForKey:@"ZVALUE"]] forState:UIControlStateNormal];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionBtnHeart:(id)sender {
}

- (IBAction)actionBtnVoltar:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}
@end

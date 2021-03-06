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
@synthesize outletBtnEnglish, outletBtnPortuguese, outletBtnSpanish, outletActivity, outletViewBtns;
@synthesize navBar, navItem;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
	// Do any additional setup after loading the view, typically from a nib.
    sinc = [[SynchronizeData alloc]init];
    
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //[delegate eraseDb];
    
    [self start];
    
}

-(void)start{
    [outletViewBtns setHidden:TRUE];
    [delegate persistentStoreCoordinator];
    if ([delegate verificaConexao]) {
        [sinc startSincro];
        [self checkDownload];
    }else if([delegate sqliteDoQuery:@"Select * from zrestaurant"].count>0){
        [outletViewBtns setHidden:FALSE];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sem conexão" message:@"Conecte-se à internet para baixar o conteúdo dos cardápios da cidade." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        [self performSelector:@selector(start) withObject:nil afterDelay:60];
    }
}

-(void)checkDownload{
    if (sinc.progressCategory && sinc.progressCity && sinc.progressMenu && sinc.progressRest) {
        [outletViewBtns setHidden:FALSE];
        [outletActivity setHidden:TRUE];
    }else{
        [outletViewBtns setHidden:TRUE];
        [outletActivity setHidden:FALSE];
    }
    [self performSelector:@selector(checkDownload) withObject:Nil afterDelay:1];
}
-(void)viewWillAppear:(BOOL)animated{
    
}
-(void)viewDidAppear:(BOOL)animated{
    
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

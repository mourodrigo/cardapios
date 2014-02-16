//
//  RestaurantDetailViewController.m
//  Cardapios
//
//  Created by Rodrigo Bueno Tomiosso on 15/02/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import "RestaurantDetailViewController.h"
#import "AppDelegate.h"
@implementation RestaurantDetailViewController{
    NSMutableDictionary *info;
    AppDelegate *delegate;
    
}
@synthesize outletScrollView, outletBtnMenu, outletBtnCall, outletBtnRoute, outletBtnStar, outletImgAmex, outletImgMaster, outletImgView, outletImgViewLogo, outletImgVisa, outletLblAbout, outletLblCards, outletLblCity, outletLblEmail, outletLblName, outletLblTime, outletLblTimeDetail, outletLblType, outletTxtAbout;

-(void)viewDidLoad{
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *idiom = [[delegate getInfoPlist] valueForKey:@"idioma"];
    
    info= [[delegate sqliteDoQuery:[NSString stringWithFormat:@"Select * from ZRESTAURANT where Z_PK = %d", delegate.idRestSelected]] objectAtIndex:0];

    NSLog(@"info %@", info);

    outletLblName.text = [info objectForKey:@"ZNAME"];
    outletLblType.text = [info objectForKey:@"ZCOMPANY"];
    outletLblCity.text = [info objectForKey:@"ZCITY"];
    outletLblEmail.text = [info objectForKey:@"ZEMAIL"];
    
    if ([idiom isEqualToString:@"en"]) {
        outletTxtAbout.text = [info objectForKey:@"ZTEXT_EN"];
        
    }else if([idiom isEqualToString:@"es"]){
        outletTxtAbout.text = [info objectForKey:@"ZTEXT_ES"];
        
    }else{
        outletTxtAbout.text = [info objectForKey:@"ZTEXT_PT"];
        
    }
    
    NSLog(@"IDIOM %@", idiom);
}
-(void)viewDidAppear:(BOOL)animated{
    [outletScrollView setDelegate:self];
    [outletScrollView setScrollEnabled:YES];

    [outletScrollView setContentSize:CGSizeMake(outletScrollView.frame.size.width, outletScrollView.frame.size.height+100)];

//    [outletScrollView setContentOffset:CGPointMake(0, outletBtnMenu.frame.origin.y+outletBtnMenu.frame.size.height-30) animated:YES];

    NSLog(@"outletBtnMenu.frame.origin.y+outletBtnMenu.frame.size.height %f", outletBtnMenu.frame.origin.y+outletBtnMenu.frame.size.height);
    NSLog(@"height %f", self.view.frame.size.height);
    
    
}


- (IBAction)actionBtnMenu:(id)sender {
}

- (IBAction)actionBtnStar:(id)sender {
}

- (IBAction)actionBtnVoltar:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionBtnCall:(id)sender {
    NSLog(@"phone %@", [info objectForKey:@"ZCELLPHONE"]);
    NSString *phoneNumber = [[[[[NSString stringWithFormat:@"telprompt://%@", [info objectForKey:@"ZCELLPHONE"]] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"(" withString:@""] stringByReplacingOccurrencesOfString:@")" withString:@""] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

- (IBAction)actionBtnRoute:(id)sender {
}
@end

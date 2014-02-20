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
    
    info= [[delegate sqliteDoQuery:[NSString stringWithFormat:@"Select * from ZRESTAURANT where ZIDREST = %d", delegate.idRestSelected]] objectAtIndex:0];

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
-(void)viewWillAppear:(BOOL)animated{
    

}

-(void)viewDidAppear:(BOOL)animated{
//    [outletScrollView setContentOffset:CGPointMake(0, outletImgViewLogo.frame.origin.y) animated:NO];
    [outletScrollView setDelegate:self];
    [outletScrollView setScrollEnabled:YES];
  //  [outletScrollView setMinimumZoomScale:1];
   // [outletScrollView setMaximumZoomScale:1];
    
    [outletBtnStar setImage:[UIImage imageNamed:@"estrela.png"] forState:UIControlStateNormal];
    [outletBtnStar setImage:[UIImage imageNamed:@"estrela_selected.png"] forState:UIControlStateSelected];
    
 //   [outletScrollView setContentSize:CGSizeMake(outletScrollView.frame.size.width, outletScrollView.frame.size.height+100)];

 
    NSLog(@"content width: %f content heigt: %f", outletScrollView.frame.size.width, outletScrollView.frame.size.height+100);

    NSLog(@"height %f", self.view.frame.size.height);
    
    NSMutableArray *favs = [delegate loadAllFav];
    NSUInteger index = [favs indexOfObject:[NSString stringWithFormat:@"%d", delegate.idRestSelected]];
    if (index!=NSNotFound || !favs) {
        [outletBtnStar setSelected:TRUE];
    }
    
}


- (IBAction)actionBtnMenu:(id)sender {
    NSLog(@"actionbtnmenu");
}

- (IBAction)actionBtnStar:(id)sender {
    if (outletBtnStar.selected) {
        NSMutableArray *favs = [delegate loadAllFav];
        NSUInteger index = [favs indexOfObject:[NSString stringWithFormat:@"%d", delegate.idRestSelected]];
        if (index!=NSNotFound) {
            [favs removeObjectAtIndex:index];
        }
        [outletBtnStar setSelected:FALSE];
        [delegate storeFav:favs];
        
    }else{
        NSMutableArray *favs = [delegate loadAllFav];
        if (!favs) {
            favs = [[NSMutableArray alloc]initWithCapacity:0];
        }
        [favs addObject:[NSString stringWithFormat:@"%d", delegate.idRestSelected]];
        [delegate storeFav:favs];
        [outletBtnStar setSelected:TRUE];
    }
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

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"dragging");
}
@end

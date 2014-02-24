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
    NSMutableArray *imgs;
    int index;
    
}
@synthesize outletScrollView, outletBtnMenu, outletBtnCall, outletBtnRoute, outletBtnStar, outletImgAmex, outletImgMaster, outletImgView, outletImgViewLogo, outletImgVisa, outletLblAbout, outletLblCards, outletLblCity, outletLblEmail, outletLblName, outletLblTime, outletLblTimeDetail, outletLblType, outletTxtAbout;
@synthesize navBar, navItem, outletLblTitle, outletLblCall, outletLblRoute;

-(void)viewDidLoad{
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *idiom = [[delegate getInfoPlist] valueForKey:@"idioma"];
    
    info= [[delegate sqliteDoQuery:[NSString stringWithFormat:@"Select * from ZRESTAURANT where ZIDREST = %d", delegate.idRestSelected]] objectAtIndex:0];

    NSLog(@"info %@", info);
    index=0;
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
    
    if (![[info valueForKey:@"ZAMERICAN"] boolValue]) {
        [outletImgAmex setHidden:TRUE];
    }

    if (![[info valueForKey:@"ZVISA"] boolValue]) {
        [outletImgVisa setHidden:TRUE];
    }
    
    if (![[info valueForKey:@"ZMASTER"] boolValue]) {
        [outletImgMaster setHidden:TRUE];
    }
    
    outletLblTitle.text = [delegate getStr:@"RESTAURANTE"];
    outletLblAbout.text = [delegate getStr:@"SOBRE O RESTAURANTE"];
    outletLblTime.text = [delegate getStr:@"HORÁRIO DE FUNCIONAMENTO"];
    outletLblCards.text = [delegate getStr:@"CARTÕES ACEITOS"];
    [outletBtnMenu setTitle:[delegate getStr:@"CARDÁPIO"] forState:UIControlStateNormal];
    outletLblRoute.text = [delegate getStr:@"ROTA"];
    outletLblCall.text = [delegate getStr:@"LIGAR"];
    
    NSLog(@"IDIOM %@", idiom);
}
-(void)viewWillAppear:(BOOL)animated{
    imgs = [[NSMutableArray alloc]initWithCapacity:0];
    
    if (![[info valueForKey:@"ZIMAGE1"] isEqualToString:@""] && [[NSFileManager defaultManager]fileExistsAtPath:[[NSString stringWithFormat:@"~/Documents/files/%@",[info valueForKey:@"ZIMAGE1"]] stringByExpandingTildeInPath]]) {
        [imgs addObject:[[NSString stringWithFormat:@"~/Documents/files/%@",[info valueForKey:@"ZIMAGE1"]] stringByExpandingTildeInPath]];
    }
    
    if (![[info valueForKey:@"ZIMAGE2"] isEqualToString:@""] && [[NSFileManager defaultManager]fileExistsAtPath:[[NSString stringWithFormat:@"~/Documents/files/%@",[info valueForKey:@"ZIMAGE2"]] stringByExpandingTildeInPath]]) {
        [imgs addObject:[[NSString stringWithFormat:@"~/Documents/files/%@",[info valueForKey:@"ZIMAGE2"]] stringByExpandingTildeInPath]];
        
    }
    
    if (![[info valueForKey:@"ZIMAGE3"] isEqualToString:@""] && [[NSFileManager defaultManager]fileExistsAtPath:[[NSString stringWithFormat:@"~/Documents/files/%@",[info valueForKey:@"ZIMAGE3"]] stringByExpandingTildeInPath]]) {
        [imgs addObject:[[NSString stringWithFormat:@"~/Documents/files/%@",[info valueForKey:@"ZIMAGE3"]] stringByExpandingTildeInPath]];
        
    }

    if (![[info valueForKey:@"ZIMAGE4"] isEqualToString:@""] && [[NSFileManager defaultManager]fileExistsAtPath:[[NSString stringWithFormat:@"~/Documents/files/%@",[info valueForKey:@"ZIMAGE4"]] stringByExpandingTildeInPath]]) {
        [imgs addObject:[[NSString stringWithFormat:@"~/Documents/files/%@",[info valueForKey:@"ZIMAGE4"]] stringByExpandingTildeInPath]];
        
    }

    if (imgs.count>0) {
        [self setImgWithIndex:0];
    }
}

-(void)setImgWithIndex:(int)theindex{
    if (index<imgs.count) {
        
        
        [UIView transitionWithView:self.view
                          duration:0.33f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            
                            [outletImgView setImage:[UIImage imageWithContentsOfFile:[imgs objectAtIndex:theindex]]];
                        } completion:NULL];
        
        theindex = index;
    }
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
    NSUInteger indexz = [favs indexOfObject:[NSString stringWithFormat:@"%d", delegate.idRestSelected]];
    if (indexz!=NSNotFound && favs) {
        [outletBtnStar setSelected:TRUE];
    }
    
}


- (IBAction)actionBtnMenu:(id)sender {
    NSLog(@"actionbtnmenu");
}

- (IBAction)actionBtnStar:(id)sender {
    if (outletBtnStar.selected) {
        NSMutableArray *favs = [delegate loadAllFav];
        NSUInteger indexz = [favs indexOfObject:[NSString stringWithFormat:@"%d", delegate.idRestSelected]];
        if (indexz!=NSNotFound) {
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
- (IBAction)actionDireita:(id)sender {
    if (index==imgs.count-1) {
        [self setImgWithIndex:0];
        index = 0;

    }else{
        [self setImgWithIndex:index+1];
        index = index+1;

    }
}

- (IBAction)actionEsquerda:(id)sender {
    if (index==0) {
        [self setImgWithIndex:imgs.count-1];
        index = imgs.count-1;

    }else{
        [self setImgWithIndex:index-1];
        index = index-1;
    }
}
@end

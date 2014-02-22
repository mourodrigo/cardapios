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
@synthesize navBar, navItem;

@synthesize outletNomeRest, outletValue, txtDetailRest, outletPrato, outletBtnHeart;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSString*)testIfIsNull:(NSString*)text{
    
    if (![text isEqual:[NSNull null]]) {
        
        return text;
        
    } else  return @"";
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSDictionary *menu = [[delegate sqliteDoQuery:[NSString stringWithFormat:@"Select * from ZMENU WHERE zidMenu = %d ",delegate.idMenu]] lastObject];
    
    NSDictionary* rest= [[delegate sqliteDoQuery:[NSString stringWithFormat:@"Select * from ZRESTAURANT where ZIDREST = %@", [menu valueForKey:@"ZIDRESTAURANT"]]] lastObject];
    
    
    NSLog(@"menu %@", menu);
    [outletNomeRest setText:[NSString stringWithFormat:@" %@", [rest valueForKey:@"ZNAME"]]];
    if ([menu valueForKey:@"ZNAME"]) {
        [outletPrato setText:[NSString stringWithFormat:@" %@", [self testIfIsNull:[menu valueForKey:@"ZNAME"]]]];
        
    }else{
        outletPrato.text = @"";
    }
    txtDetailRest.text = [menu valueForKey:@"ZDESCR"];
    [outletValue setTitle:[NSString stringWithFormat:@"$ %@", [menu valueForKey:@"ZVALUE"]] forState:UIControlStateNormal];
	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [outletBtnHeart setImage:[UIImage imageNamed:@"estrela.png"] forState:UIControlStateNormal];
    [outletBtnHeart setImage:[UIImage imageNamed:@"estrela_selected.png"] forState:UIControlStateSelected];
    NSMutableArray *favs = [delegate loadAllMenuFav];
    NSUInteger index = [favs indexOfObject:[NSString stringWithFormat:@"%d", delegate.idMenu]];
    if (index!=NSNotFound || !favs) {
        [outletBtnHeart setSelected:TRUE];
    }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionBtnHeart:(id)sender {
    if (outletBtnHeart.selected) {
        NSMutableArray *favs = [delegate loadAllMenuFav];
        NSUInteger index = [favs indexOfObject:[NSString stringWithFormat:@"%d", delegate.idMenu]];
        if (index!=NSNotFound) {
            [favs removeObjectAtIndex:index];
        }
        [outletBtnHeart setSelected:FALSE];
        [delegate storeMenuFav:favs];
        
    }else{
        NSMutableArray *favs = [delegate loadAllMenuFav];
        if (!favs) {
            favs = [[NSMutableArray alloc]initWithCapacity:0];
        }
        [favs addObject:[NSString stringWithFormat:@"%d", delegate.idMenu]];
        [delegate storeMenuFav:favs];
        [outletBtnHeart setSelected:TRUE];
    }

}

- (IBAction)actionBtnVoltar:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}
@end

//
//  SynchronizeData.m
//  Embraed
//
//  Created by MouRodrigo on 23/02/13.
//  Copyright (c) 2013 catalogbrasil. All rights reserved.
//


#import "SynchronizeData.h"
#import "AFNetworking.h"
#import "WriteDataBase.h"

#import "Core.h"

@implementation SynchronizeData
{
    WriteDataBase *manageDataObject;
    AppDelegate *_appdelegate;
    NSString *idsImoveisAtualizados;
    
    
}
@synthesize progressCity, progressCategory, progressMenu, progressRest;
- (void)startSincro
{
    manageDataObject=[[WriteDataBase alloc]init];
 
    [manageDataObject beginWriteData];
    
    _appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];

    [[NSNotificationCenter defaultCenter] removeObserver:nil name:@"JSONCity" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCity:) name:@"JSONCity" object:nil];
    [self performSelector:@selector(getCity) withObject:Nil afterDelay:1];

    [[NSNotificationCenter defaultCenter] removeObserver:nil name:@"JSONCategory" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCategory:) name:@"JSONCategory" object:nil];
    [self performSelector:@selector(getCategory) withObject:Nil afterDelay:2];

    
    [[NSNotificationCenter defaultCenter] removeObserver:nil name:@"JSONRestaurant" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRest:) name:@"JSONRestaurant" object:nil];
    [self performSelector:@selector(getRestaurant) withObject:nil afterDelay:3];

    [[NSNotificationCenter defaultCenter] removeObserver:nil name:@"JSONMenu" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMenu:) name:@"JSONMenu" object:nil];
    [self performSelector:@selector(getMenu) withObject:nil afterDelay:4];
    progressCity = progressCategory = progressMenu = progressRest = FALSE;

    
}

#pragma Mark - syncRestaurant

-(void)getRestaurant{
    
    NSString *api = @"http://cardapiosdacidade.com/xUuiBJ6N/api/restaurantes.php";
    
    NSLog(@"\n\ngetRestaurant %@", api);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:api]] success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"JSONRestaurant" object:JSON userInfo:nil];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response,NSError *error ,id JSON) {
            NSLog(@"ERRO BAIXANDO JSON response-> %@", response);
            NSLog(@"ERRO BAIXANDO JSON error-> %@", error);
        }];
        [operation start];
    });
    
}

-(void)updateRest:(NSNotification *)notification{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        @try {
            NSLog(@"JSON count %d", [notification.object count]);
            for (NSDictionary *dic in [notification.object objectForKey:@"resultado"]) {
                @try {
                    [manageDataObject writeRestaurant:dic];
         /*           NSLog(@"DICC %@", dic);
                    if (![[dic valueForKey:@"img0"] isEqualToString:@""]) {
                        _appdelegate imageRequest:<#(NSString *)#> withFileName:[dic valueForKey:@"img0"] storeAtpath:@""
                    }
      */
                }
                @catch (NSException *exception) {
                    NSLog(@"getRestaurant expection -> %@", exception.description);
                }
            }
            progressRest = true;
        }
        @catch (NSException *exception) {
            NSLog(@"getRestaurant expection -> %@", exception.description);
        }
        NSLog(@"Sync restaurante Finalizado");
    });
}


#pragma Mark - syncCity

-(void)getCity{
    
    NSString *api = @"http://cardapiosdacidade.com/xUuiBJ6N/api/cidades.php";
    
    NSLog(@"\n\ngetCity %@", api);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:api]] success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"JSONCity" object:JSON userInfo:nil];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response,NSError *error ,id JSON) {
            NSLog(@"ERRO BAIXANDO JSON response-> %@", response);
            NSLog(@"ERRO BAIXANDO JSON error-> %@", error);
        }];
        [operation start];
    });
    
}

-(void)updateCity:(NSNotification *)notification{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        @try {
            NSLog(@"JSON count %d", [notification.object count]);
            for (NSDictionary *dic in [notification.object objectForKey:@"resultado"]) {
                @try {
                    [manageDataObject writeCity:dic];
                }
                @catch (NSException *exception) {
                    NSLog(@"getcity expection -> %@", exception.description);
                }
            }
            progressCity = TRUE;
        }
        @catch (NSException *exception) {
            NSLog(@"getcity expection -> %@", exception.description);
        }
        NSLog(@"Sync city Finalizado");
    });
}


#pragma Mark - syncMenu

-(void)getMenu{
    
    NSString *api = @"http://cardapiosdacidade.com/xUuiBJ6N/api/cardapios.php";
    
    NSLog(@"\n\ngetMenu %@", api);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:api]] success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"JSONMenu" object:JSON userInfo:nil];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response,NSError *error ,id JSON) {
            NSLog(@"ERRO BAIXANDO JSON response-> %@", response);
            NSLog(@"ERRO BAIXANDO JSON error-> %@", error);
        }];
        [operation start];
    });
    
}


-(void)updateMenu:(NSNotification *)notification{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        @try {
            NSLog(@"JSON count %d", [notification.object count]);
            for (NSDictionary *dic in [notification.object objectForKey:@"resultado"]) {
                @try {
                    [manageDataObject writeMenu:dic];
                }
                @catch (NSException *exception) {
                    NSLog(@"getMenu expection -> %@", exception.description);
                }
            }
            progressMenu = TRUE;
        }
        @catch (NSException *exception) {
            NSLog(@"getMenu expection -> %@", exception.description);
        }
        NSLog(@"Sync Menu Finalizado");
    });
}



#pragma Mark - syncCategory

-(void)getCategory{
    
    NSString *api = @"http://cardapiosdacidade.com/xUuiBJ6N/api/categorias.php";
    
    NSLog(@"\n\ngetCategory %@", api);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:api]] success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"JSONCategory" object:JSON userInfo:nil];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response,NSError *error ,id JSON) {
            NSLog(@"ERRO BAIXANDO JSON response-> %@", response);
            NSLog(@"ERRO BAIXANDO JSON error-> %@", error);
        }];
        [operation start];
    });
    
}



-(void)updateCategory:(NSNotification *)notification{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        @try {
            NSLog(@"JSON count %d", [notification.object count]);
            for (NSDictionary *dic in [notification.object objectForKey:@"resultado"]) {
                @try {
                    [manageDataObject writeCategory:dic];
                }
                @catch (NSException *exception) {
                    NSLog(@"getcategory expection -> %@", exception.description);
                }
            }
            progressCategory = true;
        }
        @catch (NSException *exception) {
            NSLog(@"getcategory expection -> %@", exception.description);
        }
        NSLog(@"Sync category Finalizado");
    });
}

@end

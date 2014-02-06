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

#import "ReturnObjects.h"

@implementation SynchronizeData
{
    WriteDataBase *manageDataObject;
    AppDelegate *_appdelegate;
    NSString *idsImoveisAtualizados;
    
    
}
@synthesize progressCity, progressFood, progressMenu, progressRest;
- (void)startSincro
{
    manageDataObject=[[WriteDataBase alloc]init];
 
    [manageDataObject beginWriteData];
    
    _appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
/*
    [[NSNotificationCenter defaultCenter] removeObserver:nil name:@"JSONMenu" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMenu:) name:@"JSONMenu" object:nil];
    [self getMenu];
  */
    [[NSNotificationCenter defaultCenter] removeObserver:nil name:@"JSONCity" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCity:) name:@"JSONCity" object:nil];
    [self performSelector:@selector(getCity) withObject:Nil afterDelay:1];

    [[NSNotificationCenter defaultCenter] removeObserver:nil name:@"JSONCategory" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCategory:) name:@"JSONCategory" object:nil];
    [self performSelector:@selector(getCategory) withObject:Nil afterDelay:2];

    
    [[NSNotificationCenter defaultCenter] removeObserver:nil name:@"JSONRestaurant" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRest:) name:@"JSONRestaurant" object:nil];
    [self performSelector:@selector(getRestaurant) withObject:nil afterDelay:3];


    
}

#pragma Mark - syncRestaurant

-(void)getRestaurant{
    
    NSString *api = @"http://www.gobekdigital.com.br/cliente/cdc/aprovacao/api/restaurantes.php";
    
    NSLog(@"getRestaurant %@", api);
    
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
            progressRest = 0;
            float count = [notification.object count];
            float step = 1/count;
            NSLog(@"JSON count %d", [notification.object count]);
            for (NSDictionary *dic in [notification.object objectForKey:@"resultado"]) {
                @try {
                    [manageDataObject writeRestaurant:dic];
                    progressRest = progressRest+step;
                }
                @catch (NSException *exception) {
                    NSLog(@"getRestaurant expection -> %@", exception.description);
                }
            }
        }
        @catch (NSException *exception) {
            NSLog(@"getRestaurant expection -> %@", exception.description);
        }
        NSLog(@"Sync restaurante Finalizado");
    });
}


#pragma Mark - syncCity

-(void)getCity{
    
    NSString *api = @"http://www.gobekdigital.com.br/cliente/cdc/aprovacao/api/cidades.php";
    
    NSLog(@"getCity %@", api);
    
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
            progressCity = 0;
            float count = [notification.object count];
            float step = 1/count;
            NSLog(@"JSON count %d", [notification.object count]);
            for (NSDictionary *dic in [notification.object objectForKey:@"resultado"]) {
                @try {
                    [manageDataObject writeCity:dic];
                    progressCity = progressCity+step;
                }
                @catch (NSException *exception) {
                    NSLog(@"getcity expection -> %@", exception.description);
                }
            }
        }
        @catch (NSException *exception) {
            NSLog(@"getcity expection -> %@", exception.description);
        }
        NSLog(@"Sync city Finalizado");
    });
}


#pragma Mark - syncMenu

-(void)getMenu{
    
    NSString *api = @"http://www.gobekdigital.com.br/cliente/cdc/aprovacao/api/cardapios.php";
    
    NSLog(@"getMenu %@", api);
    
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
            progressMenu = 0;
            float count = [notification.object count];
            float step = 1/count;
            NSLog(@"JSON count %d", [notification.object count]);
            for (NSDictionary *dic in [notification.object objectForKey:@"resultado"]) {
                @try {
                    [manageDataObject writeMenu:dic];
                    progressMenu = progressMenu+step;
                }
                @catch (NSException *exception) {
                    NSLog(@"getMenu expection -> %@", exception.description);
                }
            }
        }
        @catch (NSException *exception) {
            NSLog(@"getMenu expection -> %@", exception.description);
        }
        NSLog(@"Sync Menu Finalizado");
    });
}




#pragma Mark - syncCategory

-(void)getCategory{
    
    NSString *api = @"http://www.gobekdigital.com.br/cliente/cdc/aprovacao/api/categorias.php";
    
    NSLog(@"getCategory %@", api);
    
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
            progressFood = 0;
            float count = [notification.object count];
            float step = 1/count;
            NSLog(@"JSON count %d", [notification.object count]);
            for (NSDictionary *dic in [notification.object objectForKey:@"resultado"]) {
                @try {
                    [manageDataObject writeCategory:dic];
                    progressFood = progressFood+step;
                }
                @catch (NSException *exception) {
                    NSLog(@"getcategory expection -> %@", exception.description);
                }
            }
        }
        @catch (NSException *exception) {
            NSLog(@"getcategory expection -> %@", exception.description);
        }
        NSLog(@"Sync category Finalizado");
    });
}






#pragma mark - Empresa

-(void)atualizaEmpresas:(id)Json{
    manageDataObject=[[WriteDataBase alloc]init];
    _appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
/*
    NSMutableArray *empresas = [[NSMutableArray alloc] initWithArray:[_appdelegate sqliteDoQuery:@"Select * from ZEMPRESA"]];
    int idselecionado = -1;
    for (NSDictionary *empresa in empresas) {
        if ([[empresa valueForKey:@"ZCURRENT"] integerValue]==1) {
            idselecionado = [[empresa valueForKey:@"ZIDEMPRESA"] integerValue];
        }
    }
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
    
        @try {
            
            int userId = [_appdelegate getUserId];
            
            for (NSDictionary *dic in  Json) {
                //NSLog(@"%@", dic);
                // ATUALIZACAO DA EMPRESA NO BANCO DE DADOS
                
                NSMutableDictionary *empresa = [[NSMutableDictionary alloc]initWithDictionary:[dic valueForKey:@"Imobiliaria"]];
                if ([[empresa valueForKey:@"id"] integerValue]==idselecionado) {
                    [empresa setValue:[NSNumber numberWithInt:1] forKey:@"current"];
                }else{
                    [empresa setValue:[NSNumber numberWithInt:0] forKey:@"current"];
                }
                for (NSDictionary *empresaSincronizada in empresas) {
                    if ([[empresaSincronizada valueForKey:@"ZIDEMPRESA"] integerValue] == [[empresa valueForKey:@"id"] integerValue]) {
                        
                        if ([[empresaSincronizada valueForKey:@"ZSINCRONIZADO"] boolValue]) {
                            [empresa setValue:[NSNumber numberWithInt:1] forKey:@"sincronizado"];
                        }else{  
                            [empresa setValue:[NSNumber numberWithInt:0] forKey:@"sincronizado"];
                        }
                        [_appdelegate sqliteDoQuery:[NSString stringWithFormat:@"DELETE from ZEMPRESA WHERE ZIDEMPRESA = %@", [empresaSincronizada valueForKey:@"ZIDEMPRESA"]]];
                        break;
                    }
                }
                
                [empresa setValue:[NSNumber numberWithInt:userId] forKey:@"userId"];
                
                [manageDAtaObject writeDataBaseEmpresa:empresa];
                
                // DOWNLOAD IMAGENS DA EMPRESA
                
                NSString * logomarca = [empresa valueForKey:@"logomarca"];
                NSString *arquivo_logomarca = [[NSString stringWithFormat:@"~/Documents/files/%@",logomarca] stringByExpandingTildeInPath];
                if (![[NSFileManager defaultManager]fileExistsAtPath:arquivo_logomarca]) {
                    [self getFileWithBaseUrl:@"files/" withFileName:[NSString stringWithFormat:@"%@",logomarca] storeAtpath:@"files/"];
                }
                
                NSString * logomarca_com_fundo = [empresa valueForKey:@"logomarca_com_fundo"];
                NSString *arquivo_logomarca_com_fundo = [[NSString stringWithFormat:@"~/Documents/files/%@",logomarca_com_fundo] stringByExpandingTildeInPath];
                if (![[NSFileManager defaultManager]fileExistsAtPath:arquivo_logomarca_com_fundo]) {
                    [self getFileWithBaseUrl:@"files/" withFileName:[NSString stringWithFormat:@"%@",logomarca_com_fundo] storeAtpath:@"files/"];
                }

                NSString * logomarca_reduzida = [empresa valueForKey:@"logomarca_reduzida"];
                NSString *arquivo_logomarca_reduzida = [[NSString stringWithFormat:@"~/Documents/files/%@",logomarca_reduzida] stringByExpandingTildeInPath];
                if (![[NSFileManager defaultManager]fileExistsAtPath:arquivo_logomarca_reduzida]) {
                    [self getFileWithBaseUrl:@"files/" withFileName:[NSString stringWithFormat:@"%@",logomarca_reduzida] storeAtpath:@"files/"];
                }
                
                NSString * background = [empresa valueForKey:@"background"];
                NSString *arquivo_background = [[NSString stringWithFormat:@"~/Documents/files/%@",background] stringByExpandingTildeInPath];
                if (![[NSFileManager defaultManager]fileExistsAtPath:arquivo_background]) {
                    [self getFileWithBaseUrl:@"files/" withFileName:[NSString stringWithFormat:@"%@",background] storeAtpath:@"files/"];
                }
                
                
                
            }
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:10] forKey:@"status"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"logAcessoLoginResult" object:self userInfo:userInfo];
    }
        @catch (NSException *exception) {
            NSLog(@"expection -> %@", exception.description);
        }
    
    });*/

}




- (void)getFileWithBaseUrl:(NSString*)directoryname withFileName:(NSString*)nameFile storeAtpath:(NSString*)downloadPath
{
  /*      _appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        NSString *api = [[_appdelegate getInfoPlist]valueForKey:@"api"];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:[api stringByAppendingString:@"%@%@"],directoryname,nameFile]]];
        NSLog(@"getFile url %@", request.URL);
        AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request success:^(UIImage *image) {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW,
                                                     (unsigned long)NULL), ^(void) {
                
                NSString *pathToWriteFile = [[NSString stringWithFormat:@"~/Documents/%@%@",downloadPath,nameFile] stringByExpandingTildeInPath];
                
                NSError *erro;
                if (![[NSFileManager defaultManager] fileExistsAtPath:[[NSString stringWithFormat:@"~/Documents/%@",downloadPath] stringByExpandingTildeInPath]]){
                    [[NSFileManager defaultManager] createDirectoryAtPath:[[NSString stringWithFormat:@"~/Documents/%@",downloadPath] stringByExpandingTildeInPath] withIntermediateDirectories:NO attributes:nil error:&erro];
                }

                if ([[nameFile pathExtension]isEqualToString:@"png"]) {
                    [UIImagePNGRepresentation(image) writeToFile:pathToWriteFile atomically:YES];
                    
                }else{
                    [UIImageJPEGRepresentation(image, 1.0) writeToFile:pathToWriteFile atomically:YES];
                }
                
                //NSDictionary *userInfo = [NSDictionary dictionaryWithObject:nameFile forKey:@"fileName"];
                //[[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"finished_download:%@", nameFile] object:self userInfo:userInfo];
                NSLog(@"notification center ->-%@<", [NSString stringWithFormat:@"finished_download:%@", nameFile]);
                [_appdelegate addSkipBackupAttributeToItemAtURL:[NSURL URLWithString:pathToWriteFile]];
                    
            });
            
        }];
        
        [operation start];*/
    
}




@end

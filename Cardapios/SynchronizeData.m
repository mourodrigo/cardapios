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
@synthesize downloadFinalizado, downloadEmpresaFinalizado,progress, erroSincronismo, continuarDownload, numImoveisSinc;
- (void)startSincro
{
    manageDataObject=[[WriteDataBase alloc]init];
 
    [manageDataObject beginWriteData];
    
    _appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [[NSNotificationCenter defaultCenter] removeObserver:nil name:@"JsonImoveisDownloaded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(atualizaImoveis:) name:@"JsonImoveisDownloaded" object:nil];
    [self getRestaurant];
}


-(void)getRestaurant{
    
    NSString *api = @"http://www.gobekdigital.com.br/cliente/cdc/aprovacao/api/restaurantes.php";
    
    NSLog(@"getRestaurant %@", api);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:api]] success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"JsonImoveisDownloaded" object:JSON userInfo:nil];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response,NSError *error ,id JSON) {
            NSLog(@"ERRO BAIXANDO JSON response-> %@", response);
            NSLog(@"ERRO BAIXANDO JSON error-> %@", error);
        }];
        [operation start];
    });
    
}

-(void)atualizaImoveis:(NSNotification *)notification{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
    
    
        
        
        
        NSLog(@"NOTIFICAATUALIZA self:%@", self);
        @try {
            
            progress = 0;
            float count = [notification.object count];
            float step = 1/count;
            numImoveisSinc = 0;
            
            
            NSLog(@"JSON count %d", [notification.object count]);
            
            _appdelegate.infoToSync = [[NSMutableArray alloc]initWithArray:[notification.object objectForKey:@"resultado"]];
            
            
            
            while (_appdelegate.infoToSync.count!=0) {
                
                @try {
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:[_appdelegate.infoToSync objectAtIndex:0]];
                    
                    numImoveisSinc++;
                    
                    [manageDataObject writeRestaurant:dic];
                    
                    progress = progress+step;
                    
                    [_appdelegate.infoToSync removeObjectAtIndex:0];
                    
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


-(void)checkImovelRemovido:(id)json{
 /*   int imoveisRemovidos = 0;
    NSString *idsImoveisRemovidos = @"";
    int idEmpresa = [[[_appdelegate getCurrentEmpresa] valueForKey:@"ZIDEMPRESA"] integerValue];
    
    NSMutableArray *sincronizadosdb = [[NSMutableArray alloc]initWithArray:[_appdelegate sqliteDoQuery:[NSString stringWithFormat:@"Select ZIDIMOVEL from ZIMOVEL WHERE ZUSERID = %d AND ZIDEMPRESA = %d", [_appdelegate getUserId],idEmpresa ]]];

    NSMutableArray *idsSincronizados = [[NSMutableArray alloc]initWithCapacity:0];
   
    for (NSDictionary *dic in json) {
        
        [idsSincronizados addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:[[dic valueForKey:@"id"] integerValue]],@"ZIDIMOVEL", nil]];
        
    }
    
    for (NSDictionary *dic in sincronizadosdb) {
       
        if ([idsSincronizados indexOfObject:dic]==NSNotFound) {
            
            NSLog(@"NÃO ENCONTRADO %@", dic);
            idsImoveisRemovidos = [NSString stringWithFormat:@"%@ %@ ",idsImoveisRemovidos, [dic valueForKey:@"ZIDIMOVEL"]];
            [self eraseImovelWithId:[[dic valueForKey:@"ZIDIMOVEL"] integerValue] andUserId:[_appdelegate getUserId] shouldDeleteFile:YES];

            imoveisRemovidos++;
            
            
            
        }
    }
    if (imoveisRemovidos>0) {
        [_appdelegate sqliteDoQuery:[NSString stringWithFormat:@"INSERT INTO ZHISTORICO (ZEMPRESA, ZDATA, ZCOMENTARIO, ZLOGIN, ZTIPO) VALUES ((Select ZIDEMPRESA from ZEMPRESA where ZCURRENT = 1),  datetime('now') , '%d imóveis removidos [%@]', (SELECT ZEMAIL FROM ZLOGINS WHERE ZCURRENT = 1) , 'Sincronização Imóveis')", imoveisRemovidos, idsImoveisRemovidos]];
    }
    
    */
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

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
#import "Principal.h"
#import "ReturnObjects.h"
#import "ImovelSincronizado.h"
@implementation SynchronizeData
{
    WriteDataBase *manageDAtaObject;
    AppDelegate *_appdelegate;
    NSString *idsImoveisAtualizados;
    
    
}
@synthesize downloadFinalizado, downloadEmpresaFinalizado,progress, erroSincronismo, continuarDownload, numImoveisSinc;
- (void)startSincro
{
    downloadFinalizado = FALSE;
    downloadEmpresaFinalizado = FALSE;
    manageDAtaObject=[[WriteDataBase alloc]init];
 
    [manageDAtaObject beginWriteData];
    _appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [[NSNotificationCenter defaultCenter] removeObserver:nil name:@"JsonImoveisDownloaded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(atualizaImoveis:) name:@"JsonImoveisDownloaded" object:nil];
    
}


-(void)getImoveis{
    NSLog(@"GETIMOVEIS");
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        
        _appdelegate.syncDatabase = true;
        //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sqliteNotification:) name:@"sqlite3Notification" object:nil]; //teletar

        NSString *api = [[_appdelegate getInfoPlist]valueForKey:@"api"];
        NSString *login;
        NSString *idEmpresa;
        int userId;
        @try {
            
            NSDictionary *query = [[NSDictionary alloc]initWithDictionary:[[_appdelegate sqliteDoQuery:@"SELECT ZEMAIL, Z_PK FROM ZLOGINS WHERE ZCURRENT = 1;"] objectAtIndex:0]];
            login = [query valueForKey:@"ZEMAIL"];
            userId = [_appdelegate getUserId];
            idEmpresa = [[[_appdelegate sqliteDoQuery:@"SELECT ZIDEMPRESA FROM ZEMPRESA WHERE ZCURRENT = 1;"] objectAtIndex:0] valueForKey:@"ZIDEMPRESA"];
        }
        @catch (NSException *exception) {
            NSLog(@"getImoveis erro %@", exception.description);
        }
        
            NSString *getallimoveis =[ NSString stringWithFormat:@"%@api/getAllImoveisWindows/%@/%@", api, login, idEmpresa];
        
        
        
            NSLog(@"getallimoveis -> %@", getallimoveis);
        
        
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:getallimoveis]];
        [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
           
            
            NSDictionary *sincroInfo = [[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInt:userId],@"userId",[NSNumber numberWithInt:[idEmpresa integerValue]],@"idEmpresa", nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"JsonImoveisDownloaded" object:JSON userInfo:sincroInfo];
            
           
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response,NSError *error ,id JSON) {
            NSMutableArray *arrJson = [[NSMutableArray alloc]initWithArray:JSON];
            if(!arrJson.count==0){
                [self getImoveis];
            }
            NSLog(@"ERRO BAIXANDO JSON response-> %@", response);
            NSLog(@"ERRO BAIXANDO JSON error-> %@", error);
            erroSincronismo = TRUE;
        }];
        
        [operation start];
        
    });
    
}

-(void)atualizaImoveis:(NSNotification *)notification{
    idsImoveisAtualizados = @"";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        
        

        
        NSLog(@"NOTIFICAATUALIZA self:%@", self);
        @try {
            
            int userId = [[notification.userInfo valueForKey:@"userId"] integerValue];
            
            
            progress = 0;
            float count = [notification.object count];
            float step = 1/count;
            numImoveisSinc = 0;
            
            
            NSLog(@"JSON count %d", [notification.object count]);
            
            _appdelegate.infoToSync = [[NSMutableArray alloc]initWithArray:notification.object];
            
            
            while (_appdelegate.infoToSync.count!=0) {
                //dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW,
                //                                        (unsigned long)NULL), ^(void) {
                
                @try {
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:[_appdelegate.infoToSync objectAtIndex:0]];
                    [dic setValue:[NSNumber numberWithInt:userId] forKey:@"userId"];
                    int idImovel =[[dic valueForKey:@"id"] integerValue];
                    
                    NSArray *query = [_appdelegate sqliteDoQuery:[NSString stringWithFormat:@"SELECT ZLENGHT, ZBIN FROM ZIMOVELSINCRONIZADO WHERE ZIDIMOVEL = %@ AND ZUSERID = %d", [dic valueForKey:@"id"], userId]];
                    NSData * sincronizedData;
                    
                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
                    
                    BOOL sincronizar = FALSE;
                    
                    if (query.count>0) {
                        sincronizedData = [[query objectAtIndex:0] valueForKey:@"ZBIN"];
                        if ([sincronizedData isEqualToData:data]) {
                            NSLog(@"Imóvel %@ - %@ ja está sincronizado", [dic valueForKey:@"id"], [dic valueForKey:@"titulo"]);
                        }else{
                            sincronizar= TRUE;
                            
                            [self removeImovelWithId:idImovel andUserId:userId shouldDeleteFile:NO];
                            [self removeArquivosWithId:idImovel andUserId:userId shouldDeleteFile:NO];
                            [self removeFotos3dWithId:idImovel andUserId:userId shouldDeleteFile:NO];
                            [self removeImagesWithId:idImovel andUserId:userId shouldDeleteFile:NO];
                            [self removePlantasWithId:idImovel andUserId:userId shouldDeleteFile:NO];
                        }
                        query = NULL;
                        
                    }else{
                        sincronizar = TRUE;
                    }
                    
                    if (sincronizar){
                        numImoveisSinc++;
                        [dic setValue:[notification.userInfo valueForKey:@"idEmpresa"] forKey:@"idEmpresa"];
                        
                        NSLog(@"gravando imóvel %d - %@", idImovel, [dic valueForKey:@"titulo"]);
                       idsImoveisAtualizados = [NSString stringWithFormat:@"%@ %@", idsImoveisAtualizados, [dic valueForKey:@"id"]];
                        
                        [manageDAtaObject writeDataImovel:[NSDictionary dictionaryWithObjectsAndKeys:[dic valueForKey:@"id"], @"idImovel",data,@"bin",[NSNumber numberWithInteger:data.length],@"lenght",[NSNumber numberWithInteger:userId],@"userId", nil]];
                        
                        [manageDAtaObject writeDataBaseImovel:dic];
                        
                        [manageDAtaObject writeImages:dic];
                        
                        [manageDAtaObject writePlantas:dic];
                        
                        [manageDAtaObject writePhotos3d:[dic valueForKey:@"Fotos3d"] : idImovel];
                        
                        [manageDAtaObject writeArquivos:[dic valueForKey:@"novo_disponibilidade_pdf"] deTipo:@"disponibilidade" paraImovelId:idImovel userId:userId];
                        
                        [manageDAtaObject writeArquivos:[dic valueForKey:@"novo_diversos"] deTipo:@"diversos" paraImovelId:idImovel userId:userId];
                        
                        [manageDAtaObject writeArquivos:[dic valueForKey:@"novo_Memorial_descritivoPDF"] deTipo:@"memorialDescritivo" paraImovelId:idImovel userId:userId];
                        
                        [manageDAtaObject writeArquivos:[dic valueForKey:@"novo_pdf_plantas"] deTipo:@"plantas" paraImovelId:idImovel userId:userId];
                        
                        [manageDAtaObject writeArquivos:[dic valueForKey:@"novo_pdf_precos"] deTipo:@"precos" paraImovelId:idImovel userId:userId];
                        
                        [manageDAtaObject writeArquivos:[dic valueForKey:@"novo_quadro_areasPDFf"] deTipo:@"quadroAreas" paraImovelId:idImovel userId:userId];
                        
                        [manageDAtaObject writeArquivos:[dic valueForKey:@"novo_fotos_obra"] deTipo:@"fotosObra" paraImovelId:idImovel userId:userId];
                        
                        [manageDAtaObject writeArquivos:[dic valueForKey:@"novo_videos"] deTipo:@"videos" paraImovelId:idImovel userId:userId];
                       
                        [manageDAtaObject writePhotos3d:[dic valueForKey:@"Fotos3d"] : idImovel];
                        
                        if (![[dic valueForKey:@"url_youtube"] isEqual:[NSNull null]] && ![[dic valueForKey:@"url_youtube"] isEqualToString:@""]) {
                            NSString *youtube = [[dic valueForKey:@"url_youtube"] stringByReplacingOccurrencesOfString:@"http://" withString:@""];
                            if (youtube.length>5) {
                                [manageDAtaObject writeArquivos:[NSString stringWithFormat:@"::%@;", youtube] deTipo:@"youtube" paraImovelId:idImovel userId:userId];
                            }
                        }
                        
                    }
                    
                    
                    
                    progress = progress+step;
                    
                    [_appdelegate.infoToSync removeObjectAtIndex:0];
                    
                }
                @catch (NSException *exception) {
                    NSLog(@"getImoveis expection -> %@", exception.description);
                }
                //});
            }
            [self checkImovelRemovido:[[NSMutableArray alloc]initWithArray:notification.object]];
            downloadFinalizado = TRUE;
            _appdelegate.syncDatabase = FALSE;
            //[_appdelegate sincronizaArquivos];
            NSLog(@"Sincronismo Finalizado");
            
            [_appdelegate sqliteDoQuery:[NSString stringWithFormat:@"INSERT INTO ZHISTORICO (ZEMPRESA, ZDATA, ZCOMENTARIO, ZLOGIN, ZTIPO) VALUES ((Select ZIDEMPRESA from ZEMPRESA where ZCURRENT = 1),  datetime('now') , '%d imóveis inseridos/atualizados [%@]', (SELECT ZEMAIL FROM ZLOGINS WHERE ZCURRENT = 1) , 'Sincronização Imóveis')", numImoveisSinc, idsImoveisAtualizados]];
            
            //NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:10] forKey:@"status"];
            /*
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"sincroImoveisFinalizado" object:self userInfo:nil];
            });*/
            [_appdelegate atualizaArquivos];
        }
        @catch (NSException *exception) {
            NSLog(@"atualizaImoveis erro %@", exception.description);
        }
        
    });
   
}


-(void)checkImovelRemovido:(id)json{
    int imoveisRemovidos = 0;
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
    
    
}

-(void)eraseImovelWithId:(int)idImovel andUserId:(int)userId shouldDeleteFile:(BOOL)deleteFile{
    [self removeImovelWithId:idImovel andUserId:userId shouldDeleteFile:deleteFile];
    [self removeImagesWithId:idImovel andUserId:userId shouldDeleteFile:deleteFile];
    [self removePlantasWithId:idImovel andUserId:userId shouldDeleteFile:deleteFile];
    [self removeArquivosWithId:idImovel andUserId:userId shouldDeleteFile:deleteFile];
    [self removeFotos3dWithId:idImovel andUserId:userId shouldDeleteFile:deleteFile];
}

-(void)removeImovelWithId:(int)idImovel andUserId:(int)userId shouldDeleteFile:(BOOL)deleteFile{
    [_appdelegate sqliteDoQuery:[NSString stringWithFormat:@"DELETE FROM ZIMOVEL WHERE ZIDIMOVEL = %d AND ZUSERID = %d;",idImovel, userId]];
    [_appdelegate sqliteDoQuery:[NSString stringWithFormat:@"DELETE FROM ZIMOVELSINCRONIZADO WHERE ZIDIMOVEL = %d AND ZUSERID = %d;",idImovel, userId]];
    
}

-(void)removeImagesWithId:(int)idImovel andUserId:(int)userId shouldDeleteFile:(BOOL)deleteFile{
    [_appdelegate sqliteDoQuery:[NSString stringWithFormat:@"DELETE FROM ZIMAGENS WHERE ZIDIMOVEL = %d AND ZUSERID = %d;",idImovel, userId]];
}

-(void)removePlantasWithId:(int)idImovel andUserId:(int)userId shouldDeleteFile:(BOOL)deleteFile{
    [_appdelegate sqliteDoQuery:[NSString stringWithFormat:@"DELETE FROM ZPLANTAS WHERE ZIDIMOVEL = %d AND ZUSERID = %d;",idImovel, userId]];
}

-(void)removeArquivosWithId:(int)idImovel andUserId:(int)userId shouldDeleteFile:(BOOL)deleteFile{
    [_appdelegate sqliteDoQuery:[NSString stringWithFormat:@"DELETE FROM ZARQUIVOS WHERE ZIDIMOVEL = %d AND ZUSERID = %d;",idImovel, userId]];
}

-(void)removeFotos3dWithId:(int)idImovel andUserId:(int)userId shouldDeleteFile:(BOOL)deleteFile{
    [_appdelegate sqliteDoQuery:[NSString stringWithFormat:@"DELETE FROM ZFOTOS3D WHERE ZIDIMOVEL = %d AND ZUSERID = %d;",idImovel, userId]];
}


#pragma mark - Empresa

-(void)atualizaEmpresas:(id)Json{
    manageDAtaObject=[[WriteDataBase alloc]init];
    _appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
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
    
    });

}

-(void)resumeSincro{
    NSLog(@"resume sinc %d imoveis", _appdelegate.infoToSync.count);
    manageDAtaObject=[[WriteDataBase alloc]init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        
       
        while (_appdelegate.infoToSync.count!=0) {
            NSDictionary *dic = [_appdelegate.infoToSync objectAtIndex:0];
            NSLog(@"gravando imóvel %@ - %@", [dic valueForKey:@"id"], [dic valueForKey:@"titulo"]);
            [manageDAtaObject writeDataBaseImovel:dic];
            
            [manageDAtaObject writeImages:dic];
            
            [manageDAtaObject writePlantas:dic];
            //NSLog(@"WRITE writePlantas %@",[_appdelegate sqliteDoQuery:@"Select ZLOGO from ZEMPRESA LIMIT 0, 1"]);
            [_appdelegate.infoToSync removeObjectAtIndex:0];
            
        }
        
        NSLog(@"Sincronismo Finalizado");
    
        
    });
    
}


- (void)getFileWithBaseUrl:(NSString*)directoryname withFileName:(NSString*)nameFile storeAtpath:(NSString*)downloadPath
{
        _appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
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
        
        [operation start];
    
}

- (void)showAlert //teletar
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Atenção" message:@"Problemas na conexão" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    
    [alert show];
}



-(NSData*)getDataImovelSincronizado:(NSString*)id_imovel{
    NSData *data;
    NSArray* query = [[NSArray alloc]initWithArray:[_appdelegate sqliteDoQuery:[NSString stringWithFormat:@"Select Zbin from ZImovelSincronizado where Zidimovel = %@",id_imovel]]];
    if (query.count==0) {
        return nil;
    }else{
        NSLog(@"query -> %@", query);
        return data;
    }
}


-(void)sqliteNotification:(NSNotification *)notification {
    NSDictionary *notificationInfo = notification.userInfo;
    if ([[notificationInfo valueForKey:@"sqlite3Notification"] integerValue]==100) {
    }
}

@end

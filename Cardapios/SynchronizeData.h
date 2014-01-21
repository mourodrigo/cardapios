//
//  SynchronizeData.m
//  Embraed
//
//  Created by MouRodrigo on 23/02/13.
//  Copyright (c) 2013 catalogbrasil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SynchronizeData : NSObject

@property (nonatomic) BOOL downloadFinalizado;
@property (nonatomic) BOOL continuarDownload;
@property (nonatomic) BOOL downloadEmpresaFinalizado;
@property (nonatomic) BOOL erroSincronismo;
@property (nonatomic) float progress;
@property (nonatomic) int numImoveisSinc;
- (void)getFileWithBaseUrl:(NSString*)directoryname withFileName:(NSString*)nameFile storeAtpath:(NSString*)downloadPath;

- (void)startSincro;
-(void)getImoveis;
-(void)resumeSincro;
-(void)atualizaEmpresas:(id)Json;
-(void)eraseImovelWithId:(int)idImovel andUserId:(int)userId shouldDeleteFile:(BOOL)deleteFile;
@end

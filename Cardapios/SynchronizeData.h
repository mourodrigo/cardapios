//
//  SynchronizeData.m
//  Embraed
//
//  Created by MouRodrigo on 23/02/13.
//  Copyright (c) 2013 catalogbrasil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SynchronizeData : NSObject

@property (nonatomic) float progressFood;
@property (nonatomic) float progressMenu;
@property (nonatomic) float progressRest;
@property (nonatomic) float progressCity;

- (void)getFileWithBaseUrl:(NSString*)directoryname withFileName:(NSString*)nameFile storeAtpath:(NSString*)downloadPath;

- (void)startSincro;
-(void)getImoveis;
-(void)resumeSincro;
-(void)atualizaEmpresas:(id)Json;
-(void)eraseImovelWithId:(int)idImovel andUserId:(int)userId shouldDeleteFile:(BOOL)deleteFile;
@end

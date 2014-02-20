//
//  SynchronizeData.m
//  Embraed
//
//  Created by MouRodrigo on 23/02/13.
//  Copyright (c) 2013 catalogbrasil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SynchronizeData : NSObject

@property (nonatomic) bool progressCategory;
@property (nonatomic) bool progressMenu;
@property (nonatomic) bool progressRest;
@property (nonatomic) bool progressCity;

- (void)getFileWithBaseUrl:(NSString*)directoryname withFileName:(NSString*)nameFile storeAtpath:(NSString*)downloadPath;

- (void)startSincro;
-(void)eraseImovelWithId:(int)idImovel andUserId:(int)userId shouldDeleteFile:(BOOL)deleteFile;
@end

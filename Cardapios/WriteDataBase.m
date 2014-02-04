
#import "WriteDataBase.h"

@interface WriteDataBase ()
{
    
    NSManagedObjectContext *objectContext;    
   
   // Imovel *dataImovel;
}


@end

@implementation WriteDataBase



- (void)beginWriteData
{

    _appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //[_appdelegate eraseAllDataBAse]; //SINCRO //teletar
    
    objectContext = [_appdelegate managedObjectContext];
    
}


- (void)writeDataBaseEmpresa:(NSDictionary *)dicJson
{
/*    _appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    objectContext = [_appdelegate managedObjectContext];

    Empresa *dataEmpresa = [NSEntityDescription insertNewObjectForEntityForName:@"Empresa" inManagedObjectContext:objectContext];
    //NSLog(@"writeDataBaseEmpresa %@", dicJson);
    
    NSLog(@"Adicionando no banco %@ - %@", [dicJson valueForKey:@"id"],[dicJson valueForKey:@"titulo"]);
    
    [dataEmpresa setValue:[self testIfIsNull:[dicJson valueForKey:@"background"]] forKey:@"background"];
    [dataEmpresa setValue:[self testIfIsNull:[dicJson valueForKey:@"blog"]] forKey:@"blog"];
    [dataEmpresa setValue:[self testIfIsNumber:[dicJson valueForKey:@"bloquear"]] forKey:@"bloquear"];
    [dataEmpresa setValue:[self testIfIsNull:[dicJson valueForKey:@"categoria_padrao"]] forKey:@"categoria_padrao"];
    [dataEmpresa setValue:[self testIfIsNull:[dicJson valueForKey:@"facebook"]] forKey:@"facebook"];
    [dataEmpresa setValue:[self testIfIsNumber:[dicJson valueForKey:@"id"]] forKey:@"idEmpresa"];
    [dataEmpresa setValue:[self testIfIsNull:[dicJson valueForKey:@"idioma_padrao"]] forKey:@"idioma_padrao"];
    [dataEmpresa setValue:[self testIfIsNull:[dicJson valueForKey:@"instagram"]] forKey:@"instagram"];
    [dataEmpresa setValue:[self testIfIsNull:[dicJson valueForKey:@"logomarca"]] forKey:@"logo"];
    [dataEmpresa setValue:[self testIfIsNull:[dicJson valueForKey:@"logomarca_com_fundo"]] forKey:@"logomarca_com_fundo"];
    [dataEmpresa setValue:[self testIfIsNull:[dicJson valueForKey:@"logomarca_reduzida"]] forKey:@"logomarca_reduzida"];
    [dataEmpresa setValue:[self testIfIsNull:[dicJson valueForKey:@"modulos"]] forKey:@"modulos"];
    [dataEmpresa setValue:[self testIfIsNull:[dicJson valueForKey:@"moeda"]] forKey:@"moeda"];
    [dataEmpresa setValue:[self testIfIsNull:[dicJson valueForKey:@"pinterest"]] forKey:@"pinterest"];
    [dataEmpresa setValue:[self testIfIsNull:[dicJson valueForKey:@"twitter"]] forKey:@"twitter"];
    [dataEmpresa setValue:[self testIfIsNull:[dicJson valueForKey:@"website"]] forKey:@"website"];
    [dataEmpresa setValue:[self testIfIsNull:[dicJson valueForKey:@"titulo"]] forKey:@"titulo"];
    [dataEmpresa setValue:[self testIfIsNull:[dicJson valueForKey:@"youtube"]] forKey:@"youtube"];
    [dataEmpresa setValue:[self testIfIsNumber:[dicJson valueForKey:@"current"]] forKey:@"current"];
    [dataEmpresa setValue:[self testIfIsNumber:[dicJson valueForKey:@"sincronizado"]] forKey:@"sincronizado"];
    [dataEmpresa setValue:[self testIfIsNumber:[dicJson valueForKey:@"userId"]] forKey:@"userId"];
    [dataEmpresa setValue:[self testIfIsNull:[dicJson valueForKey:@"senha"]] forKey:@"senha"];
    
    [objectContext save:nil];*/
}

- (void)writeDataImovel:(NSDictionary *)dicJson
{
    /*
    _appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    objectContext = [_appdelegate managedObjectContext];
    
    ImovelSincronizado *Sincronizado = [NSEntityDescription insertNewObjectForEntityForName:@"ImovelSincronizado" inManagedObjectContext:objectContext];
    
    [Sincronizado setValue:[self testIfIsNumber:[dicJson valueForKey:@"idImovel"]] forKey:@"idImovel"];
    [Sincronizado setValue:[dicJson valueForKey:@"bin"] forKey:@"bin"];
    [Sincronizado setValue:[dicJson valueForKey:@"lenght"] forKey:@"lenght"];
    [Sincronizado setValue:[dicJson valueForKey:@"userId"] forKey:@"userId"];
    
    
    [objectContext save:nil];*/
}

- (void)writeDataBaseImovel:(NSDictionary *)dicJson
{
    //NSLog(@"dicJson %@", dicJson);
    /*
    
    dataImovel = [NSEntityDescription insertNewObjectForEntityForName:@"Imovel" inManagedObjectContext:objectContext];
    
    [dataImovel setValue:[self testIfIsNull:[dicJson valueForKey:@"endereco"]] forKey:@"address"];
    
    [dataImovel setValue:[self testIfIsNull:[dicJson valueForKey:@"categoria"]] forKey:@"category"];
    
    [dataImovel setValue:[self testIfIsNull:[dicJson valueForKey:@"cep"]] forKey:@"cep"];
    
    [dataImovel setValue:[self testIfIsNull:[dicJson valueForKey:@"cidade"]] forKey:@"city"];
    
    [dataImovel setValue:[self testIfIsNull:[dicJson valueForKey:@"cf_foto_horizontal"]] forKey:@"cf_foto_horizontal"];
    
    [dataImovel setValue:[self testIfIsNull:[dicJson valueForKey:@"cf_foto_vertical"]] forKey:@"cf_foto_vertical"];
    
    [dataImovel setValue:FALSE forKey:@"favorite"];
    
    [dataImovel setValue:[self testIfIsNumber:[dicJson valueForKey:@"destaque"]] forKey:@"featured"];
    
    [dataImovel setValue:[self testIfIsNull:[dicJson valueForKey:@"fotoPrincipal"]] forKey:@"fotoPrincipal"];
    
    [dataImovel setValue:[self testIfIsNull:[dicJson valueForKey:@"cidade"]] forKey:@"city"];
    
    [dataImovel setValue:[self testIfIsNumber:[dicJson valueForKey:@"id"]] forKey:@"idImovel"];

    [dataImovel setValue:[self testIfIsNull:[dicJson valueForKey:@"latitude"]] forKey:@"latitude"];
    
    [dataImovel setValue:[self testIfIsNull:[dicJson valueForKey:@"longitude"]] forKey:@"longitude"];
    
    [dataImovel setValue:[self testIfIsNull:[dicJson valueForKey:@"bairro"]] forKey:@"neighborhood"];
    
    [dataImovel setValue:[self testIfIsNumber:[dicJson valueForKey:@"quartos"]]forKey:@"numQuartos"];
    
    [dataImovel setValue:[self testIfIsNull:[dicJson valueForKey:@"obraInicioTermino"]] forKey:@"obraInicioTermino"];
    
    [dataImovel setValue:[self testIfIsNull:[dicJson valueForKey:@"informacoes_proprietario"]] forKey:@"owner_info"];
    
    [dataImovel setValue:[self testIfIsNull:[dicJson valueForKey:@"pequena_descricao"]] forKey:@"pequena_descricao"];
    
    [dataImovel setValue:[self testIfIsNull:[dicJson valueForKey:@"referencia"]] forKey:@"ref"];
    
    [dataImovel setValue:[self testIfIsNull:[dicJson valueForKey:@"uf"]] forKey:@"state"];
    
    [dataImovel setValue:[self testIfIsNumber:[dicJson valueForKey:@"suites"]]forKey:@"suites"];
    
    [dataImovel setValue: [self testIfIsNull:[dicJson valueForKey:@"descricao"]] forKey:@"textInformation"];
    
    [dataImovel setValue:[self testIfIsNull:[dicJson valueForKey:@"titulo"]] forKey:@"title"];
    
    [dataImovel setValue: [self testIfIsNull:[dicJson valueForKey:@"tipo"]] forKey:@"type"];
  
    [dataImovel setValue: [self testIfIsNull:[dicJson valueForKey:@"porcentagens"]] forKey:@"percentObra"];
    
    [dataImovel setValue:[self testIfIsNumber:[dicJson valueForKey:@"valor_venda"]] forKey:@"valor_venda"];
    
    [dataImovel setValue:[self testIfIsNumber:[dicJson valueForKey:@"userId"]] forKey:@"userId"];
    
    [dataImovel setValue:[[[self testIfIsNull:[[dicJson valueForKey:@"area_util"] stringValue]] stringByReplacingOccurrencesOfString:@"m2" withString:@""] stringByAppendingString:@"m²"] forKey:@"areaUtil"];
    
    [dataImovel setValue:[NSDate date] forKey:@"dataSincronizado"];
  
    [dataImovel setValue:[self testIfIsNumber:[dicJson valueForKey:@"idEmpresa"]] forKey:@"idEmpresa"];

    //[self writeFiles:[[dicJson valueForKey:@"novo_fotos"] componentsSeparatedByString:@";"] :@"photos"]; //TELETAR
    
    //[self writeFiles:[[dicJson valueForKey:@"novo_plantas"] componentsSeparatedByString:@";"] :@"floorPlan"];
    
    
    [objectContext save:nil];*/
    
}

-(void)writeImages:(NSDictionary*)dicJson{
    /*if ([self testIfIsNull:[dicJson valueForKey:@"novo_fotos"]].length!=0) {
        NSArray *arrFotos = [[NSArray alloc]initWithArray:[[self testIfIsNull:[dicJson valueForKey:@"novo_fotos"]] componentsSeparatedByString:@";"]];
        
        
        for (NSString *infoFoto in arrFotos) {
            
            NSArray *foto  = [[NSArray alloc]initWithArray:[infoFoto componentsSeparatedByString:@":"]];
            if (foto.count>2) {
                
                
                Imagens *images = [NSEntityDescription insertNewObjectForEntityForName:@"Imagens" inManagedObjectContext:objectContext];
                
                [images setValue:[self testIfIsNumber:[dicJson valueForKey:@"id"]]forKey:@"idImovel"];
                
                [images setValue:[self testIfIsNull:[foto objectAtIndex:0]] forKey:@"category"];
                
                [images setValue:[self testIfIsNull:[foto objectAtIndex:1]] forKey:@"title"];
                
                [images setValue:[self testIfIsNull:[foto objectAtIndex:2]] forKey:@"name"];
                
                [images setValue:[self testIfIsNumber:[dicJson valueForKey:@"userId"]] forKey:@"userId"];
                
                [objectContext save:nil];
                
            }
        }
    }*/
}

-(void)writePlantas:(NSDictionary*)dicJson{
  /*  if ([self testIfIsNull:[dicJson valueForKey:@"novo_plantas"]].length!=0) {
        NSArray *arrFotos = [[NSArray alloc]initWithArray:[[self testIfIsNull:[dicJson valueForKey:@"novo_plantas"]] componentsSeparatedByString:@";"]];
        for (NSString *infoFoto in arrFotos) {
            
                NSArray *foto  = [[NSArray alloc]initWithArray:[infoFoto componentsSeparatedByString:@":"]];
                if (foto.count>2) {
                   
                    Plantas *plants = [NSEntityDescription insertNewObjectForEntityForName:@"Plantas" inManagedObjectContext:objectContext];
                    
                    [plants setValue:[self testIfIsNumber:[dicJson valueForKey:@"id"]]forKey:@"idImovel"];
                    
                    [plants setValue:[self testIfIsNull:[foto objectAtIndex:0]] forKey:@"category"];
                    
                    [plants setValue:[self testIfIsNull:[foto objectAtIndex:1]] forKey:@"title"];
                    
                    [plants setValue:[self testIfIsNull:[foto objectAtIndex:2]] forKey:@"name"];
                    
                    [plants setValue:[self testIfIsNumber:[dicJson valueForKey:@"userId"]] forKey:@"userId"];
                    
                    [objectContext save:nil];
                    
                }
            
        }
    }*/
}

-(void)writeArquivos:(NSString*)campo deTipo:(NSString*)tipo paraImovelId:(int)idImovel userId:(int)userId{
    /* if (campo.length!=0) {
        NSLog(@"\n\nwrite arquivos %@", campo);
         
        NSArray *arquivo = [[NSArray alloc]initWithArray:[campo componentsSeparatedByString:@";"]];
        
        for (NSString *infoArquivo in arquivo) {
            NSLog(@"arquivo %@", infoArquivo);
            NSArray *arrArquivo  = [[NSArray alloc]initWithArray:[infoArquivo componentsSeparatedByString:@":"]];
            if (arrArquivo.count>2) {
                
                NSLog(@"gravando arquivo %@", arrArquivo);
                
                Arquivos *dateFiles= [NSEntityDescription insertNewObjectForEntityForName:@"Arquivos" inManagedObjectContext:objectContext];
                
                [dateFiles setValue:tipo forKey:@"typeFile"];
                
                [dateFiles setValue:[self testIfIsNull:[arrArquivo objectAtIndex:0]]  forKey:@"category"];
                
                [dateFiles setValue:[self testIfIsNull:[arrArquivo objectAtIndex:1]] forKey:@"title"];
                
                [dateFiles setValue:[self testIfIsNull:[arrArquivo objectAtIndex:2]]  forKey:@"name"];
                
                [dateFiles setValue:[NSNumber numberWithInt:idImovel]  forKey:@"idImovel"];

                [dateFiles setValue:[NSNumber numberWithInt:userId]  forKey:@"userId"];

                [dataImovel addRelationshipObject:dateFiles];
                [objectContext save:nil];
            }else{
                NSLog(@"paraetros inválidos para gravar arquivo");
            }
            
        }
    }*/
}


-(void)writeFiles:(NSArray*)arrayFiles :(NSString*)type{
/*
    for (NSString *stringInArray in arrayFiles) {
        
        if ([[stringInArray componentsSeparatedByString:@":"] count]==3) {
            
            Arquivos *dateFiles= [NSEntityDescription insertNewObjectForEntityForName:@"Arquivos" inManagedObjectContext:objectContext];
            
            [dateFiles setValue:type forKey:@"typeFile"];
            
            [dateFiles setValue:[[stringInArray componentsSeparatedByString:@":"] objectAtIndex:0] forKey:@"category"];
            
            [dateFiles setValue:[[stringInArray componentsSeparatedByString:@":"] objectAtIndex:1] forKey:@"title"];
            
            [dateFiles setValue:[[stringInArray componentsSeparatedByString:@":"] objectAtIndex:2]  forKey:@"name"];
            
            [dataImovel addRelationshipObject:dateFiles];

        }
        
    }
*/
}


-(void)writePhotos3d:(NSArray*)arrayPhotos3d :(int)idImovel{
    /*
    for (NSDictionary *dic in arrayPhotos3d) {
      
        Fotos3d *dataFotos3d = [NSEntityDescription insertNewObjectForEntityForName:@"Fotos3d" inManagedObjectContext:objectContext];
        
        [dataFotos3d setValue:[dic objectForKey:@"titulo"] forKey:@"title"];
        [dataFotos3d setValue:[dic objectForKey:@"front"] forKey:@"front"];
        [dataFotos3d setValue:[dic objectForKey:@"left"] forKey:@"left"];
        [dataFotos3d setValue:[dic objectForKey:@"right"] forKey:@"right"];
        [dataFotos3d setValue:[dic objectForKey:@"back"] forKey:@"back"];
        [dataFotos3d setValue:[dic objectForKey:@"top"] forKey:@"top"];
        [dataFotos3d setValue:[dic objectForKey:@"down"] forKey:@"down"];
        [dataFotos3d setValue:[self testIfIsNumber:[dic valueForKey:@"id"]] forKey:@"idImovel"];
        [dataFotos3d setValue:[NSNumber numberWithInt:[_appdelegate getUserId]] forKey:@"userId"];
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        [dataFotos3d setValue:[f numberFromString:[dic objectForKey:@"id"]] forKey:@"id"];
        
        //NSNumber*imovel_id = [f numberFromString:[dic objectForKey:@"idImovel"]];
        
        [dataFotos3d setValue:[NSNumber numberWithInt:idImovel] forKey:@"idImovel"];
    
        [dataImovel addRelationship1Object:dataFotos3d];
        
    }*/
}


-(NSString*)testIfIsNull:(NSString*)text{
    
    if (![text isEqual:[NSNull null]]) {
        
        return text;
        
    } else  return @"";
    
    
}

-(NSNumber*)testIfIsNumber:(id)value{
    if (![value isEqual:[NSNull null]]) {
        return [[NSNumber alloc] initWithFloat:[value floatValue]];
    } else return [[NSNumber alloc] initWithFloat:0];
}







@end

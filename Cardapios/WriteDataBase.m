
#import "WriteDataBase.h"
#import "Restaurant.h"
#import "Menu.h"
#import "City.h"
#import "FoodCategory.h"

@interface WriteDataBase ()
{
    
    NSManagedObjectContext *objectContext;    
   
    Restaurant *rest;
    FoodCategory *category;
    Menu *menu;
    City *city;
}


@end

@implementation WriteDataBase



- (void)beginWriteData
{

    _appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //[_appdelegate eraseAllDataBAse]; //SINCRO //teletar
    
    objectContext = [_appdelegate managedObjectContext];
    
}



- (void)writeRestaurant:(NSDictionary *)dicJson
{
    NSLog(@"dicJson %@", dicJson);
    
    rest = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:objectContext];
  
    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"endereco"]] forKey:@"address"];
    
    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"celular"]] forKey:@"cellphone"];
    
    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"senha"]] forKey:@"password"];
    
    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"logomarca"]] forKey:@"logo"];
    
    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"descricao_en"]] forKey:@"text_en"];
    
    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"descricao_pt"]] forKey:@"text_pt"];
    
    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"descricao_es"]] forKey:@"text_es"];
    
    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"cidade"]] forKey:@"city"];
 
    [rest setValue:[self getDateFromString:[dicJson valueForKey:@"horario_funcionamento_abertura"]] forKey:@"timeOpen"];

    [rest setValue:[self getDateFromString:[dicJson valueForKey:@"horario_funcionamento_fechamento"]] forKey:@"timeClose"];

    [rest setValue:[NSNumber numberWithInt:[[dicJson valueForKey:@"aceita_master"] integerValue]] forKey:@"master"];

    [rest setValue:[NSNumber numberWithInt:[[dicJson valueForKey:@"aceita_visa"] integerValue]] forKey:@"visa"];

    [rest setValue:[NSNumber numberWithInt:[[dicJson valueForKey:@"aceita_american"] integerValue]] forKey:@"american"];

    [rest setValue:[NSNumber numberWithInt:[[dicJson valueForKey:@"aceita_dinheiro"] integerValue]] forKey:@"cash"];

    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"email"]] forKey:@"email"];
    
    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"img0"]] forKey:@"image1"];

    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"img1"]] forKey:@"image2"];

    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"img2"]] forKey:@"image3"];

    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"img3"]] forKey:@"image4"];

    [rest setValue:[self testIfIsNumber:[dicJson valueForKey:@"latitude"]] forKey:@"latitude"];

    [rest setValue:[self testIfIsNumber:[dicJson valueForKey:@"longitude"]] forKey:@"longitude"];

    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"telefone"]] forKey:@"phone1"];

    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"telefone2"]] forKey:@"phone2"];

    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"cnpj"]] forKey:@"cnpj"];

    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"cep"]] forKey:@"cep"];

    [rest setValue:[self testIfIsNumber:[dicJson valueForKey:@"id"]] forKey:@"idRest"];

    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"nome"]] forKey:@"name"];
    
    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"bairro"]] forKey:@"district"];
    
    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"empresa"]] forKey:@"company"];
    
/*
    [rest setValue:FALSE forKey:@"favorite"];
    
    [rest setValue:[self testIfIsNumber:[dicJson valueForKey:@"destaque"]] forKey:@"featured"];
    
    [rest setValue:[NSDate date] forKey:@"dataSincronizado"];
  */
    
    [objectContext save:nil];
    
}

- (void)writeCity:(NSDictionary *)dicJson
{
    NSLog(@"writeCity %@", dicJson);
    city = [NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:objectContext];
    [city setValue:[self testIfIsNumber:[dicJson valueForKey:@"id"]] forKey:@"idCity"];
    [city setValue:[self testIfIsNull:[dicJson valueForKey:@"nome"]] forKey:@"name"];
    
    [objectContext save:nil];
    
}

- (void)writeMenu:(NSDictionary *)dicJson
{
    NSLog(@"writeMenu %@", dicJson);
    menu = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:objectContext];
    [menu setValue:[self testIfIsNumber:[dicJson valueForKey:@"id"]] forKey:@"idCity"];
    [menu setValue:[self testIfIsNull:[dicJson valueForKey:@"nome"]] forKey:@"name"];
    
    [objectContext save:nil];
    
}

- (void)writeCategory:(NSDictionary *)dicJson
{
    NSLog(@"writeCategory %@", dicJson);
    category = [NSEntityDescription insertNewObjectForEntityForName:@"FoodCategory" inManagedObjectContext:objectContext];
    [category setValue:[self testIfIsNumber:[dicJson valueForKey:@"id"]] forKey:@"idFood"];
    [category setValue:[self testIfIsNull:[dicJson valueForKey:@"nome"]] forKey:@"name"];
    
    [objectContext save:nil];
    
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


-(NSDate*)getDateFromString:(NSString*)strDate{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"hh:mm:ss"];
    return [df dateFromString: strDate];
}




@end

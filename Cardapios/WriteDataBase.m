
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
    
    [_appdelegate eraseDb]; //SINCRO //teletar
    
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

    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"latitude"]] forKey:@"latitude"];

    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"longitude"]] forKey:@"longitude"];

    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"telefone"]] forKey:@"phone1"];

    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"telefone2"]] forKey:@"phone2"];

    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"cnpj"]] forKey:@"cnpj"];

    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"cep"]] forKey:@"cep"];

    [rest setValue:[self testIfIsNumber:[dicJson valueForKey:@"id"]] forKey:@"idRest"];

    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"nome"]] forKey:@"name"];
    
    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"bairro"]] forKey:@"district"];
    
    [rest setValue:[self testIfIsNull:[dicJson valueForKey:@"empresa"]] forKey:@"company"];
    
    [rest setValue:FALSE forKey:@"favorite"];
/*
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
    
    [menu setValue:[self testIfIsNull:[dicJson valueForKey:@"descricao"]] forKey:@"descr"];
    [menu setValue:[self testIfIsNumber:[dicJson valueForKey:@"id"]] forKey:@"idMenu"];
    [menu setValue:[self testIfIsNumber:[dicJson valueForKey:@"id_categoria"]] forKey:@"idCategory"];
    [menu setValue:[self testIfIsNumber:[dicJson valueForKey:@"id_restaurante"]] forKey:@"idRestaurant"];
    [menu setValue:[self testIfIsNull:[dicJson valueForKey:@"nome"]] forKey:@"name"];
    [menu setValue:[self testIfIsNumber:[dicJson valueForKey:@"valor"]] forKey:@"value"];
    [menu setValue:FALSE forKey:@"favorite"];
    
    
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

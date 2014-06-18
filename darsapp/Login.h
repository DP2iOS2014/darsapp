//
//  Login.h
//  darsapp
//
//  Created by inf227al on 18-06-14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol loginDelegate <NSObject>
@optional
-(void)loginExito;
-(void)loginFallo:(NSString*)mensaje;
-(void)falloServidor;
@end

@interface Login : NSObject

@property (nonatomic, weak) id <loginDelegate> delegate;

+ (id)sharedManager;
+(void) jsonLoginConUsuarioPersistente:(NSString*)NombreUsuario yPassword:(NSString*)ContraseñaUsuario;
+(void) jsonLoginConUsuario:(NSString*)NombreUsuario yPassword:(NSString*)ContraseñaUsuario;
@end

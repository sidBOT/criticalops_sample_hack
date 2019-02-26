#import <UIKit/UIKit.h>
#import <substrate.h>
#import <initializer_list>
#import <vector>
#import <map>
#import <mach-o/dyld.h>
#import <string>
#import <Foundation/Foundation.h>
#import "writeData.h"
#import <UIKit/UIKit.h>
#import <initializer_list>
#import <vector>
#import <mach-o/dyld.h>
#import <UIKit/UIKit.h>
#import <iostream>
#import <stdio.h>
#include <sstream>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <string.h>
#include <algorithm>
#include <fstream>
#include <ifaddrs.h>

using namespace std;

vector<string> users; //List of registered users

NSString * makeRestAPICall(NSString* reqURLStr);
NSString * XAuth = @"";//REMOVED 
bool radar=false;
bool hitbox=true;
string num="op1";

//C# string to C/C++ string 
typedef struct _monoString
{
    void* klass;
    void* monitor;
    int length;
    char chars[1];
    int getLength()
    {
      return length;
    }
    char* getChars()
    {
        return chars;
    }
    NSString* toNSString()
    {
      return [[NSString alloc] initWithBytes:(const void *)(chars)
                     length:(NSUInteger)(length * 2)
                     encoding:(NSStringEncoding)NSUTF16LittleEndianStringEncoding];
    }

    char* toCString()
    {
      NSString* v1 = toNSString();
      return (char*)([v1 UTF8String]);
    }
    std::string toCPPString()
    {
      return std::string(toCString());
    }
}monoString;

uint64_t getRealOffset(uint64_t offset){
    return _dyld_get_image_vmaddr_slide(0)+offset;
}

///////////////SERVER CALL DO NOT TOUCH/////////////////////
///////////////SERVER CALL DO NOT TOUCH/////////////////////

vector<string> parseRegisteredUsers(NSDictionary *queryDictionary) {
    vector<string> users;
    for (NSString *q1 in queryDictionary) {
        std::string mac = std::string([q1 UTF8String]);
        users.push_back(mac);
    }
    for(int i = 0; i < users.size();i++) {
        cout<<"mac: "<<users[i];
    }
    return users;
}

NSString * makeRestAPICall(NSString* reqURLStr) {
        NSURLRequest *Request = [NSURLRequest requestWithURL:[NSURL URLWithString: reqURLStr]];
        NSURLResponse *resp = nil;
        NSError *error = nil;
        NSData *response = [NSURLConnection sendSynchronousRequest: Request returningResponse: &resp error: &error];
        NSString *responseString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        NSLog(@"%@",responseString);
        return responseString;
}

void verifyUser() {
    
    NSString * api = @""; //REMOVED
    api = [api stringByAppendingString:XAuth];
    NSString *resp = makeRestAPICall(api);
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization
                     JSONObjectWithData:[resp dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
    if (jsonObject != nil && error == nil) {
        NSLog(@"Successfully deserialized...");
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
            NSLog(@"Deserialized JSON Dictionary = %@", deserializedDictionary);
            NSDictionary *queryDictionary_users = [deserializedDictionary valueForKey:@"users"];
            users = parseRegisteredUsers(queryDictionary_users);
            
            
        } else if ([jsonObject isKindOfClass:[NSArray class]]) {
            NSArray *deserializedArray = (NSArray *)jsonObject;
            NSLog(@"Deserialized JSON Array = %@", deserializedArray);
            
            
        } else {
            
        }
    } else {
        if (error != nil) {
            NSLog(@"An error happened while deserializing the JSON data.");
        }
    }
    
}

/*
*   Check the user's UUID with the registered users and return true if the user exist
*/
bool verified() {
    NSString *  uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    string s_uuid = std::string([uuid UTF8String]);
    for(int i =0; i < users.size();i++) {
        if(!users[i].compare(s_uuid)) {
            return true;
        }
    }
    return false;
}


///////////////SERVER CALL OVER/////////////////////
///////////////SERVER CALL OVER/////////////////////

void (*GameSystem_Update)(void *update, float dt);
void _GameSystem_Update(void *update, float dt){
    
    if(update) {
        if(radar) {
            writeData(0x0,0x0);
        }else {
            writeData(0x0,0x0);
        }
        if(hitbox) {
            if(!num.compare("op1")) {
                writeData(0x0, 0x0); 
            }else if(!num.compare("op2")) {
                writeData(0x0, 0x0);
            }else if(!num.compare("op3")) {
                writeData(0x0, 0x0);
            }else {
                writeData(0x0, 0x0);
            }
            writeData(0x0, 0x0);
        }else {
            writeData(0x0, 0x0);
            writeData(0x0, 0x0);
        }
    }
    GameSystem_Update(update, dt);
}

void (*gameplay_tick_update)(void * update, float time);
void _gameplay_tick_update(void * update, float time) {

    if(update != NULL) {
		void * aimAssistSettings = *(void **)((uint64_t)update + 0x0);
		if(aimAssistSettings != NULL) {
            void * (*getAA)(void *update) = (void *(*)(void *))getRealOffset(0x0); 
			void * savedFloat = getAA(aimAssistSettings);
				if(savedFloat != NULL) {
                    void (*setValue)(void *update, float val) = (void (*)(void *, float))getRealOffset(0x0); 
					setValue(savedFloat, 1.45);
				}
		}
	}
	
	gameplay_tick_update(update, time);
}

/*
*   Function to get the ingame chat messages
*/
void (*RequestSendIngameChatMessage)(void * _this, monoString * msg, int type);
void _RequestSendIngameChatMessage(void * _this, monoString * msg, int type) {

    
    if(_this) {
        char * m = msg->toCString();
        string rate = m;
        
        if(strcmp(m, "/ron") == 0 || strcmp(m, "/Ron") == 0) {
            radar = true;
        }else if(strcmp(m, "/roff") == 0 || strcmp(m, "/Roff") == 0) {
            radar = false;
        }else if(strcmp(m, "/set-op1") == 0 || strcmp(m, "/Set-op1") == 0) {
            num = "op1";
        }else if(strcmp(m, "/set-op2") == 0 || strcmp(m, "/Set-op2") == 0) {
            num = "op2";
        }else if(strcmp(m, "/set-op3") == 0 || strcmp(m, "/Set-op3") == 0) {
            num = "op3";
        }else if(strcmp(m, "/boxoff") == 0 || strcmp(m, "/Boxoff") == 0) {
            hitbox = false;
        }else if(strcmp(m, "/boxon") == 0 || strcmp(m, "/Boxon") == 0) {
            hitbox = true;
        }
    }
    RequestSendIngameChatMessage(_this, msg, type);
}

%hook UnityAppController


- (void)applicationDidBecomeActive:(id)arg0 {
    verifyUser();
    

    if(!verified()) {
        NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController * alert = [UIAlertController
                alertControllerWithTitle:@"Press Copy and send your id. APP WILL CRASH AFTER YOU PRESS COPY"
                                 message:uuid
                          preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* yesButton = [UIAlertAction
                    actionWithTitle:@"COPY"
                              style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action) {
                                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                                pasteboard.string = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
                                exit(0); //Crash the app after pressing "COPY"
                            }];
        alert.view.tintColor = [UIColor redColor];


        [alert addAction:yesButton];
        

        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alert animated:YES completion:^{
        }];
        });
       
    }
    return %orig();
}

%new

%end

%ctor {
    verifyUser();
    //Only hook is the User is registered
    if(verified()) {
        MSHookFunction((void *)getRealOffset(0x0), (void *)_GameSystem_Update, (void **)&GameSystem_Update);
        MSHookFunction((void *)getRealOffset(0x0),(void *) _RequestSendIngameChatMessage, (void**)&RequestSendIngameChatMessage);
        MSHookFunction(((void*)getRealOffset(0x0)),(void *) _gameplay_tick_update, (void**)&gameplay_tick_update);
    }
}


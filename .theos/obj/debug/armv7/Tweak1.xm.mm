#line 1 "Tweak1.xm"
#import <substrate.h>
#import <mach-o/dyld.h>
#import <string>
#import <Foundation/Foundation.h>
#import "writeData.h"
#import <UIKit/UIKit.h>

using namespace std;


uint64_t getRealOffset(uint64_t offset){
    return _dyld_get_image_vmaddr_slide(0)+offset;
}

void (*gameplay_tick_update)(void * update, float time);
void _gameplay_tick_update(void * update, float time) {

    if(update != NULL) {
		void * aimAssistSettings = *(void **)((uint64_t)update + 0x1a8);
		if(aimAssistSettings != NULL) {
            void * (*getAA)(void *update) = (void *(*)(void *))getRealOffset(0x100272044); 
			void * savedFloat = getAA(aimAssistSettings);
				if(savedFloat != NULL) {
                    void (*setValue)(void *update, float val) = (void (*)(void *, float))getRealOffset(0x1001B20D4); 
					setValue(savedFloat, 1.46);
				}
		}
	}
	
	gameplay_tick_update(update, time);
}

NSString * randomStringWithLength(int len);
NSString * decoder(NSString* string);
void callme();


UIAlertView *alert;
NSUserDefaults *prefs;



#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class UnityAppController; 
static void (*_logos_orig$_ungrouped$UnityAppController$applicationDidBecomeActive$)(_LOGOS_SELF_TYPE_NORMAL UnityAppController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$UnityAppController$applicationDidBecomeActive$(_LOGOS_SELF_TYPE_NORMAL UnityAppController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$UnityAppController$alertView$clickedButtonAtIndex$(_LOGOS_SELF_TYPE_NORMAL UnityAppController* _LOGOS_SELF_CONST, SEL, UIAlertView *, NSInteger); 

#line 42 "Tweak1.xm"


NSString * n;
NSString * str;

static void _logos_method$_ungrouped$UnityAppController$applicationDidBecomeActive$(_LOGOS_SELF_TYPE_NORMAL UnityAppController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg0) {

	
    
    
    
    
    

	prefs = [NSUserDefaults standardUserDefaults];
    NSString *isStringSet = [prefs stringForKey:@"isStringSet"];
    if(![isStringSet isEqualToString:@"1"]) {
        n = randomStringWithLength(17); 
    }else {
        n = [prefs stringForKey:@"string"];
    }
    
    NSString *myString = @"0.9.10";
    if(![myString isEqualToString:@"0.9.10"]) {

alert = [[UIAlertView alloc] initWithTitle:@"Cops Extra AA by MaskMan  LOCKED" 
                                                  message:n
                                                 delegate:self 
										cancelButtonTitle:@"UNLOCK" 
										otherButtonTitles:@"Follow me", @"Donate", nil];

alert.alertViewStyle = UIAlertViewStylePlainTextInput;
[alert show];

}
return _logos_orig$_ungrouped$UnityAppController$applicationDidBecomeActive$(self, _cmd, arg0);
}


static void _logos_method$_ungrouped$UnityAppController$alertView$clickedButtonAtIndex$(_LOGOS_SELF_TYPE_NORMAL UnityAppController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIAlertView * alertView, NSInteger buttonIndex) {
 
	prefs = [NSUserDefaults standardUserDefaults];
    str = decoder(n);
	
    
	if(buttonIndex == 0) {
        if([[alertView textFieldAtIndex:0].text  isEqual: str]) {
            [prefs setObject:@"0.9.10" forKey:@"version"];
            
        }else {
        	
            [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(callme)
                                           userInfo:nil
                                            repeats:YES];
                                            [prefs synchronize];
        }
    }else if(buttonIndex == 1) {

    	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/M4skM4n007"]];
    	[NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(callme)
                                           userInfo:nil
                                            repeats:YES];
    }else if(buttonIndex == 2) {
    	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.me/Mr007"]];
    	[NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(callme)
                                           userInfo:nil
                                            repeats:YES];
    }
 
	
}


void callme() {
	[alert show];
}

NSString * randomStringWithLength(int len) {
    
    NSString *letters = @"abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:len];
    
    for (int i = 0; i < len; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }
    prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:@"1" forKey:@"isStringSet"];
    [prefs setObject:randomString forKey:@"string"];
    [prefs synchronize];

    return randomString;
}

NSString * decoder(NSString* string) {
    
    NSUInteger len = [string length];
    NSString * nString = @"";
    
    for( int i = 0; i<(len-2); i++) {
        
        int asciiCode = [string characterAtIndex:i];
        int newCode = (asciiCode + 3);
        NSString *string = [NSString stringWithFormat:@"%c", newCode];
        nString =  [nString stringByAppendingString:string];
    }
    
    
    
    return nString;
}


static __attribute__((constructor)) void _logosLocalCtor_6d0fb68d(int __unused argc, char __unused **argv, char __unused **envp) {
    MSHookFunction(((void*)getRealOffset(0x1002C0FD4)),(void *) _gameplay_tick_update, (void**)&gameplay_tick_update);
    writeData(0x100272798, 0x0070241E);
    writeData(0x10027279c, 0xc0035fd6);
}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$UnityAppController = objc_getClass("UnityAppController"); MSHookMessageEx(_logos_class$_ungrouped$UnityAppController, @selector(applicationDidBecomeActive:), (IMP)&_logos_method$_ungrouped$UnityAppController$applicationDidBecomeActive$, (IMP*)&_logos_orig$_ungrouped$UnityAppController$applicationDidBecomeActive$);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UIAlertView *), strlen(@encode(UIAlertView *))); i += strlen(@encode(UIAlertView *)); memcpy(_typeEncoding + i, @encode(NSInteger), strlen(@encode(NSInteger))); i += strlen(@encode(NSInteger)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$UnityAppController, @selector(alertView:clickedButtonAtIndex:), (IMP)&_logos_method$_ungrouped$UnityAppController$alertView$clickedButtonAtIndex$, _typeEncoding); }} }
#line 166 "Tweak1.xm"

#import <UIKit/UIKit.h>
#import <Security/Security.h>
/*
 The KeychainItemWrapper class is an abstraction layer for the iPhone Keychain communication. It is merely a
 simple wrapper to provide a distinct barrier between all the idiosyncracies involved with the Keychain
 CF/NS container objects.
 */
@interface KeychainItemWrapper : NSObject

// Designated initializer.
- (id)initWithIdentifier: (NSString *)identifier accessGroup:(NSString *)accessGroup;
- (void)setObject:(id)inObject forKey:(id)key;
- (id)objectForKey:(id)key;

// Initializes and resets the default generic keychain item data.
- (void)resetKeychainItem;

@end
#define PASSWORD_USES_DATA


/*
 
 These are the default constants and their respective types,
 available for the kSecClassGenericPassword Keychain Item class:
 
 kSecAttrAccessGroup			-		CFStringRef
 kSecAttrCreationDate		-		CFDateRef
 kSecAttrModificationDate    -		CFDateRef
 kSecAttrDescription			-		CFStringRef
 kSecAttrComment				-		CFStringRef
 kSecAttrCreator				-		CFNumberRef
 kSecAttrType                -		CFNumberRef
 kSecAttrLabel				-		CFStringRef
 kSecAttrIsInvisible			-		CFBooleanRef
 kSecAttrIsNegative			-		CFBooleanRef
 kSecAttrAccount				-		CFStringRef
 kSecAttrService				-		CFStringRef
 kSecAttrGeneric				-		CFDataRef
 
 See the header file Security/SecItem.h for more details.
 
 */

@interface KeychainItemWrapper (PrivateMethods)
/*
 The decision behind the following two methods (secItemFormatToDictionary and dictionaryToSecItemFormat) was
 to encapsulate the transition between what the detail view controller was expecting (NSString *) and what the
 Keychain API expects as a validly constructed container class.
 */
- (NSMutableDictionary *)secItemFormatToDictionary:(NSDictionary *)dictionaryToConvert;
- (NSMutableDictionary *)dictionaryToSecItemFormat:(NSDictionary *)dictionaryToConvert;

// Updates the item in the keychain, or adds it if it doesn't exist.
- (void)writeToKeychain;

@end
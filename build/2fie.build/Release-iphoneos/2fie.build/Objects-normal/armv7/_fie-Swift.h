// Generated by Apple Swift version 2.1.1 (swiftlang-700.1.101.15 clang-700.1.81)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if defined(__has_include) && __has_include(<uchar.h>)
# include <uchar.h>
#elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
#endif

typedef struct _NSZone NSZone;

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted) 
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
#endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import Foundation;
@import CoreGraphics;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UIWindow;
@class UIApplication;
@class NSObject;
@class UIApplicationShortcutItem;
@class NSURL;
@class NSManagedObjectModel;
@class NSPersistentStoreCoordinator;
@class NSManagedObjectContext;

SWIFT_CLASS("_TtC4_fie11AppDelegate")
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow * __nullable window;
- (BOOL)application:(UIApplication * __nonnull)application didFinishLaunchingWithOptions:(NSDictionary * __nullable)launchOptions;
- (BOOL)handleShortcut:(UIApplicationShortcutItem * __nonnull)shortcutItem;
- (void)application:(UIApplication * __nonnull)application performActionForShortcutItem:(UIApplicationShortcutItem * __nonnull)shortcutItem completionHandler:(void (^ __nonnull)(BOOL))completionHandler;
- (void)applicationWillResignActive:(UIApplication * __nonnull)application;
- (void)applicationDidEnterBackground:(UIApplication * __nonnull)application;
- (void)applicationWillEnterForeground:(UIApplication * __nonnull)application;
- (void)applicationDidBecomeActive:(UIApplication * __nonnull)application;
- (void)applicationWillTerminate:(UIApplication * __nonnull)application;
@property (nonatomic, strong) NSURL * __nonnull applicationDocumentsDirectory;
@property (nonatomic, strong) NSManagedObjectModel * __nonnull managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator * __nullable persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectContext * __nullable managedObjectContext;
- (void)saveContext;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class UIActivityIndicatorView;
@class UIWebView;
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC4_fie17GalleryController")
@interface GalleryController : UIViewController
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView * __null_unspecified activityIndicator;
- (IBAction)webRefresh:(id __nonnull)sender;
- (IBAction)webFwd:(id __nonnull)sender;
- (IBAction)webBack:(id __nonnull)sender;
@property (nonatomic, strong) IBOutlet UIWebView * __null_unspecified webview;
- (void)viewWillAppear:(BOOL)animated;
- (void)webViewDidStartLoad:(UIWebView * __nonnull)_;
- (void)webViewDidFinishLoad:(UIWebView * __nonnull)_;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UITextView;

SWIFT_CLASS("_TtC4_fie18InfoViewController")
@interface InfoViewController : UIViewController
@property (nonatomic, strong) IBOutlet UIWebView * __null_unspecified webView;
@property (nonatomic, strong) IBOutlet UITextView * __null_unspecified textBox;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (void)viewWillAppear:(BOOL)animated;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UITextField;
@class NSLayoutConstraint;
@class UIButton;
@class UITouch;
@class UIEvent;

SWIFT_CLASS("_TtC4_fie19LoginViewController")
@interface LoginViewController : UIViewController <UITextFieldDelegate>
@property (nonatomic, strong) IBOutlet UITextField * __null_unspecified username;
@property (nonatomic, strong) IBOutlet UITextField * __null_unspecified password;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint * __null_unspecified passwordBottomConstraint;
@property (nonatomic, strong) IBOutlet UIButton * __null_unspecified loginButton;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (IBAction)loginButtonPressed:(id __nonnull)sender;
- (IBAction)registrationButtonPressed:(id __nonnull)sender;
- (void)touchesBegan:(NSSet<UITouch *> * __nonnull)touches withEvent:(UIEvent * __nullable)event;
- (BOOL)textFieldShouldReturn:(UITextField * __nonnull)textField;
- (void)viewWillAppear:(BOOL)animated;
- (void)login;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface NSMutableData (SWIFT_EXTENSION(_fie))
- (void)appendString:(NSString * __nonnull)string;
@end


SWIFT_CLASS("_TtC4_fie22RegistrationController")
@interface RegistrationController : UIViewController <UITextFieldDelegate>
@property (nonatomic, strong) IBOutlet UITextField * __null_unspecified username;
@property (nonatomic, strong) IBOutlet UITextField * __null_unspecified email;
@property (nonatomic, strong) IBOutlet UITextField * __null_unspecified password;
@property (nonatomic, strong) IBOutlet UIButton * __null_unspecified registerButton;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (void)viewWillAppear:(BOOL)animated;
- (void)touchesBegan:(NSSet<UITouch *> * __nonnull)touches withEvent:(UIEvent * __nullable)event;
- (BOOL)textFieldShouldReturn:(UITextField * __nonnull)textField;
- (IBAction)signupButtonPressed:(id __nonnull)sender;
- (void)signup;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface UITextField (SWIFT_EXTENSION(_fie))
- (void)roundCorners:(UIRectCorner)corners radius:(CGFloat)radius;
@end

@class UIImageView;

SWIFT_CLASS("_TtC4_fie20UploadViewController")
@interface UploadViewController : UIViewController <UINavigationControllerDelegate>
@property (nonatomic, strong) IBOutlet UIImageView * __null_unspecified locImage;
@property (nonatomic, strong) IBOutlet UITextField * __null_unspecified message;
@property (nonatomic, strong) IBOutlet UIButton * __null_unspecified sendButton;
- (IBAction)sendButtonPressed:(id __nonnull)sender;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (void)touchesBegan:(NSSet<UITouch *> * __nonnull)touches withEvent:(UIEvent * __nullable)event;
- (BOOL)textFieldShouldReturn:(UITextField * __nonnull)textField;
- (void)viewWillAppear:(BOOL)animated;
- (void)send;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UIImagePickerController;
@class UIImage;

SWIFT_CLASS("_TtC4_fie14ViewController")
@interface ViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
- (IBAction)cameraButton:(id __nonnull)sender;
- (void)openCamera;
- (void)openGallery;
- (void)imagePickerController:(UIImagePickerController * __nonnull)picker didFinishPickingImage:(UIImage * __null_unspecified)image editingInfo:(NSDictionary * __null_unspecified)editingInfo;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

#pragma clang diagnostic pop

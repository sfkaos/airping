/* 
*
*  $Rev::       $: Revision of last commit
*  $Author::    $: Author of last commit
*  $Date::      $: Date of last commit
*  $HeadURL::   $: svn file path
*
*  Copyright Zos Communications LLC, (c) 2012
*
*/

/**
*  @brief Macros to check app build settings
*/

#import <TargetConditionals.h>

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR 
	#if (!defined __IPHONE_OS_VERSION_MIN_REQUIRED)
    #error ZDA apps must be compiled with -miphoneos-version-min
  #endif
  #if (__IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_4_2) 
    #error ZDA apps must be compiled with minimim target iOS 4.2
  #endif
#else
	#if (!defined MAC_OS_X_VERSION_MIN_REQUIRED)
		#error ZDA apps must be compiled with -mmacosx-version-min
	#endif
	#if (MAC_OS_X_VERSION_MIN_REQUIRED < MAC_OS_X_VERSION_10_6) 
		#error ZDA apps for Mac OS must be compiled with minimim target Mac OS 10.6
	#endif
#endif

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR 
  #define __IOS__ 1
#else
  #define __IOS__ 0
#endif

#if __IOS__
    #import <UIKit/UIViewController.h>
    typedef UIViewController* viewControllerType;
#else
    typedef void* viewControllerType;
#endif


/**
*  @brief General ZDA Types
*/

/*
 header file imports
*/
#import <Foundation/NSDate.h>
#import <Foundation/NSString.h>

/**
  The maximum length of the API string (not including null termination) 
*/
#define ZDA_APIMAX_LEN (50)  

/**
  The maximum length of the password string (not including null termination) 
*/
#define ZDA_PWMAX_LEN  (50)

/**
  Maps ZDA userToken type to platform specific type NSString*
*/
typedef NSString* userToken;

/**
  Maps ZDA requestId type to platform specific type unsigned int
*/
typedef unsigned int requestId;

/**
  Maps ZDA DateTime type to platform specific type NSDate*
*/
typedef NSDate* DateTime;

/**
  Maps ZDA string type to platform specific type NSString*
*/
typedef NSString* string;

/*
  ZOS Descrete Agent Specification 
	7.2.1 ZDA APi
*/

/**
  ZDA error constants
*/
enum eZdaErrors
{
	eGeneral,			//!< General error.
	eAuthFailure, //!< Authentication with server failed.
	eCommFailure, 		  		//!< Communication error with ZDA.
	eAlreadyListening,			//!< Can't add the same listener twice.
	eLocationShotTimeout,  	//!< Requested accuracy was not achieved in time.
	eInvalidToken,		//!< Authentication token not found.
	eCommError,				//!< Communication error with server.
	eProtocolError,		//!< Something went wrong with the client <-> ZDA protocol.
	eNoListener,			//!< Can't remove listener because it wasn't found.
	eInvalidParams,		//!< Invalid/missing parameters.
	eNotRegistered,		//!< ZDA is not registered with the server.  
	eInvalidXML,		//!< Data passed to SendXML API is invalid XML. TBD
  eBackgroundService, //!< The ZDA service has been disabled, process will not operate in the background.
  ePropertyError, //! There was an error getting or setting a property.  
};

/**
 ZDA Action Code constants
 */
enum eZdaActionCode
{
  eRemoveListener,            //!< Listener has been removed
  eAddListener,               //!< Listener has been added
  eGetProperty,               //!< Property has been fetched.
  eSetProperty,               //!< Property has been set.
  eCancelXMLRequest,          //!< XMLRquest cancelled
  eLocationServiceOffSystem,	//!< User disabled location for this app in iOS settings.
	eLocationServiceOnSystem,		//!< User enabled location for this app in iOS settings.
	eAppLocationToggleOn,				//!< Location active toggle change On
	eAppLocationToggleOff,			//!< Location active toggle change Off
	eNumActionCodes,	 	        //!< Max action codes
};



/*! \mainpage ZOS Communications LLC
 *
 * \section intro_sec ZOS Discrete Agent (ZDA) SDK Documentation for iOS
 *
 * \section install_sec Installation
 *
 *  Please see the "ZOS Discrete Agent (ZDA) Software Development Kit for 
 *  iOS - Getting Started Guide" for details on integrating the SDK with your
 *  iOS application. 
 *
 * \section xcode_sec Integrating into XCode 
 *
 *  This documentation is compatible with XCode Documentation Sets, and can be 
 *  integrated directly into the XCode IDE. \n
 *  \n
 *	To build and install the Documentation Set:  \n
 *    a) Open a terminal in Mac OS \n
 *    b) Navigate to the directory of this index.html file \n
 *    c) Enter \e make \e install \e Makefile  \n
 *    d) Restart XCode \n
 *  \n
 *  This documentation can then be browsed in the XCode Organizer Documentation
 *  tab.\n  
 *  \n
 *  Quick help on ZDA types can be accessed by selecting a type, and choosing
 *   \e Help -> \e Quick \e Help \e for \e Selected \e Item.  \n
 *  \n
 *  To remove the ZDA Document Set from XCode:\n
 *    a) Open a terminal in Mac OS \n
 *    b) Navigate to the directory of this index.html file \n
 *    c) Enter \e make \e uninstall \e Makefile  \n
 *    d) Restart XCode \n
 * 
 */





/* 
*

$Rev$:  Revision of last commit
$Author$:  Author of last commit
$Date$:  Date of last commit
 
*  $Rev$:  Revision of last commit
*  $Author$:  Author of last commit
*  $Date$:  Date of last commit

*
*  Copyright Zos Communications LLC, (c) 2012
*
*/
  
/**
*  @brief ZDA ZDAClassFactory Type
*/

/*
 header file imports
*/
#import <Foundation/Foundation.h>
#import "ZDAEventService.h"

/**
  \brief This class is used to return a reference to a class that implements the 
	ZDAEventService interface. 

	This class is used to return a reference to a class that implements the 
	ZDAEventService interface. Class inherits from standard Cocoa Foundation base 
	class. 
*/
@interface ZDAClassFactory : NSObject 
{
}

/**
	Gets the ZDAEventService instance, and initiates server registration without
	using SMS or Email. 
  @returns ZDAEventService singleton instance
*/
+(ZDAEventService*) getEventService;

/**
	Gets the ZDAEventService instance, and initiates server registration 
	via an SMS or Email message, which the user must send. 
  @param uiview UIViewController instance. This is used to display the native
	SMS Send or Email Send control.  Used only when registering the device with
	the ZOS servers. 
  @returns ZDAEventService singleton instance, or nil if valid uiview not
	provided, or low memory condition
*/
+(ZDAEventService*) getEventService:(viewControllerType) uiview;

/**
  Method provided for ZDA Specification Compliance (some platforms implement 
	ZDA as a separate process / installation). 
  @returns true
*/
+(bool) isZDAServiceInstalled;

/**
  Method provided for ZDA Specification Compliance (some platforms implement 
	ZDA as a separate process / installation). 
  @returns false
*/
+(bool) installZDAService;


@end

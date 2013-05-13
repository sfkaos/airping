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
*  @brief ZDA ZDAEventListener Protocol Type
*/

/*
 header file imports
*/
#import <Foundation/Foundation.h>
#import "ZDATypes.h"
#import "GeoLocation.h"

/**
  \brief This interface providers the mechanism for users to receive 
	notifications from the ZDA.

  This interface providers the mechanism for users to receive 
	notifications from the ZDA.  Rather than a base class interface, as per the 
	specification, this is provided as an Objective-C protocol. 
*/
@protocol ZDAEventListener
  
/**
  Invoked in response to a successful authentication request.
  @param token The token obtained via ZDAEventListener->onAuthenticationComplete 
  @returns void
	@see ZDAEventListener 
*/
-(void) onAuthenticationComplete: (userToken) token;

/**
  Invoked when an error has occurred.
  @param erorCode The error code (eZdaErrors)
  @param reason Descriptive reason
	@see eZdaErrors
*/
-(void) onError: (int) errorCode: (string) reason;

/**
  Invoked when the on-demand location shot request determines a location that 
	matches or exceeds the requested criteria.
  @param location Location details from ZOS server
  @returns void
*/
-(void) onLocationShotResponse: (GeoLocation*) location;

/**
  Invoked when the device's location has been updated.
  @param location Location details from ZOS server
  @returns void
*/
-(void) onLocationUpdate: (GeoLocation*) location;

/**
  Invoked when the message count has changed.
  @param count The current count of messages for the account
  @returns void
*/
-(void) onMessageNotify: (int) count;

/**
  Invoked when the server sends an XML response to the device.
  @param id ID of the original XML post
  @param xml XML response to XML post
  @returns void
*/
-(void) onXMLResponse: (requestId) id: (string) xml;

/**
  Invoked to indicate the version of ZDA currently built against. 
  @param version The version string of the ZDA library
  @returns void
*/
-(void) onVersionResponse: (string) version;

/**
 Invoked in response to a successful completion of certain function calls.  All 
 calls will result in param of type string
 @param int actionCode (see eZdaActionCode)
 @param string param
 @returns void
 */
-(void) onComplete:(int) actionCode: (string) param;



@end

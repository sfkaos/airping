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
*  @brief ZDA ZDAEventService Type
*/

/*
 header file imports
*/
#import <Foundation/Foundation.h>
#import "ZDATypes.h"
#import "ZDAEventListener.h"


/**
 ZDAEventService class
 */
@interface ZDAEventService : NSObject 
{

}
					
/**
  This function will result in a request to authenticate the application.
  @param apiKey The application API Key provided by Zos 
  @param password The application Password provided by Zos 
  @param listener The class instance implementing the ZDAEventListener protocol
	 whose methods will be invoked with the outcome. 
	@return void
*/
-(void) authenticateUser:(string) apiKey:(string) password:
	(id<ZDAEventListener>) listener;

/**
  Queries the ZDA for version information and notifies the application 
	asynchronously of the result. 
  @param listener The class instance implementing the ZDAEventListener protocol
	 whose methods will be invoked with the outcome. 
	@return void
*/
-(void) getVersion: (id<ZDAEventListener>) listener;

/**
  Adds the specified event listener interface to receive location update events.
  @param token The token obtained via onAuthenticationComplete 
  @param listener The class instance implementing the ZDAEventListener protocol
	 whose methods will be invoked with location updates. 
	@return void
*/
-(void) addLocationUpdateListener: (userToken) token: 
	(id<ZDAEventListener>) listener;

/**
  Removes the specified event listener so that it no longer receives location 
	update events from this service. Instance must have been added using
	addLocationUpdateListener first. 
  @param token The token obtained via onAuthenticationComplete 
  @param listener The class instance implementing the ZDAEventListener protocol
		which is to be removed from the internal list. 
	@return void
*/
-(void) removeLocationUpdateListener: (userToken) token: 
	(id<ZDAEventListener>) listener;

/**
  Removes the specified event listener so that it no longer receives message 
	count update events from this service.
  @param token The token obtained via onAuthenticationComplete 
  @param listener The class instance implementing the ZDAEventListener protocol
	 whose methods will be invoked with message count updates. 
	@return void
*/
-(void) addMessageCountUpdateListener: (userToken) token: 
(id<ZDAEventListener>) listener;

/**
  Invoked when an error has occurred. Instance must have been added using
	addMessageCountUpdateListener first. 
  @param token The token obtained via onAuthenticationComplete 
  @param listener The class instance implementing the ZDAEventListener protocol
		which is to be removed from the internal list. 
	@return void
*/
-(void) removeMessageCountUpdateListener: (userToken) token: 
(id<ZDAEventListener>) listener;

/**
  Sends XML to the ZOS server through the generic XML pass through interface and 
	returns an ID for the request.
  @param token The token obtained via onAuthenticationComplete 
  @param xml XML string to send to ZDA server
  @param listener The class instance implementing the ZDAEventListener protocol
	 whose methods will be invoked with the outcome. 
	@return void
*/
-(requestId) sendXml: (userToken) token: (string) xml: 	
(id<ZDAEventListener>) listener;
	
/**
   Cancels an XML request.
  @param token The token obtained via onAuthenticationComplete 
  @param id The requestId returned from call to sendXml
  @param listener The class instance implementing the ZDAEventListener protocol
	 whose methods will be invoked with the outcome. 
	@return void
*/
-(void) cancelXMLRequest: (userToken) token: (requestId) _id: 
(id<ZDAEventListener>) listener;

/**
  Requests an immediate on-demand location.
  @param token The token obtained via onAuthenticationComplete 
  @param accuracy Desired accuracy in meters (minimum of 5 meters).   
  @param timeout Desired timeout in seconds (up to maximum of 15 minutes). 
  @param listener The class instance implementing the ZDAEventListener protocol
	 whose methods will be invoked with the outcome. 
	@return void
*/
-(void) requestLocationShot: (userToken) token:(int) accuracy:(int) timeout: 
(id<ZDAEventListener>) listener;

/**
  Toggles location in zda. 
	If location is not enabled in the application , then the process will not
	get any background processing time, and will not launch on device reboot.
	This means that server-side communication will stop when the application
	is not in the foreground.  
	
  @param enable - pass true to switch location on, false to switch off
	@return void
*/
-(void) toggleLocation: (userToken) token:(bool) enable: (id<ZDAEventListener>) listener;

/**
 Gets property. Value is returned via invocation of onComplete
  @param token The token obtained via onAuthenticationComplete 
  @param name The name of the field to fetch
  @param listener The class instance implementing the ZDAEventListener protocol
  @return void
 */
-(void) getProperty:(userToken) token:(string) name :(id<ZDAEventListener>) listener;

@end

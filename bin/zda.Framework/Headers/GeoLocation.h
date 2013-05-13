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
*  @brief ZDA GeoLocation type
*/

/*
 header file imports
*/
#import <Foundation/Foundation.h>
#import "ZDATypes.h"

/**
  \brief Class used for representing a physical location. 

Class used for representing a physical location. 
*/
@interface GeoLocation : NSObject <NSCopying>
{
}

/**
	Default constructor. Can be used instead of Objective-C init method.
 	Follows the 'Create Rule' - caller should release instance. 
 	https://developer.apple.com/library/ios/#documentation/CoreFoundation/Conceptual/CFMemoryMgmt/Concepts/Ownership.html
  @returns GeoLocation*
*/
-(GeoLocation*) GeoLocation;  

/**
	Constructor which initializes the GeoLocation class with values.
 	Follows the 'Create Rule' - caller should release instance. 
 	https://developer.apple.com/library/ios/#documentation/CoreFoundation/Conceptual/CFMemoryMgmt/Concepts/Ownership.html
  @param latitude Latitude
  @param longitude Longitude
  @param accuracy Accuracy (meters)
  @param timestamp Timestamp 
  @param method String describing how the location was achieved
  @param speed Speed (meters per second)
  @returns void
*/
-(GeoLocation*) GeoLocation : (double) latitude   
									 	 : (double) longitude
									   : (double) accuracy
									   : (DateTime) timestamp
									   : (string) method
									   : (double) speed;
										 
/**
	Copy constructor
 	Follows the 'Create Rule' - caller should release instance. 
 	https://developer.apple.com/library/ios/#documentation/CoreFoundation/Conceptual/CFMemoryMgmt/Concepts/Ownership.html
  @param rhs Location to copy
  @returns GeoLocation*
*/
-(GeoLocation*) GeoLocation : (GeoLocation*) rhs;

/**
  @returns Returns the accuracy of the location in meters.
*/
-(double)	getAccuracy;	

/**
  @returns Returns the distance in meters to location using the Haversine formula.

*/
-(double)	getDistanceTo:(GeoLocation*) location;

/**
  @returns Returns the latitude of the location.
*/
-(double)	getLatitude;	

/**
  @returns Returns the longitude of the location.
*/
-(double)	getLongitude;	

/**
  @returns Returns the name of the location method used to determine the location.
*/
-(string)	getMethod;		

/**
  @returns Returns the speed in meters per second (m/s).
*/
-(double)	getSpeed;			

/**
  @returns Returns the timestamp of the location in UTC.
*/
-(DateTime) 	getTimestamp;

/**
  @returns Returns true if the location is a valid location.
*/
-(bool)	isValid;      	

/**
	Sets the accuracy of the location in meters.
  @returns void
*/
-(void)	setAccuracy: (double) accuracy;

/**
Sets the latitude of the location.
  @returns void
*/
-(void)	setLatitude: (double) latitude;

/**
Sets the longitude of the location.
  @returns void
*/
-(void)	setLongitude:(double) longitude;

/**
Sets the method used for determining the location.
  @returns void
*/
-(void)	setMethod: (string) method;

/**
Sets the speed in meters per second (m/s).
  @returns void
*/
-(void)	setSpeed: (double) speed;

/**
Sets the timestamp of the location in UTC.
  @returns void
*/
-(void)	setTimestamp: (DateTime) timestamp;

/**
@returns the location in the form of a string.  The format is: [latitude],[longitude].
*/
-(string)	toString;

/**
	Extensions to ZDA Specification, for standard Objective-C and Cocoa compliance. 
*/

/**
	Extension to ZDA Specification, for standard Objective-C and Cocoa compliance. 
	Objective-C compliant init method. 
*/
-(id) init;  

/**
	Extension to ZDA Specification, for standard Objective-C and Cocoa compliance. 
	Objective-C compliant init method. 
  @param latitude Latitude
  @param longitude Longitude
  @param accuracy Accuracy (meters)
  @param timestamp Timestamp 
  @param method String describing how the location was achieved
  @param speed Speed (meters per second)
  @returns void
*/
-(id) initWithCoords : (double) latitute   
									 	 : (double) longitude
									   : (double) accuracy
									   : (DateTime) timestamp
									   : (string) method
									   : (double) speed;

/**
	Extension to ZDA Specification, for standard Objective-C and Cocoa compliance. 
	Objective-C compliant property.
	As well as accessing the value via the method according to the ZDA spec
	caller can access via the property (dot notation).
*/
@property (assign, getter=getAccuracy) double	accuracy;

/**
	Extension to ZDA Specification, for standard Objective-C and Cocoa compliance. 
	Objective-C compliant property.
	As well as accessing the value via the method according to the ZDA spec
	caller can access via the property (dot notation).
*/
@property (getter=getLatitude)  double	latitude;	

/**
	Extension to ZDA Specification, for standard Objective-C and Cocoa compliance. 
	Objective-C compliant property.
	As well as accessing the value via the method according to the ZDA spec
	caller can access via the property (dot notation).
*/
@property (assign, getter=getLongitude) double	longitude;	

/**
	Extension to ZDA Specification, for standard Objective-C and Cocoa compliance. 
	Objective-C compliant property.
	As well as accessing the value via the method according to the ZDA spec
	caller can access via the property (dot notation).
*/
@property (retain,getter=getMethod) string	method;	

/**
	Extension to ZDA Specification, for standard Objective-C and Cocoa compliance. 
	Objective-C compliant property.
	As well as accessing the value via the method according to the ZDA spec
	caller can access via the property (dot notation).
*/
@property (assign, getter=getSpeed) double	speed;	

/**
	Extension to ZDA Specification, for standard Objective-C and Cocoa compliance. 
	Objective-C compliant property.
	As well as accessing the value via the method according to the ZDA spec
	caller can access via the property (dot notation).
*/
@property (retain, getter=getTimestamp) DateTime	timestamp;


/**
	Extension to ZDA Specification, for standard Objective-C and Cocoa compliance. 
	Overload of NSObect description method.
	Returns autoreleased NString in this format:
	@"time:%@, lat/lon:%.06f/%.06f, acc:%.02f, meth:%@, speed:%.02f", 
*/
-(NSString*) description;					

/**
	Extension to ZDA Specification, for standard Objective-C and Cocoa compliance. 
	Implementation for NSCopying protocol. Required so class can be used in
	Foundation lists etc 
*/
-(id)copyWithZone:(NSZone *)zone; 

@end



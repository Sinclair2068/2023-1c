!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #ObserversTest category: 'MarsRover-WithHeading'!
TestCase subclass: #ObserversTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!ObserversTest methodsFor: 'heading' stamp: 'As 6/4/2023 17:55:16'!
directionFrom: aHeadingType
	
	(aHeadingType = MarsRoverHeadingEast) ifTrue: [^'East'].
	(aHeadingType = MarsRoverHeadingWest) ifTrue: [^'West'].
	(aHeadingType = MarsRoverHeadingNorth) ifTrue: [^'North'].
	(aHeadingType = MarsRoverHeadingSouth) ifTrue: [^'South'].
		! !


!ObserversTest methodsFor: 'assertions' stamp: 'As 6/4/2023 17:54:34'!
assertLine: aNumberOfLine on: aLog is: aRoverName headingTo: aHeadingType

	self 
		assert: aRoverName, ': ', (self directionFrom: aHeadingType)
		equals: (aLog lines at: aNumberOfLine)! !

!ObserversTest methodsFor: 'assertions' stamp: 'As 6/4/2023 17:54:13'!
assertLine: aNumberOfLine on: aLog is: aRoverName withPosition: aPosition

	self assert: aRoverName, ': ', aPosition asString equals: (aLog lines at: aNumberOfLine)! !


!ObserversTest methodsFor: 'test' stamp: 'As 6/4/2023 16:52:09'!
test01RoverForwardLogRegisterLastPosition

	| rover log |
	
	rover := self roverAt: 1@1 heading: MarsRoverHeadingNorth.
	log := Log new.
	
	rover attach: log for: self position.
	
	rover process: 'f'.
	
	self assert: 1 equals: log lines size.
	self assert: 1@2 equals: log lines first! !

!ObserversTest methodsFor: 'test' stamp: 'As 6/4/2023 16:52:20'!
test02RoverForwardTwoStepsLogRegisterTwoLastPosition

	| rover log |
	
	rover := self roverAt: 1@1 heading: MarsRoverHeadingNorth.
	log := Log new.

	rover attach: log for: self position.
	 	
	rover process: 'ff'.
	
	self assert: 2 equals: log lines size.
	self assert: 1@2 equals: log lines first.
	self assert: 1@3 equals: log lines second! !

!ObserversTest methodsFor: 'test' stamp: 'As 6/4/2023 16:52:26'!
test03RoverForwardTwoStepsLogRegisterTwoLastPosition

	| rover log |
	
	rover := self roverAt: 1@1 heading: MarsRoverHeadingNorth.
	log := Log new.

	rover attach: log for: self position.
	 	
	rover process: 'ff'.
	
	self assert: 2 equals: log lines size.
	self assert: 1@2 equals: log lines first.
	self assert: 1@3 equals: log lines second! !

!ObserversTest methodsFor: 'test' stamp: 'As 6/4/2023 18:28:59'!
test04RoverForwardTwoStepsWindowRegisterPositionsOneAfterAnother

	| rover window |
	
	rover := self roverAt: 1@1 heading: MarsRoverHeadingNorth.
	window := Window new.

	rover attach: window for: self position.
	 	
	rover process: 'ff'.
	
	self assert: '1@3' equals: window showPosition first! !

!ObserversTest methodsFor: 'test' stamp: 'As 6/4/2023 18:29:28'!
test05RoverForwardAndRightRegisterPositionsAndHeading

	| rover window |
	
	rover := self roverAt: 1@1 heading: MarsRoverHeadingNorth.
	window := Window new.

	rover attach: window for: self positionAndHeading.
	 	
	rover process: 'fr'.
	
	self assert: '1@2' equals: window showPosition first.
	self assert: 'Apuntando al este' equals: window showHeading first.! !

!ObserversTest methodsFor: 'test' stamp: 'As 6/4/2023 18:29:39'!
test06RoverForwardRightForwardRegisterLastPositionsAndHeading

	| rover window |
	
	rover := self roverAt: 1@1 heading: MarsRoverHeadingNorth.
	window := Window new.

	rover attach: window for: self positionAndHeading.
	 	
	rover process: 'frf'.
	
	self assert: '2@2' equals: window showPosition first.
	self assert: 'Apuntando al este' equals: window showHeading first.! !

!ObserversTest methodsFor: 'test' stamp: 'As 6/4/2023 18:29:46'!
test07RoverMoveForwardReportsToManyObservers

	| rover log window |
	
	rover := self roverAt: 1@1 heading: MarsRoverHeadingNorth.
	
	log := Log new.
	window := Window new.
	
	rover attach: log for: self position.
	rover attach: window for: self position.
	
	rover process: 'f'.
	
	self assert: 1 equals: log lines size.
	self assert: 1@2 equals: log lines first.
	
	self assert: '1@2' equals: window showPosition first.! !

!ObserversTest methodsFor: 'test' stamp: 'As 6/4/2023 18:29:52'!
test08RoverMoveBackwardsReportsToManyObservers

	| rover log window |
	
	rover := self roverAt: 1@1 heading: MarsRoverHeadingNorth.
	
	log := Log new.
	window := Window new.
	
	rover attach: log for: self position.
	rover attach: window for: self position.
	
	rover process: 'b'.
	
	self assert: 1 equals: log lines size.
	self assert: 1@0 equals: log lines first.
	
	self assert: '1@0' equals: window showPosition first.! !

!ObserversTest methodsFor: 'test' stamp: 'As 6/4/2023 18:30:00'!
test09RoverRotateRightReportsToManyObservers

	| rover log window |
	
	rover := self roverAt: 1@1 heading: MarsRoverHeadingNorth.
	
	log := Log new.
	window := Window new.
	
	rover attach: log for: self heading.
	rover attach: window for: self heading.
	
	rover process: 'r'.
	
	self assert: 1 equals: log lines size.
	self assert: 'East' equals: log lines first.
	
	self assert: 'Apuntando al este' equals: window showHeading first.! !

!ObserversTest methodsFor: 'test' stamp: 'As 6/4/2023 18:30:05'!
test10RoverRotateLeftReportsToManyObservers

	| rover log window |
	
	rover := self roverAt: 1@1 heading: MarsRoverHeadingNorth.
	
	log := Log new.
	window := Window new.
	
	rover attach: log for: self heading.
	rover attach: window for: self heading.
	
	rover process: 'l'.
	
	self assert: 1 equals: log lines size.
	self assert: 'West' equals: log lines first.
	
	self assert: 'Apuntando al oeste' equals: window showHeading first.! !

!ObserversTest methodsFor: 'test' stamp: 'As 6/4/2023 16:54:35'!
test11ObserverShouldOnlyShowPositionRequestedChanges

	| rover log |
	
	rover := self roverAt: 1@1 heading: MarsRoverHeadingNorth.
	
	log := Log new.
	rover attach: log for: self position.
		
	rover process: 'fr'.
	
	self assert: 1 equals: log lines size.
	self assert: 1@2 equals: log lines first.
! !

!ObserversTest methodsFor: 'test' stamp: 'As 6/4/2023 16:54:51'!
test12ObserverShouldOnlyShowHeadingRequestedChanges

	| rover log |
	
	rover := self roverAt: 1@1 heading: MarsRoverHeadingNorth.
	
	log := Log new.
	rover attach: log for: self heading.
		
	rover process: 'fr'.
	
	self assert: 1 equals: log lines size.
	self assert: 'East' equals: log lines first.
! !

!ObserversTest methodsFor: 'test' stamp: 'As 6/4/2023 16:55:10'!
test13ObserverCanAttachToAllChanges

	| rover log |
	
	rover := self roverAt: 1@1 heading: MarsRoverHeadingNorth.
	
	log := Log new.
	rover attach: log for: self positionAndHeading.
		
	rover process: 'fr'.
	
	self assert: 2 equals: log lines size.
	self assert: 1@2 equals: log lines first.
	self assert: 'East' equals: log lines second.
! !

!ObserversTest methodsFor: 'test' stamp: 'As 6/4/2023 17:33:11'!
test14ObserverShouldNotBeUpdatedIfDetachedForAnAspect

	| rover log |
	
	rover := self roverAt: 1@1 heading: MarsRoverHeadingNorth.
	
	log := Log new.
	rover attach: log for: self positionAndHeading.
		
	rover process: 'fr'.
	
	rover detach: log for: self position.
	
	rover process: 'fr'.
	
	self assert: 3 equals: log lines size.
	self assert: 1@2 equals: log lines first.
	self assert: 'East' equals: log lines second.
	self assert: 'South' equals: log lines third.
! !

!ObserversTest methodsFor: 'test' stamp: 'As 6/4/2023 17:36:41'!
test15ObserverCanDetachForAllAspects

	| rover log |
	
	rover := self roverAt: 1@1 heading: MarsRoverHeadingNorth.
	
	log := Log new.
	rover attach: log for: self positionAndHeading.
		
	rover process: 'fr'.
	
	rover detach: log.
	
	rover process: 'fr'.
	
	self assert: 2 equals: log lines size.
	self assert: 1@2 equals: log lines first.
	self assert: 'East' equals: log lines second.


! !

!ObserversTest methodsFor: 'test' stamp: 'WAL 6/4/2023 23:01:38'!
test16ObserverCanNotObserveUnsupportedAspect

	| rover log |
	
	rover := self roverAt: 1@1 heading: MarsRoverHeadingNorth.
	
	log := Log new.
	
	self
		should: [ 	rover attach: log for: self unsupportedAspect ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: rover invalidAspectErrorDescription ]
! !

!ObserversTest methodsFor: 'test' stamp: 'WAL 6/4/2023 22:44:15'!
test17LogRegisterPositionForMoreThanOneRoverActivity

	| curiosity opportunity log |
	
	curiosity := self curiosityAt: 1@1 heading: MarsRoverHeadingNorth.
	opportunity := self opportunityAt: 4@3 heading: MarsRoverHeadingEast.
	
	log := Log new.

	curiosity attach: log for: self positionAndHeading.
	opportunity attach: log for: self positionAndHeading.
	 	
	curiosity process: 'ff'.
	opportunity process: 'br'.
	
	self assert: 4 equals: log lines size.
	self assertLine: 1 on: log is: curiosity name withPosition: 1@2. 
	self assertLine: 2 on: log is: curiosity name withPosition: 1@3. 	
	self assertLine: 3 on: log is: opportunity name withPosition: 3@3. 
	self assertLine: 4 on: log is: opportunity name headingTo: MarsRoverHeadingSouth.


! !

!ObserversTest methodsFor: 'test' stamp: 'WAL 6/4/2023 22:44:22'!
test18WindowRegisterPositionForMoreThanOneRoverActivity

	| curiosity opportunity window positionsCollection headingsCollection |
	
	curiosity := self curiosityAt: 1@1 heading: MarsRoverHeadingNorth.
	opportunity := self opportunityAt: 4@3 heading: MarsRoverHeadingEast.
	
	window := Window new.

	curiosity attach: window for: self positionAndHeading.
	opportunity attach: window for: self positionAndHeading.
	 	
	curiosity process: 'ff'.
	opportunity process: 'br'.
	
	positionsCollection := window showPosition.
	headingsCollection := window showHeading.
	
	self assert: positionsCollection includes: 'Curiosity: 1@3'.
	self assert: positionsCollection includes: 'Opportunity: 3@3'.		
	self assert: headingsCollection includes: 'Opportunity: Apuntando al sur'.

! !


!ObserversTest methodsFor: 'rovers' stamp: 'As 6/4/2023 17:50:39'!
curiosityAt: aPosition heading: aHeadingType

	^ MarsRover at: aPosition heading: aHeadingType named: self curiosityName ! !

!ObserversTest methodsFor: 'rovers' stamp: 'As 6/4/2023 17:49:59'!
curiosityName

	^ 'Curiosity'! !

!ObserversTest methodsFor: 'rovers' stamp: 'As 6/4/2023 17:50:50'!
opportunityAt: aPosition heading: aHeadingType

	^ MarsRover at: aPosition heading: aHeadingType named: self opportunityName ! !

!ObserversTest methodsFor: 'rovers' stamp: 'As 6/4/2023 17:50:17'!
opportunityName

	^ 'Opportunity'! !

!ObserversTest methodsFor: 'rovers' stamp: 'As 6/4/2023 16:29:46'!
roverAt: aPosition heading: aHeadingType 

	^ MarsRover at: aPosition heading: aHeadingType! !


!ObserversTest methodsFor: 'aspects' stamp: 'As 6/4/2023 17:22:03'!
heading
	
	^{ Heading new. }! !

!ObserversTest methodsFor: 'aspects' stamp: 'As 6/4/2023 17:22:11'!
position
	
	^{ Position new. }! !

!ObserversTest methodsFor: 'aspects' stamp: 'As 6/4/2023 17:22:21'!
positionAndHeading
	
	^{ Position new. Heading new. }! !

!ObserversTest methodsFor: 'aspects' stamp: 'WAL 6/4/2023 23:18:08'!
unsupportedAspect
	
	^{ Object new }! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head observers name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'WAL 6/4/2023 22:51:18'!
invalidAspectErrorDescription
	
	^'Invalid aspect'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'WAL 6/4/2023 22:53:03'!
signalInvalidAspect
	
	self error: self invalidAspectErrorDescription ! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'WAL 6/4/2023 20:34:15'!
createObserversCollectionFor: anAspectClass

	^observers 
		at: anAspectClass name
		put: OrderedCollection new.
! !

!MarsRover methodsFor: 'initialization' stamp: 'WAL 6/4/2023 20:34:52'!
initializeAt: aPosition heading: aHeadingType

	name := ''.
	position := aPosition.
	head := aHeadingType for: self.
	self initializeObservers.
! !

!MarsRover methodsFor: 'initialization' stamp: 'WAL 6/4/2023 20:34:52'!
initializeAt: aPosition heading: aHeadingType named: aName

	name := aName.
	position := aPosition.
	head := aHeadingType for: self.
	self initializeObservers.
! !

!MarsRover methodsFor: 'initialization' stamp: 'WAL 6/4/2023 20:36:26'!
initializeObservers

	observers := Dictionary new.
	
	RoverAspect subclasses do: [ : aRoverAspectClass | self createObserversCollectionFor: aRoverAspectClass ]! !


!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:02'!
headEast
	
	head := MarsRoverHeadingEast for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:12'!
headNorth
	
	head := MarsRoverHeadingNorth for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:17'!
headSouth
	
	head := MarsRoverHeadingSouth for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:24'!
headWest
	
	head := MarsRoverHeadingWest for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'As 6/4/2023 17:23:08'!
rotateLeft
	
	head rotateLeft.	
	self notify: Heading new withValue: head.
	
	! !

!MarsRover methodsFor: 'heading' stamp: 'As 6/4/2023 17:23:16'!
rotateRight
	
	head rotateRight.	
	self notify: Heading new withValue: head.! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'As 6/4/2023 17:22:55'!
moveBackward
	
	head moveBackward.
	self notify: Position new withValue: position.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:01'!
moveEast
	
	position := position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'As 6/4/2023 17:22:45'!
moveForward
	
	head moveForward.
	self notify: Position new withValue: position.
! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:12'!
moveNorth
	
	position := position + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:34'!
moveSouth
	
	position := position + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:32'!
moveWest
	
	position := position + (-1@0)! !


!MarsRover methodsFor: 'observers' stamp: 'As 6/4/2023 17:00:52'!
add: anObserver to: anAspect

	^ (self getObserversFor: anAspect) add: anObserver! !

!MarsRover methodsFor: 'observers' stamp: 'As 6/4/2023 17:00:28'!
attach: anObserver for: anArrayOfAspects
	
	anArrayOfAspects do: [ :anAspect | 	self add: anObserver to: anAspect ].
	! !

!MarsRover methodsFor: 'observers' stamp: 'As 6/4/2023 17:38:17'!
detach: anObserver 
	
	(observers values) do: [ :collection | collection remove: anObserver ifAbsent: [] ].! !

!MarsRover methodsFor: 'observers' stamp: 'As 6/4/2023 17:34:22'!
detach: anObserver for: anArrayOfAspect
	
	anArrayOfAspect do: [ :anAspect | 	self remove: anObserver from: anAspect ].! !

!MarsRover methodsFor: 'observers' stamp: 'WAL 6/4/2023 23:09:08'!
getObserversFor: anAspect 
	
	^observers at: anAspect class name ifAbsent: [ self signalInvalidAspect ]! !

!MarsRover methodsFor: 'observers' stamp: 'As 6/4/2023 17:12:05'!
notify: anAspect withValue: aValue

	(self getObserversFor: anAspect) do: [ :observer | observer update: anAspect withValue: aValue for: self ].! !

!MarsRover methodsFor: 'observers' stamp: 'As 6/4/2023 17:34:59'!
remove: anObserver from: anAspect

	^ (self getObserversFor: anAspect) remove: anObserver! !


!MarsRover methodsFor: 'command processing' stamp: 'AS 6/1/2023 21:32:34'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ].
	
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'accesing' stamp: 'As 6/4/2023 17:49:12'!
name
	
	^name.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !

!MarsRover class methodsFor: 'instance creation' stamp: 'As 6/4/2023 17:47:35'!
at: aPosition heading: aHeadingType named: aName
	
	^self new initializeAt: aPosition heading: aHeadingType named: aName! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!classDefinition: #RoverAspect category: 'MarsRover-WithHeading'!
Object subclass: #RoverAspect
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RoverAspect methodsFor: 'update' stamp: 'As 6/4/2023 17:27:20'!
update: anObserver withValue: aValue for: aMarsRover

	self subclassResponsibility.! !


!classDefinition: #Heading category: 'MarsRover-WithHeading'!
RoverAspect subclass: #Heading
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Heading methodsFor: 'update' stamp: 'As 6/4/2023 17:28:07'!
update: anObserver withValue: aValue for: aMarsRover

	anObserver updateHeading: aValue for: aMarsRover! !


!classDefinition: #Position category: 'MarsRover-WithHeading'!
RoverAspect subclass: #Position
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Position methodsFor: 'update' stamp: 'As 6/4/2023 17:28:52'!
update: anObserver withValue: aValue for: aMarsRover

	anObserver updatePosition: aValue for: aMarsRover! !


!classDefinition: #RoverObserver category: 'MarsRover-WithHeading'!
Object subclass: #RoverObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RoverObserver methodsFor: 'update' stamp: 'As 6/4/2023 17:26:38'!
update: anAspect withValue: aValue for: aMarsRover
	
	anAspect update: self withValue: aValue for: aMarsRover.
	
	"
	(anAspect isKindOf: Heading)
		ifTrue: [ self updateHeading: aValue for: aMarsRover]
		ifFalse: [	(anAspect isKindOf: Position)
			ifTrue: [ self updatePosition: aValue  for: aMarsRover]
			ifFalse: 	[ self signalInvalidAspect. ] ]
		"! !

!RoverObserver methodsFor: 'update' stamp: 'As 6/4/2023 17:16:23'!
updateHeading: aHeadingType from: aMarsRover
	
	self subclassResponsibility ! !

!RoverObserver methodsFor: 'update' stamp: 'As 6/4/2023 17:16:35'!
updatePosition: aPosition from: aMarsRover
	
	self subclassResponsibility ! !


!classDefinition: #Log category: 'MarsRover-WithHeading'!
RoverObserver subclass: #Log
	instanceVariableNames: 'lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Log methodsFor: 'update' stamp: 'As 6/4/2023 18:00:52'!
updateHeading: aHeadingType for: aMarsRover
	
	| direction |
	
	(aHeadingType isKindOf: MarsRoverHeadingEast) ifTrue: [ direction := 'East' ].
	(aHeadingType isKindOf: MarsRoverHeadingNorth) ifTrue: [ direction := 'North' ].
	(aHeadingType isKindOf: MarsRoverHeadingSouth) ifTrue: [ direction := 'South' ].
	(aHeadingType isKindOf: MarsRoverHeadingWest) ifTrue: [ direction := 'West' ].
	
	(aMarsRover name isEmpty)
		ifTrue: [ lines add: direction ]
		ifFalse: [ lines add: aMarsRover name, ': ', direction]			! !

!Log methodsFor: 'update' stamp: 'As 6/4/2023 17:59:54'!
updatePosition: aPosition for: aMarsRover
	
	(aMarsRover name isEmpty)
		ifTrue: [ lines add: aPosition ]
		ifFalse: [ lines add: aMarsRover name, ': ', aPosition asString]! !


!Log methodsFor: 'accessing' stamp: 'AS 6/1/2023 21:31:25'!
lines
	
	^lines! !


!Log methodsFor: 'initialization' stamp: 'As 6/4/2023 16:32:04'!
initialize

	lines := OrderedCollection new.
! !


!classDefinition: #Window category: 'MarsRover-WithHeading'!
RoverObserver subclass: #Window
	instanceVariableNames: 'positions headings'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Window methodsFor: 'update' stamp: 'As 6/4/2023 18:14:28'!
updateHeading: aHeadingType for: aMarsRover
	
	| prefix direction |
	
	(aHeadingType isKindOf: MarsRoverHeadingEast) ifTrue: [ direction := 'este' ].
	(aHeadingType isKindOf: MarsRoverHeadingNorth) ifTrue: [ direction := 'norte' ].
	(aHeadingType isKindOf: MarsRoverHeadingSouth) ifTrue: [ direction := 'sur' ].
	(aHeadingType isKindOf: MarsRoverHeadingWest) ifTrue: [ direction := 'oeste' ].
		
	(aMarsRover name isEmpty)
		ifTrue: [ prefix := '' ]
		ifFalse: [ prefix := aMarsRover name, ': '].
		
	headings at: aMarsRover name put: prefix, 'Apuntando al ', direction.


! !

!Window methodsFor: 'update' stamp: 'As 6/4/2023 18:28:11'!
updatePosition: aPosition for: aMarsRover
	
	| prefix |
	
	(aMarsRover name isEmpty)
		ifTrue: [ prefix := '' ]
		ifFalse: [ prefix := aMarsRover name, ': '].
		
	positions at: aMarsRover name put: prefix, aPosition asString
	! !


!Window methodsFor: 'show' stamp: 'As 6/4/2023 18:18:23'!
showHeading

	^OrderedCollection withAll: headings values! !

!Window methodsFor: 'show' stamp: 'As 6/4/2023 18:18:37'!
showPosition

	^OrderedCollection withAll: positions values! !


!Window methodsFor: 'initialization' stamp: 'As 6/4/2023 18:03:39'!
initialize

	positions := Dictionary new.
	headings := Dictionary new.! !

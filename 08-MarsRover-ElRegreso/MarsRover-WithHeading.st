!classDefinition: #LogTest category: 'MarsRover-WithHeading'!
TestCase subclass: #LogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!LogTest methodsFor: 'as yet unclassified' stamp: 'AS 6/3/2023 14:29:23'!
test01RoverForwardLogRegisterLastPosition

	| rover log |
	
	rover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	log := Log for: rover.
	
	rover attachForAll: log.
	
	rover process: 'f'.
	
	self assert: 1 equals: log lines size.
	self assert: 1@2 equals: log lines first
! !

!LogTest methodsFor: 'as yet unclassified' stamp: 'AS 6/3/2023 14:29:29'!
test02RoverForwardTwoStepsLogRegisterTwoLastPosition

	| rover log |
	
	rover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	log := Log for: rover.

	rover attachForAll: log.
	 	
	rover process: 'ff'.
	
	self assert: 2 equals: log lines size.
	self assert: 1@2 equals: log lines first.
	self assert: 1@3 equals: log lines second
! !


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

!ObserversTest methodsFor: 'test' stamp: 'AS 6/3/2023 14:15:30'!
test01RoverMoveForwardReportsToManyObservers

	| rover log window |
	
	rover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	log := Log for: rover.
	window := Window for: rover.
	
	rover attachForPositionChanges: log.
	rover attachForPositionChanges: window.
	
	rover process: 'f'.
	
	self assert: 1 equals: log lines size.
	self assert: 1@2 equals: log lines first.
	
	self assert: '1@2' equals: window showPosition.! !

!ObserversTest methodsFor: 'test' stamp: 'AS 6/3/2023 14:15:51'!
test02RoverMoveBackwardsReportsToManyObservers

	| rover log window |
	
	rover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	log := Log for: rover.
	window := Window for: rover.
	
	rover attachForPositionChanges: log.
	rover attachForPositionChanges: window.
	
	rover process: 'b'.
	
	self assert: 1 equals: log lines size.
	self assert: 1@0 equals: log lines first.
	
	self assert: '1@0' equals: window showPosition.! !

!ObserversTest methodsFor: 'test' stamp: 'AS 6/3/2023 14:22:01'!
test03RoverRotateRightReportsToManyObservers

	| rover log window |
	
	rover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	log := Log for: rover.
	window := Window for: rover.
	
	rover attachForHeadingChanges: log.
	rover attachForHeadingChanges: window.
	
	rover process: 'r'.
	
	self assert: 1 equals: log lines size.
	self assert: 'East' equals: log lines first.
	
	self assert: 'Apuntando al este' equals: window showHeading.! !

!ObserversTest methodsFor: 'test' stamp: 'AS 6/3/2023 14:22:12'!
test04RoverRotateLeftReportsToManyObservers

	| rover log window |
	
	rover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	log := Log for: rover.
	window := Window for: rover.
	
	rover attachForHeadingChanges: log.
	rover attachForHeadingChanges: window.
	
	rover process: 'l'.
	
	self assert: 1 equals: log lines size.
	self assert: 'West' equals: log lines first.
	
	self assert: 'Apuntando al oeste' equals: window showHeading.! !

!ObserversTest methodsFor: 'test' stamp: 'AS 6/3/2023 14:16:59'!
test05ObserverShouldOnlyShowPositionRequestedChanges

	| rover log |
	
	rover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	log := Log for: rover.
	rover attachForPositionChanges: log.
		
	rover process: 'fr'.
	
	self assert: 1 equals: log lines size.
	self assert: 1@2 equals: log lines first.
! !

!ObserversTest methodsFor: 'test' stamp: 'AS 6/3/2023 14:18:13'!
test06ObserverShouldOnlyShowHeadingRequestedChanges

	| rover log |
	
	rover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	log := Log for: rover.
	rover attachForHeadingChanges: log.
		
	rover process: 'fr'.
	
	self assert: 1 equals: log lines size.
	self assert: 'East' equals: log lines first.
! !

!ObserversTest methodsFor: 'test' stamp: 'AS 6/3/2023 14:29:15'!
test07ObserverCanAttachToAllChanges

	| rover log |
	
	rover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	log := Log for: rover.
	rover attachForAll: log.
		
	rover process: 'fr'.
	
	self assert: 2 equals: log lines size.
	self assert: 1@2 equals: log lines first.
	self assert: 'East' equals: log lines second.
! !


!classDefinition: #WindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #WindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!WindowTest methodsFor: 'test' stamp: 'AS 6/3/2023 14:28:48'!
test01RoverForwardWindowShowsLastPosition

	| rover window |
	
	rover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := Window for: rover.
	
	rover attachForAll: window.
	
	rover process: 'f'.
	
	self assert: '1@2' equals: window showPosition.
	self assert: '' equals: window showHeading.
! !

!WindowTest methodsFor: 'test' stamp: 'AS 6/3/2023 14:28:54'!
test02RoverForwardTwoStepsWindowRegisterPositionsOneAfterAnother

	| rover window |
	
	rover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := Window for: rover.

	rover attachForAll: window.
	 	
	rover process: 'ff'.
	
	self assert: '1@3' equals: window showPosition! !

!WindowTest methodsFor: 'test' stamp: 'AS 6/3/2023 14:30:06'!
test03RoverForwardAndRightRegisterPositionsAndHeading

	| rover window |
	
	rover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := Window for: rover.

	rover attachForAll: window.
	 	
	rover process: 'fr'.
	
	self assert: '1@2' equals: window showPosition.
	self assert: 'Apuntando al este' equals: window showHeading.! !

!WindowTest methodsFor: 'test' stamp: 'AS 6/3/2023 14:31:20'!
test04RoverForwardRightForwardRegisterLastPositionsAndHeading

	| rover window |
	
	rover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := Window for: rover.

	rover attachForAll: window.
	 	
	rover process: 'frf'.
	
	self assert: '2@2' equals: window showPosition.
	self assert: 'Apuntando al este' equals: window showHeading.! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head observers observersForPositionChanges observersForHeadingChanges'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'AS 6/3/2023 14:20:02'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.

	observersForPositionChanges := OrderedCollection new.
	observersForHeadingChanges := OrderedCollection new.! !


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

!MarsRover methodsFor: 'heading' stamp: 'AS 6/3/2023 13:48:14'!
rotateLeft
	
	head rotateLeft.	
	self notifyHeading.
	
	! !

!MarsRover methodsFor: 'heading' stamp: 'AS 6/3/2023 13:48:18'!
rotateRight
	
	head rotateRight.	
	self notifyHeading.! !


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


!MarsRover methodsFor: 'moving' stamp: 'AS 6/3/2023 13:48:39'!
moveBackward
	
	head moveBackward.
	self notifyPosition! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:01'!
moveEast
	
	position := position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'AS 6/3/2023 13:48:39'!
moveForward
	
	head moveForward.
	self notifyPosition
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


!MarsRover methodsFor: 'observers' stamp: 'AS 6/3/2023 14:28:35'!
attachForAll: anObserver 
	
	observersForPositionChanges add: anObserver.
	observersForHeadingChanges add: anObserver.! !

!MarsRover methodsFor: 'observers' stamp: 'AS 6/3/2023 14:18:50'!
attachForHeadingChanges: anObserver 
	
	observersForHeadingChanges add: anObserver! !

!MarsRover methodsFor: 'observers' stamp: 'AS 6/3/2023 14:12:59'!
attachForPositionChanges: anObserver 
	
	observersForPositionChanges add: anObserver! !

!MarsRover methodsFor: 'observers' stamp: 'AS 6/3/2023 14:19:14'!
notifyHeading

	observersForHeadingChanges do: [ :anObserver | anObserver updateHeading: head]! !

!MarsRover methodsFor: 'observers' stamp: 'AS 6/3/2023 14:13:40'!
notifyPosition

	observersForPositionChanges do: [ :observer | observer updatePosition: position. ]! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


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



!classDefinition: #RoverObserver category: 'MarsRover-WithHeading'!
Object subclass: #RoverObserver
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RoverObserver methodsFor: 'as yet unclassified' stamp: 'AS 6/3/2023 13:59:30'!
for: aMarsRover
	
	marsRover := aMarsRover.! !

!RoverObserver methodsFor: 'as yet unclassified' stamp: 'AS 6/3/2023 13:58:26'!
updateHeading: aHeadingType
	
	self subclassResponsibility ! !

!RoverObserver methodsFor: 'as yet unclassified' stamp: 'AS 6/3/2023 13:58:49'!
updatePosition: aPosition
	
	self subclassResponsibility ! !


!classDefinition: #Log category: 'MarsRover-WithHeading'!
RoverObserver subclass: #Log
	instanceVariableNames: 'lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Log methodsFor: 'accessing' stamp: 'AS 6/3/2023 14:01:08'!
for: aMarsRover
	
	super for: aMarsRover.
	lines := OrderedCollection new.
! !

!Log methodsFor: 'accessing' stamp: 'AS 6/1/2023 21:31:25'!
lines
	
	^lines! !

!Log methodsFor: 'accessing' stamp: 'AS 6/3/2023 13:39:44'!
updateHeading: aHeadingType
	
	| direction |
	
	(aHeadingType isKindOf: MarsRoverHeadingEast) ifTrue: [ direction := 'East' ].
	(aHeadingType isKindOf: MarsRoverHeadingNorth) ifTrue: [ direction := 'North' ].
	(aHeadingType isKindOf: MarsRoverHeadingSouth) ifTrue: [ direction := 'South' ].
	(aHeadingType isKindOf: MarsRoverHeadingWest) ifTrue: [ direction := 'West' ].
	
	lines add: direction.! !

!Log methodsFor: 'accessing' stamp: 'AS 6/3/2023 13:17:11'!
updatePosition: aPosition
	
	lines add: aPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Log class' category: 'MarsRover-WithHeading'!
Log class
	instanceVariableNames: ''!

!Log class methodsFor: 'as yet unclassified' stamp: 'AS 6/1/2023 20:55:44'!
for: aMarsRover
		
	^self new for: aMarsRover! !


!classDefinition: #Window category: 'MarsRover-WithHeading'!
RoverObserver subclass: #Window
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Window methodsFor: 'as yet unclassified' stamp: 'AS 6/3/2023 14:01:21'!
for: aMarsRover
	
	super for: aMarsRover.! !

!Window methodsFor: 'as yet unclassified' stamp: 'AS 6/3/2023 13:45:04'!
showHeading

	^heading! !

!Window methodsFor: 'as yet unclassified' stamp: 'AS 6/3/2023 13:45:14'!
showPosition

	^position! !

!Window methodsFor: 'as yet unclassified' stamp: 'AS 6/3/2023 13:40:34'!
updateHeading: aHeadingType
	
	| direction |
	
	(aHeadingType isKindOf: MarsRoverHeadingEast) ifTrue: [ direction := 'este' ].
	(aHeadingType isKindOf: MarsRoverHeadingNorth) ifTrue: [ direction := 'norte' ].
	(aHeadingType isKindOf: MarsRoverHeadingSouth) ifTrue: [ direction := 'sur' ].
	(aHeadingType isKindOf: MarsRoverHeadingWest) ifTrue: [ direction := 'oeste' ].
		
	heading := 'Apuntando al ', direction.! !

!Window methodsFor: 'as yet unclassified' stamp: 'AS 6/3/2023 13:34:17'!
updatePosition: aPosition
	
	position := aPosition asString. 
	! !


!Window methodsFor: 'initialization' stamp: 'AS 6/3/2023 13:34:01'!
initialize

	position := ''.
	heading := ''.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Window class' category: 'MarsRover-WithHeading'!
Window class
	instanceVariableNames: ''!

!Window class methodsFor: 'instance creation' stamp: 'AS 6/1/2023 20:57:39'!
for: aMarsRover 
	
	^self new for: aMarsRover
! !

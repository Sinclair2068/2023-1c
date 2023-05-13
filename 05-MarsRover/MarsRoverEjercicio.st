!classDefinition: #MarsRoverTest category: 'MarsRoverEjercicio'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!MarsRoverTest methodsFor: 'assertions' stamp: 'WAL 5/13/2023 16:16:57'!
assertRover: marsRover at: aPosition pointing: aPointingDirection

	self assert: aPosition                equals: marsRover position.
	self assert: aPointingDirection equals: marsRover pointing.! !


!MarsRoverTest methodsFor: 'pointing directions' stamp: 'WAL 5/13/2023 12:37:10'!
east

	^ East new! !

!MarsRoverTest methodsFor: 'pointing directions' stamp: 'WAL 5/13/2023 11:51:06'!
north

	^ North new! !

!MarsRoverTest methodsFor: 'pointing directions' stamp: 'WAL 5/13/2023 12:37:22'!
south

	^ South new! !

!MarsRoverTest methodsFor: 'pointing directions' stamp: 'WAL 5/13/2023 12:36:14'!
west

	^ West new! !


!MarsRoverTest methodsFor: 'tests' stamp: 'WAL 5/13/2023 12:32:25'!
test01NewRowerStartsAtDefinedPositionAndPointing

	| marsRover |

	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	
	
	self assertRover: marsRover at: 1@1 pointing: self north.
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'WAL 5/13/2023 12:32:52'!
test02EmptyCommandSequenceDoesNothing

	| marsRover |

	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover giveCommands: ''.
	
	self assertRover: marsRover at: 1@1 pointing: self north.
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'WAL 5/13/2023 12:33:15'!
test03OneForwardCommandMovesOneForward

	| marsRover |

	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover giveCommands: 'f'.

	self assertRover: marsRover at: 1@2 pointing: self north.	
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'WAL 5/13/2023 12:33:28'!
test04TwoForwardCommandsMovesTwoForward

	| marsRover |

	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover giveCommands: 'ff'.
	
	self assertRover: marsRover at: 1@3 pointing: self north.
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'WAL 5/13/2023 12:33:38'!
test05ManyForwardCommandsMovesManyForward

	| marsRover |

	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover giveCommands: 'fffff'.
	
	self assertRover: marsRover at: 1@6 pointing: self north.
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'WAL 5/13/2023 12:33:47'!
test06OneBackwardCommandMovesOneBackward

	| marsRover |

	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover giveCommands: 'b'.
	
	self assertRover: marsRover at: 1@0 pointing: self north.
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'WAL 5/13/2023 12:33:55'!
test07TwoBackwardCommandsMovesTwoBackward

	| marsRover |

	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover giveCommands: 'bb'.
	
	self assertRover: marsRover at: 1@-1 pointing: self north.
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'WAL 5/13/2023 12:34:10'!
test08ManyBackwardCommandsMovesManyBackward

	| marsRover |

	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover giveCommands: 'bbbbb'.
	
	self assertRover: marsRover at: 1@-4 pointing: self north.
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'WAL 5/13/2023 12:36:01'!
test09NorthOneLeftCommandPointsWest

	| marsRover |

	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover giveCommands: 'l'.
	
	self assertRover: marsRover at: 1@1 pointing: self west.
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'WAL 5/13/2023 12:38:06'!
test10NorthTwoLeftCommandsPointsSouth

	| marsRover |

	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover giveCommands: 'll'.
	
	self assertRover: marsRover at: 1@1 pointing: self south.
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'WAL 5/13/2023 12:38:15'!
test11NorthThreeLeftCommandsPointsEast

	| marsRover |

	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover giveCommands: 'lll'.
	
	self assertRover: marsRover at: 1@1 pointing: self east.
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'WAL 5/13/2023 12:38:33'!
test12NorthOneRightCommandPointsEast

	| marsRover |

	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover giveCommands: 'r'.
	
	self assertRover: marsRover at: 1@1 pointing: self east.
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'WAL 5/13/2023 12:40:53'!
test13NorthTwoRightCommandPointsSouth

	| marsRover |

	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover giveCommands: 'rr'.
	
	self assertRover: marsRover at: 1@1 pointing: self south.
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'WAL 5/13/2023 12:41:57'!
test14NorthThreeRightCommandPointsWest

	| marsRover |

	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover giveCommands: 'rrr'.
	
	self assertRover: marsRover at: 1@1 pointing: self west.
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'WAL 5/13/2023 14:04:47'!
test15NorthOneLeftOneForwardCommandsPointsWestMovesOneWest

	| marsRover |

	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover giveCommands: 'lf'.

	self assertRover: marsRover at: 0@1 pointing: self west.	
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'WAL 5/13/2023 14:04:32'!
test16NorthTwoLeftOneForwardCommandsPointsSouthMovesOneSouth

	| marsRover |

	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover giveCommands: 'llf'.

	self assertRover: marsRover at: 1@0 pointing: self south.	
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'WAL 5/13/2023 13:19:03'!
test17NorthThreeLeftOneForwardCommandsPointsEastMovesOneEast

	| marsRover |

	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover giveCommands: 'lllf'.

	self assertRover: marsRover at: 2@1 pointing: self east.	
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'WAL 5/13/2023 14:08:25'!
test18NorthOneLeftOneBackwardCommandsPointsWestMovesOneEast

	| marsRover |

	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover giveCommands: 'lb'.

	self assertRover: marsRover at: 2@1 pointing: self west.	
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'WAL 5/13/2023 14:12:11'!
test19NorthTwoLeftOneBackwardCommandsPointsWestMovesOneNorth

	| marsRover |

	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover giveCommands: 'llb'.

	self assertRover: marsRover at: 1@2 pointing: self south.	
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'WAL 5/13/2023 14:14:45'!
test20NorthThreeLeftOneBackwardCommandsPointsEastMovesOneWest

	| marsRover |

	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover giveCommands: 'lllb'.

	self assertRover: marsRover at: 0@1 pointing: self east.	
	
	! !


!classDefinition: #Command category: 'MarsRoverEjercicio'!
Object subclass: #Command
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Command class' category: 'MarsRoverEjercicio'!
Command class
	instanceVariableNames: ''!

!Command class methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 17:24:15'!
for: aCommandCharacter

	^ (Command allSubclasses detect: [ : subclass | subclass handles: aCommandCharacter]) new! !


!classDefinition: #Backward category: 'MarsRoverEjercicio'!
Command subclass: #Backward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!Backward methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 17:09:20'!
executeOn: aMarsRover.
		
	aMarsRover moveBackward.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Backward class' category: 'MarsRoverEjercicio'!
Backward class
	instanceVariableNames: ''!

!Backward class methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 17:02:25'!
handles: aCommandCharacter

	^aCommandCharacter = $b! !


!classDefinition: #Forward category: 'MarsRoverEjercicio'!
Command subclass: #Forward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!Forward methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 17:08:43'!
executeOn: aMarsRover.
		
	aMarsRover moveForward.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Forward class' category: 'MarsRoverEjercicio'!
Forward class
	instanceVariableNames: ''!

!Forward class methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 17:02:34'!
handles: aCommandCharacter

	^aCommandCharacter = $f! !


!classDefinition: #Left category: 'MarsRoverEjercicio'!
Command subclass: #Left
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!Left methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 17:05:53'!
executeOn: aMarsRover.
		
	aMarsRover rotateLeft.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Left class' category: 'MarsRoverEjercicio'!
Left class
	instanceVariableNames: ''!

!Left class methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 17:02:44'!
handles: aCommandCharacter

	^aCommandCharacter = $l! !


!classDefinition: #Right category: 'MarsRoverEjercicio'!
Command subclass: #Right
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!Right methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 17:06:12'!
executeOn: aMarsRover.
		
	aMarsRover rotateRight.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Right class' category: 'MarsRoverEjercicio'!
Right class
	instanceVariableNames: ''!

!Right class methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 17:02:51'!
handles: aCommandCharacter

	^aCommandCharacter = $r! !


!classDefinition: #MarsRover category: 'MarsRoverEjercicio'!
Object subclass: #MarsRover
	instanceVariableNames: 'position pointing'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!MarsRover methodsFor: 'initialize' stamp: 'WAL 5/12/2023 22:03:14'!
initializeStartOn: aPoint facing: aDirection 

	position := aPoint.
	pointing := aDirection.! !


!MarsRover methodsFor: 'control' stamp: 'WAL 5/13/2023 17:10:23'!
giveCommands: aCommandSequence

	aCommandSequence do: [ : commandCharacter |
		
		| command |
		
		command := Command for: commandCharacter.
		
		command executeOn: self.
		
		"commandCharacter = $f ifTrue: [
			position := position + pointing asVersor
		].
		commandCharacter = $b ifTrue: [
			position := position - pointing asVersor
		].
		commandCharacter = $l ifTrue: [ 
			pointing := pointing left
		].
		commandCharacter = $r ifTrue: [ 
			pointing := pointing right
		]."
	].! !


!MarsRover methodsFor: 'position and pointing' stamp: 'WAL 5/12/2023 22:44:56'!
pointing
	
	^pointing ! !

!MarsRover methodsFor: 'position and pointing' stamp: 'WAL 5/12/2023 22:03:48'!
position
	
	^position! !


!MarsRover methodsFor: 'private' stamp: 'WAL 5/13/2023 17:09:20'!
moveBackward

	position := position - pointing asVersor! !

!MarsRover methodsFor: 'private' stamp: 'WAL 5/13/2023 17:08:43'!
moveForward

	position := position + pointing asVersor! !

!MarsRover methodsFor: 'private' stamp: 'WAL 5/13/2023 17:09:45'!
rotateLeft

	pointing := pointing left! !

!MarsRover methodsFor: 'private' stamp: 'WAL 5/13/2023 17:10:05'!
rotateRight

	pointing := pointing right! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRoverEjercicio'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'WAL 5/11/2023 21:24:23'!
startOn: aPoint facing: aDirection
	
	^self new initializeStartOn: aPoint facing: aDirection! !


!classDefinition: #PointingDirection category: 'MarsRoverEjercicio'!
Object subclass: #PointingDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!PointingDirection methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 13:22:53'!
asVersor

	self subclassResponsibility ! !

!PointingDirection methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 16:15:48'!
left

	self subclassResponsibility ! !

!PointingDirection methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 16:15:55'!
right

	self subclassResponsibility ! !


!classDefinition: #East category: 'MarsRoverEjercicio'!
PointingDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!East methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 13:21:33'!
asVersor

	^1@0! !

!East methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 16:15:48'!
left

	^North new! !

!East methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 16:15:55'!
right

	^South new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: 'MarsRoverEjercicio'!
East class
	instanceVariableNames: 'uniqueInstance'!

!East class methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 16:13:08'!
new

	uniqueInstance ifNil: [ uniqueInstance := self basicNew ].
	^uniqueInstance! !


!classDefinition: #North category: 'MarsRoverEjercicio'!
PointingDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!North methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 13:21:53'!
asVersor

	^0@1! !

!North methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 16:15:48'!
left

	^West new! !

!North methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 16:15:55'!
right

	^East new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: 'MarsRoverEjercicio'!
North class
	instanceVariableNames: 'uniqueInstance'!

!North class methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 16:13:53'!
new

	uniqueInstance ifNil: [ uniqueInstance := self basicNew ].
	^uniqueInstance! !


!classDefinition: #South category: 'MarsRoverEjercicio'!
PointingDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!South methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 13:22:02'!
asVersor

	^0@-1! !

!South methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 16:15:48'!
left

	^East new! !

!South methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 16:15:55'!
right

	^West new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: 'MarsRoverEjercicio'!
South class
	instanceVariableNames: 'uniqueInstance'!

!South class methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 16:14:04'!
new

	uniqueInstance ifNil: [ uniqueInstance := self basicNew ].
	^uniqueInstance! !


!classDefinition: #West category: 'MarsRoverEjercicio'!
PointingDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!West methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 13:22:17'!
asVersor

	^-1@0! !

!West methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 16:15:48'!
left

	^South new! !

!West methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 16:15:55'!
right

	^North new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: 'MarsRoverEjercicio'!
West class
	instanceVariableNames: 'uniqueInstance'!

!West class methodsFor: 'as yet unclassified' stamp: 'WAL 5/13/2023 16:14:14'!
new

	uniqueInstance ifNil: [ uniqueInstance := self basicNew ].
	^uniqueInstance! !

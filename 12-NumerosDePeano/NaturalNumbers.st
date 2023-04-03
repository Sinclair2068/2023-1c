!classDefinition: #I category: 'NaturalNumbers'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'NaturalNumbers'!
I class
	instanceVariableNames: 'next previous'!

!I class methodsFor: 'operators' stamp: 'AS 3/31/2023 18:29:18'!
* aNaturalNumber
	^aNaturalNumber! !

!I class methodsFor: 'operators' stamp: 'AS 3/31/2023 16:46:18'!
+ aNaturalNumber
	^aNaturalNumber next! !

!I class methodsFor: 'operators' stamp: 'AS 4/2/2023 18:47:36'!
- aNaturalNumber
	self error: self negativeNumbersNotSupportedErrorDescription! !

!I class methodsFor: 'operators' stamp: 'AS 4/2/2023 19:55:03'!
/ aNaturalNumber
	(self = aNaturalNumber) ifTrue: [^self].
	self error: self canNotDivideByBiggerNumberErrorDescription ! !


!I class methodsFor: 'errorMessages' stamp: 'AS 4/2/2023 19:48:44'!
canNotDivideByBiggerNumberErrorDescription
	^ 'Can not divide by bigger number'! !

!I class methodsFor: 'errorMessages' stamp: 'AS 4/2/2023 18:39:08'!
negativeNumbersNotSupportedErrorDescription
	^'Negative numbers not supported'! !


!I class methodsFor: 'private' stamp: 'AS 3/31/2023 18:38:53'!
divideTo: aNaturalNumber
	^aNaturalNumber! !

!I class methodsFor: 'private' stamp: 'AS 4/2/2023 18:25:23'!
greaterThanMe: aNaturalNumber
	^(self ~= aNaturalNumber)! !

!I class methodsFor: 'private' stamp: 'AS 3/31/2023 17:04:51'!
next
	^II! !

!I class methodsFor: 'private' stamp: 'AS 4/2/2023 19:39:46'!
substractFrom: aNaturalNumber
	^aNaturalNumber previous! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'WAL 4/2/2023 21:47:49'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.
	previous := I.! !


!classDefinition: #II category: 'NaturalNumbers'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'NaturalNumbers'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'private' stamp: 'AS 3/31/2023 16:53:29'!
clearNext
	next := nil
! !

!II class methodsFor: 'private' stamp: 'WAL 4/2/2023 21:46:41'!
divideTo: aNaturalNumber
	(self greaterThanMe: aNaturalNumber) ifTrue: [
		^(I + (self divideTo: (aNaturalNumber - self)))
	]
	ifFalse: [^I]
! !

!II class methodsFor: 'private' stamp: 'AS 4/2/2023 18:27:47'!
greaterThanMe: aNaturalNumber
	(self = aNaturalNumber) ifTrue: [^false].
	^(self previous) greaterThanMe: aNaturalNumber! !

!II class methodsFor: 'private' stamp: 'WAL 4/2/2023 21:43:05'!
next
	next ifNil: [
		next := II createChildNamed: self name, 'I'.
		next previous: self
	].
	^next.! !

!II class methodsFor: 'private' stamp: 'AS 3/31/2023 16:45:08'!
previous
	^previous! !

!II class methodsFor: 'private' stamp: 'AS 3/31/2023 16:45:33'!
previous: aNaturalNumber
	previous := aNaturalNumber! !

!II class methodsFor: 'private' stamp: 'AS 4/2/2023 19:35:42'!
substractFrom: aNaturalNumber
	^aNaturalNumber previous - self previous! !


!II class methodsFor: 'operators' stamp: 'AS 3/31/2023 18:32:25'!
* aNaturalNumber
	^aNaturalNumber + (self previous * aNaturalNumber)! !

!II class methodsFor: 'operators' stamp: 'AS 3/31/2023 16:52:59'!
+ aNaturalNumber
	^self previous + aNaturalNumber next! !

!II class methodsFor: 'operators' stamp: 'AS 3/31/2023 18:24:30'!
- aNaturalNumber
	^aNaturalNumber substractFrom: self! !

!II class methodsFor: 'operators' stamp: 'AS 4/2/2023 20:01:18'!
/ aNaturalNumber
	(self greaterThanMe: aNaturalNumber)
		ifTrue: [^self error: self canNotDivideByBiggerNumberErrorDescription.]
		ifFalse: [^aNaturalNumber divideTo: self]! !


!II class methodsFor: 'errorMessages' stamp: 'AS 4/2/2023 19:48:56'!
canNotDivideByBiggerNumberErrorDescription
	^ 'Can not divide by bigger number'! !

!II class methodsFor: 'errorMessages' stamp: 'AS 4/2/2023 18:38:49'!
negativeNumbersNotSupportedErrorDescription
	^'Negative numbers not supported'! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'WAL 4/2/2023 21:47:49'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'NaturalNumbers'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'NaturalNumbers'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'WAL 4/2/2023 21:47:49'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'NaturalNumbers'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'NaturalNumbers'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'WAL 4/2/2023 21:47:49'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
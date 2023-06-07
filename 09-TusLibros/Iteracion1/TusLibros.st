!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'test' stamp: 'WAL 6/7/2023 19:02:15'!
test01NewCartIsEmpty
	
	self assert: Cart new isEmpty.! !

!CartTest methodsFor: 'test' stamp: 'WAL 6/7/2023 19:13:19'!
test02ABookCanBeAdded
	
	| cart book | 
	
	book := '1234567890123'.
	
	cart := Cart new.
	cart add: book.
	
	self deny: cart isEmpty.
	self assert: cart includes: book! !

!CartTest methodsFor: 'test' stamp: 'WAL 6/7/2023 19:30:15'!
test03AnNotAvailableBookCanNotBeAdded
	
	| cart book | 
	
	book := '0123123456789'.
	
	cart := Cart new.
	
	self
		should: [ cart add: book. ]
		raise: Error
		withExceptionDo: [ :anError | cart isEmpty ]! !

!CartTest methodsFor: 'test' stamp: 'WAL 6/7/2023 19:23:31'!
test04AQuantityOfABookCanBeAdded
	
	| cart book | 
	
	book := '1234567890123'.
	
	cart := Cart new.
	cart add: book quantity: 10.
	
	self deny: cart isEmpty.
	self assert: 10 equals: (cart quantityOf: book)! !

!CartTest methodsFor: 'test' stamp: 'WAL 6/7/2023 19:31:41'!
test05ANotAvailableQuantityOfABookCanNotBeAdded
	
	| cart book | 
	
	book := '1234567890123'.
	
	cart := Cart new.
	
	self
		should: [ cart add: book quantity: 50. ]
		raise: Error
		withExceptionDo: [ :anError | cart isEmpty ]! !

!CartTest methodsFor: 'test' stamp: 'WAL 6/7/2023 19:41:40'!
test06QuantitiesOfASameBookCanBeAddedSequentially
	
	| cart book | 
	
	book := '1234567890123'.
	
	cart := Cart new.
	cart add: book quantity: 10.
	cart add: book quantity: 5.
	
	self deny: cart isEmpty.
	self assert: 15 equals: (cart quantityOf: book)! !

!CartTest methodsFor: 'test' stamp: 'WAL 6/7/2023 19:51:58'!
test07QuantitiesOfASameBookCanNotBeAddedSequentiallyIfNotAvailable
	
	| cart book | 
	
	book := '1234567890123'.
	
	cart := Cart new.
	cart add: book quantity: 20.
	
	self
		should: [ cart add: book quantity: 20. ]
		raise: Error
		withExceptionDo: [ : anError |
			self assert: 20 equals: (cart quantityOf: book)
		]! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'contents inventory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'accessing' stamp: 'WAL 6/7/2023 19:27:52'!
add: aBook

	self add: aBook quantity: 1! !

!Cart methodsFor: 'accessing' stamp: 'WAL 6/7/2023 19:51:27'!
add: aBook quantity: aQuantity

	| availableQuantity totalRequestedQuantity |
	
	availableQuantity := inventory at: aBook ifAbsent: [
		self error: 'Book not available'
	].

	totalRequestedQuantity := aQuantity + (self quantityOf: aBook).

	(availableQuantity > totalRequestedQuantity) ifTrue: [
		contents at: aBook put: totalRequestedQuantity
	] ifFalse: [
		self error: 'Book quantity not available'
	]! !

!Cart methodsFor: 'accessing' stamp: 'WAL 6/7/2023 19:28:48'!
includes: aBook

	^contents keys includes: aBook! !

!Cart methodsFor: 'accessing' stamp: 'WAL 6/7/2023 19:40:15'!
initialize

	inventory := Dictionary newFromPairs: {'1234567890123' . 30}.
	contents := Dictionary new.! !

!Cart methodsFor: 'accessing' stamp: 'WAL 6/7/2023 19:09:41'!
isEmpty

	^contents isEmpty! !

!Cart methodsFor: 'accessing' stamp: 'WAL 6/7/2023 19:44:04'!
quantityOf: aBook

	^contents at: aBook ifAbsent: 0! !

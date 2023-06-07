!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'test' stamp: 'WAL 6/7/2023 01:59:17'!
test01NewCartIsEmpty
	
	self assert: Cart new isEmpty.! !

!CartTest methodsFor: 'test' stamp: 'WAL 6/7/2023 01:59:24'!
test02AQuantityOfABookCanBeAddedToCart
	
	| chart book | 
	
	book := '1234567890123'.
	
	chart := Cart new.
	chart add: book quantity: 10.
	
	self deny: chart isEmpty.
	self assert: 10 equals: (chart quantityOf: book)
	! !

!CartTest methodsFor: 'test' stamp: 'WAL 6/7/2023 01:59:28'!
test03QuantitiesOfASameBookCanBeAddedSequentiallyToCart
	
	| chart book | 
	
	book := '1234567890123'.
	
	chart := Cart new.
	chart add: book quantity: 10.
	chart add: book quantity: 5.
	
	self deny: chart isEmpty.
	self assert: 15 equals: (chart quantityOf: book)
	! !


!classDefinition: #InventoryTest category: 'TusLibros'!
TestCase subclass: #InventoryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InventoryTest methodsFor: 'test' stamp: 'WAL 6/7/2023 01:01:29'!
test01NewInventoryIsEmpty
	
	self assert: Inventory new isEmpty.! !

!InventoryTest methodsFor: 'test' stamp: 'WAL 6/7/2023 01:08:24'!
test02AQuantityOfABookCanBeAddedToInventory
	
	| inventory book | 
	
	book := '1234567890123'.
	
	inventory := Inventory new.
	inventory add: book quantity: 50.
	
	self deny: inventory isEmpty.
	self assert: 50 equals: (inventory quantityOf: book)
	! !

!InventoryTest methodsFor: 'test' stamp: 'WAL 6/7/2023 01:14:11'!
test03QuantitiesOfASameBookCanBeAddedSequentiallyToInventory
	
	| inventory book | 
	
	book := '1234567890123'.
	
	inventory := Inventory new.
	inventory add: book quantity: 50.
	inventory add: book quantity: 20.
	
	self deny: inventory isEmpty.
	self assert: 70 equals: (inventory quantityOf: book)! !


!classDefinition: #StoreTest category: 'TusLibros'!
TestCase subclass: #StoreTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTest methodsFor: 'as yet unclassified' stamp: 'WAL 6/7/2023 02:25:28'!
test01UnregisteredClientCanNotCreateNewCart
	
	| clientID cartID  store | 
	
	clientID := 57.
	
	store := Store new.
	
	self
		should: [ cartID := store newChartForClient: clientID. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Store invalidClientIDErrorDescription ]! !

!StoreTest methodsFor: 'as yet unclassified' stamp: 'WAL 6/7/2023 02:28:18'!
test02StoreAddsRequestedBookQuantityToCartIfAvailableOnStock
	
	| book clientID cartID  store | 
	
	clientID := 57.
	
	book := '1234567890123'.
	
	store := Store new.
	store addToInventory: book quantity: 50.
	
	cartID := store newChartForClient: clientID.
	
	store put: book quantity: 10 on: cartID.    "<< esto es lo que queremos testear, pero nos implica implementar antes todos los métodos de arriba"
	
	self assert: 10 equals: ((store listCart: cartID) at: book).! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'WAL 6/7/2023 00:19:52'!
initialize
	
	books := Dictionary new! !


!Cart methodsFor: 'accessing' stamp: 'WAL 6/7/2023 00:46:14'!
add: aBookIdentifier quantity: aQuantity

	books at: aBookIdentifier
		ifPresent: [
			: previousQuantity | books at: aBookIdentifier put: previousQuantity + aQuantity ]
		ifAbsent: [
			books at: aBookIdentifier put: aQuantity ]! !

!Cart methodsFor: 'accessing' stamp: 'WAL 6/6/2023 22:16:19'!
isEmpty

	^books isEmpty! !

!Cart methodsFor: 'accessing' stamp: 'WAL 6/7/2023 00:27:53'!
quantityOf: aBookIdentifier

	^books at: aBookIdentifier! !


!classDefinition: #Inventory category: 'TusLibros'!
Object subclass: #Inventory
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Inventory methodsFor: 'accessing' stamp: 'WAL 6/7/2023 01:07:35'!
isEmpty

	^contents isEmpty! !

!Inventory methodsFor: 'accessing' stamp: 'WAL 6/7/2023 01:09:38'!
quantityOf: aBookIdentifier

	^contents at: aBookIdentifier! !


!Inventory methodsFor: 'as yet unclassified' stamp: 'WAL 6/7/2023 01:07:03'!
add: aBookIdentifier quantity: aQuantity

	contents at: aBookIdentifier
		ifPresent: [
			: previousQuantity | contents at: aBookIdentifier put: previousQuantity + aQuantity ]
		ifAbsent: [
			contents at: aBookIdentifier put: aQuantity ]! !

!Inventory methodsFor: 'as yet unclassified' stamp: 'WAL 6/7/2023 01:02:47'!
initialize
	
	contents := Dictionary new! !


!classDefinition: #Store category: 'TusLibros'!
Object subclass: #Store
	instanceVariableNames: 'inventory charts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

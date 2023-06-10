!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testSupport'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'WAL 6/8/2023 19:56:12'!
test01NewCartsAreCreatedEmpty

	self assert: testSupport createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'WAL 6/8/2023 19:56:16'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testSupport createCart.
	
	self 
		should: [ cart add: testSupport itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'WAL 6/8/2023 19:56:20'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testSupport createCart.
	
	cart add: testSupport itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'WAL 6/8/2023 19:56:24'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testSupport createCart.
	
	self 
		should: [cart add: 0 of: testSupport itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'WAL 6/8/2023 19:56:35'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testSupport createCart.
	
	self 
		should: [cart add: 2 of: testSupport itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'WAL 6/8/2023 19:56:41'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testSupport createCart.
	
	cart add: testSupport itemSellByTheStore.
	self assert: (cart includes: testSupport itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'WAL 6/8/2023 19:56:45'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testSupport createCart.
	
	self deny: (cart includes: testSupport itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'WAL 6/8/2023 19:56:50'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testSupport createCart.
	
	cart add: 2 of: testSupport itemSellByTheStore.
	self assert: (cart occurrencesOf: testSupport itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setUp/tearDown' stamp: 'WAL 6/8/2023 21:31:26'!
setUp

	testSupport :=TestObjectsFactory new! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testSupport cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'setUp/tearDown' stamp: 'WAL 6/8/2023 21:31:26'!
setUp

	testSupport :=TestObjectsFactory new! !


!CashierTest methodsFor: 'tests' stamp: 'WAL 6/9/2023 19:47:55'!
test01EmptyCartCanNotBeCharged

	| cashier |
	cart := testSupport createCart.
	
	cashier := Cashier new.
	
	self
		should: [ cashier checkOut: cart charge: testSupport validCreditCard on: testSupport currentDate ]
		raise: Error
		withExceptionDo: [ : anError | 
			self assert: Cashier emptyCartCanNotBeChargedErrorDescription equals: anError messageText ]
	! !

!CashierTest methodsFor: 'tests' stamp: 'WAL 6/9/2023 19:47:37'!
test02CartWithOneItemBillsItemPrice

	| cashier bill |
	cart := testSupport createCart.
	cart add: testSupport itemSellByTheStore.
	
	cashier := Cashier new.
	
	bill := cashier checkOut: cart charge: testSupport validCreditCard on: testSupport currentDate.
	
	self assert: testSupport itemSellByTheStorePrice equals: bill.
	! !

!CashierTest methodsFor: 'tests' stamp: 'WAL 6/9/2023 19:44:34'!
test03CartWithManyItemsBillsTotalAmount

	| cashier bill |
	cart := testSupport createCart.
	cart add: testSupport itemSellByTheStore.
	cart add: testSupport anotherItemSellByTheStore.
	
	cashier := Cashier new.
	
	bill := cashier checkOut: cart charge: testSupport validCreditCard on: testSupport currentDate .
	
	self assert: testSupport itemSellByTheStorePrice + testSupport anotherItemSellByTheStorePrice equals: bill.
	! !

!CashierTest methodsFor: 'tests' stamp: 'WAL 6/8/2023 21:30:34'!
test04ValidateCreditCardExpirationDate

	| cashier bill |
	
	cart := testSupport createCart.
	cart add: testSupport itemSellByTheStore.
	
	cashier := Cashier new.
	
	bill := cashier checkOut: cart charge: testSupport validCreditCard on: testSupport currentDate .
	
	self assert: testSupport itemSellByTheStorePrice equals: bill.
	! !

!CashierTest methodsFor: 'tests' stamp: 'WAL 6/9/2023 20:08:25'!
test05ExpiredCreditCardShouldRaiseError

	| cashier |
	
	cart := testSupport createCart.
	cart add: testSupport itemSellByTheStore.
	
	cashier := Cashier new.
	
	self
		should: 	[ cashier checkOut: cart charge: testSupport expiredCreditCard on: testSupport currentDate ]
		raise: Error
		withExceptionDo: [ : anError | self assert: CreditCard expiredCreditCardErrorDescription equals: anError messageText ]
	
	
	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'priceList items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'WAL 6/8/2023 21:18:48'!
assertIsValidItem: anItem

	(priceList keys includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'WAL 6/8/2023 21:18:48'!
initializeAcceptingItemsOf: aCatalog

	priceList := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !

!Cart methodsFor: 'testing' stamp: 'WAL 6/8/2023 20:26:25'!
list

	^items copy! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

!Cart methodsFor: 'adding' stamp: 'WAL 6/8/2023 21:25:14'!
total

	^items sum: [ : item | priceList at: item ] ifEmpty: 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'WAL 6/8/2023 21:46:19'!
assertCartIsNotEmpty: aCart

	^ aCart isEmpty ifTrue: [ self error: Cashier emptyCartCanNotBeChargedErrorDescription ]! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'WAL 6/9/2023 20:43:23'!
checkOut: aCart charge: aCreditCard on: aGregorianDate

	self assertCartIsNotEmpty: aCart.

	(aCreditCard isExpiredOn: aGregorianDate) ifFalse: [
		^ aCart total
	] ifTrue: [
		self error: Cashier expiredCreditCardErrorDescription 
	]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'WAL 6/8/2023 20:04:44'!
emptyCartCanNotBeChargedErrorDescription

	^'Empty cart can not be charged'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'WAL 6/9/2023 20:43:11'!
expiredCreditCardErrorDescription
	
	^'Credit card expired'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'number name expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'accessing' stamp: 'WAL 6/9/2023 20:39:34'!
isExpiredOn: aGregorianDate

	^expiration < aGregorianDate! !


!CreditCard methodsFor: 'initialization' stamp: 'WAL 6/8/2023 21:43:33'!
initializeWithNumber: aString owner: aName expiration: aGregorianMonthOfYear

	number := aString.
	name := aName.
	expiration := aGregorianMonthOfYear
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'WAL 6/9/2023 19:53:22'!
number: aString owner: aName expiration: aGregorianMonthOfYear

	^self new initializeWithNumber: aString owner: aName expiration: aGregorianMonthOfYear! !



!classDefinition: #TestObjectsFactory category: 'TusLibros'!
Object subclass: #TestObjectsFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'WAL 6/8/2023 21:21:16'!
anotherItemSellByTheStore
	
	^ 'anotherValidBook' ! !

!TestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'WAL 6/8/2023 21:21:32'!
anotherItemSellByTheStorePrice
	
	^ 200! !

!TestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'WAL 6/8/2023 19:54:02'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!TestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'WAL 6/9/2023 20:38:13'!
currentDate
	
	^ GregorianMonthOfYear year: 2023 month: June! !

!TestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'WAL 6/8/2023 21:22:44'!
defaultCatalog
	
	^Dictionary newFromPairs: 
		{ self itemSellByTheStore             . self itemSellByTheStorePrice             .
		   self anotherItemSellByTheStore . self anotherItemSellByTheStorePrice}! !

!TestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'WAL 6/8/2023 19:54:21'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!TestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'WAL 6/8/2023 20:17:30'!
itemSellByTheStore
	
	^ 'validBook' ! !

!TestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'WAL 6/8/2023 20:24:00'!
itemSellByTheStorePrice
	
	^ 150! !


!TestObjectsFactory methodsFor: 'credit cards' stamp: 'WAL 6/9/2023 20:09:32'!
expiredCreditCard

	^CreditCard number: '1234567890123456' owner: 'PEPE' expiration: (GregorianMonthOfYear year: 2020 month: January)! !

!TestObjectsFactory methodsFor: 'credit cards' stamp: 'WAL 6/8/2023 21:40:47'!
validCreditCard

	^CreditCard number: '1234567890123456' owner: 'PEPE' expiration: (GregorianMonthOfYear year: 2027 month: May)! !

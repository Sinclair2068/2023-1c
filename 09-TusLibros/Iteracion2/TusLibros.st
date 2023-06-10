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


!CashierTest methodsFor: 'tests' stamp: 'WAL 6/10/2023 14:08:03'!
test01EmptyCartCanNotBeCharged

	| cashier salesBook |
	
	salesBook := OrderedCollection new.
	
	cart := testSupport createCart.
	
	cashier := Cashier new.
	
	self
		should: [
			cashier
				checkOut: cart
				charge: testSupport validCreditCard
				for: testSupport merchantProcessor
				on: testSupport currentDate
				registerOn: salesBook ]
		raise: Error
		withExceptionDo: [ : anError | 
			self assert: Cashier emptyCartCanNotBeChargedErrorDescription equals: anError messageText.
			self assert: salesBook isEmpty ]
	! !

!CashierTest methodsFor: 'tests' stamp: 'WAL 6/10/2023 14:06:26'!
test02CartWithOneItemBillsItemPrice

	| cashier bill salesBook |
	
	salesBook := OrderedCollection new.
	
	cart := testSupport createCart.
	cart add: testSupport itemSellByTheStore.
	
	cashier := Cashier new.
	
	bill := cashier
		checkOut: cart
		charge: testSupport validCreditCard
		for: testSupport merchantProcessor
		on: testSupport currentDate
		registerOn: salesBook.
	
	self assert: testSupport itemSellByTheStorePrice equals: bill.
	self assert: bill equals: salesBook first! !

!CashierTest methodsFor: 'tests' stamp: 'WAL 6/10/2023 14:07:56'!
test03CartWithManyItemsBillsTotalAmount

	| cashier bill salesBook |
	
	salesBook := OrderedCollection new.
	
	cart := testSupport createCart.
	cart add: testSupport itemSellByTheStore.
	cart add: testSupport anotherItemSellByTheStore.
	
	cashier := Cashier new.
	
	bill := cashier
		checkOut: cart
		charge: testSupport validCreditCard
		for: testSupport merchantProcessor
		on: testSupport currentDate
		registerOn: salesBook .
	
	self assert: testSupport itemSellByTheStorePrice + testSupport anotherItemSellByTheStorePrice equals: bill.
	self assert: bill equals: salesBook first! !

!CashierTest methodsFor: 'tests' stamp: 'WAL 6/10/2023 14:07:49'!
test04ValidateCreditCardExpirationDate

	| cashier bill salesBook |
	
	salesBook := OrderedCollection new.
	
	cart := testSupport createCart.
	cart add: testSupport itemSellByTheStore.
	
	cashier := Cashier new.
	
	bill := cashier
		checkOut: cart
		charge: testSupport validCreditCard
		for: testSupport merchantProcessor
		on: testSupport currentDate
		registerOn: salesBook.
	
	self assert: testSupport itemSellByTheStorePrice equals: bill.
	self assert: bill equals: salesBook first! !

!CashierTest methodsFor: 'tests' stamp: 'WAL 6/10/2023 14:07:45'!
test05ExpiredCreditCardShouldRaiseError

	| cashier salesBook |
	
	salesBook := OrderedCollection new.
	
	cart := testSupport createCart.
	cart add: testSupport itemSellByTheStore.
	
	cashier := Cashier new.
	
	self
		should: 	[
			cashier
				checkOut: cart
				charge: testSupport expiredCreditCard
				for: testSupport merchantProcessor
				on: testSupport currentDate
				registerOn: salesBook ]
		raise: Error
		withExceptionDo: [ : anError |
			self assert: CreditCard expiredCreditCardErrorDescription equals: anError messageText.
			self assert: salesBook isEmpty ]
	
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'WAL 6/10/2023 14:07:40'!
test06InvalidNumberedCreditCardShouldRaiseError

	| cashier salesBook |
	
	salesBook := OrderedCollection new.
	
	cart := testSupport createCart.
	cart add: testSupport itemSellByTheStore.
	
	cashier := Cashier new.
	
	self
		should: 	[
			cashier
				checkOut: cart
				charge: testSupport invalidNumberedCreditCard
				for: testSupport merchantProcessor
				on: testSupport currentDate
				registerOn: salesBook ]
		raise: Error
		withExceptionDo: [ : anError |
			self assert: CreditCard invalidNumberedCreditCardErrorDescription equals: anError messageText.
			self assert: salesBook isEmpty ]
	
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'WAL 6/10/2023 14:07:35'!
test07CreditCardWithoutNameShouldRaiseError

	| cashier salesBook |
	
	salesBook := OrderedCollection new.
	
	cart := testSupport createCart.
	cart add: testSupport itemSellByTheStore.
	
	cashier := Cashier new.
	
	self
		should: 	[
			cashier
				checkOut: cart
				charge: testSupport creditCardWithoutName
				for: testSupport merchantProcessor
				on: testSupport currentDate
				registerOn: salesBook ]
		raise: Error
		withExceptionDo: [ : anError |
			self assert: CreditCard creditCardWithoutNameErrorDescription equals: anError messageText.
			self assert: salesBook isEmpty ]
	
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'WAL 6/10/2023 14:07:21'!
test08StolenCreditCardShouldRaiseError

	| cashier salesBook |
	
	salesBook := OrderedCollection new.
	
	cart := testSupport createCart.
	cart add: testSupport itemSellByTheStore.
	
	cashier := Cashier new.
	
	self
		should: 	[
			cashier
				checkOut: cart
				charge: testSupport stolenCreditCard
				for: testSupport merchantProcessor
				on: testSupport currentDate
				registerOn: salesBook ]
		raise: Error
		withExceptionDo: [ : anError |
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'WAL 6/10/2023 14:07:29'!
test09CreditCardWithNoCreditShouldRaiseError

	| cashier salesBook |
	
	salesBook := OrderedCollection new.
	
	cart := testSupport createCart.
	cart add: testSupport itemSellByTheStore.
	
	cashier := Cashier new.
	
	self
		should: 	[
			cashier
				checkOut: cart
				charge: testSupport validCreditCardWithoutEnoughCredit
				for: testSupport merchantProcessor
				on: testSupport currentDate
				registerOn: salesBook ]
		raise: Error
		withExceptionDo: [ : anError |
			self assert: salesBook isEmpty ]! !


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

!Cashier methodsFor: 'as yet unclassified' stamp: 'WAL 6/10/2023 14:09:10'!
checkOut: aCart charge: aCreditCard for: aMerchantProcessor on: aGregorianDate registerOn: aSalesBook 

	| bill |

	self assertCartIsNotEmpty: aCart.
	aCreditCard assertIsValidOn: aGregorianDate.

	bill :=  aCart total.
	
	aMerchantProcessor debit: bill from: aCreditCard.

	aSalesBook add: bill.
	^ bill! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'WAL 6/8/2023 20:04:44'!
emptyCartCanNotBeChargedErrorDescription

	^'Empty cart can not be charged'! !



!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'number name expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'WAL 6/8/2023 21:43:33'!
initializeWithNumber: aString owner: aName expiration: aGregorianMonthOfYear

	number := aString.
	name := aName.
	expiration := aGregorianMonthOfYear
	
	! !



!CreditCard methodsFor: 'accessing' stamp: 'WAL 6/10/2023 12:20:29'!
assertIsValidOn: aGregorianDate

	(self isExpiredOn: aGregorianDate) ifTrue: [
		self error: CreditCard expiredCreditCardErrorDescription 
	].
	(self hasInvalidNumber) ifTrue: [
		self error: CreditCard invalidNumberedCreditCardErrorDescription 
	].
	(self hasNoOwnerName) ifTrue: [
		self error: CreditCard creditCardWithoutNameErrorDescription 
	].! !

!CreditCard methodsFor: 'accessing' stamp: 'WAL 6/10/2023 12:03:24'!
hasInvalidNumber

	^number size < 16! !

!CreditCard methodsFor: 'accessing' stamp: 'WAL 6/10/2023 12:13:17'!
hasNoOwnerName

	^name = ''! !

!CreditCard methodsFor: 'accessing' stamp: 'WAL 6/9/2023 20:39:34'!
isExpiredOn: aGregorianDate

	^expiration < aGregorianDate! !

!CreditCard methodsFor: 'accessing' stamp: 'WAL 6/10/2023 14:11:07'!
number

	^number! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'WAL 6/10/2023 12:21:12'!
invalidNumberedCreditCardErrorDescription
	
	^'Credit card number is not valid'! !

!CreditCard class methodsFor: 'instance creation' stamp: 'WAL 6/9/2023 19:53:22'!
number: aString owner: aName expiration: aGregorianMonthOfYear

	^self new initializeWithNumber: aString owner: aName expiration: aGregorianMonthOfYear! !


!CreditCard class methodsFor: 'error descriptions' stamp: 'WAL 6/10/2023 12:21:33'!
creditCardWithoutNameErrorDescription
	
	^'Credit card should have the owners name'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'WAL 6/10/2023 12:20:50'!
expiredCreditCardErrorDescription
	
	^'Credit card expired'! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'stolenCreditCardNumbers validCreditCardNumbers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'initialize' stamp: 'WAL 6/10/2023 13:37:43'!
initialize

	validCreditCardNumbers := Dictionary new.
	stolenCreditCardNumbers := Set new! !

!MerchantProcessorSimulator methodsFor: 'initialize' stamp: 'WAL 6/10/2023 13:39:07'!
stolenCreditCardNumbers

	^stolenCreditCardNumbers! !

!MerchantProcessorSimulator methodsFor: 'initialize' stamp: 'WAL 6/10/2023 13:38:49'!
validCreditCardNumbers

	^validCreditCardNumbers! !


!MerchantProcessorSimulator methodsFor: 'operations' stamp: 'WAL 6/10/2023 14:32:06'!
debit: anAmount from: aCreditCard

	(stolenCreditCardNumbers includes: aCreditCard number) ifTrue: [
		self error: 'Stolen credit card'
	].

	(validCreditCardNumbers at: aCreditCard number < anAmount) ifTrue: [
		self error: 'Not enough credit on credit card'
	]

	! !


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

!TestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'WAL 6/8/2023 21:40:47'!
validCreditCard

	^CreditCard number: '1234567890123456' owner: 'PEPE' expiration: (GregorianMonthOfYear year: 2027 month: May)! !


!TestObjectsFactory methodsFor: 'credit cards' stamp: 'WAL 6/10/2023 12:12:04'!
creditCardWithoutName

	^CreditCard number: '1234567890123456' owner: '' expiration: (GregorianMonthOfYear year: 2027 month: May)! !

!TestObjectsFactory methodsFor: 'credit cards' stamp: 'WAL 6/9/2023 20:09:32'!
expiredCreditCard

	^CreditCard number: '1234567890123456' owner: 'PEPE' expiration: (GregorianMonthOfYear year: 2020 month: January)! !

!TestObjectsFactory methodsFor: 'credit cards' stamp: 'WAL 6/10/2023 11:55:34'!
invalidNumberedCreditCard

	^CreditCard number: '' owner: 'JUAN' expiration: (GregorianMonthOfYear year: 2027 month: May)! !

!TestObjectsFactory methodsFor: 'credit cards' stamp: 'WAL 6/10/2023 13:13:43'!
stolenCreditCard

	^CreditCard number: '9876543210654321' owner: 'MARIO' expiration: (GregorianMonthOfYear year: 2027 month: May)! !

!TestObjectsFactory methodsFor: 'credit cards' stamp: 'WAL 6/10/2023 13:54:19'!
validCreditCardWithoutEnoughCredit

	^CreditCard number: '6543219876543210' owner: 'MARIA' expiration: (GregorianMonthOfYear year: 2027 month: May)! !


!TestObjectsFactory methodsFor: 'merchant processors' stamp: 'WAL 6/10/2023 14:15:56'!
merchantProcessor
	
	| merchantProcessor |
	
	merchantProcessor := MerchantProcessorSimulator new.
	
	merchantProcessor stolenCreditCardNumbers add: self stolenCreditCard number.
	
	merchantProcessor validCreditCardNumbers at: self validCreditCard put: 1000.
	merchantProcessor validCreditCardNumbers at: self validCreditCardWithoutEnoughCredit put: 10.
	
	^ merchantProcessor! !

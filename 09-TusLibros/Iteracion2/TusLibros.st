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
	instanceVariableNames: 'testingObjects cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'setUp/tearDown' stamp: 'AS 6/11/2023 19:15:17'!
setUp

	testingObjects :=TestObjectsFactory new! !


!CashierTest methodsFor: 'private' stamp: 'AS 6/11/2023 19:17:29'!
testCheckItems: anArrayOfItems chargedTo: aCreditCard shouldRaise: anErrorDescription

	| cashier salesBook |
	
	salesBook := OrderedCollection new.
	
	cart := testingObjects createCartWithItems: anArrayOfItems.
	
	cashier := Cashier new.
	
	self
		should: [
			cashier
				checkOut: cart
				charge: aCreditCard
				for: testingObjects merchantProcessor
				on: testingObjects currentDate
				registerOn: salesBook ]
		raise: Error
		withExceptionDo: [ : anError | 
			self assert: anErrorDescription equals: anError messageText.
			self assert: salesBook isEmpty ]
	! !

!CashierTest methodsFor: 'private' stamp: 'AS 6/11/2023 19:18:24'!
testCheckOutItems: anArrayOfItems chargedTo: aCreditCard withAmountOf: anAmount

	| cashier bill salesBook |
	
	salesBook := OrderedCollection new.	
	cart := testingObjects createCartWithItems: anArrayOfItems .
		
	cashier := Cashier new.
	
	bill := cashier
		checkOut: cart
		charge: aCreditCard
		for: testingObjects merchantProcessor
		on: testingObjects currentDate
		registerOn: salesBook.
	
	self assert: anAmount equals: bill.
	self assert: bill equals: salesBook first! !


!CashierTest methodsFor: 'tests' stamp: 'AS 6/11/2023 19:17:52'!
test01EmptyCartCanNotBeCharged

	self 
		testCheckItems: {} 
		chargedTo: testingObjects validCreditCard 
		shouldRaise: Cashier emptyCartCanNotBeChargedErrorDescription! !

!CashierTest methodsFor: 'tests' stamp: 'AS 6/11/2023 19:18:37'!
test02CartWithOneItemBillsItemPrice

	self 
		testCheckOutItems: { testingObjects itemSellByTheStore }
		chargedTo: testingObjects validCreditCard
		withAmountOf: testingObjects itemSellByTheStorePrice! !

!CashierTest methodsFor: 'tests' stamp: 'AS 6/11/2023 19:18:47'!
test03CartWithManyItemsBillsTotalAmount

	self 
		testCheckOutItems: { testingObjects itemSellByTheStore. testingObjects anotherItemSellByTheStore }
		chargedTo: testingObjects validCreditCard
		withAmountOf: (testingObjects itemSellByTheStorePrice + testingObjects anotherItemSellByTheStorePrice).! !

!CashierTest methodsFor: 'tests' stamp: 'AS 6/11/2023 19:19:49'!
test04ExpiredCreditCardShouldRaiseError

	self 
		testCheckItems: { testingObjects itemSellByTheStore. } 
		chargedTo: testingObjects expiredCreditCard 
		shouldRaise: Cashier creditCardIsExpiredErrorDescription	! !

!CashierTest methodsFor: 'tests' stamp: 'AS 6/11/2023 19:22:03'!
test05StolenCreditCardShouldRaiseError

	self 
		testCheckItems: { testingObjects itemSellByTheStore. } 
		chargedTo: testingObjects stolenCreditCard 
		shouldRaise: MerchantProcessorSimulator creditCardIsStolenErrorDescription! !

!CashierTest methodsFor: 'tests' stamp: 'AS 6/11/2023 19:24:22'!
test06CreditCardWithNotEnoughCreditShouldRaiseError

	self 
		testCheckItems: { testingObjects itemSellByTheStore. } 
		chargedTo: testingObjects validCreditCardWithNotEnoughCredit 
		shouldRaise: MerchantProcessorSimulator creditCardDoesNotHaveEnoughCredit! !

!CashierTest methodsFor: 'tests' stamp: 'AS 6/11/2023 19:26:58'!
test07InvalidCreditCardShouldRaiseError	
	
	self 
		testCheckItems: { testingObjects itemSellByTheStore. } 
		chargedTo: testingObjects invalidCreditCard 
		shouldRaise: MerchantProcessorSimulator creditCardIsNotValidErrorDescription 	
! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'test' stamp: 'WAL 6/11/2023 21:00:36'!
test01NumberMustHaveSizeOf16Characters
	
	self 
		assertCreditCard: '1234' 
		ownedBy: 'Un titular' 
		shouldRise: CreditCard invalidNumberedCreditCardErrorDescription.
	! !

!CreditCardTest methodsFor: 'test' stamp: 'AS 6/11/2023 19:09:26'!
test02NumberContainsOnlyDigitCharacters
	
	self 
		assertCreditCard: '1234    9012ABCD' 
		ownedBy: 'Un titular' 
		shouldRise: CreditCard invalidNumberedCreditCardErrorDescription.
! !

!CreditCardTest methodsFor: 'test' stamp: 'AS 6/11/2023 19:09:54'!
test03OwnerIsNotAnEmptyString
	
	self 
		assertCreditCard: '1234123412341234' 
		ownedBy: '' 
		shouldRise: CreditCard creditCardWithoutNameErrorDescription.
! !


!CreditCardTest methodsFor: 'private' stamp: 'AS 6/11/2023 19:08:12'!
assertCreditCard: aCreditCardNumber ownedBy: anOwnerName shouldRise: anErrorMessage
	
	self 
		should: [ CreditCard 
					number: aCreditCardNumber 
					owner: anOwnerName
					expiration: (GregorianMonthOfYear year: 2023 month: April) ]
		raise: Error
		withExceptionDo: [ : anError | self assert: anErrorMessage equals: anError messageText ]! !


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

!Cashier methodsFor: 'assertions' stamp: 'WAL 6/8/2023 21:46:19'!
assertCartIsNotEmpty: aCart

	^ aCart isEmpty ifTrue: [ self error: Cashier emptyCartCanNotBeChargedErrorDescription ]! !

!Cashier methodsFor: 'assertions' stamp: 'AS 6/11/2023 19:11:07'!
assertCreditCard: aCreditCard isNotExpiredOn: aGregorianMonthOfYear

	(aCreditCard isExpiredOn: aGregorianMonthOfYear)
		ifTrue: [ self error: Cashier creditCardIsExpiredErrorDescription ]! !


!Cashier methodsFor: 'operations' stamp: 'AS 6/11/2023 19:13:24'!
checkOut: aCart charge: aCreditCard for: aMerchantProcessor on: aGregorianMonthOfYear registerOn: aSalesBook 

	| bill |

	self assertCartIsNotEmpty: aCart.
	self assertCreditCard: aCreditCard isNotExpiredOn: aGregorianMonthOfYear.

	bill :=  aCart total.
	
	aMerchantProcessor debit: bill from: aCreditCard.

	aSalesBook add: bill.
	^ bill! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error descriptions' stamp: 'AS 6/11/2023 19:11:25'!
creditCardIsExpiredErrorDescription

	^'Credit card is expired'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'WAL 6/8/2023 20:04:44'!
emptyCartCanNotBeChargedErrorDescription

	^'Empty cart can not be charged'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'number name expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'WAL 6/8/2023 21:43:33'!
initializeWithNumber: aString owner: aName expiration: aGregorianMonthOfYear

	number := aString.
	name := aName.
	expiration := aGregorianMonthOfYear
	
	! !


!CreditCard methodsFor: 'assertions' stamp: 'WAL 6/10/2023 23:55:46'!
isExpiredOn: aGregorianMonthOfYear

	^ expiration < aGregorianMonthOfYear! !


!CreditCard methodsFor: 'accessing' stamp: 'WAL 6/10/2023 14:11:07'!
number

	^number! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'assertions' stamp: 'AS 6/11/2023 19:00:39'!
assertCreditCardNumberHave16Character: aCreditCardNumberString

	^ (aCreditCardNumberString size = 16) ifFalse: [ self error: self invalidNumberedCreditCardErrorDescription ]! !

!CreditCard class methodsFor: 'assertions' stamp: 'AS 6/11/2023 19:01:13'!
assertCreditCardNumberOnlyHaveDigits: aCreditCardNumberString

	^ (aCreditCardNumberString allSatisfy: [ : char | char isDigit ]) ifFalse: [ self error: self invalidNumberedCreditCardErrorDescription ]! !

!CreditCard class methodsFor: 'assertions' stamp: 'AS 6/11/2023 19:04:02'!
assertCreditCardOwnerIsNotAnEmptyString: aName

	^ (aName isEmpty) ifTrue: [ self error: self creditCardWithoutNameErrorDescription ]! !

!CreditCard class methodsFor: 'assertions' stamp: 'AS 6/11/2023 19:01:31'!
assertCreditCardValidNumber: aCreditCardNumberString

	self assertCreditCardNumberHave16Character: aCreditCardNumberString.
	self assertCreditCardNumberOnlyHaveDigits: aCreditCardNumberString! !


!CreditCard class methodsFor: 'instance creation' stamp: 'AS 6/11/2023 19:04:46'!
number: aCreditCardNumberString owner: aName expiration: aGregorianMonthOfYear

	self assertCreditCardValidNumber: aCreditCardNumberString.
	self assertCreditCardOwnerIsNotAnEmptyString: aName.

	^self new 
		initializeWithNumber: aCreditCardNumberString 
		owner: aName 
		expiration: aGregorianMonthOfYear! !


!CreditCard class methodsFor: 'error descriptions' stamp: 'WAL 6/10/2023 12:21:33'!
creditCardWithoutNameErrorDescription
	
	^'Credit card should have the owners name'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'WAL 6/10/2023 12:20:50'!
expiredCreditCardErrorDescription
	
	^'Credit card expired'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'WAL 6/10/2023 12:21:12'!
invalidNumberedCreditCardErrorDescription
	
	^'Credit card number is not valid'! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'stolenCreditCards activeCreditCards'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'initialize' stamp: 'WAL 6/11/2023 21:29:04'!
initialize

	activeCreditCards := Dictionary new.
	stolenCreditCards := Set new! !

!MerchantProcessorSimulator methodsFor: 'initialize' stamp: 'WAL 6/10/2023 23:42:47'!
stolenCreditCards

	^stolenCreditCards! !

!MerchantProcessorSimulator methodsFor: 'initialize' stamp: 'WAL 6/11/2023 21:29:04'!
validCreditCards

	^activeCreditCards! !


!MerchantProcessorSimulator methodsFor: 'assertions' stamp: 'WAL 6/11/2023 21:31:49'!
assertAmount: anAmount canBeChargedOn: aCreditCard

	^ ((activeCreditCards at: aCreditCard number) < anAmount) ifTrue: [
		self error: MerchantProcessorSimulator creditCardDoesNotHaveEnoughCredit 
	]! !

!MerchantProcessorSimulator methodsFor: 'assertions' stamp: 'WAL 6/11/2023 21:30:26'!
assertCreditCardIsActive: aCreditCard

	^ (activeCreditCards keys includes: aCreditCard number) ifFalse: [
		self error: MerchantProcessorSimulator creditCardIsNotValidErrorDescription
	]! !

!MerchantProcessorSimulator methodsFor: 'assertions' stamp: 'WAL 6/11/2023 21:30:06'!
assertCreditCardIsNotStolen: aCreditCard

	^ (stolenCreditCards includes: aCreditCard number) ifTrue: [
		self error: MerchantProcessorSimulator creditCardIsStolenErrorDescription.
	]! !


!MerchantProcessorSimulator methodsFor: 'operations' stamp: 'WAL 6/11/2023 21:32:39'!
debit: anAmount from: aCreditCard

	self assertCreditCardIsNotStolen: aCreditCard.

	self assertCreditCardIsActive: aCreditCard.

	self assertAmount: anAmount canBeChargedOn: aCreditCard

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: 'TusLibros'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'error descriptions' stamp: 'AS 6/11/2023 19:24:42'!
creditCardDoesNotHaveEnoughCredit
	
	^'Credit card does not have enough credit'! !

!MerchantProcessorSimulator class methodsFor: 'error descriptions' stamp: 'AS 6/11/2023 19:27:16'!
creditCardIsNotValidErrorDescription
	
	^'Credit card is not valid'! !

!MerchantProcessorSimulator class methodsFor: 'error descriptions' stamp: 'AS 6/11/2023 19:22:37'!
creditCardIsStolenErrorDescription
	
	^'Credit card is stolen'! !


!classDefinition: #TestObjectsFactory category: 'TusLibros'!
Object subclass: #TestObjectsFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestObjectsFactory methodsFor: 'cart' stamp: 'WAL 6/8/2023 19:54:02'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!TestObjectsFactory methodsFor: 'cart' stamp: 'AS 6/11/2023 19:15:46'!
createCartWithItems: anArrayOfItems

	| cart |
	
	cart := Cart acceptingItemsOf: self defaultCatalog.
	anArrayOfItems do: [ : anItem | cart add: anItem ].
	
	^cart.! !

!TestObjectsFactory methodsFor: 'cart' stamp: 'WAL 6/8/2023 21:22:44'!
defaultCatalog
	
	^Dictionary newFromPairs: 
		{ self itemSellByTheStore             . self itemSellByTheStorePrice             .
		   self anotherItemSellByTheStore . self anotherItemSellByTheStorePrice}! !


!TestObjectsFactory methodsFor: 'items' stamp: 'WAL 6/8/2023 21:21:16'!
anotherItemSellByTheStore
	
	^ 'anotherValidBook' ! !

!TestObjectsFactory methodsFor: 'items' stamp: 'WAL 6/8/2023 21:21:32'!
anotherItemSellByTheStorePrice
	
	^ 200! !

!TestObjectsFactory methodsFor: 'items' stamp: 'WAL 6/8/2023 19:54:21'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!TestObjectsFactory methodsFor: 'items' stamp: 'WAL 6/8/2023 20:17:30'!
itemSellByTheStore
	
	^ 'validBook' ! !

!TestObjectsFactory methodsFor: 'items' stamp: 'WAL 6/8/2023 20:24:00'!
itemSellByTheStorePrice
	
	^ 150! !


!TestObjectsFactory methodsFor: 'dates' stamp: 'WAL 6/9/2023 20:38:13'!
currentDate
	
	^ GregorianMonthOfYear year: 2023 month: June! !


!TestObjectsFactory methodsFor: 'credit cards' stamp: 'WAL 6/11/2023 21:40:01'!
expiredCreditCard

	^CreditCard number: '1234567890123456' owner: 'JULIO' expiration: (GregorianMonthOfYear year: 2020 month: January)! !

!TestObjectsFactory methodsFor: 'credit cards' stamp: 'WAL 6/11/2023 21:39:42'!
invalidCreditCard

	^CreditCard number: '1234123412341234' owner: 'ANA' expiration: (GregorianMonthOfYear year: 2027 month: May)! !

!TestObjectsFactory methodsFor: 'credit cards' stamp: 'WAL 6/10/2023 13:13:43'!
stolenCreditCard

	^CreditCard number: '9876543210654321' owner: 'MARIO' expiration: (GregorianMonthOfYear year: 2027 month: May)! !

!TestObjectsFactory methodsFor: 'credit cards' stamp: 'WAL 6/8/2023 21:40:47'!
validCreditCard

	^CreditCard number: '1234567890123456' owner: 'PEPE' expiration: (GregorianMonthOfYear year: 2027 month: May)! !

!TestObjectsFactory methodsFor: 'credit cards' stamp: 'WAL 6/11/2023 00:12:18'!
validCreditCardWithNotEnoughCredit

	^CreditCard number: '6543219876543210' owner: 'MARIA' expiration: (GregorianMonthOfYear year: 2027 month: May)! !


!TestObjectsFactory methodsFor: 'merchant processors' stamp: 'AS 6/11/2023 19:26:00'!
merchantProcessor
	
	| merchantProcessor |
	
	merchantProcessor := MerchantProcessorSimulator new.
	
	merchantProcessor stolenCreditCards add: self stolenCreditCard number.
	
	merchantProcessor validCreditCards at: self validCreditCard number put: 1000.
	merchantProcessor validCreditCards at: self validCreditCardWithNotEnoughCredit number put: 10.
	merchantProcessor validCreditCards at: self stolenCreditCard number put: 0.
	
	^ merchantProcessor! !

!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'ARM 6/11/2023 13:50:03'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'ARM 6/11/2023 14:10:01'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: self creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = self creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'ARM 6/11/2023 14:09:42'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !

!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #RestInterfaceTest category: 'TusLibros'!
TestCase subclass: #RestInterfaceTest
	instanceVariableNames: 'testObjectsFactory timeSimulator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTest methodsFor: 'assertions' stamp: 'AS 6/14/2023 19:47:07'!
assertAfter: previousActionsBlock should: anErrorRaisingBlock raiseError: anErrorMessage

	| interface cartId |

	interface := self createDefaultInterface.
	
	cartId := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	
	previousActionsBlock value: interface value: cartId.
	
	self
		should: [ anErrorRaisingBlock value: interface value: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = anErrorMessage ]! !

!RestInterfaceTest methodsFor: 'assertions' stamp: 'AS 6/14/2023 20:07:06'!
assertAfter: previousActionsBlock shouldntRaiseError: anErrorRaisingBlock

	| interface cartId |

	interface := self createDefaultInterface.
	
	cartId := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	
	previousActionsBlock value: interface value: cartId.
	
	self
		shouldnt: [ anErrorRaisingBlock value: interface value: cartId ]
		raise: Error - MessageNotUnderstood
! !

!RestInterfaceTest methodsFor: 'assertions' stamp: 'AS 6/14/2023 19:35:05'!
assertShould: anErrorRaisingBlock raiseError: anErrorMessage

	| interface |

	interface := self createDefaultInterface.
	
	self
		should: [ anErrorRaisingBlock value: interface ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = anErrorMessage ]! !

!RestInterfaceTest methodsFor: 'assertions' stamp: 'AS 6/14/2023 20:27:27'!
assertWithCart: anAssertionsBlock

	| interface cartId |
	
	interface := self createDefaultInterface.

	cartId := interface createCartFor: self validUser authenticatedWith: self validUserPassword.

	anAssertionsBlock value: interface value: cartId	.! !

!RestInterfaceTest methodsFor: 'assertions' stamp: 'AS 6/14/2023 19:52:49'!
assertWithCartShould: anErrorRaisingBlock raiseError: anErrorMessage

	| interface cartId |

	interface := self createDefaultInterface.
	
	cartId := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	
	self
		should: [ anErrorRaisingBlock value: interface value: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = anErrorMessage ]! !


!RestInterfaceTest methodsFor: 'test' stamp: 'AS 6/14/2023 20:27:41'!
test01CanCreateCartWithValidUserAndPassword
	
	self assertWithCart: [ :anInterface :aCartId | self assert: (anInterface listCartIdentifiedAs: aCartId) isEmpty ]
! !

!RestInterfaceTest methodsFor: 'test' stamp: 'AS 6/14/2023 19:30:43'!
test02CanNotCreateCartWithInvalidUser

	self 
		assertShould: [ :anInterface | anInterface createCartFor: self invalidUser authenticatedWith: self validUserPassword ] 
		raiseError: RestInterface invalidUserAndOrPasswordErrorDescription! !

!RestInterfaceTest methodsFor: 'test' stamp: 'AS 6/14/2023 19:31:23'!
test03CanNotCreateCartWithInvalidPassword

	self 
		assertShould: [ :anInterface | anInterface createCartFor: self validUser authenticatedWith: self invalidPassword ]
		raiseError: RestInterface invalidUserAndOrPasswordErrorDescription
! !

!RestInterfaceTest methodsFor: 'test' stamp: 'HernanWilkinson 6/21/2013 23:15'!
test04CanAddItemsToACreatedCart

	| interface cartId |

	interface := self createDefaultInterface.

	cartId := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	self
		shouldnt: [interface add: self validBook quantity: 1 toCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		! !

!RestInterfaceTest methodsFor: 'test' stamp: 'AS 6/14/2023 19:37:03'!
test05CanNotAddItemToNotCreatedCart

	self 
		assertShould: [ :anInterface | anInterface add: self validBook quantity: 1 toCartIdentifiedAs: self invalidCartId ]
		raiseError: RestInterface invalidCartIdErrorDescription.
		! !

!RestInterfaceTest methodsFor: 'test' stamp: 'AS 6/14/2023 19:53:13'!
test06CanNotAddItemNotSellByTheStore

	self
		assertWithCartShould: [ :anInterface :aCartId | anInterface add: self invalidBook quantity: 1 toCartIdentifiedAs: aCartId ]
		raiseError: RestInterface invalidItemErrorMessage.
		! !

!RestInterfaceTest methodsFor: 'test' stamp: 'AS 6/14/2023 20:27:53'!
test07ListCartOfAnEmptyCartReturnsAnEmptyBag

	self assertWithCart: [ :anInterface :aCartId | self assert: (anInterface listCartIdentifiedAs: aCartId) isEmpty ].
			
	! !

!RestInterfaceTest methodsFor: 'test' stamp: 'AS 6/14/2023 19:41:49'!
test08CanNotListCartOfInvalidCartId

	self 
		assertShould: [ :anInterface | anInterface listCartIdentifiedAs: self invalidCartId ]
		raiseError: RestInterface invalidCartIdErrorDescription.
		! !

!RestInterfaceTest methodsFor: 'test' stamp: 'AS 6/14/2023 20:29:57'!
test09ListCartReturnsTheRightNumberOfItems

	self assertWithCart: [ :anInterface :aCartId | 
		
		| cartContent |
		
		anInterface add: self validBook quantity: 1 toCartIdentifiedAs: aCartId.
		anInterface add: self anotherValidBook quantity: 2 toCartIdentifiedAs: aCartId.
		
		cartContent := anInterface listCartIdentifiedAs: aCartId.
	
		self assert: (cartContent occurrencesOf: self validBook) = 1. 
		self assert: (cartContent occurrencesOf: self anotherValidBook) = 2		 ].

! !

!RestInterfaceTest methodsFor: 'test' stamp: 'AS 6/14/2023 20:13:56'!
test10CanCheckoutACart

	self 
		assertAfter: [ :anInterface :aCartId | 
			anInterface add: self validBook quantity: 1 toCartIdentifiedAs: aCartId. ]
		shouldntRaiseError: [ :anInterface :aCartId |
			anInterface checkOutCartIdentifiedAs: aCartId 
					   withCreditCardNumbered: '1111222233334444' 
					   ownedBy: 'Juan Perez' 
					   expiringOn: testObjectsFactory notExpiredMonthOfYear ]	
		
		! !

!RestInterfaceTest methodsFor: 'test' stamp: 'AS 6/14/2023 19:43:26'!
test11CanNotCheckoutANotCreatedCart

	self 
		assertShould: [ :anInterface | anInterface checkOutCartIdentifiedAs: self invalidCartId  
			withCreditCardNumbered: '1111222233334444' 
			ownedBy: 'Juan Perez' 
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raiseError: RestInterface invalidCartIdErrorDescription.

		! !

!RestInterfaceTest methodsFor: 'test' stamp: 'AS 6/14/2023 19:55:42'!
test12CanNotCheckoutAnEmptyCart

	self assertWithCartShould: [ :anInterface :aCartId | 
			anInterface checkOutCartIdentifiedAs: aCartId 
			withCreditCardNumbered: '1111222233334444' 
			ownedBy: 'Juan Perez' 
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raiseError: RestInterface cartCanNotBeEmptyErrorMessage
		
		! !

!RestInterfaceTest methodsFor: 'test' stamp: 'AS 6/14/2023 20:00:25'!
test13CanNotListCartAfterTimeOut

	self 
		assertAfter: [ :anInterface :aCartId | timeSimulator advanceOn: (Duration minutes: 35) ] 
		should: [ :anInterface :aCartId | anInterface listCartIdentifiedAs: aCartId ] 
		raiseError: RestInterface timeOutErrorDescription.	! !

!RestInterfaceTest methodsFor: 'test' stamp: 'AS 6/14/2023 20:01:24'!
test14CanNotAddItemToCartAfterTimeOut

	self 
		assertAfter: [ :anInterface :aCartId | timeSimulator advanceOn: (Duration minutes: 35) ] 
		should: [ :anInterface :aCartId | anInterface add: self validBook quantity: 1 toCartIdentifiedAs: aCartId ] 
		raiseError: RestInterface timeOutErrorDescription.	
! !

!RestInterfaceTest methodsFor: 'test' stamp: 'AS 6/14/2023 20:17:25'!
test15CanNotAddItemToCartAfterTimeOut

	self 
		assertAfter: [ :anInterface :aCartId | 
					anInterface add: self validBook quantity: 1 toCartIdentifiedAs: aCartId.
					timeSimulator advanceOn: (Duration minutes: 35) ]
		 should:  [ :anInterface :aCartId |
					anInterface checkOutCartIdentifiedAs: aCartId 
					   withCreditCardNumbered: '1111222233334444' 
					   ownedBy: 'Juan Perez' 
					   expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raiseError:  RestInterface timeOutErrorDescription
! !

!RestInterfaceTest methodsFor: 'test' stamp: 'AS 6/14/2023 20:09:20'!
test16ListCartResetsTimeOut

	self 
		assertAfter: [ :anInterface :aCartId | 
			timeSimulator advanceOn: (Duration minutes: 29).
			anInterface listCartIdentifiedAs: aCartId.
			timeSimulator advanceOn: (Duration minutes: 5). ] 
		shouldntRaiseError: [ :anInterface :aCartId | anInterface listCartIdentifiedAs: aCartId ]
! !

!RestInterfaceTest methodsFor: 'test' stamp: 'AS 6/14/2023 20:10:01'!
test17AddItemResetsTimeOut

	self 
		assertAfter: [ :anInterface :aCartId | 
			timeSimulator advanceOn: (Duration minutes: 29).
			anInterface add: self validBook quantity: 1 toCartIdentifiedAs: aCartId.
			timeSimulator advanceOn: (Duration minutes: 5). ] 
		shouldntRaiseError: [ :anInterface :aCartId | anInterface listCartIdentifiedAs: aCartId ]
	! !

!RestInterfaceTest methodsFor: 'test' stamp: 'AS 6/14/2023 20:05:07'!
test18CartIsNotAvailableAfterCheckOut

	self 
		assertAfter: [ :anInterface :aCartId |
				anInterface add: self validBook quantity: 1 toCartIdentifiedAs: aCartId.
				anInterface 		checkOutCartIdentifiedAs: aCartId 
						    withCreditCardNumbered: '1111222233334444' 
						    ownedBy: 'Juan Perez' 
						    expiringOn: testObjectsFactory notExpiredMonthOfYear. ] 
		should: [ :anInterface :aCartId | anInterface listCartIdentifiedAs: aCartId ] 
		raiseError: RestInterface invalidCartIdErrorDescription.	
	
	! !


!RestInterfaceTest methodsFor: 'setup' stamp: 'WAL 6/12/2023 21:29:42'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	timeSimulator := (TimeSimulator startingAt: DateAndTime now)
! !


!RestInterfaceTest methodsFor: 'users' stamp: 'HernanWilkinson 6/21/2013 23:06'!
invalidPassword
	
	^'invalidPassword'! !

!RestInterfaceTest methodsFor: 'users' stamp: 'HernanWilkinson 6/21/2013 22:30'!
invalidUser

	^'invalidUser'! !

!RestInterfaceTest methodsFor: 'users' stamp: 'AS 6/14/2023 18:59:58'!
is: aUser authenticatingWith: aPassword 

	| storedPassword |
	
	storedPassword := self validUsersAndPasswords at: aUser ifAbsent: [ ^false ].
	
	^aPassword = storedPassword ! !

!RestInterfaceTest methodsFor: 'users' stamp: 'HernanWilkinson 6/21/2013 22:27'!
validUser
	
	^'validUser'! !

!RestInterfaceTest methodsFor: 'users' stamp: 'HernanWilkinson 6/21/2013 22:28'!
validUserPassword
	
	^'validUserPassword'! !

!RestInterfaceTest methodsFor: 'users' stamp: 'HernanWilkinson 6/21/2013 22:43'!
validUsersAndPasswords
	
	^Dictionary new
		at: self validUser put: self validUserPassword;
		yourself! !


!RestInterfaceTest methodsFor: 'books' stamp: 'HernanWilkinson 6/22/2013 00:15'!
anotherValidBook
	
	^testObjectsFactory anotherItemSellByTheStore ! !

!RestInterfaceTest methodsFor: 'books' stamp: 'HernanWilkinson 6/21/2013 23:49'!
invalidBook

	^testObjectsFactory itemNotSellByTheStore ! !

!RestInterfaceTest methodsFor: 'books' stamp: 'HernanWilkinson 6/21/2013 23:50'!
validBook
	
	^testObjectsFactory itemSellByTheStore ! !


!RestInterfaceTest methodsFor: 'carts' stamp: 'HernanWilkinson 6/21/2013 23:25'!
invalidCartId
	
	"Devuelvo nil porque seguro que siempre sera un id invalido, no importa que sea el id - Hernan"
	^nil! !


!RestInterfaceTest methodsFor: 'interfaces' stamp: 'WAL 6/12/2023 21:29:03'!
createDefaultInterface
	
	^RestInterface
		authenticatingWith: self
		acceptingItemsOf: testObjectsFactory defaultCatalog
		merchantProcessor: self
		timeServer: timeSimulator.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage
	
	^self class invalidItemErrorMessage ! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage
	
	^self class invalidQuantityErrorMessage ! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 00:20'!
content
	
	^Bag new
		addAll: items;
		yourself ! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
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


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'ARM 6/11/2023 13:49:52'!
createSale

	^ total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #RestInterface category: 'TusLibros'!
Object subclass: #RestInterface
	instanceVariableNames: 'authenticationSystem carts catalog lastId merchantProcessor salesBook cartsLastInteraction timeServer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'initialization' stamp: 'WAL 6/12/2023 21:09:26'!
initializeAuthenticatingWith: anAuthenticationSystem acceptingItemsOf: aCatalog merchantProcessor: anMP timeServer: aTimeServer 

	authenticationSystem := anAuthenticationSystem.
	catalog := aCatalog.
	carts := Dictionary new.
	cartsLastInteraction := Dictionary new.
	lastId := 0.
	merchantProcessor := anMP.
	timeServer := aTimeServer! !


!RestInterface methodsFor: 'dates' stamp: 'HernanWilkinson 6/22/2013 11:17'!
today
	
	^DateAndTime now! !


!RestInterface methodsFor: 'authentication' stamp: 'ARM 6/11/2023 13:54:36'!
is: aUser authenticatingWith: aPassword 
	
	^authenticationSystem is: aUser authenticatingWith: aPassword 
! !


!RestInterface methodsFor: 'errors' stamp: 'AS 6/14/2023 19:40:40'!
signalInvalidCartId
	
	self error: RestInterface invalidCartIdErrorDescription ! !

!RestInterface methodsFor: 'errors' stamp: 'AS 6/14/2023 19:44:17'!
signalInvalidUserAndOrPassword
	
	self error: RestInterface invalidUserAndOrPasswordErrorDescription! !


!RestInterface methodsFor: 'operations' stamp: 'AS 6/14/2023 18:49:09'!
add: aBook quantity: anAmount toCartIdentifiedAs: aCartId

	| cart |
	
	cart := carts at: aCartId ifAbsent: [ self signalInvalidCartId ].
	
	self assertNotTimedOut: aCartId.
	
	cartsLastInteraction at: aCartId put: timeServer currentTime.
	
	cart add: anAmount of: aBook.
	! !

!RestInterface methodsFor: 'operations' stamp: 'AS 6/14/2023 18:54:46'!
checkOutCartIdentifiedAs: aCartId withCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear

	| cart |
	
	cart := carts at: aCartId ifAbsent: [self signalInvalidCartId ].
	
	self assertNotTimedOut: aCartId.	
	
	Cashier 
		toCheckout: cart 
		charging: (CreditCard expiringOn: anExpirationMonthOfYear) 
		throught: merchantProcessor 
		on: self today 
		registeringOn: salesBook.
		
	carts removeKey: aCartId.! !

!RestInterface methodsFor: 'operations' stamp: 'WAL 6/12/2023 21:18:06'!
createCartFor: aUser authenticatedWith: aPassword

	| cartId |
	
	(self is: aUser authenticatingWith: aPassword) ifFalse: [ self signalInvalidUserAndOrPassword ].
	
	cartId := self generateCartId.
	carts at: cartId put: (Cart acceptingItemsOf: catalog).
	cartsLastInteraction at: cartId put: timeServer currentTime.
	
	^cartId ! !

!RestInterface methodsFor: 'operations' stamp: 'WAL 6/12/2023 22:02:39'!
listCartIdentifiedAs: aCartId

	| cart |
	
	cart := carts at: aCartId ifAbsent: [ self signalInvalidCartId ].
	
	self assertNotTimedOut: aCartId.
	
	cartsLastInteraction at: aCartId put: timeServer currentTime .
	
	^cart content! !


!RestInterface methodsFor: 'private' stamp: 'HernanWilkinson 6/21/2013 23:32'!
generateCartId
	
	"Recuerden que esto es un ejemplo, por lo que voy a generar ids numericos consecutivos, pero en una 
	implementacion real no deberian se numeros consecutivos ni nada que genere problemas de seguridad - Hernan"
	
	lastId := lastId + 1.
	^lastId! !


!RestInterface methodsFor: 'assertions' stamp: 'AS 6/14/2023 19:02:35'!
assertNotTimedOut: aCartId

	| lastInteraction |
	
	lastInteraction := cartsLastInteraction at: aCartId.
	
	((timeServer minutesElapsedSince: lastInteraction)  > 30 ) 
		ifTrue: [ self error: self class timeOutErrorDescription ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: 'TusLibros'!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'instance creation' stamp: 'WAL 6/12/2023 21:14:00'!
authenticatingWith: aValidUsersAndPasswords acceptingItemsOf: aCatalog merchantProcessor: anMP timeServer: aTimeServer 

	^self new initializeAuthenticatingWith: aValidUsersAndPasswords acceptingItemsOf: aCatalog merchantProcessor: anMP timeServer: aTimeServer! !


!RestInterface class methodsFor: 'error descriptions' stamp: 'AS 6/14/2023 19:56:01'!
cartCanNotBeEmptyErrorMessage
	
	^Cashier cartCanNotBeEmptyErrorMessage ! !

!RestInterface class methodsFor: 'error descriptions' stamp: 'AS 6/14/2023 19:37:24'!
invalidCartIdErrorDescription
	
	^'Invalid cart id'! !

!RestInterface class methodsFor: 'error descriptions' stamp: 'AS 6/14/2023 19:50:14'!
invalidItemErrorMessage
	
	^Cart invalidItemErrorMessage ! !

!RestInterface class methodsFor: 'error descriptions' stamp: 'AS 6/14/2023 19:27:43'!
invalidUserAndOrPasswordErrorDescription
	
	^'Invalid user and/or password'! !

!RestInterface class methodsFor: 'error descriptions' stamp: 'WAL 6/12/2023 20:55:35'!
timeOutErrorDescription

	^'Time out'! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/22/2013 00:16'!
anotherItemSellByTheStore
	
	^'anotherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/22/2013 00:16'!
anotherItemSellByTheStorePrice
	
	^15! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/22/2013 00:16'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self anotherItemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:06'!
notExpiredCreditCard
	
	^CreditCard expiringOn: self notExpiredMonthOfYear! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:06'!
notExpiredMonthOfYear

	^ Month month: today monthIndex year: today yearNumber + 1! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!classDefinition: #TimeSimulator category: 'TusLibros'!
Object subclass: #TimeSimulator
	instanceVariableNames: 'time'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TimeSimulator methodsFor: 'initialization' stamp: 'WAL 6/12/2023 20:58:33'!
initializeStartingAt: aTime

	time := aTime! !


!TimeSimulator methodsFor: 'operations' stamp: 'WAL 6/12/2023 21:00:39'!
advanceOn: aTimeSpan

	time := time + aTimeSpan! !


!TimeSimulator methodsFor: 'accessing' stamp: 'WAL 6/12/2023 20:58:58'!
currentTime

	^time! !

!TimeSimulator methodsFor: 'accessing' stamp: 'WAL 6/12/2023 21:43:17'!
minutesElapsedSince: aTime

	^ (Timespan starting: aTime ending: time) duration minutes! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TimeSimulator class' category: 'TusLibros'!
TimeSimulator class
	instanceVariableNames: ''!

!TimeSimulator class methodsFor: 'instance creation' stamp: 'WAL 6/12/2023 20:58:15'!
startingAt: aTime

	^self new initializeStartingAt: aTime! !

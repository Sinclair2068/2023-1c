!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'accounts' stamp: 'AS 5/17/2023 08:46:36'!
accountWithDepositOf: anAmount
	
	| account |

	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	^account! !

!PortfolioTest methodsFor: 'accounts' stamp: 'AS 5/17/2023 09:43:42'!
depositOf: anAmount on: anAccount
	
	^Deposit register: anAmount on: anAccount! !

!PortfolioTest methodsFor: 'accounts' stamp: 'AS 5/17/2023 09:02:42'!
portfolioWithAccounts: anArrayOfAccounts
	
	| portfolio |

	portfolio := Portfolio new.
	anArrayOfAccounts do: [ :account | portfolio addAccount: account ].
	
	^portfolio! !

!PortfolioTest methodsFor: 'accounts' stamp: 'WAL 5/20/2023 17:04:24'!
portfolioWithDepositOf: anAmount
	
	^ self portfolioWithAccounts: { self accountWithDepositOf: anAmount.	 }.
	! !

!PortfolioTest methodsFor: 'accounts' stamp: 'AS 5/17/2023 09:04:58'!
portfolioWithPortfolios: anArrayOfPortfolios
	
	| portfolio |

	portfolio := Portfolio new.
	anArrayOfPortfolios do: [ :childPortfolio | portfolio addPortfolio: childPortfolio ].
	
	^portfolio! !


!PortfolioTest methodsFor: 'test' stamp: 'WAL 5/20/2023 17:36:28'!
onPortfolioWithTransactionDo: aBlock

	| portfolio account transaction |
	
	account := ReceptiveAccount new.	
	transaction := self depositOf: 100 on: account.		
	portfolio := self portfolioWithAccounts: { account }.
	
	aBlock value: transaction value: portfolio.
	
	
! !

!PortfolioTest methodsFor: 'test' stamp: 'WAL 5/20/2023 17:37:38'!
onPortfolioWithTransactionInChildPortfolioDo: aBlock

	| portfolio childPortfolio account transaction |
	
	account := ReceptiveAccount new.	
	transaction := self depositOf: 100 on: account.	
	childPortfolio := self portfolioWithAccounts: { account }.
	
	portfolio := self portfolioWithPortfolios: { childPortfolio }.
	
	aBlock value: transaction value: portfolio.
	
	
! !

!PortfolioTest methodsFor: 'test' stamp: 'AS 5/17/2023 09:02:27'!
test01PortfolioWithOneAccountShouldReturnAccountBalance

	| account portfolio |
	
	account := self accountWithDepositOf: 100.
	portfolio := self portfolioWithAccounts: { account }.
	
	self assert: account balance equals: portfolio balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'AS 5/17/2023 09:45:29'!
test02PortfolioWithTwoAccountShouldReturnSumAccountsBalance

	| account1 account2 portfolio |
	
	account1 := self accountWithDepositOf: 100.
	account2 := self accountWithDepositOf: 250.	
	portfolio := self portfolioWithAccounts: { account1. account2 }.
	
	self 
		assert: account1 balance + account2 balance
		equals: portfolio balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'AS 5/17/2023 09:05:24'!
test03PortfolioWithOnePortfolioShouldReturnPortfolioBalance

	| account portfolio childPortfolio|
	
	account := self accountWithDepositOf: 100.
	childPortfolio := self portfolioWithAccounts: { account }.
	
	portfolio := self portfolioWithPortfolios: { childPortfolio }.
	
	self assert: childPortfolio balance equals: portfolio balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'WAL 5/20/2023 17:05:13'!
test04PortfolioWithTwoPortfoliosShouldReturnSumPortfoliosBalance

	| portfolio childPortfolio1 childPortfolio2 |
	
	childPortfolio1 := self portfolioWithDepositOf: 100.
	childPortfolio2 := self portfolioWithDepositOf: 150.
		
	portfolio := self portfolioWithPortfolios: { childPortfolio1. childPortfolio2 }.
	
	self 
		assert: childPortfolio1 balance + childPortfolio2 balance
		equals: portfolio balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'WAL 5/20/2023 17:36:28'!
test05PortfolioHasRegisteredTransactionsInChildAccounts

	self onPortfolioWithTransactionDo:
		[ : transaction : portfolio | 
			self assert: (portfolio hasRegistered: transaction)
	        ] .! !

!PortfolioTest methodsFor: 'test' stamp: 'WAL 5/20/2023 17:38:38'!
test06PortfolioHasRegisteredTransactionsInChildPortfolios

	self onPortfolioWithTransactionInChildPortfolioDo:
		[ : transaction : portfolio | 
			self assert: (portfolio hasRegistered: transaction)
	        ] .! !

!PortfolioTest methodsFor: 'test' stamp: 'WAL 5/20/2023 17:36:28'!
test07PortfolioKnowsChildAccountsTransactions

	self onPortfolioWithTransactionDo:
		[ : transaction : portfolio | 
			self assert: 1 equals: portfolio transactions size.
			self assert: (portfolio transactions includes: transaction).
	        ] .
! !

!PortfolioTest methodsFor: 'test' stamp: 'WAL 5/20/2023 17:39:09'!
test08PortfolioKnowsChildPortfoliosTransactions

	self onPortfolioWithTransactionInChildPortfolioDo:
		[ : transaction : portfolio | 
			self assert: 1 equals: portfolio transactions size.
			self assert: (portfolio transactions includes: transaction).
	        ] .! !

!PortfolioTest methodsFor: 'test' stamp: 'AS 5/17/2023 20:03:10'!
test09PortfolioCantHaveRepeatedAccounts

	| account portfolio |
	
	account := ReceptiveAccount new.	
		
	portfolio := Portfolio new.
	portfolio addAccount: account.
	
	self 
		should: [ 	portfolio addAccount: account ]
		raise: Error
! !

!PortfolioTest methodsFor: 'test' stamp: 'WAL 5/20/2023 17:40:47'!
test10PortfolioCantHaveTheSameAccountsInChildPortfolio

	| account parentPortfolio childPortfolio |
	
	account := ReceptiveAccount new.	
		
	parentPortfolio := Portfolio new.
	parentPortfolio addAccount: account.
	
	childPortfolio := Portfolio new.
	parentPortfolio addPortfolio: childPortfolio.
		
	self 
		should: [ 	childPortfolio addAccount: account ]
		raise: Error
! !

!PortfolioTest methodsFor: 'test' stamp: 'AS 5/17/2023 20:35:49'!
test11PortfolioCantHaveTheSameAccountsInParentPortfolio

	| account parentPortfolio childPortfolio|
	
	account := ReceptiveAccount new.	
		
	parentPortfolio := Portfolio new.
	
	childPortfolio := Portfolio new.
	parentPortfolio addPortfolio: childPortfolio.
	childPortfolio addAccount: account.
		
	self 
		should: [ 	parentPortfolio addAccount: account ]
		raise: Error
! !

!PortfolioTest methodsFor: 'test' stamp: 'WAL 5/20/2023 16:51:45'!
test12PortfolioCanHaveTwoParents

	| parentPortfolio1 parentPortfolio2 childPortfolio |
			
	parentPortfolio1 := Portfolio new.
	parentPortfolio2 := Portfolio new.
	
	childPortfolio := Portfolio new.
	
	parentPortfolio1 addPortfolio: childPortfolio.
	parentPortfolio2 addPortfolio: childPortfolio.
	
	self assert: 	(childPortfolio parents includes: parentPortfolio1).
	self assert: 	(childPortfolio parents includes: parentPortfolio2).
! !

!PortfolioTest methodsFor: 'test' stamp: 'WAL 5/17/2023 23:22:06'!
test13PortfolioCanHaveManyParents

	| parentPortfolio1 parentPortfolio2 parentPortfolio3 childPortfolio |
			
	parentPortfolio1 := Portfolio new.
	parentPortfolio2 := Portfolio new.
	parentPortfolio3 := Portfolio new.
	
	childPortfolio := Portfolio new.
	
	parentPortfolio1 addPortfolio: childPortfolio.
	parentPortfolio2 addPortfolio: childPortfolio.
	parentPortfolio3 addPortfolio: childPortfolio.
			
	self assert: 	(childPortfolio parents includes: parentPortfolio1).
	self assert: 	(childPortfolio parents includes: parentPortfolio2).
	self assert: 	(childPortfolio parents includes: parentPortfolio3).
! !

!PortfolioTest methodsFor: 'test' stamp: 'WAL 5/17/2023 23:35:31'!
test14PortfolioCantHaveRepeatedPortfolios

	| portfolioChild portfolio |
	
	portfolioChild := Portfolio new.	
		
	portfolio := Portfolio new.
	portfolio addPortfolio: portfolioChild.
	
	self 
		should: [ 	portfolio addPortfolio: portfolioChild ]
		raise: Error
! !

!PortfolioTest methodsFor: 'test' stamp: 'WAL 5/18/2023 00:16:05'!
test15CannotAddPortfolioWithRepeatedAccountOnChild

	| portfolioParent portfolioChild account  |
	
	account := ReceptiveAccount new.
	
	portfolioChild := Portfolio new.	
	portfolioParent := Portfolio new.	
		
	portfolioChild addAccount: account.
	portfolioParent addAccount: account.
	
	self 
		should: [ 	portfolioParent addPortfolio: portfolioChild ]
		raise: Error
! !

!PortfolioTest methodsFor: 'test' stamp: 'WAL 5/18/2023 00:15:56'!
test16CannotAddPortfolioWithRepeatedAccountOnGrandchild

	| portfolioParent portfolioChild portfolioGrandchild account  |
	
	account := ReceptiveAccount new.
	
	portfolioGrandchild := Portfolio new.	
	portfolioChild := Portfolio new.	
	portfolioParent := Portfolio new.	
		
	portfolioGrandchild addAccount: account.
	portfolioParent addAccount: account.
	portfolioChild addPortfolio: portfolioGrandchild.
	
	self 
		should: [ 	portfolioParent addPortfolio: portfolioChild ]
		raise: Error
! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'balance' stamp: 'AS 5/16/2023 16:06:26'!
addToBalance: balance 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'initialization' stamp: 'WAL 5/20/2023 18:02:06'!
initializeFor: aValue

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'balance' stamp: 'AS 5/16/2023 15:53:14'!
addToBalance: balance 
	
	^balance + value! !


!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'balance' stamp: 'AS 5/16/2023 16:05:21'!
addToBalance: balance 
	
	^balance - value! !


!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #PortfolioOrAccount category: 'Portfolio-Ejercicio'!
Object subclass: #PortfolioOrAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioOrAccount methodsFor: 'transactions' stamp: 'WAL 5/20/2023 14:36:34'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!PortfolioOrAccount methodsFor: 'transactions' stamp: 'WAL 5/20/2023 14:37:02'!
transactions

	self subclassResponsibility ! !


!PortfolioOrAccount methodsFor: 'private' stamp: 'WAL 5/20/2023 15:30:51'!
addMyselfTo: aCollection

	self subclassResponsibility ! !

!PortfolioOrAccount methodsFor: 'private' stamp: 'WAL 5/20/2023 17:56:47'!
addTransactionsTo: aTransactionsCollection.
	
	self subclassResponsibility ! !


!PortfolioOrAccount methodsFor: 'balance' stamp: 'WAL 5/20/2023 14:36:00'!
balance

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
PortfolioOrAccount subclass: #Portfolio
	instanceVariableNames: 'elements parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'assertions' stamp: 'WAL 5/20/2023 16:21:50'!
assertDoesNotContainAccount: anAccount

	^ (self allRootsElements includes: anAccount)
		ifTrue: [ self error: 'La cuenta ya pertenece al portfolio' ]! !

!Portfolio methodsFor: 'assertions' stamp: 'WAL 5/20/2023 16:21:03'!
assertNoCommonElementsWith: aPortfolio

	^ (self allRootsElements includesAnyOf: aPortfolio allElements)
		ifTrue: [ 	self error: 'El portfolio no puede agregarse.' 	]! !


!Portfolio methodsFor: 'balance' stamp: 'WAL 5/20/2023 16:11:23'!
balance
			
	^ (elements sum: [ :element | element balance ] ifEmpty: [0])
! !


!Portfolio methodsFor: 'elements' stamp: 'WAL 5/20/2023 16:21:50'!
addAccount: anAccount 
	
	self assertDoesNotContainAccount: anAccount.
		
	elements add: anAccount
			! !

!Portfolio methodsFor: 'elements' stamp: 'WAL 5/20/2023 16:21:03'!
addPortfolio: aPortfolio 

	self assertNoCommonElementsWith: aPortfolio.
	
	elements add: aPortfolio.
	aPortfolio addParent: self.! !


!Portfolio methodsFor: 'initialization' stamp: 'WAL 5/20/2023 16:25:11'!
initialize
	
	elements := OrderedCollection new.
	parents := OrderedCollection new.
	! !


!Portfolio methodsFor: 'transactions' stamp: 'WAL 5/20/2023 16:26:32'!
hasRegistered: aTransaction 
		
	^elements anySatisfy: [ :element | element hasRegistered: aTransaction ]
	! !

!Portfolio methodsFor: 'transactions' stamp: 'WAL 5/20/2023 16:54:57'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	
	self addTransactionsTo: transactions.
		
	^transactions.
		! !


!Portfolio methodsFor: 'private' stamp: 'WAL 5/20/2023 16:11:23'!
addMyselfTo: aCollection

	aCollection add: self.
	
	elements do: [ : element | element addMyselfTo: aCollection ].! !

!Portfolio methodsFor: 'private' stamp: 'WAL 5/17/2023 23:25:29'!
addParent: aPortfolio

	parents add: aPortfolio ! !

!Portfolio methodsFor: 'private' stamp: 'WAL 5/17/2023 23:29:52'!
addRootsTo: aRootCollection
	
	parents do: [ : parent | parent addRootsTo: aRootCollection ] .
	
	parents ifEmpty: [ aRootCollection add: self ].
	! !

!Portfolio methodsFor: 'private' stamp: 'WAL 5/20/2023 16:42:14'!
addTransactionsTo: aTransactionsCollection.
	
	elements do: [ :element | element addTransactionsTo: aTransactionsCollection ].! !

!Portfolio methodsFor: 'private' stamp: 'WAL 5/20/2023 16:12:58'!
allElements

	| allElements |

	allElements := OrderedCollection with: self.
	
	elements do: [ : element | element addMyselfTo: allElements ].

	^allElements! !

!Portfolio methodsFor: 'private' stamp: 'WAL 5/20/2023 16:11:40'!
allRootsElements

	| allRootsElements |
	
	allRootsElements := OrderedCollection  new.
	self roots do: [ : root | allRootsElements addAll: root allElements ].
	
	^allRootsElements! !

!Portfolio methodsFor: 'private' stamp: 'WAL 5/17/2023 23:30:14'!
parents

	^parents! !

!Portfolio methodsFor: 'private' stamp: 'WAL 5/17/2023 23:32:54'!
roots
	
	| aRootCollection |
	
	aRootCollection := OrderedCollection new.
	
	parents do: [ : parent | parent addRootsTo: aRootCollection ] .
	
	parents ifEmpty: [ aRootCollection add: self ].
	
	^aRootCollection
	
	
	
	! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
PortfolioOrAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'balance' stamp: 'AS 5/16/2023 15:56:36'!
balance
	| balance |
	
	balance := 0.
	
	transactions do: [ :aTransaction | balance := aTransaction addToBalance: balance ].
	
	^balance! !


!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'AS 5/16/2023 16:29:43'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private' stamp: 'WAL 5/20/2023 15:30:33'!
addMyselfTo: aCollection

	aCollection add: self.! !

!ReceptiveAccount methodsFor: 'private' stamp: 'WAL 5/20/2023 16:47:02'!
addTransactionsTo: aTransactionsCollection.
	
	aTransactionsCollection addAll: transactions copy! !

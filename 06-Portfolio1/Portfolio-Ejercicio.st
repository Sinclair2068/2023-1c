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

!PortfolioTest methodsFor: 'accounts' stamp: 'AS 5/17/2023 09:04:58'!
portfolioWithPortfolios: anArrayOfPortfolios
	
	| portfolio |

	portfolio := Portfolio new.
	anArrayOfPortfolios do: [ :childPortfolio | portfolio addPortfolio: childPortfolio ].
	
	^portfolio! !


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

!PortfolioTest methodsFor: 'test' stamp: 'AS 5/17/2023 09:07:07'!
test04PortfolioWithTwoPortfoliosShouldReturnSumPortfoliosBalance

	| portfolio accountPortfolio1 accountPortfolio2 childPortfolio1 childPortfolio2 |
	
	accountPortfolio1 := self accountWithDepositOf: 100.	
	childPortfolio1 := self portfolioWithAccounts: { accountPortfolio1 }.
		
	accountPortfolio2 := self accountWithDepositOf: 150.
	childPortfolio2 := self portfolioWithAccounts: { accountPortfolio2 }.
		
	portfolio := self portfolioWithPortfolios: { childPortfolio1. childPortfolio2 }.
	
	self 
		assert: childPortfolio1 balance + childPortfolio2 balance
		equals: portfolio balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'AS 5/17/2023 09:45:17'!
test05PortfolioHasRegisteredTransactionsInChildAccounts

	| portfolio account transaction |
	
	account := ReceptiveAccount new.	
	transaction := self depositOf: 100 on: account.	
	portfolio := self portfolioWithAccounts: { account }.
	
	self assert: (portfolio hasRegistered: transaction)! !

!PortfolioTest methodsFor: 'test' stamp: 'AS 5/17/2023 09:45:13'!
test06PortfolioHasRegisteredTransactionsInChildPortfolios

	| account transaction childPortfolio portfolio |
	
	account := ReceptiveAccount new.	
	transaction := self depositOf: 100 on: account.	
	childPortfolio := self portfolioWithAccounts: { account }.
	
	portfolio := self portfolioWithPortfolios: { childPortfolio }.
	
	self assert: (portfolio hasRegistered: transaction)! !

!PortfolioTest methodsFor: 'test' stamp: 'AS 5/17/2023 09:45:08'!
test07PortfolioKnowsChildAccountsTransactions

	| account transaction portfolio |
	
	account := ReceptiveAccount new.	
	transaction := self depositOf: 100 on: account.		
	portfolio := self portfolioWithAccounts: { account }.
	
	self assert: 1 equals: portfolio transactions size.
	self assert: (portfolio transactions includes: transaction).! !

!PortfolioTest methodsFor: 'test' stamp: 'AS 5/17/2023 09:45:02'!
test08PortfolioKnowsChildPortfoliosTransactions

	| account transaction childPortfolio portfolio |
	
	account := ReceptiveAccount new.	
	transaction := self depositOf: 100 on: account.		
	childPortfolio := self portfolioWithAccounts: { account }.
	
	portfolio := self portfolioWithPortfolios: { childPortfolio }.
	
	self assert: 1 equals: portfolio transactions size.
	self assert: (portfolio transactions includes: transaction).! !

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

!PortfolioTest methodsFor: 'test' stamp: 'AS 5/17/2023 20:35:41'!
test10PortfolioCantHaveTheSameAccountsInChildPortfolio

	| account parentPortfolio childPortfolio|
	
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

!PortfolioTest methodsFor: 'test' stamp: 'WAL 5/17/2023 23:01:25'!
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

!AccountTransaction methodsFor: 'value' stamp: 'AS 5/16/2023 16:06:26'!
addToBalance: balance 

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

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'AS 5/16/2023 15:53:14'!
addToBalance: balance 
	
	^balance + value! !

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

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'AS 5/16/2023 16:05:21'!
addToBalance: balance 
	
	^balance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'WAL 5/17/2023 23:23:37'!
initialize
	
	accounts := OrderedCollection new.
	portfolios := OrderedCollection new.
	parents := OrderedCollection new.
	! !


!Portfolio methodsFor: 'balance' stamp: 'AS 5/17/2023 19:17:18'!
balance
			
	^ (accounts sum: [ :account | account balance ] ifEmpty: [0])
		+ (portfolios sum: [ :portfolio | portfolio balance ] ifEmpty: [0])
! !


!Portfolio methodsFor: 'accounts' stamp: 'WAL 5/18/2023 00:07:46'!
accounts

	| allAccounts |

	allAccounts := OrderedCollection new.
	allAccounts addAll: accounts.
	
	portfolios do: [ : portfolio | allAccounts addAll: portfolio accounts ].

	^allAccounts! !

!Portfolio methodsFor: 'accounts' stamp: 'AS 5/17/2023 21:07:37'!
addAccount: anAccount 
	
	(self roots anySatisfy: [ :root | root hasAccount: anAccount ])
		ifTrue: [ self error: 'La cuenta ya pertenece al portfolio' ].
		
	accounts add: anAccount
			! !

!Portfolio methodsFor: 'accounts' stamp: 'WAL 5/17/2023 23:57:45'!
addPortfolio: aPortfolio 

	(self roots anySatisfy: [ :root | root hasPortfolio: aPortfolio ])
		ifTrue: [ self error: 'El portfolio ya pertenece al portfolio' ].
	
	aPortfolio accounts do: [ : anAccount | 
		(self roots anySatisfy: [ :root | root hasAccount: anAccount ])
				ifTrue: [ self error: 'Alguna cuenta ya pertenece al portfolio' ].
	].
	
	portfolios add: aPortfolio.
	aPortfolio addParent: self.! !

!Portfolio methodsFor: 'accounts' stamp: 'AS 5/17/2023 20:16:08'!
hasAccount: anAccount 
	
	^(accounts includes: anAccount) or: 	(portfolios anySatisfy: [ :portfolio | portfolio hasAccount: anAccount ])
			! !

!Portfolio methodsFor: 'accounts' stamp: 'WAL 5/17/2023 23:40:34'!
hasPortfolio: aPortfolio 
	
	^(portfolios includes: aPortfolio) or: 	(portfolios anySatisfy: [ :portfolio | portfolio hasPortfolio: aPortfolio ])
			! !


!Portfolio methodsFor: 'transactions' stamp: 'AS 5/17/2023 09:40:57'!
hasRegistered: aTransaction 
		
	^(accounts anySatisfy: [ :account | account hasRegistered: aTransaction ]) or:
	(portfolios anySatisfy: [ :portfolio | portfolio hasRegistered: aTransaction ]).
	! !

!Portfolio methodsFor: 'transactions' stamp: 'AS 5/17/2023 19:24:49'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	
	transactions addAll: (accounts do: [ :account | ^account transactions ]).	
	transactions addAll: (portfolios do: [ :portfolio | ^portfolio transactions ]).
		
	^transactions.
		! !


!Portfolio methodsFor: 'private' stamp: 'WAL 5/17/2023 23:25:29'!
addParent: aPortfolio

	parents add: aPortfolio ! !

!Portfolio methodsFor: 'private' stamp: 'WAL 5/17/2023 23:29:52'!
addRootsTo: aRootCollection
	
	parents do: [ : parent | parent addRootsTo: aRootCollection ] .
	
	parents ifEmpty: [ aRootCollection add: self ].
	! !

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
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'AS 5/16/2023 16:29:43'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'AS 5/16/2023 15:56:36'!
balance
	| balance |
	
	balance := 0.
	
	transactions do: [ :aTransaction | balance := aTransaction addToBalance: balance ].
	
	^balance! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

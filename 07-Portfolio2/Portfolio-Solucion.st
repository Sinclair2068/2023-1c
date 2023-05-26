!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AS 5/25/2023 15:00:20'!
test08TransferIncreasesBalanceOfDestinationAccountAndDecreasesBalanceOfSourceAccountOnTransactionValue 

	| sourceAccount destinationAccount |
	
	sourceAccount := ReceptiveAccount  new.
	destinationAccount := ReceptiveAccount  new.
	
	Transfer register: 100 from: sourceAccount to: destinationAccount.
		
	self assert: 100 equals: destinationAccount balance .
	self assert: 100 * -1 equals: sourceAccount balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AS 5/25/2023 15:38:59'!
test09TransferDepositKnowsTransferWithdrawAndViceversa

	| sourceAccount destinationAccount transfer transferDeposit transferWithdraw |
	
	sourceAccount := ReceptiveAccount  new.
	destinationAccount := ReceptiveAccount  new.
	
	transfer := Transfer register: 100 from: sourceAccount to: destinationAccount.
	
	transferDeposit := transfer deposit.
	transferWithdraw := transfer withdraw.
		
	self assert: transferDeposit equals: transferWithdraw deposit.
	self assert: transferWithdraw equals: transferDeposit withdraw.
! !


!classDefinition: #ReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'test' stamp: 'AS 5/25/2023 19:52:08'!
test01AccountSummaryOnEmptyAccountShouldReturnOnlyBalanceLineWithZero

	| account report |
	
	account := ReceptiveAccount  new.

	report := AccountSummary on: account.
	
	self assert: 1 equals: report lines size.	
	self assert: 'Balance = 0' equals: (report lines at: 1)! !

!ReportTest methodsFor: 'test' stamp: 'AS 5/25/2023 19:52:32'!
test02AccountSummaryOnAccountWithDepositShouldReturnDepositLines

	| account report |
	
	account := ReceptiveAccount  new.

	Deposit register: 100 on: account.
	Deposit register: 150 on: account.
	
	report := AccountSummary on: account.
	
	self assert: report lines includes: 'Depósito por 100'.
	self assert: report lines includes: 'Depósito por 150'.
	self assert: 'Balance = 250' equals: (report lines at: 3)
! !

!ReportTest methodsFor: 'test' stamp: 'AS 5/25/2023 19:52:44'!
test03AccountSummaryOnAccountWithWithdrawShouldReturnWithdrawLines

	| account report |
	
	account := ReceptiveAccount  new.

	Withdraw register: 100 on: account.
	Withdraw register: 150 on: account.
	
	report := AccountSummary on: account.
	
	self assert: report lines includes: 'Extracción por 100'.
	self assert: report lines includes: 'Extracción por 150'.
	self assert: 'Balance = -250' equals: (report lines at: 3)
! !

!ReportTest methodsFor: 'test' stamp: 'AS 5/25/2023 19:52:55'!
test04AccountSummaryOnAccountWithTransferShouldReturnTransferLines

	| sourceAccount destinationAccount sourceAccountReport destinationAccountReport |
	
	sourceAccount := ReceptiveAccount  new.
	destinationAccount := ReceptiveAccount  new.

	Transfer register: 100 from: sourceAccount to: destinationAccount.
		
	sourceAccountReport := AccountSummary on: sourceAccount.
	destinationAccountReport := AccountSummary on: destinationAccount.
	
	self assert: sourceAccountReport lines includes: 'Salida por transferencia de 100'.
	self assert: 'Balance = -100' equals: (sourceAccountReport lines at: 2).
	self assert: destinationAccountReport lines includes: 'Entrada por transferencia de 100'.
	self assert: 'Balance = 100' equals: (destinationAccountReport lines at: 2).	
! !

!ReportTest methodsFor: 'test' stamp: 'AS 5/25/2023 19:54:12'!
test05AccountSummaryOnEmptyPortfolioShouldReturnOnlyBalanceLineWithZero

	| portfolio report |
	
	portfolio := Portfolio  new.

	report := AccountSummary on: portfolio.
	
	self assert: 1 equals: report lines size.	
	self assert: 'Balance = 0' equals: (report lines at: 1)! !

!ReportTest methodsFor: 'test' stamp: 'AS 5/25/2023 20:04:49'!
test06AccountSummaryOnPortfolioShouldReturnAccountTransactions

	| portfolio account1 account2 report |
	
	account1 := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.

	Deposit register: 100 on: account1.
	Withdraw register: 70 on: account1.
	Transfer register: 60 from: account1 to: account2.
	
	portfolio := Portfolio new.
	portfolio add: account1.

	report := AccountSummary on: portfolio.
	
	self assert: report lines includes: 'Depósito por 100'.
	self assert: report lines includes: 'Extracción por 70'.
	self assert: report lines includes: 'Salida por transferencia de 60'.
	self assert: 'Balance = -30' equals: (report lines at: 4)
! !

!ReportTest methodsFor: 'test' stamp: 'WAL 5/25/2023 20:22:10'!
test07TransferNetOnEmptyAccountShouldReturnOnlyBalanceLineWithZero

	| account report |
	
	account := ReceptiveAccount  new.

	report := TransferNet on: account.
	
	self assert: 1 equals: report lines size.	
	self assert: 'Neto de transferencias = 0' equals: (report lines at: 1)! !

!ReportTest methodsFor: 'test' stamp: 'WAL 5/25/2023 20:34:37'!
test08TransferNetOnAccountWithTransferShouldReturnTransferLines

	| account1 account2 account1Report account2Report |
	
	account1 := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.

	Transfer register: 100 from: account1 to: account2.
	Transfer register: 70 from: account2 to: account1.
		
	account1Report := TransferNet on: account1.
	account2Report := TransferNet on: account2.
	
	self assert: 'Neto de transferencias = -30' equals: (account1Report lines at: 1).
	self assert: 'Neto de transferencias = 30' equals: (account2Report lines at: 1).	
! !

!ReportTest methodsFor: 'test' stamp: 'WAL 5/25/2023 20:49:04'!
test09TransferNetOnAccountShouldNotBeAffectedByOrdinaryDepositsOrWithdraws

	| account accountReport |
	
	account := ReceptiveAccount  new.

	Deposit register: 100 on: account.
	Withdraw register: 30 on: account.
		
	accountReport := TransferNet on: account.
	
	self assert: 'Neto de transferencias = 0' equals: (accountReport lines at: 1).
! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'reports' stamp: 'AS 5/25/2023 20:00:44'!
reportOn: aReport 
		
	accounts do: [ :account | account reportOn: aReport ].
	"transactions do: [ :transaction | transaction reportOn: aReport ].				"! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'AS 5/25/2023 17:36:32'!
reportOn: aReport
	
	transactions do: [ :transaction | transaction reportOn: aReport ].			
	! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'balance' stamp: 'AS 5/25/2023 19:46:49'!
reportOn: aReport

	self subclassResponsibility ! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

!Deposit methodsFor: 'balance' stamp: 'AS 5/25/2023 17:22:13'!
reportOn: aReport
	
	aReport writeDeposit: value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'AS 5/25/2023 16:08:55'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferDeposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferDeposit
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'AS 5/25/2023 15:57:00'!
affectBalance: aBalance

	^aBalance + transfer value ! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'AS 5/25/2023 16:01:06'!
initializeFrom: aTransfer

	transfer := aTransfer! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'AS 5/25/2023 19:48:30'!
reportOn: aReport

	aReport writeTransferDeposit: transfer value! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'AS 5/25/2023 15:58:03'!
withdraw
	
	^transfer withdraw! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: 'Portfolio-Solucion'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'instance creation' stamp: 'AS 5/25/2023 16:35:08'!
transfer: aTransfer on: anAccount

	| transferDeposit |
	
	transferDeposit := self new initializeFrom: aTransfer.
	anAccount register: transferDeposit.
	
	^transferDeposit.! !


!classDefinition: #TransferWithdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferWithdraw
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'AS 5/25/2023 15:57:11'!
affectBalance: aBalance

	^aBalance - transfer value ! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'AS 5/25/2023 15:57:47'!
deposit
	
	^transfer deposit! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'AS 5/25/2023 16:01:12'!
initializeFrom: aTransfer

	transfer := aTransfer! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'AS 5/25/2023 19:47:25'!
reportOn: aReport

	aReport writeTransferWithdraw: transfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: 'Portfolio-Solucion'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'instance creation' stamp: 'AS 5/25/2023 16:34:20'!
transfer: aTransfer on: anAccount

	| transferWithdraw |
	
	transferWithdraw := self new initializeFrom: aTransfer.
	anAccount register: transferWithdraw.
	
	^transferWithdraw.! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'AS 5/25/2023 19:39:13'!
reportOn: aReport 
	
	aReport writeWithdraw: value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'AS 5/25/2023 16:08:55'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'accessing' stamp: 'AS 5/25/2023 17:39:16'!
lines

	^lines! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'initialization' stamp: 'AS 5/25/2023 17:41:15'!
initializeOn: anAccount
	
	lines := OrderedCollection new.
	
	anAccount reportOn: self.
	
	lines add: 'Balance = ', anAccount balance asString.
	! !


!AccountSummary methodsFor: 'transactions' stamp: 'AS 5/25/2023 17:44:24'!
writeDeposit: aValue

	lines add: 'Depósito por ', aValue asString.! !

!AccountSummary methodsFor: 'transactions' stamp: 'AS 5/25/2023 19:48:12'!
writeTransferDeposit: aValue 
	
	lines add: 'Entrada por transferencia de ', aValue asString! !

!AccountSummary methodsFor: 'transactions' stamp: 'AS 5/25/2023 19:47:51'!
writeTransferWithdraw: aValue 
	
	lines add: 'Salida por transferencia de ', aValue asString! !

!AccountSummary methodsFor: 'transactions' stamp: 'AS 5/25/2023 19:39:59'!
writeWithdraw: aValue 
	
	lines add: 'Extracción por ', aValue asString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'as yet unclassified' stamp: 'AS 5/25/2023 17:28:39'!
on: anAccount
	
	^self new initializeOn: anAccount! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: 'transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'as yet unclassified' stamp: 'WAL 5/25/2023 20:49:52'!
initializeOn: anAccount
	
	transferNet := 0.
	
	lines := OrderedCollection new.
	
	anAccount reportOn: self.
	
	lines add: 'Neto de transferencias = ', transferNet asString.
	! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'WAL 5/25/2023 20:44:07'!
writeDeposit: aValue
	! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'WAL 5/25/2023 20:37:23'!
writeTransferDeposit: aValue 
	
	transferNet := transferNet + aValue
	! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'WAL 5/25/2023 20:38:07'!
writeTransferWithdraw: aValue 
	
	transferNet := transferNet - aValue
	! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'WAL 5/25/2023 20:44:15'!
writeWithdraw: aValue
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'Portfolio-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'as yet unclassified' stamp: 'WAL 5/25/2023 20:25:30'!
on: anAccount
	
	^self new initializeOn: anAccount! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value deposit withdraw'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'AS 5/25/2023 15:39:40'!
deposit
	
	^ deposit! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'AS 5/25/2023 16:28:41'!
initializeFor: aValue

	value := aValue! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'AS 5/25/2023 16:44:57'!
initializeFor: aValue from: aWithdraw to: aDeposit

	value := aValue.
	withdraw := aWithdraw.
	deposit := aDeposit.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'AS 5/25/2023 16:47:27'!
value
	
	^ value! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'AS 5/25/2023 15:39:49'!
withdraw
	
	^ withdraw! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'AS 5/25/2023 16:45:09'!
register: aValue from: sourceAccount to: destinationAccount

	| transfer deposit withdraw |

	transfer := self new.
	
	withdraw := TransferWithdraw transfer: transfer on: sourceAccount.
	deposit := TransferDeposit transfer: transfer on: destinationAccount.
	
	transfer initializeFor: aValue from: withdraw to: deposit.
	
	^ transfer! !

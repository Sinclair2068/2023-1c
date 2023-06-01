!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:46:41'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: (Portfolio named: 'Mi portfolio') balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:33:29'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount named: 'Mi cuenta'.
	Deposit register: 100 on: account.
	portfolio := Portfolio named: 'Mi portfolio' with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:35:40'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount named: 'Mi cuenta 1'.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio named: 'Mi portfolio simple' with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount named: 'Mi cuenta 2'.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio named: 'Mi portfolio compuesto' with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:47:13'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: ((Portfolio named: 'Mi portfolio') hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:36:08'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount named: 'Mi cuenta'.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio named: 'Mi portfolio' with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:37:09'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount named: 'Mi cuenta 1'.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio named: 'Mi portfolio hijo' with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount named: 'Mi cuenta 2'.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio named: 'Mi portfolio padre' with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:47:32'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: (Portfolio named: 'Mi portfolio') transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:38:54'!
test08PortfolioTransactionsAtions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount named: 'Mi cuenta'.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount named: 'Mi otra cuenta'.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio named: 'Mi portfolio' with: account.   
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:38:29'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount named: 'Mi cuenta'.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount named: 'Mi otra cuenta'.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio named: 'Mi portfolio' with: account.   
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:39:50'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount named: 'Mi cuenta 1'.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio named: 'Mi portfolio hijo' with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount named: 'Mi cuenta 2'.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio named: 'Mi portfolio padre' with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:40:07'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount named: 'Mi cuenta'.
	portfolio := Portfolio named: 'Mi portfolio' with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:40:34'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount named: 'Mi cuenta'..
	simplePortfolio := Portfolio named: 'Mi portfolio hijo' with: account.
	composedPortfolio := Portfolio named: 'Mi portfolio padre' with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:41:01'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount named: 'Mi cuenta'.
	simplePortfolio := Portfolio named: 'Mi portfolio' with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:41:32'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount named: 'Mi cuenta'.
	simplePortfolio := Portfolio named: 'Mi portfolio hijo'.
	composedPortfolio := Portfolio named: 'Mi portfolio padre' with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:43:19'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount  named: 'Mi cuenta'.
	portfolio := Portfolio named: 'Mi portfolio'.
	leftParentPortfolio := Portfolio named: 'Mi portfolio padre izquierdo' with: portfolio .
	leftRootParentPortfolio := Portfolio named: 'Mi portfolio padre raíz izquierdo' with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio named: 'Mi portfolio padre derecho' with: portfolio .
	rightRootParentPortfolio := Portfolio named: 'Mi portfolio padre raíz derecho' with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:44:34'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount named: 'Cuenta compartido'.
	portfolioToModify := Portfolio named: 'Portfolio a modificar'.
	rootPortfolio := Portfolio named: 'Portfolio raíz' with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio named: 'Portfolio para agregar' with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'WAL 5/26/2023 11:39:19'!
test16PortfolioCanHaveAName

	| portfolio |
	
	portfolio := Portfolio named: 'Portfolio de la familia'.
	
	self assert: 'Portfolio de la familia' equals: portfolio name! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:45:29'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount named: 'Mi cuenta'.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:45:41'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount named: 'Mi cuenta'.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:45:46'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount named: 'Mi cuenta'.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:45:53'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount named: 'Mi cuenta'.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:45:57'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount named: 'Mi cuenta'.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:46:01'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount named: 'Mi cuenta'.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:46:04'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount named: 'Mi cuenta'.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:15:25'!
test08ReceptiveAccountCanHaveName

	| account |
	
	account := ReceptiveAccount named: 'Cuenta Mia'.

	self assert: 'Cuenta Mia' equals: account name.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:46:14'!
test09DepositValueMustBeGreaterThanCero

	| account |
	
	account := ReceptiveAccount named: 'Mi cuenta'.
			
	self 
		should: [ Deposit register: 0 on: account. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: AccountTransaction transactionValueMustBeGreaterThanCeroErrorDescription ].
	
	self 
		should: [ Deposit register: -100 on: account. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: AccountTransaction transactionValueMustBeGreaterThanCeroErrorDescription ]
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'WAL 5/31/2023 21:46:18'!
test10WithdrawValueMustBeGreaterThanCero

	| account |
	
	account := ReceptiveAccount named: 'Mi cuenta'.
			
	self 
		should: [ Withdraw register: 0 on: account. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: AccountTransaction transactionValueMustBeGreaterThanCeroErrorDescription ].
	
	self 
		should: [ Withdraw register: -100 on: account. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: AccountTransaction transactionValueMustBeGreaterThanCeroErrorDescription ]
	! !


!classDefinition: #ReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'assertions' stamp: 'WAL 5/28/2023 15:57:15'!
assert: aReport sameAs: anArrayOfLines

	self assert: aReport lines asArray = anArrayOfLines.

! !


!ReportTest methodsFor: 'lines' stamp: 'WAL 5/28/2023 17:50:23'!
line: aText withTabs: aSize

	^ ( String new: aSize * self tabSize withAll: self tabCharacter ) , aText! !

!ReportTest methodsFor: 'lines' stamp: 'WAL 5/28/2023 17:34:05'!
tabCharacter

	^ Character space! !

!ReportTest methodsFor: 'lines' stamp: 'WAL 5/28/2023 17:45:23'!
tabSize

	^3! !

!ReportTest methodsFor: 'lines' stamp: 'WAL 5/28/2023 17:28:38'!
textBalanceIgual: anAmount

	^ 'Balance = ' , anAmount asString ! !

!ReportTest methodsFor: 'lines' stamp: 'WAL 5/28/2023 17:28:54'!
textDepositoPor: anAmount

	^ 'Depósito por ' , anAmount asString! !

!ReportTest methodsFor: 'lines' stamp: 'WAL 5/28/2023 18:11:59'!
textEntradaPorTransferenciaDe: anAmount

	^ 'Entrada por transferencia de ' , anAmount asString ! !

!ReportTest methodsFor: 'lines' stamp: 'WAL 5/28/2023 17:29:16'!
textExtraccionPor: anAmount

	^ 'Extracción por ' , anAmount asString! !

!ReportTest methodsFor: 'lines' stamp: 'WAL 5/28/2023 17:29:23'!
textNetoDeTransferenciasIgual: anAmount
	
	^'Neto de transferencias = ' , anAmount asString ! !

!ReportTest methodsFor: 'lines' stamp: 'WAL 5/28/2023 17:29:40'!
textSalidaPorTransferenciaDe: anAmount

	^ 'Salida por transferencia de ' , anAmount asString! !


!ReportTest methodsFor: 'accounts' stamp: 'WAL 5/28/2023 17:58:59'!
cuentaDeAngelesName

	^ 'Cuenta de Angeles'! !

!ReportTest methodsFor: 'accounts' stamp: 'WAL 5/28/2023 17:58:48'!
cuentaDeJuanName

	^ 'Cuenta de Juan'! !

!ReportTest methodsFor: 'accounts' stamp: 'WAL 5/28/2023 17:58:34'!
cuentaMiaName

	^ 'Cuenta Mia'! !

!ReportTest methodsFor: 'accounts' stamp: 'WAL 5/28/2023 17:58:09'!
portfolioDeHijosName

	^ 'Portfolio de hijos'  ! !

!ReportTest methodsFor: 'accounts' stamp: 'WAL 5/28/2023 17:57:51'!
portfolioDeLaFamiliaName

	^ 'Portfolio de la familia'! !


!ReportTest methodsFor: 'test' stamp: 'WAL 5/28/2023 17:28:39'!
test01AccountSummaryOnEmptyAccountShouldReturnOnlyBalanceLineWithZero

	| report |

	report := AccountSummary on: (ReceptiveAccount named: 'Mi cuenta').
	
	self assert: report sameAs: { self textBalanceIgual: 0 } .! !

!ReportTest methodsFor: 'test' stamp: 'WAL 5/31/2023 21:49:02'!
test02AccountSummaryOnAccountWithDepositShouldReturnDepositLines

	| account report |
	
	account := ReceptiveAccount named: 'Mi cuenta'.

	Deposit register: 100 on: account.
	Deposit register: 150 on: account.
	
	report := AccountSummary on: account.
	
	self assert: report sameAs: {
		self textDepositoPor: 100 .
		self textDepositoPor: 150 .
		self textBalanceIgual: 250 }
! !

!ReportTest methodsFor: 'test' stamp: 'WAL 5/31/2023 21:49:22'!
test03AccountSummaryOnAccountWithWithdrawShouldReturnWithdrawLines

	| account report |
	
	account := ReceptiveAccount named: 'Mi cuenta'.

	Withdraw register: 100 on: account.
	Withdraw register: 150 on: account.
	
	report := AccountSummary on: account.
	
	self assert: report sameAs: {
		self textExtraccionPor: 100. 
		self textExtraccionPor: 150.
		self textBalanceIgual: (-250) }
! !

!ReportTest methodsFor: 'test' stamp: 'WAL 5/31/2023 21:49:43'!
test04AccountSummaryOnAccountWithTransferShouldReturnTransferLines

	| sourceAccount destinationAccount sourceAccountReport destinationAccountReport |
	
	sourceAccount := ReceptiveAccount named: 'Mi cuenta 1'.
	destinationAccount := ReceptiveAccount named: 'Mi cuenta 2'.

	Transfer register: 100 from: sourceAccount to: destinationAccount.
		
	sourceAccountReport := AccountSummary on: sourceAccount.
	destinationAccountReport := AccountSummary on: destinationAccount.
	
	self assert: sourceAccountReport sameAs: {
		self textSalidaPorTransferenciaDe: 100.
		self textBalanceIgual: (-100) }.

	self assert: destinationAccountReport sameAs: {
		self textEntradaPorTransferenciaDe: 100.
		self textBalanceIgual: 100 }.
! !

!ReportTest methodsFor: 'test' stamp: 'WAL 5/31/2023 21:50:02'!
test05AccountSummaryOnEmptyPortfolioShouldReturnOnlyBalanceLineWithZero

	| portfolio report |
	
	portfolio := Portfolio named: 'Mi portfolio'.

	report := AccountSummary on: portfolio.
	
	self assert: report sameAs: { self textBalanceIgual: 0 }.! !

!ReportTest methodsFor: 'test' stamp: 'WAL 5/31/2023 21:50:43'!
test06AccountSummaryOnPortfolioShouldReturnAccountTransactions

	| portfolio account1 account2 report |
	
	account1 := ReceptiveAccount named: 'Mi cuenta 1'.
	account2 := ReceptiveAccount named: 'Mi cuenta 2'.

	Deposit register: 100 on: account1.
	Withdraw register: 70 on: account1.
	Transfer register: 60 from: account1 to: account2.
	
	portfolio := Portfolio named: 'Mi portfolio'.
	portfolio add: account1.

	report := AccountSummary on: portfolio.
	
	self assert: report sameAs: {
		self textDepositoPor: 100.
		self textExtraccionPor: 70.
		self textSalidaPorTransferenciaDe: 60.
		self textBalanceIgual: ( -30 ) }
! !

!ReportTest methodsFor: 'test' stamp: 'WAL 5/31/2023 21:51:02'!
test07TransferNetOnEmptyAccountShouldReturnOnlyBalanceLineWithZero

	| account report |
	
	account := ReceptiveAccount named: 'Mi cuenta 1'.

	report := TransferNet on: account.
	
	self assert: report sameAs: { self textNetoDeTransferenciasIgual: 0 }! !

!ReportTest methodsFor: 'test' stamp: 'WAL 5/31/2023 21:51:40'!
test08TransferNetOnAccountWithTransferShouldReturnTransferLines

	| account1 account2 account1Report account2Report portfolio portfolioReport |
	
	account1 := ReceptiveAccount named: 'Mi cuenta 1'.
	account2 := ReceptiveAccount named: 'Mi cuenta 2'.

	Transfer register: 100 from: account1 to: account2.
	Transfer register: 70 from: account2 to: account1.
	
	portfolio := Portfolio named: 'Mi portfolio' with: account1.
	
	account1Report := TransferNet on: account1.
	account2Report := TransferNet on: account2.	
	portfolioReport := TransferNet on: portfolio.
	
	self assert: portfolioReport sameAs: { self textNetoDeTransferenciasIgual: -30 }.
	self assert: account1Report sameAs: { self textNetoDeTransferenciasIgual: -30 }.
	self assert: account2Report sameAs: { self textNetoDeTransferenciasIgual: 30 }

		
! !

!ReportTest methodsFor: 'test' stamp: 'WAL 5/31/2023 21:52:05'!
test09TransferNetOnAccountShouldNotBeAffectedByOrdinaryDepositsOrWithdraws

	| account report |
	
	account := ReceptiveAccount named: 'Mi cuenta'.

	Deposit register: 100 on: account.
	Withdraw register: 30 on: account.
		
	report := TransferNet on: account.
	
	self assert: report sameAs: { self textNetoDeTransferenciasIgual: 0 }! !

!ReportTest methodsFor: 'test' stamp: 'WAL 5/28/2023 17:59:43'!
test10PortfolioStructureOnEmptyPortfolioShouldReturnPortfolioName

	| report |
	
	report := PortfolioStructure on: (Portfolio named: self portfolioDeLaFamiliaName).
	
	self assert: report sameAs: { self portfolioDeLaFamiliaName }.! !

!ReportTest methodsFor: 'test' stamp: 'WAL 5/28/2023 18:03:54'!
test11PortfolioStructureOnPortfolioShouldReturnPortfolioStructureReport

	| portfolio report |
	
	portfolio := Portfolio named: self portfolioDeLaFamiliaName
		with: (ReceptiveAccount named: self cuentaMiaName)
		with: (Portfolio named: self portfolioDeHijosName
			with: (	ReceptiveAccount named: self cuentaDeJuanName)
			with: (ReceptiveAccount named: self cuentaDeAngelesName)).
	
	report := PortfolioStructure on: portfolio.
	
	self assert: report sameAs: {
		self portfolioDeLaFamiliaName.
		self line: self cuentaMiaName withTabs: 1.
		self line: self portfolioDeHijosName withTabs: 1.
		self line: self cuentaDeJuanName withTabs: 2.
		self line: self cuentaDeAngelesName withTabs: 2.
	}.
	! !

!ReportTest methodsFor: 'test' stamp: 'WAL 5/28/2023 18:15:39'!
test12PortfolioStructureOnReceptiveAccountShouldRiseError

	self 
		should: [ PortfolioStructure on: (ReceptiveAccount named: 'Mi cuenta') ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: PortfolioStructure portfolioStructureNotPossibleOnReceptiveAccountErrorDescription ]
	! !

!ReportTest methodsFor: 'test' stamp: 'WAL 5/28/2023 18:16:22'!
test13StructuredAccountSummaryOnPortfolioShouldReturnPortfolioStructuredAccountSummary

	| portfolio cuentaMia cuentaDeJuan cuentaDeAngeles report |
	
	cuentaMia := ReceptiveAccount named: self cuentaMiaName .
	Deposit register: 100 on: cuentaMia.
	Withdraw register: 70 on: cuentaMia.
	
	cuentaDeJuan := ReceptiveAccount named: self cuentaDeJuanName .
	cuentaDeAngeles := 	ReceptiveAccount named: self cuentaDeAngelesName .
	Transfer register: 200 from: cuentaDeJuan to: cuentaDeAngeles.
	
	portfolio := Portfolio named: self portfolioDeLaFamiliaName 
		with: cuentaMia
		with: (Portfolio named: self portfolioDeHijosName 
			with: cuentaDeJuan
			with: cuentaDeAngeles).
	
	report := StructuredAccountSummary on: portfolio.
	
	self assert: report sameAs: {
		self portfolioDeLaFamiliaName .
		self line: self cuentaMiaName withTabs: 1.
		self line: (self textDepositoPor: 100) withTabs: 2.
		self line: (self textExtraccionPor: 70) withTabs: 2.
		self line: (self textBalanceIgual: 30) withTabs: 2.
		self line: self portfolioDeHijosName withTabs: 1.
		self line: self cuentaDeJuanName withTabs: 2.
		self line: (self textSalidaPorTransferenciaDe: 200) withTabs: 3.
		self line: (self textBalanceIgual: -200) withTabs: 3.
		self line: self cuentaDeAngelesName withTabs: 2.
		self line: (self textEntradaPorTransferenciaDe: 200) withTabs: 3.	
		self line: (self textBalanceIgual: 200) withTabs: 3.
		self line: (self textBalanceIgual: 0) withTabs: 2.
		self line: (self textBalanceIgual: 30) withTabs: 1. }.! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'test' stamp: 'WAL 5/31/2023 21:17:31'!
test01TransferIncreasesBalanceOfDestinationAccountAndDecreasesBalanceOfSourceAccountOnTransactionValue 

	| sourceAccount destinationAccount |
	
	sourceAccount := ReceptiveAccount  new.
	destinationAccount := ReceptiveAccount  new.
	
	Transfer register: 100 from: sourceAccount to: destinationAccount.
		
	self assert: 100 equals: destinationAccount balance .
	self assert: 100 * -1 equals: sourceAccount balance .
! !

!TransferTest methodsFor: 'test' stamp: 'WAL 5/31/2023 21:17:37'!
test02TransferDepositKnowsTransferWithdrawAndViceversa

	| sourceAccount destinationAccount transfer transferDeposit transferWithdraw |
	
	sourceAccount := ReceptiveAccount  new.
	destinationAccount := ReceptiveAccount  new.
	
	transfer := Transfer register: 100 from: sourceAccount to: destinationAccount.
	
	transferDeposit := transfer deposit.
	transferWithdraw := transfer withdraw.
		
	self assert: transferDeposit equals: transferWithdraw deposit.
	self assert: transferWithdraw equals: transferDeposit withdraw.! !

!TransferTest methodsFor: 'test' stamp: 'WAL 5/31/2023 21:17:47'!
test03TransferValueMustBeGreaterThanCero

	| sourceAccount destinationAccount |
	
	sourceAccount := ReceptiveAccount  new.
	destinationAccount := ReceptiveAccount  new.
			
	self 
		should: [ Transfer register: 0 from: sourceAccount to: destinationAccount. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Transfer transferValueMustBeGreaterThanCeroErrorDescription ].
	
	self 
		should: [ Transfer register: -100 from: sourceAccount to: destinationAccount. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Transfer transferValueMustBeGreaterThanCeroErrorDescription ]! !

!TransferTest methodsFor: 'test' stamp: 'WAL 5/31/2023 21:20:37'!
test04TransferDestinationCanNotBeSameAsSource

	| account |
	
	account := ReceptiveAccount  new.
			
	self 
		should: [ Transfer register: 100 from: account to: account. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Transfer transferDestinationCanNotBeSameAsSourceErrorDescription ].
	
	! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'initialization' stamp: 'WAL 5/28/2023 18:39:26'!
initializeWithName: aName

	self subclassResponsibility ! !


!Account methodsFor: 'name' stamp: 'WAL 5/26/2023 11:40:16'!
name

	^name! !


!Account methodsFor: 'reports' stamp: 'WAL 5/28/2023 18:36:05'!
reportFor: aReportClass

	self subclassResponsibility ! !

!Account methodsFor: 'reports' stamp: 'WAL 5/28/2023 18:36:15'!
reportOn: aReport

	self subclassResponsibility ! !

!Account methodsFor: 'reports' stamp: 'WAL 5/28/2023 18:36:38'!
writeTo: aReport

	self subclassResponsibility ! !


!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'Portfolio-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'instance creation' stamp: 'WAL 5/26/2023 11:45:51'!
named: aName

	^ self new initializeWithName: aName.! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

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


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'WAL 5/26/2023 11:48:17'!
initializeWithName: aName 
	
	name := aName.! !


!Portfolio methodsFor: 'reports' stamp: 'WAL 5/27/2023 19:37:25'!
reportFor: aReportClass

	aReportClass createOnPortfolio: self! !

!Portfolio methodsFor: 'reports' stamp: 'WAL 5/27/2023 20:01:47'!
reportOn: aReport 
	
	aReport writePortfolio: self.! !

!Portfolio methodsFor: 'reports' stamp: 'WAL 5/26/2023 13:38:35'!
writeTo: aReport 
	
	accounts do: [ :account | account reportOn: aReport ].! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!Portfolio class methodsFor: 'instance creation' stamp: 'WAL 5/26/2023 11:44:30'!
named: aName with: anAccount

	^(self new initializeWithName: aName)
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'WAL 5/26/2023 11:44:58'!
named: aName with: anAccount with: anotherAccount

	^(self new initializeWithName: aName)
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'WAL 5/26/2023 11:35:52'!
initializeWithName: aName.

	name := aName! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'WAL 5/27/2023 19:37:25'!
reportFor: aReportClass

	aReportClass createOnReceptiveAccount: self! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'WAL 5/27/2023 20:13:33'!
reportOn: aReport
	
	aReport writeReceptiveAccount: self.! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'WAL 5/28/2023 18:32:45'!
writeTo: aReport
	
	transactions do: [ :transaction | transaction reportOn: aReport ].	
	! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'WAL 5/26/2023 11:34:55'!
named: aName

	^ self new initializeWithName: aName.
	
	! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reports' stamp: 'WAL 5/28/2023 18:32:07'!
reportOn: aReport

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'error descriptions' stamp: 'WAL 5/31/2023 20:22:56'!
transactionValueMustBeGreaterThanCeroErrorDescription

	^'Transaction value must be greater than cero'! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'reports' stamp: 'WAL 5/28/2023 18:32:07'!
reportOn: aReport
	
	aReport writeDeposit: value! !


!Deposit methodsFor: 'value' stamp: 'WAL 5/28/2023 18:45:41'!
value
	
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'WAL 5/31/2023 20:31:29'!
register: aValue on: account

	| transaction |
	
	(aValue <= 0) ifTrue: [self error: AccountTransaction transactionValueMustBeGreaterThanCeroErrorDescription].
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferDeposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferDeposit
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'legs' stamp: 'AS 5/25/2023 15:58:03'!
withdraw
	
	^transfer withdraw! !


!TransferDeposit methodsFor: 'balance' stamp: 'AS 5/25/2023 15:57:00'!
affectBalance: aBalance

	^aBalance + transfer value ! !


!TransferDeposit methodsFor: 'reports' stamp: 'WAL 5/28/2023 18:32:07'!
reportOn: aReport

	aReport writeTransferDeposit: transfer value! !


!TransferDeposit methodsFor: 'initialization' stamp: 'AS 5/25/2023 16:01:06'!
initializeFrom: aTransfer

	transfer := aTransfer! !


!TransferDeposit methodsFor: 'value' stamp: 'WAL 5/28/2023 18:48:06'!
value
	
	^transfer value! !

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

!TransferWithdraw methodsFor: 'legs' stamp: 'AS 5/25/2023 15:57:47'!
deposit
	
	^transfer deposit! !


!TransferWithdraw methodsFor: 'balance' stamp: 'AS 5/25/2023 15:57:11'!
affectBalance: aBalance

	^aBalance - transfer value ! !


!TransferWithdraw methodsFor: 'reports' stamp: 'WAL 5/28/2023 18:32:07'!
reportOn: aReport

	aReport writeTransferWithdraw: transfer value! !


!TransferWithdraw methodsFor: 'initialization' stamp: 'AS 5/25/2023 16:01:12'!
initializeFrom: aTransfer

	transfer := aTransfer! !


!TransferWithdraw methodsFor: 'value' stamp: 'WAL 5/28/2023 18:48:12'!
value
	
	^transfer value! !

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

!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'reports' stamp: 'WAL 5/28/2023 18:32:07'!
reportOn: aReport 
	
	aReport writeWithdraw: value! !


!Withdraw methodsFor: 'value' stamp: 'WAL 5/28/2023 18:45:26'!
value
	
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'WAL 5/31/2023 20:31:44'!
register: aValue on: account

	| transaction |

	(aValue <= 0) ifTrue: [self error: AccountTransaction transactionValueMustBeGreaterThanCeroErrorDescription].
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'initialization' stamp: 'WAL 5/27/2023 20:42:46'!
initialize

	lines := OrderedCollection new! !


!Report methodsFor: 'accessing' stamp: 'AS 5/25/2023 17:39:16'!
lines

	^lines! !


!Report methodsFor: 'private' stamp: 'WAL 5/27/2023 21:14:21'!
writeBalance: anAccount

	self writeLine: 'Balance = ', anAccount balance asString! !

!Report methodsFor: 'private' stamp: 'WAL 5/27/2023 21:22:26'!
writeLine: aText

	lines add: aText! !


!Report methodsFor: 'write' stamp: 'WAL 5/31/2023 20:56:38'!
writeDeposit: aValue

	self subclassResponsibility ! !

!Report methodsFor: 'write' stamp: 'WAL 5/31/2023 20:57:47'!
writePortfolio: aPortfolio
	
	self subclassResponsibility ! !

!Report methodsFor: 'write' stamp: 'WAL 5/31/2023 20:58:05'!
writeReceptiveAccount: aReceptiveAccount

	self subclassResponsibility ! !

!Report methodsFor: 'write' stamp: 'WAL 5/31/2023 20:57:08'!
writeTransferDeposit: aValue

	self subclassResponsibility ! !

!Report methodsFor: 'write' stamp: 'WAL 5/31/2023 20:57:03'!
writeTransferWithdraw: aValue

	self subclassResponsibility ! !

!Report methodsFor: 'write' stamp: 'WAL 5/31/2023 20:56:46'!
writeWithdraw: aValue

	self subclassResponsibility ! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'initialization' stamp: 'WAL 5/27/2023 21:14:47'!
initializeOn: anAccount
	
	anAccount reportOn: self.
	
	self writeBalance: anAccount
	! !


!AccountSummary methodsFor: 'write' stamp: 'WAL 5/27/2023 21:07:59'!
writeDeposit: aValue

	self writeLine: 'Depósito por ', aValue asString.! !

!AccountSummary methodsFor: 'write' stamp: 'WAL 5/26/2023 13:51:24'!
writePortfolio: aPortfolio
	
	aPortfolio writeTo: self! !

!AccountSummary methodsFor: 'write' stamp: 'WAL 5/26/2023 13:45:13'!
writeReceptiveAccount: aReceptiveAccount
	
	aReceptiveAccount writeTo: self! !

!AccountSummary methodsFor: 'write' stamp: 'WAL 5/27/2023 21:08:28'!
writeTransferDeposit: aValue 
	
	self writeLine: 'Entrada por transferencia de ', aValue asString! !

!AccountSummary methodsFor: 'write' stamp: 'WAL 5/27/2023 21:08:32'!
writeTransferWithdraw: aValue 
	
	self writeLine: 'Salida por transferencia de ', aValue asString! !

!AccountSummary methodsFor: 'write' stamp: 'WAL 5/27/2023 21:07:16'!
writeWithdraw: aValue 
	
	self writeLine: 'Extracción por ', aValue asString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'AS 5/25/2023 17:28:39'!
on: anAccount
	
	^self new initializeOn: anAccount! !


!classDefinition: #StructuredReport category: 'Portfolio-Solucion'!
Report subclass: #StructuredReport
	instanceVariableNames: 'indentationSize tabSize tabCharacter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!StructuredReport methodsFor: 'indentation' stamp: 'WAL 5/27/2023 20:53:51'!
decrementIndentation

	^ indentationSize := indentationSize - tabSize! !

!StructuredReport methodsFor: 'indentation' stamp: 'WAL 5/27/2023 20:53:47'!
incrementIndentation

	^ indentationSize := indentationSize + tabSize! !

!StructuredReport methodsFor: 'indentation' stamp: 'WAL 5/27/2023 20:53:44'!
indentation

	^ String new: indentationSize withAll: tabCharacter.! !


!StructuredReport methodsFor: 'initialization' stamp: 'WAL 5/27/2023 20:52:17'!
initialize

	super initialize.

	indentationSize := 0.
	tabSize := 3.
	tabCharacter := Character space.
! !


!StructuredReport methodsFor: 'private' stamp: 'WAL 5/27/2023 20:55:01'!
writeLine: aText

	lines add: (self indentation), aText! !

!StructuredReport methodsFor: 'private' stamp: 'WAL 5/27/2023 20:55:14'!
writeName: anAccount

	self writeLine: anAccount name! !


!StructuredReport methodsFor: 'write' stamp: 'WAL 5/31/2023 20:54:35'!
writeDeposit: aValue

	self subclassResponsibility ! !

!StructuredReport methodsFor: 'write' stamp: 'WAL 5/31/2023 20:55:02'!
writePortfolio: aPortfolio

	self subclassResponsibility ! !

!StructuredReport methodsFor: 'write' stamp: 'WAL 5/31/2023 20:56:08'!
writeReceptiveAccount: aReceptiveAccount

	self subclassResponsibility ! !

!StructuredReport methodsFor: 'write' stamp: 'WAL 5/31/2023 20:55:44'!
writeTransferDeposit: aValue 

	self subclassResponsibility ! !

!StructuredReport methodsFor: 'write' stamp: 'WAL 5/31/2023 20:55:32'!
writeTransferWithdraw: aValue 

	self subclassResponsibility ! !

!StructuredReport methodsFor: 'write' stamp: 'WAL 5/31/2023 20:55:19'!
writeWithdraw: aValue 

	self subclassResponsibility ! !


!classDefinition: #PortfolioStructure category: 'Portfolio-Solucion'!
StructuredReport subclass: #PortfolioStructure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioStructure methodsFor: 'write' stamp: 'WAL 5/31/2023 20:51:52'!
writeDeposit: aValue! !

!PortfolioStructure methodsFor: 'write' stamp: 'WAL 5/27/2023 20:56:34'!
writePortfolio: aPortfolio
	
	self writeName: aPortfolio.
	
	self incrementIndentation.
	
	aPortfolio writeTo: self.
	
	self decrementIndentation.! !

!PortfolioStructure methodsFor: 'write' stamp: 'WAL 5/27/2023 21:00:29'!
writeReceptiveAccount: aReceptiveAccount
	
	self writeName: aReceptiveAccount.! !

!PortfolioStructure methodsFor: 'write' stamp: 'WAL 5/31/2023 20:52:25'!
writeTransferDeposit: aValue! !

!PortfolioStructure methodsFor: 'write' stamp: 'WAL 5/31/2023 20:52:50'!
writeTransferWithdraw: aValue ! !

!PortfolioStructure methodsFor: 'write' stamp: 'WAL 5/31/2023 20:53:13'!
writeWithdraw: aValue ! !


!PortfolioStructure methodsFor: 'initialization' stamp: 'WAL 5/27/2023 20:45:41'!
initializeOn: aPortfolio
	
	aPortfolio reportOn: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioStructure class' category: 'Portfolio-Solucion'!
PortfolioStructure class
	instanceVariableNames: ''!

!PortfolioStructure class methodsFor: 'error descriptions' stamp: 'WAL 5/27/2023 19:21:23'!
portfolioStructureNotPossibleOnReceptiveAccountErrorDescription

	^'PortfolioStructure report not possible on receptive account'! !


!PortfolioStructure class methodsFor: 'instance creation' stamp: 'WAL 5/27/2023 19:31:34'!
createOnPortfolio: aPortfolio
	
	^self new initializeOn: aPortfolio! !

!PortfolioStructure class methodsFor: 'instance creation' stamp: 'WAL 5/27/2023 19:31:50'!
createOnReceptiveAccount: aReceptiveAccount
	
	self error: self portfolioStructureNotPossibleOnReceptiveAccountErrorDescription ! !

!PortfolioStructure class methodsFor: 'instance creation' stamp: 'WAL 5/27/2023 19:37:25'!
on: aPortfolio
	
	aPortfolio reportFor: self.
	
	^self new initializeOn: aPortfolio! !


!classDefinition: #StructuredAccountSummary category: 'Portfolio-Solucion'!
StructuredReport subclass: #StructuredAccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!StructuredAccountSummary methodsFor: 'initialization' stamp: 'WAL 5/27/2023 20:45:49'!
initializeOn: anAccount
	
	anAccount reportOn: self.
	! !


!StructuredAccountSummary methodsFor: 'private' stamp: 'WAL 5/27/2023 20:36:40'!
writeAccount: anAccount

	self writeName: anAccount.
	
	self incrementIndentation.
	
	anAccount writeTo: self.
	
	self writeBalance: anAccount.	
	
	self decrementIndentation.
	
! !


!StructuredAccountSummary methodsFor: 'write' stamp: 'WAL 5/27/2023 20:34:22'!
writeDeposit: aValue

	self writeLine: 'Depósito por ', aValue asString.! !

!StructuredAccountSummary methodsFor: 'write' stamp: 'WAL 5/27/2023 20:29:00'!
writePortfolio: aPortfolio

	self writeAccount: aPortfolio
	
! !

!StructuredAccountSummary methodsFor: 'write' stamp: 'WAL 5/27/2023 20:29:19'!
writeReceptiveAccount: aReceptiveAccount

	self writeAccount: aReceptiveAccount! !

!StructuredAccountSummary methodsFor: 'write' stamp: 'WAL 5/27/2023 20:33:35'!
writeTransferDeposit: aValue 
	
	self writeLine: 'Entrada por transferencia de ', aValue asString! !

!StructuredAccountSummary methodsFor: 'write' stamp: 'WAL 5/27/2023 20:33:40'!
writeTransferWithdraw: aValue 
	
	self writeLine: 'Salida por transferencia de ', aValue asString! !

!StructuredAccountSummary methodsFor: 'write' stamp: 'WAL 5/27/2023 20:33:47'!
writeWithdraw: aValue 
	
	self writeLine: 'Extracción por ', aValue asString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StructuredAccountSummary class' category: 'Portfolio-Solucion'!
StructuredAccountSummary class
	instanceVariableNames: ''!

!StructuredAccountSummary class methodsFor: 'instance creation' stamp: 'WAL 5/27/2023 19:56:11'!
on: anAccount

	^self new initializeOn: anAccount! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: 'transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'initialization' stamp: 'WAL 5/27/2023 21:23:45'!
initializeOn: anAccount
	
	transferNet := 0.
	
	anAccount reportOn: self.
	
	self writeTransferNet.
	! !


!TransferNet methodsFor: 'private' stamp: 'WAL 5/27/2023 21:23:45'!
writeTransferNet

	^ self writeLine: 'Neto de transferencias = ', transferNet asString! !


!TransferNet methodsFor: 'write' stamp: 'WAL 5/25/2023 20:44:07'!
writeDeposit: aValue
	! !

!TransferNet methodsFor: 'write' stamp: 'WAL 5/26/2023 13:51:09'!
writePortfolio: aPortfolio
	
	aPortfolio writeTo: self! !

!TransferNet methodsFor: 'write' stamp: 'WAL 5/26/2023 13:48:58'!
writeReceptiveAccount: aReceptiveAccount
	
	aReceptiveAccount writeTo: self! !

!TransferNet methodsFor: 'write' stamp: 'WAL 5/25/2023 20:37:23'!
writeTransferDeposit: aValue 
	
	transferNet := transferNet + aValue
	! !

!TransferNet methodsFor: 'write' stamp: 'WAL 5/25/2023 20:38:07'!
writeTransferWithdraw: aValue 
	
	transferNet := transferNet - aValue
	! !

!TransferNet methodsFor: 'write' stamp: 'WAL 5/25/2023 20:44:15'!
writeWithdraw: aValue
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'Portfolio-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'instance creation' stamp: 'WAL 5/25/2023 20:25:30'!
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

!Transfer class methodsFor: 'error descriptions' stamp: 'WAL 5/31/2023 21:21:43'!
transferDestinationCanNotBeSameAsSourceErrorDescription
	
	^'Transfer destination can not be same as source'! !

!Transfer class methodsFor: 'error descriptions' stamp: 'WAL 5/31/2023 20:28:19'!
transferValueMustBeGreaterThanCeroErrorDescription
	
	^'Transfer Value Must be greater than cero'! !


!Transfer class methodsFor: 'instance creation' stamp: 'WAL 5/31/2023 21:22:52'!
register: aValue from: sourceAccount to: destinationAccount

	| transfer deposit withdraw |

	(aValue <= 0) ifTrue: [self error: self transferValueMustBeGreaterThanCeroErrorDescription].
	
	(sourceAccount = destinationAccount) ifTrue: [self error: self transferDestinationCanNotBeSameAsSourceErrorDescription].

	transfer := self new.
	
	withdraw := TransferWithdraw transfer: transfer on: sourceAccount.
	deposit := TransferDeposit transfer: transfer on: destinationAccount.
	
	transfer initializeFor: aValue from: withdraw to: deposit.
	
	^ transfer! !

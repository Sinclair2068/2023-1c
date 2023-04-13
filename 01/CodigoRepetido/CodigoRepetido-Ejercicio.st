!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'auxiliary methods for testing' stamp: 'AS 4/12/2023 20:22:54'!
assertBookAction: aBookAction errorDescription: errorDescription bookStateAfter: aBlock

	[ aBookAction value
	self fail ]
		on: Error
		do: [ :anError |		self assert: anError messageText = errorDescription.
				self assert: aBlock value ].
		! !

!CustomerBookTest methodsFor: 'auxiliary methods for testing' stamp: 'AS 4/12/2023 20:21:23'!
assertBookAction: aBookAction onError: error bookStateAfter: aBlock

	[ aBookAction value
	self fail ]
		on: error
		do: [	aBlock value ].
		! !

!CustomerBookTest methodsFor: 'auxiliary methods for testing' stamp: 'AS 4/12/2023 18:29:56'!
assertIfBlockRunning: aBlock takesLessTimeThan: time

	self assert: (self calculateRunningBlockElapsedTime: aBlock) < time! !

!CustomerBookTest methodsFor: 'auxiliary methods for testing' stamp: 'AS 4/12/2023 20:11:38'!
assertOn: aCustomerBook activeCustomersCount: activeCustomersCount suspendedCustomersCount: suspendedCustomersCount
	| customersCount |
	
	customersCount := activeCustomersCount + suspendedCustomersCount.

	self assert: activeCustomersCount equals: aCustomerBook numberOfActiveCustomers.
	self assert: suspendedCustomersCount equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: customersCount equals: aCustomerBook numberOfCustomers.
! !

!CustomerBookTest methodsFor: 'auxiliary methods for testing' stamp: 'AS 4/12/2023 20:14:19'!
assertOn: aCustomerBook canNotSuspendCustomerName: aCustomerToSuspend onlyIncludes: aCustomerIncluded
	
	[ aCustomerBook suspendCustomerNamed: aCustomerToSuspend.
	self fail ]
		on: CantSuspend 
		do: [ 	self assertOn: aCustomerBook onlyIncludes: aCustomerIncluded ]! !

!CustomerBookTest methodsFor: 'auxiliary methods for testing' stamp: 'AS 4/12/2023 20:07:57'!
assertOn: aCustomerBook onlyIncludes: aCustomerName

	self assert: aCustomerBook numberOfCustomers = 1.
	self assert: (aCustomerBook includesCustomerNamed: aCustomerName)
	! !

!CustomerBookTest methodsFor: 'auxiliary methods for testing' stamp: 'AS 4/12/2023 13:16:23'!
calculateRunningBlockElapsedTime: aBlock

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^ millisecondsAfterRunning-millisecondsBeforeRunning! !

!CustomerBookTest methodsFor: 'auxiliary methods for testing' stamp: 'AS 4/12/2023 13:28:29'!
createBookWithCustomerNamed: aCustomerName
	
	| customerBook |
	
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aCustomerName.
	
	^customerBook.! !

!CustomerBookTest methodsFor: 'auxiliary methods for testing' stamp: 'AS 4/12/2023 20:50:05'!
createBookWithCustomerSuspendNamed: aCustomerName
	
	| customerBook |
	
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aCustomerName.
	customerBook suspendCustomerNamed: aCustomerName.
	
	^customerBook.! !


!CustomerBookTest methodsFor: 'testing' stamp: 'AS 4/12/2023 18:29:56'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
		
	self assertIfBlockRunning: [customerBook addCustomerNamed: 'John Lennon'] takesLessTimeThan: (50 * millisecond)

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AS 4/12/2023 18:29:56'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self createBookWithCustomerNamed: paulMcCartney.
	  
	self assertIfBlockRunning:  [customerBook removeCustomerNamed: paulMcCartney] takesLessTimeThan: (100 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AS 4/12/2023 20:32:22'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self assertBookAction: [ customerBook addCustomerNamed: '' ]
		errorDescription: CustomerBook customerCanNotBeEmptyErrorMessage
		bookStateAfter: [ customerBook isEmpty ]

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AS 4/12/2023 20:21:23'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assertBookAction: [ customerBook removeCustomerNamed: 'Paul McCartney']
		onError: NotFound
		bookStateAfter: [ self assertOn: customerBook onlyIncludes: johnLennon ]. ! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AS 4/12/2023 20:50:56'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self createBookWithCustomerSuspendNamed: paulMcCartney.
	
	self assertOn: customerBook activeCustomersCount: 0 suspendedCustomersCount: 1.
	self assertOn: customerBook onlyIncludes: paulMcCartney
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AS 4/12/2023 20:50:42'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self createBookWithCustomerSuspendNamed: paulMcCartney.

	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertOn:  customerBook activeCustomersCount: 0 suspendedCustomersCount: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AS 4/12/2023 20:15:14'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
	
	johnLennon := 'John Lennon'.		
	customerBook := self createBookWithCustomerNamed: johnLennon.
	
	self assertOn: customerBook canNotSuspendCustomerName: 'George Harrison' onlyIncludes: johnLennon.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AS 4/12/2023 20:50:27'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
	
	johnLennon := 'John Lennon'.		
	customerBook := self createBookWithCustomerSuspendNamed: johnLennon.

	self assertOn: customerBook canNotSuspendCustomerName: johnLennon onlyIncludes: johnLennon.
! !



!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'AS 4/12/2023 19:36:49'!
checkInvalidCustomerEntries: aCustomerName

	aCustomerName isEmpty ifTrue:
		[ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aCustomerName)		ifTrue:
		[ self signalCustomerAlreadyExists ].! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'AS 4/12/2023 19:37:30'!
addCustomerNamed: aName

	self checkInvalidCustomerEntries: aName.
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'AS 4/12/2023 19:56:29'!
removeCustomerNamed: aName 
 
	active remove: aName 
		ifAbsent: [ suspended remove: aName 
			ifAbsent: [^NotFound signal] ].
	^ aName
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'AS 4/12/2023 17:49:37'!
customerNotFoundErrorMessage

	^'Customer not found!!!!!!'! !

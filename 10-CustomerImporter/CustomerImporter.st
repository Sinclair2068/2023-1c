!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'WAL 6/26/2023 19:42:27'!
test01ImportValidData

	CustomerImporter valueFrom: self validImportData into: session..

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'WAL 6/28/2023 19:31:08'!
test02MissingFieldOnCustomerShouldRiseError

	self
		should: [ CustomerImporter valueFrom: self inputStreamWithMissingFieldOnCustomer into: session ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: CustomerImporter invalidNumberOfCustomerFieldsErrorDescription equals: anError messageText ]! !

!ImportTest methodsFor: 'tests' stamp: 'WAL 6/28/2023 19:31:03'!
test03MissingFieldOnAddressShouldRiseError

	self
		should: [ CustomerImporter valueFrom: self inputStreamWithMissingFieldOnAddress into: session ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: CustomerImporter invalidNumberOfAddressFieldsErrorDescription equals: anError messageText ]! !

!ImportTest methodsFor: 'tests' stamp: 'WAL 6/28/2023 19:30:57'!
test04ExcessFieldsOnCustomerShouldRiseError

	self
		should: [ CustomerImporter valueFrom: self inputStreamWithExcessFieldsOnCustomer into: session ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: CustomerImporter invalidNumberOfCustomerFieldsErrorDescription equals: anError messageText ]! !

!ImportTest methodsFor: 'tests' stamp: 'WAL 6/28/2023 19:30:52'!
test05ExcessFieldsOnAddressShouldRiseError

	self
		should: [ CustomerImporter valueFrom: self inputStreamWithExcessFieldsOnAddress into: session ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: CustomerImporter invalidNumberOfAddressFieldsErrorDescription equals: anError messageText ]! !

!ImportTest methodsFor: 'tests' stamp: 'WAL 6/28/2023 19:31:19'!
test06InvalidRecordTypeShouldRiseError

	self
		should: [ CustomerImporter valueFrom: self inputStreamWithInvalidRecordType into: session ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: CustomerImporter invalidRecordTypeErrorDescription equals: anError messageText ]! !

!ImportTest methodsFor: 'tests' stamp: 'WAL 6/28/2023 19:30:38'!
test07InvalidRecordTypeLengthShouldRiseError

	self
		should: [ CustomerImporter valueFrom: self inputStreamWithInvalidRecordTypeLength into: session ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: CustomerImporter invalidRecordTypeErrorDescription equals: anError messageText ]! !

!ImportTest methodsFor: 'tests' stamp: 'WAL 6/26/2023 21:57:52'!
test08AddressWithoutCustomerShouldRiseError

	self
		should: [ CustomerImporter valueFrom: self inputStreamWithAddressBeforeFirstCustomer into: session ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: CustomerImporter addressCanNotBeImportedWithoutCustomerErrorDescription equals: anError messageText ]! !

!ImportTest methodsFor: 'tests' stamp: 'WAL 6/28/2023 19:35:18'!
test09EmptyLineShouldRiseError

	self
		should: [ CustomerImporter valueFrom: self inputStreamWithEmptyLine into: session ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: CustomerImporter emptyLineErrorDescription equals: anError messageText ]! !

!ImportTest methodsFor: 'tests' stamp: 'WAL 6/28/2023 19:35:07'!
test10EmptyStreamShouldRiseError

	self
		should: [ CustomerImporter valueFrom: self inputStreamEmpty into: session ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: CustomerImporter emptyInputStreamErrorDescription equals: anError messageText ]! !

!ImportTest methodsFor: 'tests' stamp: 'WAL 6/28/2023 19:49:11'!
test11NotNumericStreetNumberShouldRiseError

	self
		should: [ CustomerImporter valueFrom: self inputStreamWithNotNumericStreetNumber into: session ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: CustomerImporter notNumericStreetNumberErrorDescription equals: anError messageText ]! !

!ImportTest methodsFor: 'tests' stamp: 'WAL 6/28/2023 19:51:58'!
test12NotNumericZipCodeShouldRiseError

	self
		should: [ CustomerImporter valueFrom: self inputStreamWithNotNumericZipCode into: session ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: CustomerImporter notNumericZipCodeErrorDescription equals: anError messageText ]! !


!ImportTest methodsFor: 'assertions' stamp: 'WAL 6/28/2023 20:13:13'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:12:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:27:50'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:28:23'!
tearDown

	session commit.
	session close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'HAW 5/22/2022 18:14:22'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !


!ImportTest methodsFor: 'test data' stamp: 'WAL 6/28/2023 19:13:52'!
inputStreamEmpty

	^ ReadStream on: ''! !

!ImportTest methodsFor: 'test data' stamp: 'WAL 6/26/2023 21:40:46'!
inputStreamWithAddressBeforeFirstCustomer

	^ ReadStream on:
'A,San Martin,3322,Olivos,1636,BsAs
C,Pepe,Sanchez,D,22333444
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'WAL 6/26/2023 21:56:25'!
inputStreamWithEmptyLine

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444

A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'WAL 6/26/2023 21:55:59'!
inputStreamWithExcessFieldsOnAddress

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs,San Martin
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'WAL 6/26/2023 21:55:26'!
inputStreamWithExcessFieldsOnCustomer

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444,Pepe
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'WAL 6/26/2023 21:16:59'!
inputStreamWithInvalidRecordType

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'WAL 6/26/2023 21:18:10'!
inputStreamWithInvalidRecordTypeLength

	^ ReadStream on:
'Customer,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'WAL 6/26/2023 20:46:40'!
inputStreamWithMissingFieldOnAddress

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'WAL 6/26/2023 20:46:23'!
inputStreamWithMissingFieldOnCustomer

	^ ReadStream on:
'C,Pepe,Sanchez,D
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'WAL 6/28/2023 19:42:21'!
inputStreamWithNotNumericStreetNumber

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,A3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'WAL 6/28/2023 19:51:33'!
inputStreamWithNotNumericZipCode

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636A,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'WAL 6/28/2023 20:10:22'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream newCustomer record line'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'HAW 5/22/2022 18:06:47'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'assertions' stamp: 'WAL 6/28/2023 20:07:44'!
assertAddressRecordIsValid

	self assertValidNumberOfAddressFields.
	self assertIsNumeric: record third ifNotErrorDescription: CustomerImporter notNumericStreetNumberErrorDescription.
	self assertIsNumeric: record fifth ifNotErrorDescription: CustomerImporter notNumericZipCodeErrorDescription! !

!CustomerImporter methodsFor: 'assertions' stamp: 'WAL 6/26/2023 21:57:52'!
assertCustomerIsInstantiated

	^ (newCustomer isNil) ifTrue: [ self error: CustomerImporter addressCanNotBeImportedWithoutCustomerErrorDescription ]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'WAL 6/28/2023 20:06:06'!
assertIsNumeric: aField ifNotErrorDescription: anErrorDescription 
	
	^ (aField allSatisfy: [ : aCharacter | aCharacter isDigit ]) ifFalse: [ self error: anErrorDescription ]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'WAL 6/28/2023 19:59:14'!
assertValidNumberOfAddressFields

	^ (record size =6) ifFalse: [ self error: CustomerImporter invalidNumberOfAddressFieldsErrorDescription ]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'WAL 6/28/2023 19:59:29'!
assertValidNumberOfCustomerFields

	^ (record size = 5) ifFalse: [ self error: CustomerImporter invalidNumberOfCustomerFieldsErrorDescription ]! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'WAL 6/28/2023 19:35:18'!
createRecord

	record := self findTokensInLine.
	
	(record isEmpty) ifTrue: [self error: CustomerImporter emptyLineErrorDescription]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'WAL 6/26/2023 21:33:00'!
findTokensInLine

	^ line findTokens: $,! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'WAL 6/28/2023 20:18:04'!
hasNextLine

	line := readStream nextLine.
	^line notNil! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'WAL 6/28/2023 20:00:47'!
importAddress

	| newAddress |
	
	self assertAddressRecordIsValid.
	
	newAddress := Address new.
	
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	newAddress zipCode: record fifth asNumber .
	newAddress province: record sixth.
	
	self assertCustomerIsInstantiated.
	
	newCustomer addAddress: newAddress.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'WAL 6/28/2023 19:59:29'!
importCustomer

	self assertValidNumberOfCustomerFields.
	
	newCustomer := Customer new.
	
	newCustomer firstName: record second.
	newCustomer lastName: record third.
	newCustomer identificationType: record fourth.
	newCustomer identificationNumber: record fifth.
	
	session persist: newCustomer.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'WAL 6/26/2023 21:37:28'!
importRecord

	self recordIsCustomer ifTrue: [ self importCustomer ] ifFalse: [
		(self recordIsAddress) ifTrue: [ self importAddress ] ifFalse: [
			self error: CustomerImporter invalidRecordTypeErrorDescription ] ]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'WAL 6/26/2023 21:37:28'!
recordIsAddress

	^ record first = 'A'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'WAL 6/26/2023 21:37:15'!
recordIsCustomer

	^ record first = 'C'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'WAL 6/28/2023 20:18:36'!
value

	[ self hasNextLine ] whileTrue: [
		self createRecord.
		self importRecord ]

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'WAL 6/26/2023 21:57:52'!
addressCanNotBeImportedWithoutCustomerErrorDescription
	
	^'Address can not be imported without customer.'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'WAL 6/28/2023 19:35:07'!
emptyInputStreamErrorDescription
	
	^'Input stream is empty.'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'WAL 6/28/2023 19:35:18'!
emptyLineErrorDescription
	
	^'Input stream has empty line.'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'WAL 6/26/2023 20:58:39'!
invalidNumberOfAddressFieldsErrorDescription
	
	^'Invalid number of address fields.'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'WAL 6/26/2023 20:57:37'!
invalidNumberOfCustomerFieldsErrorDescription
	
	^'Invalid number of customer fields.'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'WAL 6/26/2023 21:15:07'!
invalidRecordTypeErrorDescription
	
	^'Invalid record type.'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'WAL 6/28/2023 19:52:37'!
notNumericStreetNumberErrorDescription
	
	^'Street number must be numeric.'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'WAL 6/28/2023 19:52:33'!
notNumericZipCodeErrorDescription
	
	^'Zip code must be numeric.'! !


!CustomerImporter class methodsFor: 'instance creation' stamp: 'WAL 6/28/2023 19:35:07'!
from: aReadStream into: aSession

	(aReadStream size = 0) ifTrue: [ self error: self emptyInputStreamErrorDescription ].

	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'importing' stamp: 'HAW 5/22/2022 18:11:27'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) value! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !

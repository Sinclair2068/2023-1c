!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'as yet unclassified' stamp: 'AS 6/24/2023 16:35:03'!
assertAddressOfCustomerType: anIdentificationType number: anIdentificationNumber addresses: anArrayOfAddress  

	| customer index |
	
	customer := (self selectCustomerWith: anIdentificationType number: anIdentificationNumber) anyOne.
	
	index := 1.
	[index <= anArrayOfAddress size] whileTrue: [self assert: (customer addresses at: index) equals: (anArrayOfAddress at: index).
		index := index + 1 ]! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'AS 6/24/2023 20:18:29'!
assertCustomerType: anIdentificationType number: anIdentificationNumber firstName: aFirstName lastName: aLastName addresses: anArrayOfAddresses    

	self assertSelectCustomerType: anIdentificationType 	number: anIdentificationNumber 
		firstName: aFirstName lastName: aLastName.	
		
	self assertAddressOfCustomerType: anIdentificationType number: anIdentificationNumber 
		addresses:  anArrayOfAddresses! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'AS 6/24/2023 15:56:12'!
assertSelectCustomerType: identificationType number: anIdentificationNumber firstName: aFirstName lastName: aLastName   

	| queryResult customer |
	
	queryResult := self selectCustomerWith: identificationType number: anIdentificationNumber.
	self assert: 1 equals: queryResult size.
	
	customer := queryResult anyOne.
	
	self assert: aFirstName equals: customer firstName.
	self assert: aLastName equals: customer lastName.! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'AS 6/24/2023 21:03:06'!
crlf

	^String with: Character cr with: Character lf! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'AS 6/24/2023 20:21:25'!
importCustomers: aStream

	"
	self importCustomers
	"
	| inputStream  newCustomer line |

	inputStream := aStream.

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth.
			session persist: newAddress ].

		line := inputStream nextLine. ].

	inputStream close.
	! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'AS 6/24/2023 15:55:20'!
selectCustomerWith: anIdentificationType number: anIdentificationNumber 
	
	^session select: [ :customer | (customer identificationType = anIdentificationType) and: [customer identificationNumber = anIdentificationNumber] ] ofType: Customer.
! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'WAL 6/22/2023 20:46:35'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'WAL 6/22/2023 20:47:00'!
tearDown

	session commit.
	session close! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'AS 6/24/2023 21:13:26'!
test01Import

	| allCustomers stream crlf |
	
	"self importCustomers: (UniFileStream new open: 'input.txt' forWrite: false)."
	
	crlf := String with: (Character cr)			 with: (Character lf).
	stream := ReadStream on: {						'C,Pepe,Sanchez,D,22333444', crlf.
							'A,San Martin,3322,Olivos,1636,BsAs', crlf. 
							'A,Maipu,888,Florida,1122,Buenos Aires', crlf.
							'C,Juan,Perez,C,23-25666777-9',crlf. 
							'A,Alem,1122,CABA,1001,CABA',crlf
							}.
	
	self importCustomers: stream.
	
	allCustomers := session selectAllOfType: Customer.
	self assert: 2 equals: (allCustomers size).
	
	self assertCustomerType: 'D' number: '22333444' firstName: 'Pepe' lastName: 'Sanchez' addresses: {
			Address 
				withStreetName: 'San Martin'
				streetNumber: 3322
				town: 'Olivos'
				zipCode: 1636
				province: 'BsAs'.

			Address
				withStreetName: 'Maipu'
				streetNumber: 888
				town: 'Florida'
				zipCode: 1122
				province: 'Buenos Aires' }.

	self assertCustomerType: 'C' number: '23-25666777-9' firstName: 'Juan' lastName: 'Perez' addresses: {
			Address 
				withStreetName: 'Alem'
				streetNumber: 1122
				town: 'CABA'
				zipCode: 1001
				province: 'CABA'. }
! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'AS 6/24/2023 16:41:17'!
= otherAddress
	
	^(streetName = otherAddress streetName)
		and: [streetNumber = otherAddress streetNumber]
		and: [town = otherAddress town]
		and: [zipCode = otherAddress zipCode]
		and: [province = otherAddress province].! !

!Address methodsFor: 'province' stamp: 'AS 6/24/2023 16:44:25'!
hash
	
	^((((streetName hash) 
		bitXor: (streetNumber hash))
			bitXor: (town hash))
				bitXor: (zipCode hash))
					bitXor: (province hash)! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


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


!Address methodsFor: 'initialization' stamp: 'AS 6/24/2023 16:13:54'!
initializeWithStreetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode province: aProvince 

	streetName := aStreetName.
	streetNumber := aStreetNumber.
	town := aTown.
	zipCode := aZipCode.
	province := aProvince.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Address class' category: 'CustomerImporter'!
Address class
	instanceVariableNames: ''!

!Address class methodsFor: 'instance creation' stamp: 'AS 6/24/2023 16:13:26'!
withStreetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode province: aProvince 

	^self new initializeWithStreetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode province: aProvince ! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

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

!classDefinition: #AddressTest category: 'CustomerImporter'!
TestCase subclass: #AddressTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!AddressTest methodsFor: 'test' stamp: 'AS 6/25/2023 09:52:17'!
test01InitializeAssignColaboratorsValues
	
	| address |
	
	address := Address 
					withStreetName: 'San Martin'
					streetNumber: 3388
					town: 'Olivos'
					zipCode: 1636
					province: 'Buenos Aires'.	
					
	self assert: 'San Martin' equals: address streetName.
	self assert: 3388 equals: address streetNumber.
	self assert: 'Olivos' equals: address town.
	self assert: 1636 equals: address zipCode.
	self assert: 'Buenos Aires' equals: address province.! !

!AddressTest methodsFor: 'test' stamp: 'AS 6/25/2023 09:53:35'!
test02EqualsIsTrueWhenAllValuesAreEquals
	
	| address1 address2 |
	
	address1 := Address 
					withStreetName: 'San Martin'
					streetNumber: 3388
					town: 'Olivos'
					zipCode: 1636
					province: 'Buenos Aires'.	
					
	address2 := Address 
					withStreetName: 'San Martin'
					streetNumber: 3388
					town: 'Olivos'
					zipCode: 1636
					province: 'Buenos Aires'.						
					
	self assert: address1 equals: address2.
! !

!AddressTest methodsFor: 'test' stamp: 'AS 6/25/2023 09:55:21'!
test03EqualsIsFalseWhenStreetNameIsNotEqual
	
	| address1 address2 |
	
	address1 := Address 
					withStreetName: 'San Martin'
					streetNumber: 3388
					town: 'Olivos'
					zipCode: 1636
					province: 'Buenos Aires'.	
					
	address2 := Address 
					withStreetName: 'Jose de San Martin'
					streetNumber: 3388
					town: 'Olivos'
					zipCode: 1636
					province: 'Buenos Aires'.						
					
	self assert: (address1 ~= address2).
! !

!AddressTest methodsFor: 'test' stamp: 'AS 6/25/2023 09:55:52'!
test04EqualsIsFalseWhenStreetNumberIsNotEqual
	
	| address1 address2 |
	
	address1 := Address 
					withStreetName: 'San Martin'
					streetNumber: 3388
					town: 'Olivos'
					zipCode: 1636
					province: 'Buenos Aires'.	
					
	address2 := Address 
					withStreetName: 'San Martin'
					streetNumber: 33881
					town: 'Olivos'
					zipCode: 1636
					province: 'Buenos Aires'.						
					
	self assert: (address1 ~= address2).
! !

!AddressTest methodsFor: 'test' stamp: 'AS 6/25/2023 09:56:17'!
test05EqualsIsFalseWhenTownIsNotEqual
	
	| address1 address2 |
	
	address1 := Address 
					withStreetName: 'San Martin'
					streetNumber: 3388
					town: 'Olivos'
					zipCode: 1636
					province: 'Buenos Aires'.	
					
	address2 := Address 
					withStreetName: 'San Martin'
					streetNumber: 3388
					town: 'Florida'
					zipCode: 1636
					province: 'Buenos Aires'.						
					
	self assert: (address1 ~= address2).
! !

!AddressTest methodsFor: 'test' stamp: 'AS 6/25/2023 09:56:39'!
test06EqualsIsFalseWhenZipCodeIsNotEqual
	
	| address1 address2 |
	
	address1 := Address 
					withStreetName: 'San Martin'
					streetNumber: 3388
					town: 'Olivos'
					zipCode: 1636
					province: 'Buenos Aires'.	
					
	address2 := Address 
					withStreetName: 'San Martin'
					streetNumber: 3388
					town: 'Olivos'
					zipCode: 1640
					province: 'Buenos Aires'.						
					
	self assert: (address1 ~= address2).
! !

!AddressTest methodsFor: 'test' stamp: 'AS 6/25/2023 09:56:57'!
test07EqualsIsFalseWhenProvinceIsNotEqual
	
	| address1 address2 |
	
	address1 := Address 
					withStreetName: 'San Martin'
					streetNumber: 3388
					town: 'Olivos'
					zipCode: 1636
					province: 'Buenos Aires'.	
					
	address2 := Address 
					withStreetName: 'San Martin'
					streetNumber: 3388
					town: 'Olivos'
					zipCode: 1640
					province: 'BsAs'.						
					
	self assert: (address1 ~= address2).
! !

!AddressTest methodsFor: 'test' stamp: 'AS 6/25/2023 09:57:34'!
test08SameObjectMustHaveSameHash
	
	| address1 address2 |
	
	address1 := Address 
					withStreetName: 'San Martin'
					streetNumber: 3388
					town: 'Olivos'
					zipCode: 1636
					province: 'Buenos Aires'.	
					
	address2 := Address 
					withStreetName: 'San Martin'
					streetNumber: 3388
					town: 'Olivos'
					zipCode: 1636
					province: 'Buenos Aires'.						
					
	self assert: address1 hash equals: address2 hash.
! !

!AddressTest methodsFor: 'test' stamp: 'AS 6/25/2023 09:58:38'!
test09DifferentObjectShouldHaveDifferentHash
	
	| address1 address2 |
	
	address1 := Address 
					withStreetName: 'San Martin'
					streetNumber: 3388
					town: 'Olivos'
					zipCode: 1636
					province: 'Buenos Aires'.	
					
	address2 := Address 
					withStreetName: 'Jode de San Martin'
					streetNumber: 3388
					town: 'Olivos'
					zipCode: 1636
					province: 'Buenos Aires'.						
					
	self assert: (address1 hash ~= address2 hash).
! !


!classDefinition: #CustomerTest category: 'CustomerImporter'!
TestCase subclass: #CustomerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerTest methodsFor: 'test' stamp: 'AS 6/25/2023 10:42:12'!
test01InitializeAssignColaboratorsValues
	
	| customer |
	
	customer := Customer 
					withIdentificationType: 'D'
					identificationNumber: '11112222'
					firstName: 'Juan'
					lastName: 'Perez'
					addresses: #().
						
	self assert: 'D' equals: customer identificationType.
	self assert: '11112222' equals: customer identificationNumber .
	self assert: 'Juan' equals: customer firstName .
	self assert: 'Perez' equals: customer lastName.
	self assert: 0 equals: customer addressesSize.! !

!CustomerTest methodsFor: 'test' stamp: 'AS 6/25/2023 10:42:12'!
test02InitializeAddAddresses
	
	| customer |
	
	customer := Customer 
					withIdentificationType: 'D'
					identificationNumber: '11112222'
					firstName: 'Juan'
					lastName: 'Perez'
					addresses: { Address withStreetName: 'San Martin' streetNumber: 3388 town: 'Olivos' zipCode: 1636  province: 'Buenos Aires' }.
						
	self assert: 1 equals: customer addressesSize.! !

!CustomerTest methodsFor: 'test' stamp: 'AS 6/25/2023 10:42:12'!
test03CustomerAreEqualsIfTheyHaveSameValues
	
	| customer1 customer2 |
	
	customer1 := Customer 
					withIdentificationType: 'D'
					identificationNumber: '11112222'
					firstName: 'Juan'
					lastName: 'Perez'
					addresses: { Address withStreetName: 'San Martin' streetNumber: 3388 town: 'Olivos' zipCode: 1636  province: 'Buenos Aires' }.
					
	customer2 := Customer 
					withIdentificationType: 'D'
					identificationNumber: '11112222'
					firstName: 'Juan'
					lastName: 'Perez'
					addresses: { Address withStreetName: 'San Martin' streetNumber: 3388 town: 'Olivos' zipCode: 1636  province: 'Buenos Aires' }.					
						
	self assert: customer1 equals: customer2.! !

!CustomerTest methodsFor: 'test' stamp: 'AS 6/25/2023 10:42:12'!
test04CustomerAreNotEqualsIfIdentificationTypeIsDifferent
	
	| customer1 customer2 |
	
	customer1 := Customer 
					withIdentificationType: 'D'
					identificationNumber: '11112222'
					firstName: 'Juan'
					lastName: 'Perez'
					addresses: { Address withStreetName: 'San Martin' streetNumber: 3388 town: 'Olivos' zipCode: 1636  province: 'Buenos Aires' }.
					
	customer2 := Customer 
					withIdentificationType: 'C'
					identificationNumber: '11112222'
					firstName: 'Juan'
					lastName: 'Perez'
					addresses: { Address withStreetName: 'San Martin' streetNumber: 3388 town: 'Olivos' zipCode: 1636  province: 'Buenos Aires' }.					
						
	self assert: (customer1 ~= customer2).! !

!CustomerTest methodsFor: 'test' stamp: 'AS 6/25/2023 10:42:12'!
test05CustomerAreNotEqualsIfIdentificationNumberIsDifferent
	
	| customer1 customer2 |
	
	customer1 := Customer 
					withIdentificationType: 'D'
					identificationNumber: '11112222'
					firstName: 'Juan'
					lastName: 'Perez'
					addresses: { Address withStreetName: 'San Martin' streetNumber: 3388 town: 'Olivos' zipCode: 1636  province: 'Buenos Aires' }.
					
	customer2 := Customer 
					withIdentificationType: 'D'
					identificationNumber: '11112223'
					firstName: 'Juan'
					lastName: 'Perez'
					addresses: { Address withStreetName: 'San Martin' streetNumber: 3388 town: 'Olivos' zipCode: 1636  province: 'Buenos Aires' }.					
						
	self assert: (customer1 ~= customer2).! !

!CustomerTest methodsFor: 'test' stamp: 'AS 6/25/2023 10:42:12'!
test06CustomerAreNotEqualsIfFirstNameIsDifferent
	
	| customer1 customer2 |
	
	customer1 := Customer 
					withIdentificationType: 'D'
					identificationNumber: '11112222'
					firstName: 'Juan'
					lastName: 'Perez'
					addresses: { Address withStreetName: 'San Martin' streetNumber: 3388 town: 'Olivos' zipCode: 1636  province: 'Buenos Aires' }.
					
	customer2 := Customer 
					withIdentificationType: 'D'
					identificationNumber: '11112222'
					firstName: 'Juancito'
					lastName: 'Perez'
					addresses: { Address withStreetName: 'San Martin' streetNumber: 3388 town: 'Olivos' zipCode: 1636  province: 'Buenos Aires' }.					
						
	self assert: (customer1 ~= customer2).! !

!CustomerTest methodsFor: 'test' stamp: 'AS 6/25/2023 10:42:12'!
test07CustomerAreNotEqualsIfLastNameIsDifferent
	
	| customer1 customer2 |
	
	customer1 := Customer 
					withIdentificationType: 'D'
					identificationNumber: '11112222'
					firstName: 'Juan'
					lastName: 'Perez'
					addresses: { Address withStreetName: 'San Martin' streetNumber: 3388 town: 'Olivos' zipCode: 1636  province: 'Buenos Aires' }.
					
	customer2 := Customer 
					withIdentificationType: 'D'
					identificationNumber: '11112222'
					firstName: 'Juan'
					lastName: 'Peres'
					addresses: { Address withStreetName: 'San Martin' streetNumber: 3388 town: 'Olivos' zipCode: 1636  province: 'Buenos Aires' }.					
						
	self assert: (customer1 ~= customer2).! !

!CustomerTest methodsFor: 'test' stamp: 'AS 6/25/2023 10:42:12'!
test08CustomerAreNotEqualsIfAddressesSizeIsDifferent
	
	| customer1 customer2 |
	
	customer1 := Customer 
					withIdentificationType: 'D'
					identificationNumber: '11112222'
					firstName: 'Juan'
					lastName: 'Perez'
					addresses: { Address withStreetName: 'San Martin' streetNumber: 3388 town: 'Olivos' zipCode: 1636  province: 'Buenos Aires' }.
					
	customer2 := Customer 
					withIdentificationType: 'D'
					identificationNumber: '11112222'
					firstName: 'Juan'
					lastName: 'Perez'
					addresses: { Address withStreetName: 'San Martin' streetNumber: 3388 town: 'Olivos' zipCode: 1636  province: 'Buenos Aires'.
								Address withStreetName: 'Roca' streetNumber: 1234 town: 'Olivos' zipCode: 1636  province: 'Buenos Aires' }.					
						
	self assert: (customer1 ~= customer2).! !

!CustomerTest methodsFor: 'test' stamp: 'AS 6/25/2023 10:42:12'!
test09CustomerAreNotEqualsIfAddressesAreDifferent
	
	| customer1 customer2 |
	
	customer1 := Customer 
					withIdentificationType: 'D'
					identificationNumber: '11112222'
					firstName: 'Juan'
					lastName: 'Perez'
					addresses: { Address withStreetName: 'San Martin' streetNumber: 3388 town: 'Olivos' zipCode: 1636  province: 'Buenos Aires' }.
					
	customer2 := Customer 
					withIdentificationType: 'D'
					identificationNumber: '11112222'
					firstName: 'Juan'
					lastName: 'Perez'
					addresses: { Address withStreetName: 'Roca' streetNumber: 3388 town: 'Olivos' zipCode: 1636  province: 'Buenos Aires'.								}.
						
	self assert: (customer1 ~= customer2).! !

!CustomerTest methodsFor: 'test' stamp: 'AS 6/25/2023 10:42:12'!
test10IfCustomerAreEqualsTheyHaveTheSameHash
	
	| customer1 customer2 |
	
	customer1 := Customer 
					withIdentificationType: 'D'
					identificationNumber: '11112222'
					firstName: 'Juan'
					lastName: 'Perez'
					addresses: { Address withStreetName: 'San Martin' streetNumber: 3388 town: 'Olivos' zipCode: 1636  province: 'Buenos Aires' }.
					
	customer2 := Customer 
					withIdentificationType: 'D'
					identificationNumber: '11112222'
					firstName: 'Juan'
					lastName: 'Perez'
					addresses: { Address withStreetName: 'San Martin' streetNumber: 3388 town: 'Olivos' zipCode: 1636  province: 'Buenos Aires'.								}.
						
	self assert: customer1 hash equals: customer2 hash.! !

!CustomerTest methodsFor: 'test' stamp: 'AS 6/25/2023 10:42:12'!
test11IfCustomerAreNotEqualsTheyShouldHaveDifferentHash
	
	| customer1 customer2 |
	
	customer1 := Customer 
					withIdentificationType: 'D'
					identificationNumber: '11112222'
					firstName: 'Juan'
					lastName: 'Perez'
					addresses: { Address withStreetName: 'San Martin' streetNumber: 3388 town: 'Olivos' zipCode: 1636  province: 'Buenos Aires' }.
					
	customer2 := Customer 
					withIdentificationType: 'C'
					identificationNumber: '11112222'
					firstName: 'Juan'
					lastName: 'Perez'
					addresses: { Address withStreetName: 'San Martin' streetNumber: 3388 town: 'Olivos' zipCode: 1636  province: 'Buenos Aires'.								}.
						
	self assert: (customer1 hash ~= customer2 hash).! !


!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'setup' stamp: 'WAL 6/22/2023 20:46:35'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction! !

!ImportTest methodsFor: 'setup' stamp: 'WAL 6/22/2023 20:47:00'!
tearDown

	session commit.
	session close! !


!ImportTest methodsFor: 'stream' stamp: 'AS 6/25/2023 09:15:38'!
concatenatedStringFrom: anArrayOfStrings

	^ anArrayOfStrings inject: ''  into: [ :inputString :string | inputString, string, self crlf ]! !

!ImportTest methodsFor: 'stream' stamp: 'AS 6/25/2023 09:15:38'!
createStream: anArrayOfStrings

	^ ReadStream on: (self concatenatedStringFrom: anArrayOfStrings).! !

!ImportTest methodsFor: 'stream' stamp: 'AS 6/24/2023 21:03:06'!
crlf

	^String with: Character cr with: Character lf! !


!ImportTest methodsFor: 'session' stamp: 'AS 6/24/2023 15:55:20'!
selectCustomerWith: anIdentificationType number: anIdentificationNumber 
	
	^session select: [ :customer | (customer identificationType = anIdentificationType) and: [customer identificationNumber = anIdentificationNumber] ] ofType: Customer.
! !


!ImportTest methodsFor: 'test' stamp: 'AS 6/25/2023 10:42:12'!
test01Import

	| allCustomers stream importCostumers |
		
	stream := self createStream: { 'C,Pepe,Sanchez,D,22333444'.
							  'A,San Martin,3322,Olivos,1636,BsAs'.
							  'A,Maipu,888,Florida,1122,Buenos Aires'.
							  'C,Juan,Perez,C,23-25666777-9'.
							  'A,Alem,1122,CABA,1001,CABA' }.
								
	importCostumers := ImportCustomers session: session inputStream: stream.
	importCostumers import.
	
	allCustomers := session selectAllOfType: Customer.
	self assert: 2 equals: (allCustomers size).
	
	self assertSelectCustomer: (Customer withIdentificationType: 'D' identificationNumber: '22333444' firstName: 'Pepe' lastName: 'Sanchez' addresses: {
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
				province: 'Buenos Aires' }).

	self assertSelectCustomer: (Customer withIdentificationType: 'C' identificationNumber: '23-25666777-9' firstName: 'Juan' lastName: 'Perez' addresses: {
			Address 
				withStreetName: 'Alem'
				streetNumber: 1122
				town: 'CABA'
				zipCode: 1001
				province: 'CABA'. })
! !


!ImportTest methodsFor: 'assertions' stamp: 'AS 6/25/2023 10:39:08'!
assertAddressOfCustomer: aCustomer

"
	No es necesario si implementamos el = en Customer
	
	| customer index |
	
	customer := (self selectCustomerWith: aCustomer identificationType number: aCustomer identificationNumber) anyOne.
	
	index := 1.
	[index <= aCustomer addressesSize] whileTrue: [self assert: (customer addresses at: index) equals: (aCustomer addresses at: index).
		index := index + 1 ]
	"! !

!ImportTest methodsFor: 'assertions' stamp: 'AS 6/25/2023 10:38:50'!
assertCustomer: aCustomer
"
	No es necesario si implementamos el = en Customer
	
	self assertSelectCustomer: aCustomer.		
	self assertAddressOfCustomer: aCustomer
	"! !

!ImportTest methodsFor: 'assertions' stamp: 'AS 6/25/2023 10:36:00'!
assertSelectCustomer: aCustomer

	| queryResult selectedCustomer |
	
	queryResult := self selectCustomerWith: aCustomer identificationType number: aCustomer identificationNumber.
	self assert: 1 equals: queryResult size.
	
	selectedCustomer := queryResult anyOne.
	
	self assert: aCustomer equals: selectedCustomer! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'comparing' stamp: 'AS 6/24/2023 16:41:17'!
= otherAddress
	
	^(streetName = otherAddress streetName)
		and: [streetNumber = otherAddress streetNumber]
		and: [town = otherAddress town]
		and: [zipCode = otherAddress zipCode]
		and: [province = otherAddress province].! !

!Address methodsFor: 'comparing' stamp: 'AS 6/24/2023 16:44:25'!
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

!Customer methodsFor: 'addresses' stamp: 'AS 6/25/2023 09:34:47'!
addressesSize
	
	^ addresses size! !


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


!Customer methodsFor: 'initialization' stamp: 'AS 6/25/2023 09:26:45'!
initialize

	super initialize.	
	addresses ifNil: [ 	addresses := OrderedCollection new. ].! !

!Customer methodsFor: 'initialization' stamp: 'AS 6/25/2023 10:42:31'!
initializeWithIdentificationType: anIdentificationType identificationNumber: anIdentificationNumber firstName: aFirstName lastName: aLastName addresses: anArrayOfAddresses 

	identificationType := anIdentificationType.
	identificationNumber := anIdentificationNumber.
	firstName := aFirstName.
	lastName := aLastName.
	addresses := OrderedCollection withAll: anArrayOfAddresses.! !


!Customer methodsFor: 'comparing' stamp: 'AS 6/25/2023 10:41:36'!
= otherCustomer
	
	^(identificationType = otherCustomer identificationType)
	and: [ identificationNumber = otherCustomer identificationNumber ]
	and: [ firstName = otherCustomer firstName ]
	and: [ lastName = otherCustomer lastName ]
	and: [ addresses =  otherCustomer addresses ]
! !

!Customer methodsFor: 'comparing' stamp: 'AS 6/25/2023 10:32:16'!
hash
	
	^((((identificationType hash)
		bitXor: 	(identificationNumber hash))
			bitXor: (firstName hash))
				bitXor: (lastName hash))
					bitXor: (addresses hash).
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: 'CustomerImporter'!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'instance creation' stamp: 'AS 6/25/2023 10:42:31'!
withIdentificationType: anIdentificationType identificationNumber: anIdentificationNumber firstName: aFirstName lastName: aLastName addresses: anArrayOfAddresses 

	^self new initializeWithIdentificationType: anIdentificationType identificationNumber: anIdentificationNumber firstName: aFirstName lastName: aLastName addresses: anArrayOfAddresses ! !


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


!classDefinition: #ImportCustomers category: 'CustomerImporter'!
Object subclass: #ImportCustomers
	instanceVariableNames: 'session stream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportCustomers methodsFor: 'initialization' stamp: 'AS 6/25/2023 08:41:51'!
initializeSession: aSession inputStream: anInputStream

	session := aSession.
	stream := anInputStream.! !


!ImportCustomers methodsFor: 'evaluating' stamp: 'AS 6/25/2023 08:42:09'!
import

	| inputStream  newCustomer line |

	inputStream := stream.

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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ImportCustomers class' category: 'CustomerImporter'!
ImportCustomers class
	instanceVariableNames: ''!

!ImportCustomers class methodsFor: 'instance creation' stamp: 'AS 6/25/2023 08:41:37'!
session: aSession inputStream: anInputStream

	^self new initializeSession: aSession inputStream: anInputStream! !

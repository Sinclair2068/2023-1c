!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:19:28'!
addEntero: unEntero
	
	self subclassResponsibility.! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:19:01'!
addFraccion: unaFraccion 
	
	self subclassResponsibility.! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:27:32'!
divideAFraccion: unaFraccion
	
	self subclassResponsibility! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:27:40'!
divideAnEntero: unaFraccion
	
	self subclassResponsibility! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:28:05'!
multiplyWithEntero: unNumero

	self subclassResponsibility! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:28:14'!
multiplyWithFraccion: unaFraccion 
	
	self subclassResponsibility.! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:28:25'!
substractToEntero: unEntero
	
	self subclassResponsibility.! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:28:33'!
substractToFraccion: unaFraccion
	
	self subclassResponsibility.! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:24:34'!
* aMultiplier 
	
	^aMultiplier multiplyWithEntero: self.
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:19:21'!
+ anAdder 
	
	^anAdder addEntero: self.
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:25:26'!
- aSubtrahend

	^ aSubtrahend substractToEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:21:09'!
/ aDivisor 

	^aDivisor divideAnEntero: self.
	
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'WAL 4/17/2023 21:32:24'!
// aDivisor 
	
	^self class with: self integerValue // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:26:11'!
addEntero: unEntero 
	
	^self class with: self integerValue + unEntero integerValue.
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:25:56'!
addFraccion: unaFraccion
	
	^unaFraccion addEntero: self.
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:23:05'!
divideANumerator: aNumerator
	
	^Fraccion new initializeWith: aNumerator over: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:21:14'!
divideAnEntero: unEntero

	 self subclassResponsibility ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:07:51'!
fibonacci

	self subclassResponsibility 
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'WAL 4/17/2023 21:32:44'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (self integerValue gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:24:43'!
multiplyWithEntero: unEntero
	
	^self class with: self integerValue * unEntero integerValue
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:24:34'!
multiplyWithFraccion: unaFraccion 
	
	^unaFraccion multiplyWithEntero: self.
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:25:35'!
substractToEntero: unEntero

	^ self class with: unEntero integerValue - self integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:25:11'!
substractToFraccion: unaFraccion

	^ Fraccion
			with: unaFraccion numerator - (self * unaFraccion denominator)
			over: unaFraccion denominator! !


!Entero methodsFor: 'comparing' stamp: 'AS 4/18/2023 22:30:32'!
= anObject

	^(anObject isKindOf: self class) and: [ self integerValue = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'AS 4/19/2023 19:10:01'!
hash

	^ self integerValue hash! !


!Entero methodsFor: 'initialization' stamp: 'AS 4/19/2023 19:20:30'!
divideAFraccion: unaFraccion
	
	^Fraccion with: unaFraccion numerator over: unaFraccion denominator * self! !

!Entero methodsFor: 'initialization' stamp: 'AS 4/19/2023 19:10:45'!
initializeWith: aValue 
	
	self subclassResponsibility ! !


!Entero methodsFor: 'value' stamp: 'AS 4/19/2023 19:11:03'!
integerValue

	self subclassResponsibility ! !


!Entero methodsFor: 'printing' stamp: 'WAL 4/18/2023 18:01:59'!
printOn: aStream

	aStream print: self integerValue ! !


!Entero methodsFor: 'testing' stamp: 'AS 4/19/2023 19:11:15'!
isNegative
	
	self subclassResponsibility ! !

!Entero methodsFor: 'testing' stamp: 'AS 4/19/2023 19:11:21'!
isOne
	
	self subclassResponsibility ! !

!Entero methodsFor: 'testing' stamp: 'AS 4/19/2023 19:11:26'!
isZero
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'error descriptions' stamp: 'AS 4/19/2023 19:12:20'!
negativeFibonacciErrorDescription

	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !


!Entero class methodsFor: 'instance creation' stamp: 'AS 4/19/2023 19:11:55'!
isConstructedWith: aValue 
	
	self subclassResponsibility 
! !

!Entero class methodsFor: 'instance creation' stamp: 'AS 4/19/2023 19:13:00'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^(Entero subclasses detect: [:enteroSubclass | enteroSubclass isConstructedWith: aValue]) initializeWith: aValue

! !


!classDefinition: #Cero category: 'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'testing' stamp: 'WAL 4/17/2023 21:55:04'!
isNegative
	
	^false! !

!Cero methodsFor: 'testing' stamp: 'WAL 4/17/2023 21:54:15'!
isOne
	
	^false! !

!Cero methodsFor: 'testing' stamp: 'WAL 4/17/2023 21:27:35'!
isZero
	
	^true! !


!Cero methodsFor: 'value' stamp: 'WAL 4/17/2023 21:17:24'!
integerValue

	^0! !


!Cero methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:28:47'!
divideAnEntero: unEntero

	self error: Numero canNotDivideByZeroErrorDescription! !

!Cero methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:07:13'!
fibonacci
	
	^ Uno new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cero class' category: 'Numero-Exercise'!
Cero class
	instanceVariableNames: ''!

!Cero class methodsFor: 'instance creation' stamp: 'AS 4/19/2023 13:42:01'!
initializeWith: aValue
	
	^Cero new! !

!Cero class methodsFor: 'instance creation' stamp: 'AS 4/19/2023 18:55:34'!
isConstructedWith: aValue
	
	^ aValue = 0! !


!classDefinition: #EnteroSalvoCeroNiUno category: 'Numero-Exercise'!
Entero subclass: #EnteroSalvoCeroNiUno
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroSalvoCeroNiUno methodsFor: 'initialization' stamp: 'WAL 4/18/2023 20:16:39'!
initializeWith: aValue 
	
	value := aValue! !


!EnteroSalvoCeroNiUno methodsFor: 'testing' stamp: 'WAL 4/18/2023 19:09:14'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !

!EnteroSalvoCeroNiUno methodsFor: 'testing' stamp: 'AS 4/19/2023 19:13:54'!
isNegative
	
	self subclassResponsibility ! !

!EnteroSalvoCeroNiUno methodsFor: 'testing' stamp: 'WAL 4/17/2023 21:54:27'!
isOne
	
	^false! !

!EnteroSalvoCeroNiUno methodsFor: 'testing' stamp: 'WAL 4/17/2023 21:27:42'!
isZero
	
	^false! !


!EnteroSalvoCeroNiUno methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:28:58'!
divideAnEntero: unEntero
	
	self subclassResponsibility ! !

!EnteroSalvoCeroNiUno methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:06:52'!
fibonacci
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroSalvoCeroNiUno class' category: 'Numero-Exercise'!
EnteroSalvoCeroNiUno class
	instanceVariableNames: ''!

!EnteroSalvoCeroNiUno class methodsFor: 'instance creation' stamp: 'AS 4/19/2023 18:55:34'!
initializeWith: aValue
	
	"Estamos asumiendo que ninguna subclase tiene subclases y por eso usamos el new.
	 Podríamos ser mas genéricos si quitamos el new y cada subclase se crea en initializeWith,
	 pero en este caso ambas subclases tendrian el mismo código."
	
	^(self subclasses detect: [:subclass | subclass isConstructedWith: aValue]) new initializeWith: aValue
! !

!EnteroSalvoCeroNiUno class methodsFor: 'instance creation' stamp: 'AS 4/19/2023 18:55:34'!
isConstructedWith: aValue

	^ self subclasses anySatisfy: [:subclass | subclass isConstructedWith: aValue]! !


!classDefinition: #EnteroNegativoSalvoCeroNiUno category: 'Numero-Exercise'!
EnteroSalvoCeroNiUno subclass: #EnteroNegativoSalvoCeroNiUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroNegativoSalvoCeroNiUno methodsFor: 'testing' stamp: 'WAL 4/17/2023 21:56:00'!
isNegative
	
	^true! !


!EnteroNegativoSalvoCeroNiUno methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:29:29'!
divideAnEntero: unEntero

	^unEntero negated / self negated! !

!EnteroNegativoSalvoCeroNiUno methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:06:33'!
fibonacci
	
	self error: Entero negativeFibonacciErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroNegativoSalvoCeroNiUno class' category: 'Numero-Exercise'!
EnteroNegativoSalvoCeroNiUno class
	instanceVariableNames: ''!

!EnteroNegativoSalvoCeroNiUno class methodsFor: 'instance creation' stamp: 'AS 4/19/2023 18:55:34'!
isConstructedWith: aValue
	
	^ aValue < 0! !


!classDefinition: #EnteroPositivoSalvoCeroNiUno category: 'Numero-Exercise'!
EnteroSalvoCeroNiUno subclass: #EnteroPositivoSalvoCeroNiUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroPositivoSalvoCeroNiUno methodsFor: 'testing' stamp: 'WAL 4/17/2023 21:56:33'!
isNegative
	
	^false! !


!EnteroPositivoSalvoCeroNiUno methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:57:36'!
divideAnEntero: unEntero

	| greatestCommonDivisor numerator denominator |
	
	greatestCommonDivisor := unEntero greatestCommonDivisorWith: self. 
	numerator := unEntero // greatestCommonDivisor.
	denominator := self // greatestCommonDivisor.

	^denominator divideANumerator: numerator
	
	"Si el denominador es 1, debe devolver un Entero, en caso contrario debe devolver una fracción
	Para quitar el if, hicimos un nuevo mensaje (divideANumerator) que diferencie entre el 1 y los demás enteros."
	
"	(denominator isOne)	 ifTrue: [^numerator].
	^Fraccion new initializeWith: numerator over: denominator"

	
	
! !

!EnteroPositivoSalvoCeroNiUno methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:05:40'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroPositivoSalvoCeroNiUno class' category: 'Numero-Exercise'!
EnteroPositivoSalvoCeroNiUno class
	instanceVariableNames: ''!

!EnteroPositivoSalvoCeroNiUno class methodsFor: 'as yet unclassified' stamp: 'AS 4/19/2023 18:55:34'!
isConstructedWith: aValue
	
	^ aValue > 1! !


!classDefinition: #Uno category: 'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'value' stamp: 'WAL 4/17/2023 21:17:32'!
integerValue

	^1! !


!Uno methodsFor: 'testing' stamp: 'WAL 4/17/2023 21:56:43'!
isNegative
	
	^false! !

!Uno methodsFor: 'testing' stamp: 'WAL 4/17/2023 21:54:34'!
isOne
	
	^true! !

!Uno methodsFor: 'testing' stamp: 'WAL 4/17/2023 21:27:48'!
isZero
	
	^false! !


!Uno methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:23:05'!
divideANumerator: aNumerator
	
	^aNumerator! !

!Uno methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:30:16'!
divideAnEntero: unEntero

	^ unEntero! !

!Uno methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:07:32'!
fibonacci
	
	^ Uno new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Uno class' category: 'Numero-Exercise'!
Uno class
	instanceVariableNames: ''!

!Uno class methodsFor: 'instance creation' stamp: 'AS 4/19/2023 13:42:33'!
initializeWith: aValue
	
	^ Uno new! !

!Uno class methodsFor: 'instance creation' stamp: 'AS 4/19/2023 18:55:34'!
isConstructedWith: aValue
	
	^ aValue = 1! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:24:05'!
* aMultiplier 
	
	^aMultiplier multiplyWithFraccion: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:18:20'!
+ anAdder 
	
	^anAdder addFraccion: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:24:59'!
- aSubtrahend 

	^ aSubtrahend substractToFraccion: self.
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:19:58'!
/ aDivisor 

	^aDivisor divideAFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:30:43'!
addEntero: unEntero 
	
	| nuevoNumerador |
	
	nuevoNumerador := (unEntero * self denominator) + self numerator .
	
	^self class with: nuevoNumerador over: self denominator.
	
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:31:00'!
addFraccion: unaFraccion 

	| newNumerator newDenominator |
	
	newNumerator := (numerator * unaFraccion denominator) + (denominator * unaFraccion numerator).
	newDenominator := denominator * unaFraccion denominator.
	
	^newNumerator / newDenominator ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:31:19'!
divideAFraccion: unaFraccion
	
	^Fraccion with: unaFraccion numerator * self denominator over: unaFraccion denominator * self numerator

! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:31:32'!
divideAnEntero: unEntero
	
	^Fraccion with: unEntero * self denominator over: self numerator

! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:32:32'!
divideByEntero: unEntero
	
	^numerator / (denominator * unEntero integerValue)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:32:09'!
divideByFraccion: unaFraccion
	
	^(numerator * unaFraccion denominator) / (denominator * unaFraccion numerator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:32:43'!
multiplyWithEntero: unEntero
	
	^self class with: self numerator * unEntero over: self denominator 
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:33:25'!
multiplyWithFraccion: unaFraccion
	
	^(self numerator * unaFraccion numerator) / (self denominator * unaFraccion denominator)
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:33:51'!
substractToEntero: unEntero

	^ self class
			with: unEntero * self denominator - self numerator
			over: self denominator
	
	
	

! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AS 4/19/2023 19:34:06'!
substractToFraccion: unaFraccion

	^ self class
			with: unaFraccion numerator * self denominator - (self numerator * unaFraccion denominator)
			over: unaFraccion denominator * self denominator
	
	
	

! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'AS 4/19/2023 19:21:09'!
with: aDividend over: aDivisor

	^ aDivisor divideAnEntero: aDividend
! !

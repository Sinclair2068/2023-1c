!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'WAL 4/22/2023 16:02:06'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	
	
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'WAL 4/22/2023 16:00:01'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	
	
	
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'WAL 4/22/2023 16:46:01'!
test01CanNotUsePrefixWithSpaceCharacters

	| stack sentenceFinder |
	
	stack := OOStack new.
	
	sentenceFinder := SentenceFinderByPrefix new.
	
	self
		should: [ sentenceFinder  selectFromStack: stack sentencesPrefixedWith: 'prefix with spaces' ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixWithSpaceCharacterErrorDescription.
			self assert: stack isEmpty ]
		
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'WAL 4/22/2023 16:46:05'!
test02CanNotUseEmptyPrefix

	| stack sentenceFinder |
	
	stack := OOStack new.
	
	sentenceFinder := SentenceFinderByPrefix new.
	
	self
		should: [ sentenceFinder  selectFromStack: stack sentencesPrefixedWith: '' ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixEmptyErrorDescription.
			self assert: stack isEmpty ]
		
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'WAL 4/22/2023 18:45:42'!
test03EmptyStackShouldReturnEmptyCollection

	self
		testFinderWithPrefix: 'Fire'
		onStackWith: #()
		shouldReturn: (OrderedCollection newFrom: #() )! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'WAL 4/22/2023 18:45:34'!
test04IfNotFoundReturnedCollectionShouldBeEmpty
	
	self
		testFinderWithPrefix: 'Fire'
		onStackWith: #('Iceberg' 'Ice breaker' 'Stormy winter')
		shouldReturn: ( OrderedCollection newFrom: #() )! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'WAL 4/22/2023 18:45:31'!
test05IfOneFoundReturnOneFound

	self
		testFinderWithPrefix: 'Storm'
		onStackWith: #('Iceberg' 'Ice breaker' 'Stormy winter')
		shouldReturn: ( OrderedCollection newFrom: #('Stormy winter') )! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'WAL 4/22/2023 18:45:29'!
test06IfMoreThanOneFoundReturnAllFound

	self
		testFinderWithPrefix: 'Ice'
		onStackWith: #('Iceberg' 'Ice breaker' 'Stormy winter')
		shouldReturn: ( OrderedCollection newFrom: #('Iceberg' 'Ice breaker') )! !


!SentenceFinderByPrefixTest methodsFor: 'test auxiliary' stamp: 'WAL 4/22/2023 18:20:06'!
addToCollection: returnedCollection fromOOStack: anOOStack

	| value |

	(anOOStack isEmpty) ifFalse: [
		value := anOOStack pop.
		
		self addToCollection: returnedCollection fromOOStack: anOOStack.
		
		returnedCollection add: value.
		
		anOOStack push: value.
		
	]! !

!SentenceFinderByPrefixTest methodsFor: 'test auxiliary' stamp: 'WAL 4/22/2023 18:16:53'!
convertStackToOrderedCollection: anOOStack

	| returnedCollection |
	
	returnedCollection := OrderedCollection new.
	
	self  addToCollection: returnedCollection
		fromOOStack: anOOStack .

	^returnedCollection! !

!SentenceFinderByPrefixTest methodsFor: 'test auxiliary' stamp: 'WAL 4/22/2023 18:27:38'!
createStackFromArrayOfSentences: anArrayOfSentencesToStack
	
	| stack |
	
	stack := OOStack new.
	anArrayOfSentencesToStack do: [:aSentence | stack push: aSentence].
	
	^stack
	! !

!SentenceFinderByPrefixTest methodsFor: 'test auxiliary' stamp: 'WAL 4/22/2023 18:50:45'!
testFinderWithPrefix: aPrefix onStackWith: anArrayOfSentencesToStack shouldReturn:  anExpectedResult

	| stack originalSentences finder finderResult |
	
	stack:= self createStackFromArrayOfSentences: anArrayOfSentencesToStack.
	
	originalSentences := self convertStackToOrderedCollection: stack.
	
	finder := SentenceFinderByPrefix new.
	finderResult := finder selectFromStack: stack sentencesPrefixedWith: aPrefix.
		
	self assert: finderResult equals: anExpectedResult.
	self assert: originalSentences equals: (self convertStackToOrderedCollection: stack).
	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topElement size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialize' stamp: 'WAL 4/22/2023 11:52:03'!
initialize

	topElement := OOStackEmptyElement new.
	
	size := 0! !


!OOStack methodsFor: 'stack operations' stamp: 'WAL 4/22/2023 11:51:23'!
isEmpty

	^size = 0

	"Evitamos ^topElement isEmpty, es decir, evitamos implementar isEmpty en los elementos"! !

!OOStack methodsFor: 'stack operations' stamp: 'WAL 4/22/2023 11:45:18'!
pop

	| returnTop |

	returnTop := topElement value .
	topElement := topElement previous .
	
	size := size -1.
	
	^returnTop! !

!OOStack methodsFor: 'stack operations' stamp: 'WAL 4/22/2023 11:54:40'!
push: aValueToStack

	topElement := OOStackNonEmptyElement withValue: aValueToStack stackOn: topElement.
	
	size := size +1
 	! !

!OOStack methodsFor: 'stack operations' stamp: 'WAL 4/22/2023 11:44:38'!
size

	^size! !

!OOStack methodsFor: 'stack operations' stamp: 'WAL 4/22/2023 11:46:07'!
top

	^topElement value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackElement category: 'Stack-Exercise'!
Object subclass: #OOStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'element operations' stamp: 'WAL 4/22/2023 12:07:59'!
previous

	self subclassResponsibility ! !

!OOStackElement methodsFor: 'element operations' stamp: 'WAL 4/22/2023 12:05:53'!
value

	self subclassResponsibility ! !


!classDefinition: #OOStackEmptyElement category: 'Stack-Exercise'!
OOStackElement subclass: #OOStackEmptyElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackEmptyElement methodsFor: 'element operations' stamp: 'WAL 4/22/2023 12:07:21'!
previous

	self error: OOStack stackEmptyErrorDescription! !

!OOStackEmptyElement methodsFor: 'element operations' stamp: 'WAL 4/22/2023 12:05:28'!
value

	self error: OOStack stackEmptyErrorDescription! !


!classDefinition: #OOStackNonEmptyElement category: 'Stack-Exercise'!
OOStackElement subclass: #OOStackNonEmptyElement
	instanceVariableNames: 'value previous'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNonEmptyElement methodsFor: 'element operations' stamp: 'WAL 4/22/2023 12:00:06'!
previous

	^previous ! !

!OOStackNonEmptyElement methodsFor: 'element operations' stamp: 'WAL 4/22/2023 12:03:01'!
value

	^value ! !


!OOStackNonEmptyElement methodsFor: 'initialization' stamp: 'WAL 4/22/2023 11:36:47'!
initializeWith: aValue stackOn: anOOStackElement

	value := aValue.
	previous := anOOStackElement.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackNonEmptyElement class' category: 'Stack-Exercise'!
OOStackNonEmptyElement class
	instanceVariableNames: ''!

!OOStackNonEmptyElement class methodsFor: 'instance creation' stamp: 'WAL 4/22/2023 11:58:39'!
withValue: aValue stackOn: anOOStackElement

	^self new initializeWith: aValue stackOn: anOOStackElement
	! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'select' stamp: 'WAL 4/22/2023 18:59:46'!
selectFromStack: anOOStack sentencesPrefixedWith: aPrefix

	| returnedCollection |

	self validateNotEmptyPrefix: aPrefix.
	self validateNoBlankSpaces: aPrefix.
	
	returnedCollection := OrderedCollection new.
	
	self  addTo: returnedCollection
		sentencesPrefixedWith: aPrefix 
		fromOOStack: anOOStack .

	^returnedCollection! !


!SentenceFinderByPrefix methodsFor: 'validations' stamp: 'WAL 4/22/2023 18:59:34'!
validateNoBlankSpaces: aPrefix

	( aPrefix includes: Character space ) ifTrue: [ self error: SentenceFinderByPrefix prefixWithSpaceCharacterErrorDescription ].
	
	! !

!SentenceFinderByPrefix methodsFor: 'validations' stamp: 'WAL 4/22/2023 18:59:46'!
validateNotEmptyPrefix: aString

	aString isEmpty ifTrue: [ self error: SentenceFinderByPrefix prefixEmptyErrorDescription ]! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'WAL 4/22/2023 17:52:31'!
addTo: collectionToReturn sentencesPrefixedWith: aPrefix fromOOStack: anOOStack


	
	(anOOStack isEmpty) ifFalse: [
		
		| sentence |
		
		sentence := anOOStack pop.
		
		self addTo: collectionToReturn
		       sentencesPrefixedWith: aPrefix
		       fromOOStack: anOOStack.
		
		self ifSentence: sentence
		       beginsWith: aPrefix
		       thenAddTo: collectionToReturn.
	
		anOOStack push: sentence
	]! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'WAL 4/22/2023 15:46:47'!
ifSentence: aSentence beginsWith: aPrefix thenAddTo: collection

	( aSentence beginsWith: aPrefix ) ifTrue: [
		collection add: aSentence
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'WAL 4/22/2023 16:24:25'!
prefixEmptyErrorDescription
	
	^'Prefix can not be empty'! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'WAL 4/22/2023 16:25:40'!
prefixWithSpaceCharacterErrorDescription
	
	^'Prefix can not contain space characters.'! !

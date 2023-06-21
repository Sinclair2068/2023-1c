!classDefinition: #ThreadProcessor category: 'TusLibros-ThreadProcessor'!
Object subclass: #ThreadProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-ThreadProcessor'!

!ThreadProcessor methodsFor: 'operations' stamp: 'WAL 6/17/2023 14:53:00'!
processThreads: aCollectionOfBlocks

	| semaphores |
		
	semaphores := OrderedCollection new.
	
	aCollectionOfBlocks do: [ :aBlock | 
			| semaphore |
			semaphore := Semaphore new.
			semaphores add: semaphore. 			
			
			[ aBlock value. 
			semaphore signal. ] fork ].
	
	semaphores do: [ :semaphore | semaphore wait ].! !

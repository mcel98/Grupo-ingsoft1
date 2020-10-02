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

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:48'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
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

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
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

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
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


!classDefinition: #LinkedNode category: 'Stack-Exercise'!
Object subclass: #LinkedNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!LinkedNode methodsFor: 'as yet unclassified' stamp: 'fr 10/2/2020 04:02:36'!
chainLengthFromHere
	self subclassResponsibility ! !

!LinkedNode methodsFor: 'as yet unclassified' stamp: 'fr 10/2/2020 04:07:46'!
contentIfAbsent: aBlock
	self subclassResponsibility ! !

!LinkedNode methodsFor: 'as yet unclassified' stamp: 'fr 10/2/2020 03:36:48'!
isVoid
	self subclassResponsibility ! !

!LinkedNode methodsFor: 'as yet unclassified' stamp: 'fr 10/2/2020 03:54:30'!
nextIfAbsent: aBlock
	self subclassResponsibility ! !


!classDefinition: #FullLinkedNode category: 'Stack-Exercise'!
LinkedNode subclass: #FullLinkedNode
	instanceVariableNames: 'content next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!FullLinkedNode methodsFor: 'operations' stamp: 'fr 10/2/2020 04:03:01'!
chainLengthFromHere
	^1+next chainLengthFromHere! !

!FullLinkedNode methodsFor: 'operations' stamp: 'fr 10/2/2020 04:04:03'!
contentIfAbsent: aBlock
	^content! !

!FullLinkedNode methodsFor: 'operations' stamp: 'fr 10/2/2020 03:36:57'!
isVoid
	^false! !

!FullLinkedNode methodsFor: 'operations' stamp: 'fr 10/2/2020 03:54:45'!
nextIfAbsent: aBlock
	^next! !


!FullLinkedNode methodsFor: 'initialize' stamp: 'fr 10/2/2020 03:45:27'!
initializeWithContent: someContent andNext: aLinkedNode
	content _ someContent.
	next _ aLinkedNode ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FullLinkedNode class' category: 'Stack-Exercise'!
FullLinkedNode class
	instanceVariableNames: ''!

!FullLinkedNode class methodsFor: 'instance creation' stamp: 'fr 10/2/2020 03:47:58'!
withContent: someContent andNext: aLinkedNode
	^self new initializeWithContent: someContent andNext: aLinkedNode! !


!classDefinition: #VoidLinkedNode category: 'Stack-Exercise'!
LinkedNode subclass: #VoidLinkedNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!VoidLinkedNode methodsFor: 'operations' stamp: 'fr 10/2/2020 04:03:14'!
chainLengthFromHere
	^0! !

!VoidLinkedNode methodsFor: 'operations' stamp: 'fr 10/2/2020 04:04:12'!
contentIfAbsent: aBlock
	^aBlock value! !

!VoidLinkedNode methodsFor: 'operations' stamp: 'fr 10/2/2020 03:37:06'!
isVoid
	^true! !

!VoidLinkedNode methodsFor: 'operations' stamp: 'fr 10/2/2020 03:55:00'!
nextIfAbsent: aBlock
	^aBlock value! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'top'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'operations' stamp: 'fr 10/2/2020 03:53:17'!
pop
	| topValue |
	topValue _ self top.
	top _ top nextIfAbsent: [self error: OOStack stackEmptyErrorDescription]. "ACÁ NO ROMPO ENCAPSULAMIENTO?"
	^topValue	! !

!OOStack methodsFor: 'operations' stamp: 'fr 10/2/2020 03:47:04'!
push: someContent
	top _ FullLinkedNode withContent: someContent andNext: top! !


!OOStack methodsFor: 'initialization' stamp: 'fr 10/2/2020 03:37:54'!
initialize
	top _ VoidLinkedNode new! !


!OOStack methodsFor: 'properties' stamp: 'fr 10/2/2020 03:30:04'!
isEmpty
	^top isVoid! !

!OOStack methodsFor: 'properties' stamp: 'fr 10/2/2020 04:02:22'!
size
	^top chainLengthFromHere! !

!OOStack methodsFor: 'properties' stamp: 'fr 10/2/2020 04:04:28'!
top
	^top contentIfAbsent: [self error: OOStack stackEmptyErrorDescription]. "NUEVAMENTE ENCAPSULAMIENTO. LINKED NODE TERMINA SIENDO ANÉMICA"! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 10/1/2020 18:08:13'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stackSentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'fr 10/2/2020 04:49:57'!
initializeWithStack: aStack
	stackSentences _ OrderedCollection new.
	[aStack isEmpty] whileFalse: [stackSentences add: aStack pop]  ! !


!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'fr 10/2/2020 04:52:05'!
find: aPrefix
	"Asegurarse que sea prefijo válido"
	
	^stackSentences select: [:sentece | sentece beginsWith: aPrefix]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'fr 10/2/2020 04:39:41'!
withStack: aStack
	^self new initializeWithStack: aStack copy! !

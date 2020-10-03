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
	instanceVariableNames: 'stack emptyStack noMatchStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'fr 10/2/2020 05:39:53'!
test01LookingForAPrefixInAnEmptyStackShouldReturnAnEmptyCollection
	
	| sentenceFinder  |
	
	sentenceFinder _ SentenceFinderByPrefix withStack: emptyStack. 
	
	self assert: (sentenceFinder find: 'Wint') size = 0
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'fr 10/2/2020 05:40:52'!
test02LookingForAPrefixInAStackWithNoMatchesShouldReturnAnEmptyCollection
	
	|  sentenceFinder |
	
	sentenceFinder _ SentenceFinderByPrefix withStack: noMatchStack . 
	
	self assert: (sentenceFinder find: 'Wint') size = 0
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'fr 10/2/2020 06:03:19'!
test03LookingForAnEmptyPrefixShouldEndWithAnError

	self assertFinding: '' producesAnErrorWIthMessage: SentenceFinderByPrefix voidPrefixError.
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'fr 10/2/2020 05:54:45'!
test04LookingForAPrefixWithABlankSpaceShouldEndWithAnError
		
	self assertFinding: 'prefix with blank spaces' producesAnErrorWIthMessage: SentenceFinderByPrefix blankSpaceInPrefix
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'fr 10/2/2020 06:04:08'!
test05LookingForAPrefixWithoutMatchesShouldNotModifyTheStackLength
	
	self assertSizeDoesNotChangeWhenFinding: 'Wint'

	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'fr 10/2/2020 06:04:17'!
test06LookingForAPrefixWithMatchesShouldNotModifyTheStackLength
		
	self assertSizeDoesNotChangeWhenFinding: 'soy'
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'fr 10/2/2020 21:41:26'!
test09FindIsCaseSensitive
		
	| sentenceFinder |
	
	sentenceFinder _ SentenceFinderByPrefix withStack: stack.
	
	self assert: ((sentenceFinder find: 'soy') size = 1 and: (sentenceFinder find: 'Soy') size = 0)! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'fr 10/2/2020 05:45:33'!
setUp

	emptyStack _ OOStack new.
	
	noMatchStack _ OOStack new.
	noMatchStack push: 'hola'.
	noMatchStack push: 'no'.
	noMatchStack push: 'tengo'.
	noMatchStack push: 'matches'.
	
	stack _ OOStack new.
	stack push: 'soy'.
	stack push: 'un'.
	stack push: 'stack'.

! !


!SentenceFinderByPrefixTest methodsFor: 'private' stamp: 'fr 10/2/2020 06:02:26'!
assertFinding: aPrefix producesAnErrorWIthMessage: anErrorMessage
	
	| sentenceFinder |

	sentenceFinder _ SentenceFinderByPrefix withStack: stack. 
	
	self 
		should: [sentenceFinder find: aPrefix]
		raise: Error 
		withExceptionDo: [:anError |
			self assert: anError messageText = anErrorMessage].
! !

!SentenceFinderByPrefixTest methodsFor: 'private' stamp: 'fr 10/2/2020 05:49:55'!
assertSizeDoesNotChangeWhenFinding: aPrefix
	
	| sentenceFinder previousLength |
	
	previousLength _ stack size.

	sentenceFinder _ SentenceFinderByPrefix withStack: stack . 
	sentenceFinder find: aPrefix.
	
	self assert: previousLength = stack size.
	
	"¿Implementar = en OOStack para comparar aunque no sea requerido?"! !


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

!OOStack methodsFor: 'operations' stamp: 'fr 10/2/2020 06:23:31'!
pop
	| topValue |
	topValue _ self top.
	top _ self moveTop. "ACÁ NO ROMPO ENCAPSULAMIENTO?"
	^topValue	! !

!OOStack methodsFor: 'operations' stamp: 'fr 10/2/2020 03:47:04'!
push: someContent
	top _ FullLinkedNode withContent: someContent andNext: top! !


!OOStack methodsFor: 'initialization' stamp: 'fr 10/2/2020 03:37:54'!
initialize
	top _ VoidLinkedNode new! !


!OOStack methodsFor: 'private' stamp: 'fr 10/2/2020 21:36:23'!
= anotherStack
	| equal selfCopy anotherStackCopy |
	
	equal _ true.	
	selfCopy _ self copy.
	anotherStackCopy _ anotherStack copy.
	[selfCopy isEmpty]  whileFalse: [equal _ equal and: selfCopy pop = anotherStackCopy pop].
	^equal and: anotherStackCopy isEmpty! !

!OOStack methodsFor: 'private' stamp: 'fr 10/2/2020 06:23:31'!
moveTop

	^ top nextIfAbsent: [self error: OOStack stackEmptyErrorDescription]! !


!OOStack methodsFor: 'properties' stamp: 'fr 10/2/2020 03:30:04'!
isEmpty
	^top isVoid! !

!OOStack methodsFor: 'properties' stamp: 'fr 10/2/2020 04:02:22'!
size
	^top chainLengthFromHere! !

!OOStack methodsFor: 'properties' stamp: 'fr 10/2/2020 06:24:34'!
top
	^top contentIfAbsent: [self error: OOStack stackEmptyErrorDescription]. "NUEVAMENTE ENCAPSULAMIENTO. LINKED NODE PARECE SER ANÉMICA"! !

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


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'fr 10/2/2020 05:10:24'!
isAValidPrefix: aPrefix
	self prefixIsNotEmpty: aPrefix.
	self prefixDoesNotContainBlankSpace: aPrefix.
	^true! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'fr 10/2/2020 05:13:28'!
prefixDoesNotContainBlankSpace: aPrefix

	^ (aPrefix findString: ' ') = 0 ifFalse: [self error: self class blankSpaceInPrefix]! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'fr 10/2/2020 05:09:56'!
prefixIsNotEmpty: aPrefix

	^ aPrefix = '' ifTrue: [self error: self class voidPrefixError]! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'fr 10/2/2020 06:19:54'!
find: aPrefix
	self isAValidPrefix: aPrefix.
	^stackSentences select: [:sentece | sentece beginsWith: aPrefix]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'fr 10/2/2020 04:39:41'!
withStack: aStack
	^self new initializeWithStack: aStack copy! !


!SentenceFinderByPrefix class methodsFor: 'error messages' stamp: 'fr 10/2/2020 05:08:21'!
blankSpaceInPrefix
	^'Prefix can not contain blank space'! !

!SentenceFinderByPrefix class methodsFor: 'error messages' stamp: 'fr 10/2/2020 05:08:04'!
voidPrefixError
	^'Prefix can not be empty'! !

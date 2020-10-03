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

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'fr 10/3/2020 17:24:20'!
test01LookingForAPrefixInAnEmptyStackShouldReturnAnEmptyCollection
	
	self assertFindingPrefix: 'Wint' returnsAnEmptyCollectionWhenCalledWithStack: emptyStack

	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'fr 10/3/2020 17:24:01'!
test02LookingForAPrefixInAStackWithNoMatchesShouldReturnAnEmptyCollection
	
	self assertFindingPrefix: 'Wint' returnsAnEmptyCollectionWhenCalledWithStack: noMatchStack
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

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'fr 10/3/2020 17:17:26'!
test07LookingForAPrefixWithMatchesShouldNotModifyTheStack
			
	self assertStackIsNotModifiedWhenFindingPrefix: 'soy'
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'fr 10/3/2020 17:17:30'!
test08LookingForAPrefixWithoutMatchesShouldNotModifyTheStack
			
	self assertStackIsNotModifiedWhenFindingPrefix: 'inge1'.
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

!SentenceFinderByPrefixTest methodsFor: 'private' stamp: 'fr 10/3/2020 17:23:44'!
assertFindingPrefix: aPrefix returnsAnEmptyCollectionWhenCalledWithStack: aStack 
	| sentenceFinder |
	
	sentenceFinder _ SentenceFinderByPrefix withStack: aStack . 
	
	self assert: (sentenceFinder find: aPrefix) size = 0.! !

!SentenceFinderByPrefixTest methodsFor: 'private' stamp: 'fr 10/2/2020 05:49:55'!
assertSizeDoesNotChangeWhenFinding: aPrefix
	
	| sentenceFinder previousLength |
	
	previousLength _ stack size.

	sentenceFinder _ SentenceFinderByPrefix withStack: stack . 
	sentenceFinder find: aPrefix.
	
	self assert: previousLength = stack size.
	
	"¿Implementar = en OOStack para comparar aunque no sea requerido?"! !

!SentenceFinderByPrefixTest methodsFor: 'private' stamp: 'fr 10/3/2020 17:17:18'!
assertStackIsNotModifiedWhenFindingPrefix: aPrefix
		
	| stackBefore stackAfter sentenceFinder |
	
	stackBefore _ stack copy.
	sentenceFinder _ SentenceFinderByPrefix withStack: stack. 
	sentenceFinder find: aPrefix.
	stackAfter _ stack copy.
	self assert: (self thereIsNoDifferenceBetweenStackAfterFind: stackAfter andBeforeFind: stackBefore)
! !

!SentenceFinderByPrefixTest methodsFor: 'private' stamp: 'fr 10/3/2020 16:57:23'!
thereIsNoDifferenceBetweenStackAfterFind: stackAfter andBeforeFind: stackBefore
	| equal |
	equal _ true.
	[stackAfter isEmpty] whileFalse: [equal _ equal and: (stackAfter pop = stackBefore pop)].
	^equal and: stackBefore isEmpty 
	! !


!classDefinition: #LinkedElement category: 'Stack-Exercise'!
Object subclass: #LinkedElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!LinkedElement methodsFor: 'as yet unclassified' stamp: 'fr 10/2/2020 04:02:36'!
chainLengthFromHere
	self subclassResponsibility ! !

!LinkedElement methodsFor: 'as yet unclassified' stamp: 'fr 10/2/2020 04:07:46'!
contentIfAbsent: aBlock
	self subclassResponsibility ! !

!LinkedElement methodsFor: 'as yet unclassified' stamp: 'fr 10/2/2020 03:36:48'!
isVoid
	self subclassResponsibility ! !

!LinkedElement methodsFor: 'as yet unclassified' stamp: 'fr 10/2/2020 03:54:30'!
nextIfAbsent: aBlock
	self subclassResponsibility ! !


!classDefinition: #FullLinkedElement category: 'Stack-Exercise'!
LinkedElement subclass: #FullLinkedElement
	instanceVariableNames: 'content next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!FullLinkedElement methodsFor: 'operations' stamp: 'fr 10/3/2020 16:33:58'!
contentIfAbsent: aBlock
	^content copy "¿DEVOLVER COPIA?"! !

!FullLinkedElement methodsFor: 'operations' stamp: 'fr 10/3/2020 16:17:15'!
nextIfAbsent: aBlock
	^next! !


!FullLinkedElement methodsFor: 'initialize' stamp: 'fr 10/3/2020 17:13:37'!
initializeWithContent: someContent andNext: anElement
	content _ someContent.
	next _ anElement ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FullLinkedElement class' category: 'Stack-Exercise'!
FullLinkedElement class
	instanceVariableNames: ''!

!FullLinkedElement class methodsFor: 'instance creation' stamp: 'fr 10/2/2020 03:47:58'!
withContent: someContent andNext: aLinkedNode
	^self new initializeWithContent: someContent andNext: aLinkedNode! !


!classDefinition: #VoidLinkedElement category: 'Stack-Exercise'!
LinkedElement subclass: #VoidLinkedElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!VoidLinkedElement methodsFor: 'operations' stamp: 'fr 10/2/2020 04:04:12'!
contentIfAbsent: aBlock
	^aBlock value! !

!VoidLinkedElement methodsFor: 'operations' stamp: 'fr 10/2/2020 03:55:00'!
nextIfAbsent: aBlock
	^aBlock value! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'top size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'operations' stamp: 'fr 10/3/2020 17:07:59'!
pop
	| topValue |
	topValue _ self top.
	top _ self moveTop. "ACÁ NO ROMPO ENCAPSULAMIENTO?"
	size _ size -1.
	^topValue	! !

!OOStack methodsFor: 'operations' stamp: 'fr 10/3/2020 17:08:18'!
push: someContent
	top _ FullLinkedElement withContent: someContent andNext: top.
	size _ size + 1! !


!OOStack methodsFor: 'initialization' stamp: 'fr 10/3/2020 17:11:15'!
initialize
	top _ VoidLinkedElement new.
	size _ 0! !


!OOStack methodsFor: 'private' stamp: 'fr 10/3/2020 16:10:42'!
= anotherStack "¿ESTÁ BIEN IMPLEMENTARLO? ¿IMPLEMENTAMOS EL = DE LINKED NODE?" 
	| equal selfCopy anotherStackCopy |
	
	equal _ true.	
	selfCopy _ self copy.
	anotherStackCopy _ anotherStack copy.
	[selfCopy isEmpty]  whileFalse: [equal _ equal and: selfCopy pop = anotherStackCopy pop].
	^equal and: anotherStackCopy isEmpty! !

!OOStack methodsFor: 'private' stamp: 'fr 10/3/2020 17:09:31'!
moveTop
	^top nextIfAbsent: [self error: OOStack stackEmptyErrorDescription] "¿DOUBLE DISPATCH PARA EL ERROR O IFABSENT?"! !


!OOStack methodsFor: 'properties' stamp: 'fr 10/3/2020 17:10:55'!
isEmpty
	^size = 0 "size = 0 disminuye acoplamiento frente a isVoid"! !

!OOStack methodsFor: 'properties' stamp: 'fr 10/3/2020 17:09:59'!
size
	^size "¿ENCAPSULAMIENTO?"! !

!OOStack methodsFor: 'properties' stamp: 'fr 10/3/2020 16:11:30'!
top
	^top contentIfAbsent: [self error: OOStack stackEmptyErrorDescription]. "NUEVAMENTE ENCAPSULAMIENTO. LINKED NODE PARECE ANÉMICA"! !

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

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'fr 10/3/2020 17:25:11'!
prefixDoesNotContainBlankSpace: aPrefix

	^(aPrefix findString: ' ') = 0 ifFalse: [self error: self class blankSpaceInPrefix]! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'fr 10/3/2020 17:24:53'!
prefixIsNotEmpty: aPrefix

	^ aPrefix isEmpty ifTrue: [self error: self class voidPrefixError]! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'fr 10/3/2020 17:16:45'!
find: aPrefix "¿SE PUEDE BUSCAR EN MÁS DE UN STACK?¿COPIAR STACK ACÁ?" 
	self isAValidPrefix: aPrefix.
	^stackSentences select: [:sentece | sentece beginsWith: aPrefix] ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'fr 10/3/2020 16:08:10'!
withStack: aStack
	^self new initializeWithStack: aStack copy "¿CUÁNDO HACER LA COPIA?"! !


!SentenceFinderByPrefix class methodsFor: 'error messages' stamp: 'fr 10/3/2020 17:27:24'!
blankSpaceInPrefix
	^'Prefix can not contain blank spaces!!'! !

!SentenceFinderByPrefix class methodsFor: 'error messages' stamp: 'fr 10/3/2020 17:27:28'!
voidPrefixError
	^'Prefix can not be empty!!'! !

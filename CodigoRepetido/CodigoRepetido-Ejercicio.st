!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: 'johnLennon paulMcCartney georgeHarrison'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'Testing' stamp: 'fr 9/24/2020 11:43:37'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	|customerBook|
	customerBook _ CustomerBook new.
		
	self assertTheOperation: [ customerBook addCustomerNamed: paulMcCartney ] takesLessThan: 50.! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'fr 9/24/2020 12:26:19'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook |
	customerBook _ self createACustomerBookWithACustomerNamed: paulMcCartney andSuspended: false.

	self assertTheOperation: [ customerBook removeCustomerNamed: paulMcCartney ] takesLessThan: 100.! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'fr 9/24/2020 11:24:16'!
test03CanNotAddACustomerWithEmptyName

	| customerBook |
	customerBook _ CustomerBook new.
	
	self customerBookIsEmptyAfterFailingToAddAnEmptyCustomer: customerBook.! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'fr 9/24/2020 12:26:23'!
test04CanNotRemoveAnInvalidCustomer

	| customerBook |
	customerBook _ self createACustomerBookWithACustomerNamed: johnLennon andSuspended: false.
	
	self customerBookWithJustOneCustomer: customerBook staysTheSameAfterFailingToRemoveACustomerNamedDifferentlyThan: johnLennon.



		! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'fr 9/24/2020 12:26:26'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook |
	customerBook _ self createACustomerBookWithACustomerNamed: paulMcCartney andSuspended: true.
		
	self theBook: customerBook hasThisNumberOfActiveCustomers: 0 ThisNumberOfSuspended: 1 thisIsTheTotal: 1 andThisIsTrueAboutTheBook: [customerBook includesCustomerNamed:  paulMcCartney].! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'fr 9/24/2020 12:26:30'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook |
	customerBook _ self createACustomerBookWithACustomerNamed:  paulMcCartney andSuspended: true.
	customerBook removeCustomerNamed:  paulMcCartney .
	
	self theBook: customerBook hasThisNumberOfActiveCustomers: 0 ThisNumberOfSuspended: 0 thisIsTheTotal: 0 andThisIsTrueAboutTheBook: [(customerBook includesCustomerNamed:  paulMcCartney ) not].! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'fr 9/24/2020 12:26:33'!
test07CanNotSuspendAnInvalidCustomer

	| customerBook |
	customerBook _ self createACustomerBookWithACustomerNamed: johnLennon andSuspended: false.
		
	self customerBook: customerBook withJustOneCustomerNamed: johnLennon staysTheSameAfterFailingToSuspend: georgeHarrison.
! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'fr 9/24/2020 12:26:36'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook |
	customerBook _ self createACustomerBookWithACustomerNamed: johnLennon andSuspended: true.

	self customerBook: customerBook withJustOneCustomerNamed: johnLennon staysTheSameAfterFailingToSuspend: johnLennon

	
	
	! !


!CustomerBookTest methodsFor: 'SignalHandlers' stamp: 'fr 9/24/2020 11:29:55'!
customerBook: aCustomerBook withJustOneCustomerNamed: aCustomerName staysTheSameAfterFailingToSuspend: aFakeCustomerName
	 
	self tryToRun: [aCustomerBook suspendCustomerNamed: aFakeCustomerName. self fail ] andAssert: [aCustomerBook numberOfCustomers = 1.] and: [(aCustomerBook includesCustomerNamed: aCustomerName).] when: CantSuspend.! !

!CustomerBookTest methodsFor: 'SignalHandlers' stamp: 'fr 9/24/2020 11:19:04'!
customerBookIsEmptyAfterFailingToAddAnEmptyCustomer: aCustomerBook

	self tryToRun: [ aCustomerBook addCustomerNamed: ''. self fail ] andAssert: [:anError | anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage] and: [aCustomerBook isEmpty] when: Error.
! !

!CustomerBookTest methodsFor: 'SignalHandlers' stamp: 'fr 9/24/2020 11:29:08'!
customerBookWithJustOneCustomer: aCustomerBook staysTheSameAfterFailingToRemoveACustomerNamedDifferentlyThan: aName
	
	 self tryToRun: [aCustomerBook removeCustomerNamed: paulMcCartney. self fail ] andAssert: [aCustomerBook numberOfCustomers = 1.] and:[(aCustomerBook includesCustomerNamed: aName).] when: NotFound.
		! !

!CustomerBookTest methodsFor: 'SignalHandlers' stamp: 'fr 9/24/2020 11:44:31'!
tryToRun: aBlockToRun andAssert: aBlockToAssert and: anotherBlockToAssert when: aSignal
	
	aBlockToRun
		on: aSignal
		do: [ :anError |
			self assert: (aBlockToAssert numArgs = 0 ifTrue: aBlockToAssert ifFalse: [aBlockToAssert value: anError]).
			self assert: anotherBlockToAssert.].! !


!CustomerBookTest methodsFor: 'TestingUtils' stamp: 'fr 9/24/2020 11:43:50'!
assertTheOperation: blockWithOperation takesLessThan: limit
	self assert: ((Time millisecondsToRun: blockWithOperation)*millisecond) < (limit*millisecond).! !

!CustomerBookTest methodsFor: 'TestingUtils' stamp: 'fr 9/24/2020 12:25:49'!
createACustomerBookWithACustomerNamed: aName andSuspended: aChoice
	| customerBook |
	customerBook _ CustomerBook new.
	customerBook addCustomerNamed: aName.
	aChoice ifTrue: [ customerBook suspendCustomerNamed: aName].
	^customerBook.! !

!CustomerBookTest methodsFor: 'TestingUtils' stamp: 'fr 9/24/2020 11:38:20'!
theBook: aCustomerBook hasThisNumberOfActiveCustomers: activeCustomers ThisNumberOfSuspended: suspendedCustomers thisIsTheTotal: totalCustomers andThisIsTrueAboutTheBook: aBlockToAssert

	self assert: ((aCustomerBook numberOfActiveCustomers = activeCustomers )and:(aCustomerBook numberOfSuspendedCustomers = suspendedCustomers )and:(aCustomerBook numberOfCustomers = totalCustomers)and:(aBlockToAssert value)).
! !


!CustomerBookTest methodsFor: 'Initialization' stamp: 'FR 9/23/2020 18:36:16'!
initialize
	johnLennon _ 'John Lennon'.
	paulMcCartney _ 'Paul McCartney'.
	georgeHarrison _ 'George Harrison'.! !


!classDefinition: #Customer category: #'CodigoRepetido-Ejercicio'!
Object subclass: #Customer
	instanceVariableNames: 'name state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!Customer methodsFor: 'Operations' stamp: 'fr 9/24/2020 11:55:17'!
isActive
	
	^state = 'active'.! !

!Customer methodsFor: 'Operations' stamp: 'fr 9/24/2020 11:47:08'!
name

	^name.! !

!Customer methodsFor: 'Operations' stamp: 'fr 9/24/2020 11:47:11'!
state

	^state.! !

!Customer methodsFor: 'Operations' stamp: 'fr 9/24/2020 11:47:15'!
suspend

	state _ 'suspended'.! !


!Customer methodsFor: 'Initialization' stamp: 'fr 9/24/2020 11:47:26'!
initialize: customerName

	name _ customerName.
	state _ 'active'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: #'CodigoRepetido-Ejercicio'!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'as yet unclassified' stamp: 'fr 9/24/2020 05:15:41'!
new: customerName
	^self new initialize: customerName.! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspendedSize customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'Properties' stamp: 'fr 9/24/2020 04:56:47'!
isEmpty
	
	^customers isEmpty.! !

!CustomerBook methodsFor: 'Properties' stamp: 'fr 9/24/2020 05:26:09'!
numberOfActiveCustomers
	
	^(customers size) - suspendedSize.! !

!CustomerBook methodsFor: 'Properties' stamp: 'fr 9/24/2020 04:58:45'!
numberOfCustomers
	
	^customers size.! !

!CustomerBook methodsFor: 'Properties' stamp: 'fr 9/24/2020 04:59:08'!
numberOfSuspendedCustomers
	
	^suspendedSize. ! !


!CustomerBook methodsFor: 'Initialization' stamp: 'fr 9/24/2020 05:26:44'!
initialize

	customers _ OrderedCollection new.
	suspendedSize _ 0.
! !


!CustomerBook methodsFor: 'Checks' stamp: 'fr 9/24/2020 11:41:15'!
checkAndFailIfCustomerAlreadyExists: aName

	^(self includesCustomerNamed: aName) ifTrue: [self signalCustomerAlreadyExists].! !

!CustomerBook methodsFor: 'Checks' stamp: 'fr 9/24/2020 11:46:47'!
checkAndFailIfCustomerExistsAndIsActive: aName

	(self hasAnActiveCustomerNamed: aName) ifFalse: [^CantSuspend signal].! !

!CustomerBook methodsFor: 'Checks' stamp: 'fr 9/24/2020 11:42:08'!
checkAndFailIfNameIsEmpty: aName

	^aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty].! !


!CustomerBook methodsFor: 'CustomerManagement' stamp: 'fr 9/24/2020 11:45:43'!
addCustomerNamed: aName

	| newCustomer |
	self checkAndFailIfNameIsEmpty: aName.	
	self checkAndFailIfCustomerAlreadyExists: aName.
	
	newCustomer _ Customer new: aName.
	customers add:  newCustomer.! !

!CustomerBook methodsFor: 'CustomerManagement' stamp: 'fr 9/24/2020 15:49:26'!
removeCustomerNamed: aName 

	| index |
	index _ self getIndexForCustomerNamed: aName.
	index = 0 ifTrue: [^ NotFound signal] ifFalse: [self removeCustomerAt: index]. 	
! !

!CustomerBook methodsFor: 'CustomerManagement' stamp: 'fr 9/24/2020 15:52:11'!
suspendCustomerNamed: aName 
	
	| index |
	self checkAndFailIfCustomerExistsAndIsActive: aName.
	index _ self getIndexForCustomerNamed: aName.
	(customers at: index) suspend.
	suspendedSize _ suspendedSize + 1.
! !


!CustomerBook methodsFor: 'Signals' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'Signals' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !


!CustomerBook methodsFor: 'BookUtils' stamp: 'fr 9/24/2020 11:54:26'!
getIndexForCustomerNamed: aName

	^customers findFirst: [:aCustomer | aCustomer name = aName].! !

!CustomerBook methodsFor: 'BookUtils' stamp: 'fr 9/24/2020 15:54:41'!
hasAnActiveCustomerNamed: aName

	| index |
	index _ self getIndexForCustomerNamed: aName.
	^(index = 0 ifTrue: [false] ifFalse: [(customers at: index) isActive]).! !

!CustomerBook methodsFor: 'BookUtils' stamp: 'fr 9/24/2020 15:57:09'!
includesCustomerNamed: aName
	
	| index |
	index _ self getIndexForCustomerNamed: aName.
	^(index = 0) not.! !

!CustomerBook methodsFor: 'BookUtils' stamp: 'fr 9/24/2020 11:46:29'!
removeCustomerAt: anIndex

	(customers at: anIndex) state = 'suspended' ifTrue: [suspendedSize _ suspendedSize - 1].
	customers removeAt: anIndex.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:01:49'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:02:05'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!'! !

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

!CustomerBookTest methodsFor: 'Testing' stamp: 'FR 9/23/2020 18:40:07'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	|customerBook|
	customerBook _ CustomerBook new.
		
	self theOperation: [ customerBook addCustomerNamed: paulMcCartney ] takesLessThan: 50.! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'FR 9/23/2020 18:52:25'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	| customerBook |
	customerBook _ self insertCustomerNamed: paulMcCartney andSuspended: False.

	self theOperation: [ customerBook removeCustomerNamed: paulMcCartney ] takesLessThan: 100.! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'FR 9/20/2020 21:56:08'!
test03CanNotAddACustomerWithEmptyName
	| customerBook |
	customerBook _ CustomerBook new.
	
	self emptyNameHandler: customerBook.! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'FR 9/23/2020 18:52:29'!
test04CanNotRemoveAnInvalidCustomer
	| customerBook |
	customerBook _ self insertCustomerNamed: johnLennon andSuspended: False.

	self customerNotFoundHandler: customerBook customerNamed: johnLennon



		! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'FR 9/23/2020 18:52:33'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook
	| customerBook |
	customerBook _ self insertCustomerNamed: paulMcCartney andSuspended: True.
		
	self theBook: customerBook hasThisNumberOfActiveCustomers: 0 ThisNumberOfSuspended: 1 AndThisIsTheTotal: 1.
	self assert: (customerBook includesCustomerNamed:  paulMcCartney ).! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'FR 9/23/2020 18:52:36'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook
	| customerBook |
	customerBook _ self insertCustomerNamed:  paulMcCartney andSuspended: True.
	customerBook removeCustomerNamed:  paulMcCartney .
	
	self theBook: customerBook hasThisNumberOfActiveCustomers: 0 ThisNumberOfSuspended: 0 AndThisIsTheTotal: 0.
	self deny: (customerBook includesCustomerNamed:  paulMcCartney ).! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'FR 9/23/2020 18:52:41'!
test07CanNotSuspendAnInvalidCustomer
	| customerBook |
	customerBook _ self insertCustomerNamed: johnLennon andSuspended: False.
		
	self customerCantSuspendHandler: customerBook realCustomerNamed: johnLennon testCustomerNamed: georgeHarrison. 
! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'FR 9/23/2020 18:52:44'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook |
	customerBook _ self insertCustomerNamed: johnLennon andSuspended: True.
	
	self customerCantSuspendHandler: customerBook realCustomerNamed: johnLennon testCustomerNamed: johnLennon 
	
	
	! !


!CustomerBookTest methodsFor: 'SignalHandlers' stamp: 'FR 9/20/2020 20:48:21'!
customerCantSuspendHandler: aCustomerBook realCustomerNamed: aRealName testCustomerNamed: aNameToTest
	 
	self customerSignalHandler: [aCustomerBook suspendCustomerNamed: aNameToTest.self fail ] on: [aCustomerBook numberOfCustomers = 1.] and:[(aCustomerBook includesCustomerNamed: aRealName).] raced:CantSuspend.! !

!CustomerBookTest methodsFor: 'SignalHandlers' stamp: 'FR 9/20/2020 20:49:42'!
customerNotFoundHandler: aCustomerBook customerNamed: aName
	
	 self customerSignalHandler: [aCustomerBook removeCustomerNamed: 'Paul McCartney'.self fail ] on: [aCustomerBook numberOfCustomers = 1.] and:[(aCustomerBook includesCustomerNamed: aName).] raced: NotFound.
		! !

!CustomerBookTest methodsFor: 'SignalHandlers' stamp: 'FR 9/20/2020 22:36:00'!
customerSignalHandler: aFirstBlock on: aSecondBlock and: aThirdBlock raced: aSignal
	
	aFirstBlock
		on: aSignal
		do: [ :anError |
			self assert: (aSecondBlock numArgs = 0 ifTrue: aSecondBlock ifFalse: [aSecondBlock value: anError]). "esto podemos ponerlo dentro de otro mensaje"
			self assert: aThirdBlock.].! !

!CustomerBookTest methodsFor: 'SignalHandlers' stamp: 'FR 9/20/2020 21:05:15'!
emptyNameHandler: aCustomerBook
	self customerSignalHandler: [ aCustomerBook addCustomerNamed: ''. self fail ] on: [:anError | anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage] and: [aCustomerBook isEmpty] raced: Error.
! !


!CustomerBookTest methodsFor: 'TestingUtils' stamp: 'FR 9/23/2020 18:52:13'!
insertCustomerNamed: aName andSuspended: aChoice
	| customerBook |
	customerBook _ CustomerBook new.
	customerBook addCustomerNamed: aName.
	aChoice = True ifTrue: [ customerBook suspendCustomerNamed: aName].
	^customerBook.! !

!CustomerBookTest methodsFor: 'TestingUtils' stamp: 'FR 9/20/2020 19:56:46'!
theBook: customerBook hasThisNumberOfActiveCustomers: active ThisNumberOfSuspended: suspended AndThisIsTheTotal: total
	self assert: ((customerBook numberOfActiveCustomers = active)and:(customerBook numberOfSuspendedCustomers = suspended)and:(customerBook numberOfCustomers = total)).
! !

!CustomerBookTest methodsFor: 'TestingUtils' stamp: 'FR 9/20/2020 21:22:21'!
theOperation: blockWithOperation takesLessThan: limit
	self assert: ((Time millisecondsToRun: blockWithOperation)*millisecond) < (limit*millisecond).! !


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

!Customer methodsFor: 'Operations' stamp: 'fr 9/24/2020 05:14:02'!
name
	^name.! !

!Customer methodsFor: 'Operations' stamp: 'fr 9/24/2020 05:14:10'!
state
	^state.! !

!Customer methodsFor: 'Operations' stamp: 'fr 9/24/2020 05:14:27'!
suspend
	state _ 'suspended'.! !


!Customer methodsFor: 'Initialization' stamp: 'fr 9/24/2020 05:16:24'!
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

!CustomerBook methodsFor: 'Properties' stamp: 'fr 9/24/2020 04:56:26'!
includesCustomerNamed: aName
	
	|exists|
	exists _ customers select: [:customer | (customer name) = aName].
	^(exists isEmpty) not.! !

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


!CustomerBook methodsFor: 'Checks' stamp: 'fr 9/24/2020 04:55:36'!
checkIfCustomerAlreadyExists: aName

	^(self includesCustomerNamed: aName) ifTrue: [self signalCustomerAlreadyExists].! !

!CustomerBook methodsFor: 'Checks' stamp: 'fr 9/24/2020 05:32:50'!
checkIfCustomerExistsAndIsActive: aName
	(self hasAnActiveCustomerNamed: aName) ifFalse: [^CantSuspend signal].! !

!CustomerBook methodsFor: 'Checks' stamp: 'fr 9/24/2020 04:55:49'!
checkIfNameIsEmpty: aName

	^aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty].! !


!CustomerBook methodsFor: 'CustomerManagement' stamp: 'fr 9/24/2020 05:03:40'!
addCustomerNamed: aName
	| newCustomer |
	self checkIfNameIsEmpty: aName.	
	self checkIfCustomerAlreadyExists: aName.
	
	newCustomer _ Customer new: aName.
	customers add:  newCustomer.! !

!CustomerBook methodsFor: 'CustomerManagement' stamp: 'fr 9/24/2020 05:17:28'!
removeCustomerNamed: aName 
	1 to: customers size do: 
	[ :index |
		(self hasCustomerNamed: aName atIndex: index) 
			ifTrue: [
				self removeCustomerAt: index.
				^ aName
			]. 
	].

	^ NotFound signal.
! !

!CustomerBook methodsFor: 'CustomerManagement' stamp: 'fr 9/24/2020 05:08:48'!
suspendCustomerNamed: aName 
	|index|
	self checkIfCustomerExistsAndIsActive: aName.
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


!CustomerBook methodsFor: 'BookUtils' stamp: 'fr 9/24/2020 05:24:00'!
getCustomerNamed: aName
	^customers detect: [:aCustomer | aName = (aCustomer name)] ifNone: ['customer not found'].! !

!CustomerBook methodsFor: 'BookUtils' stamp: 'fr 9/24/2020 05:09:18'!
getIndexForCustomerNamed: aName

	^customers findFirst: [:customer | customer name = aName].! !

!CustomerBook methodsFor: 'BookUtils' stamp: 'fr 9/24/2020 05:32:34'!
hasAnActiveCustomerNamed: aName

	|state client|
	client _ self getCustomerNamed: aName.
	state _ client = 'customer not found' ifFalse: [client state].
	^state = 'active'.! !

!CustomerBook methodsFor: 'BookUtils' stamp: 'fr 9/24/2020 05:03:16'!
hasCustomerNamed: aName atIndex: anIndex

	^aName = (customers at: anIndex) name.! !

!CustomerBook methodsFor: 'BookUtils' stamp: 'fr 9/24/2020 05:18:31'!
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

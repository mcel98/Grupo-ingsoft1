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

!Customer methodsFor: 'Operations' stamp: 'FR 9/23/2020 18:53:20'!
name

	^name.! !

!Customer methodsFor: 'Operations' stamp: 'FR 9/23/2020 18:53:26'!
state

	^state.! !

!Customer methodsFor: 'Operations' stamp: 'FR 9/23/2020 17:57:57'!
suspend

	state = 'activo' ifTrue: [state := 'suspended'] ifFalse: [state := 'activo'].

	! !


!Customer methodsFor: 'Initialization' stamp: 'msm 9/19/2020 22:53:52'!
initialize: aName
	name := aName.
	state := 'activo'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: #'CodigoRepetido-Ejercicio'!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'Creation' stamp: 'msm 9/19/2020 22:54:12'!
new: aName

	^self new initialize: aName. ! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customerList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'Properties' stamp: 'FR 9/23/2020 19:01:06'!
includesCustomerNamed: aName

	"Se revisa la lista unica"

	^customerList includesCustomerNamed: aName.! !

!CustomerBook methodsFor: 'Properties' stamp: 'FR 9/23/2020 17:51:57'!
isEmpty

	^customerList isEmpty.! !

!CustomerBook methodsFor: 'Properties' stamp: 'FR 9/23/2020 17:52:05'!
numberOfActiveCustomers
	
	^customerList activeSize.! !

!CustomerBook methodsFor: 'Properties' stamp: 'FR 9/23/2020 17:52:22'!
numberOfCustomers
	
	^customerList size.! !

!CustomerBook methodsFor: 'Properties' stamp: 'FR 9/23/2020 17:52:18'!
numberOfSuspendedCustomers
	
	^customerList suspendedSize.! !


!CustomerBook methodsFor: 'Initialization' stamp: 'FR 9/23/2020 17:52:30'!
initialize

	customerList _ CustomerList new.! !


!CustomerBook methodsFor: 'CustomerManagement' stamp: 'FR 9/23/2020 19:03:29'!
addCustomerNamed: aName

	self checkIfNameIsEmpty: aName.
	self checkIfCustomerAlreadyExists: aName.
	
	customerList addCustomerNamed: aName.! !

!CustomerBook methodsFor: 'CustomerManagement' stamp: 'FR 9/23/2020 19:07:58'!
removeCustomerNamed: aName 
 	"lista unica borra codigo repetido "
	1 to: customerList size do: 
	[ :index |
		(customerList hasCustomerNamed: aName atIndex: index) 
			ifTrue: [
				customerList removeCustomerAt: index.
				^ aName
			]. 
	].

	^ NotFound signal.
! !

!CustomerBook methodsFor: 'CustomerManagement' stamp: 'FR 9/23/2020 19:13:02'!
suspendCustomerNamed: aName 
	
	self checkIfCustomerExistsAndIsActive: aName.
	
	customerList suspendCustomerNamed: aName.
	
! !


!CustomerBook methodsFor: 'Signals' stamp: 'msm 9/20/2020 20:56:33'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage.! !

!CustomerBook methodsFor: 'Signals' stamp: 'msm 9/20/2020 20:56:27'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage.! !


!CustomerBook methodsFor: 'Checks' stamp: 'FR 9/23/2020 19:03:55'!
checkIfCustomerAlreadyExists: aName

	(customerList includesCustomerNamed: aName) ifTrue: [self signalCustomerAlreadyExists ]! !

!CustomerBook methodsFor: 'Checks' stamp: 'FR 9/23/2020 19:12:54'!
checkIfCustomerExistsAndIsActive: aName

	(customerList isActive: aName) ifFalse: [^CantSuspend signal]! !

!CustomerBook methodsFor: 'Checks' stamp: 'FR 9/23/2020 19:12:08'!
checkIfNameIsEmpty: aName

	aName isEmpty ifTrue: [self signalCustomerNameCannotBeEmpty]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'ErrorMessages' stamp: 'msm 9/20/2020 19:28:10'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!'.! !

!CustomerBook class methodsFor: 'ErrorMessages' stamp: 'msm 9/20/2020 19:31:26'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!'.! !


!classDefinition: #CustomerList category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerList
	instanceVariableNames: 'customerCollection suspendedCounter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerList methodsFor: 'Operations' stamp: 'FR 9/23/2020 18:56:53'!
addCustomerNamed: aName
	|customer|
	customer _ Customer new: aName.
	customerCollection add: customer.
	! !

!CustomerList methodsFor: 'Operations' stamp: 'FR 9/23/2020 18:55:28'!
getCustomerNamed: aName

	^customerCollection detect: [:aCustomer | aName = (aCustomer name)] ifNone: ['customer not found'].! !

!CustomerList methodsFor: 'Operations' stamp: 'FR 9/23/2020 19:14:50'!
removeCustomerAt: anIndex

	self decreaseSuspendedCounterIfCustomerIsSuspended: anIndex.
	
	customerCollection removeAt: anIndex.! !

!CustomerList methodsFor: 'Operations' stamp: 'FR 9/23/2020 19:16:07'!
suspendCustomerNamed: aName
	|index|
 	index _ customerCollection findFirst: [:a | a name = aName].
	
	(customerCollection at: index) suspend.
	
	suspendedCounter _ suspendedCounter + 1.
	! !


!CustomerList methodsFor: 'Initialization' stamp: 'FR 9/23/2020 17:59:50'!
initialize

	customerCollection _ OrderedCollection new.
	suspendedCounter _ 0.
	! !


!CustomerList methodsFor: 'Properties' stamp: 'FR 9/23/2020 18:03:59'!
activeSize

	^customerCollection size - suspendedCounter.! !

!CustomerList methodsFor: 'Properties' stamp: 'FR 9/23/2020 18:56:15'!
hasCustomerNamed: aName atIndex: anIndex

	^aName = ((customerCollection at: anIndex) name).! !

!CustomerList methodsFor: 'Properties' stamp: 'FR 9/23/2020 19:00:39'!
includesCustomerNamed: aName
	|exists|
	exists _ customerCollection select: [:customer | (customer name) = aName].
	^(exists isEmpty) not.! !

!CustomerList methodsFor: 'Properties' stamp: 'FR 9/23/2020 19:16:38'!
isActive: aName
	|state client|
	client _ self getCustomerNamed: aName.
	state _ client = 'customer not found' ifTrue: [ 'sin estado'] ifFalse: [client state].
	^state = 'activo'.! !

!CustomerList methodsFor: 'Properties' stamp: 'FR 9/23/2020 17:56:38'!
isEmpty

	^customerCollection isEmpty.! !

!CustomerList methodsFor: 'Properties' stamp: 'FR 9/23/2020 17:56:47'!
size

	^customerCollection size.! !

!CustomerList methodsFor: 'Properties' stamp: 'msm 9/20/2020 18:11:21'!
suspendedSize
	
	^suspendedCounter.! !


!CustomerList methodsFor: 'Utils' stamp: 'FR 9/23/2020 19:15:31'!
decreaseSuspendedCounterIfCustomerIsSuspended: anIndex

	^((customerCollection at: anIndex) state = 'suspended') ifTrue: [suspendedCounter _ suspendedCounter - 1]! !

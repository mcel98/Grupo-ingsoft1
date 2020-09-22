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
	instanceVariableNames: 'messageText'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'Testing' stamp: 'FR 9/20/2020 20:06:07'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	|customerBook|
	customerBook := CustomerBook new.
		
	self theOperation: [ customerBook addCustomerNamed: 'Paul McCartney' ] takesLessThan: 50.! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'FR 9/20/2020 20:12:38'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	| customerBook |
	customerBook _ self insertCustomerNamed: 'Paul McCartney' andSuspendedSet: False.

	self theOperation: [ customerBook removeCustomerNamed: 'Paul McCartney' ] takesLessThan: 100.! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'FR 9/20/2020 21:56:08'!
test03CanNotAddACustomerWithEmptyName
	| customerBook |
	customerBook _ CustomerBook new.
	
	self emptyNameHandler: customerBook.! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'FR 9/20/2020 20:14:08'!
test04CanNotRemoveAnInvalidCustomer
	| customerBook johnLennon |
	johnLennon _ 'John Lennon'.
	customerBook _ self insertCustomerNamed: johnLennon andSuspendedSet: False.

	self customerNotFoundHandler: customerBook customerNamed: johnLennon



		! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'FR 9/20/2020 20:12:38'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook
	| customerBook paulMcCartney |
	 paulMcCartney  _ 'Paul McCartney'.
	customerBook _ self insertCustomerNamed: paulMcCartney andSuspendedSet: True.
		
	self theBook: customerBook hasThisNumberOfActiveCustomers: 0 ThisNumberOfSuspended: 1 AndThisIsTheTotal: 1.
	self assert: (customerBook includesCustomerNamed:  paulMcCartney ).! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'FR 9/20/2020 20:13:40'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook
	| customerBook  paulMcCartney  |
	 paulMcCartney  _ 'Paul McCartney'.
	customerBook _ self insertCustomerNamed:  paulMcCartney andSuspendedSet: True.
	customerBook removeCustomerNamed:  paulMcCartney .
	
	self theBook: customerBook hasThisNumberOfActiveCustomers: 0 ThisNumberOfSuspended: 0 AndThisIsTheTotal: 0.
	self deny: (customerBook includesCustomerNamed:  paulMcCartney ).! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'FR 9/20/2020 20:13:11'!
test07CanNotSuspendAnInvalidCustomer
	| customerBook johnLennon georgeHarrison |
	johnLennon _ 'John Lennon'.
	georgeHarrison _ 'George Harrison'.
	customerBook _ self insertCustomerNamed: johnLennon andSuspendedSet: False.
		
	self customerCantSuspendHandler: customerBook realCustomerNamed: johnLennon testCustomerNamed: georgeHarrison. 
! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'FR 9/20/2020 20:36:39'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
	johnLennon _ 'Jhon Lennon'.
	customerBook _ self insertCustomerNamed: johnLennon andSuspendedSet: True.
	
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


!CustomerBookTest methodsFor: 'TimeMeasurement' stamp: 'msm 9/19/2020 23:37:53'!
compareTime: aFirstTimeStamp with: aSecondTimeStamp

	^ aFirstTimeStamp < aSecondTimeStamp.! !

!CustomerBookTest methodsFor: 'TimeMeasurement' stamp: 'msm 9/19/2020 23:40:52'!
mensaje: aBlock tardaMenosQue: aTimeStamp
	|runtime|
	runtime := Time millisecondsToRun: aBlock.
	^self compareTime: runtime with: aTimeStamp * millisecond.

	
	! !


!CustomerBookTest methodsFor: 'TestingUtils' stamp: 'FR 9/20/2020 20:12:38'!
insertCustomerNamed: aName andSuspendedSet: aDecision
	| customerBook |
	customerBook _ CustomerBook new.
	customerBook addCustomerNamed: aName.
	aDecision = True ifTrue: [ customerBook suspendCustomerNamed: aName].
	^ customerBook.! !

!CustomerBookTest methodsFor: 'TestingUtils' stamp: 'FR 9/20/2020 19:56:46'!
theBook: customerBook hasThisNumberOfActiveCustomers: active ThisNumberOfSuspended: suspended AndThisIsTheTotal: total
	self assert: ((customerBook numberOfActiveCustomers = active)and:(customerBook numberOfSuspendedCustomers = suspended)and:(customerBook numberOfCustomers = total)).
! !

!CustomerBookTest methodsFor: 'TestingUtils' stamp: 'FR 9/20/2020 21:22:21'!
theOperation: blockWithOperation takesLessThan: limit
	self assert: ((Time millisecondsToRun: blockWithOperation)*millisecond) < (limit*millisecond).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBookTest class' category: #'CodigoRepetido-Ejercicio'!
CustomerBookTest class
	instanceVariableNames: 'milisegundosDeEjecucion customerBook paulMcCartney johnLennon'!


!classDefinition: #Customer category: #'CodigoRepetido-Ejercicio'!
Object subclass: #Customer
	instanceVariableNames: 'name state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!Customer methodsFor: 'Operations' stamp: 'msm 9/20/2020 18:59:22'!
changeState

	state = 'activo' ifTrue: [state := 'suspended'] ifFalse: [state := 'activo'].

	! !

!Customer methodsFor: 'Operations' stamp: 'msm 9/19/2020 23:44:00'!
getName

	^name.! !

!Customer methodsFor: 'Operations' stamp: 'msm 9/19/2020 23:44:36'!
getState

	^state.! !


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
	instanceVariableNames: 'suspended active customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'Properties' stamp: 'msm 9/20/2020 18:12:23'!
includesCustomerNamed: aName

	"Se revisa la lista unica"

	^customers includes: aName.! !

!CustomerBook methodsFor: 'Properties' stamp: 'msm 9/20/2020 22:07:45'!
isEmpty

	^customers isEmpty.! !

!CustomerBook methodsFor: 'Properties' stamp: 'msm 9/20/2020 18:12:51'!
numberOfActiveCustomers
	
	^customers activeSize.! !

!CustomerBook methodsFor: 'Properties' stamp: 'msm 9/20/2020 18:13:05'!
numberOfCustomers
	
	^ customers size.! !

!CustomerBook methodsFor: 'Properties' stamp: 'msm 9/20/2020 18:13:30'!
numberOfSuspendedCustomers
	
	^customers suspendedSize.! !


!CustomerBook methodsFor: 'Initialization' stamp: 'FR 9/22/2020 14:11:45'!
initialize

	customers := CustomerList new.! !


!CustomerBook methodsFor: 'CustomerManagement' stamp: 'msm 9/20/2020 22:25:52'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [self signalCustomerNameCannotBeEmpty].
	(customers includes: aName) ifTrue: [self signalCustomerAlreadyExists ].
	
	customers add: aName.! !

!CustomerBook methodsFor: 'CustomerManagement' stamp: 'msm 9/20/2020 22:31:42'!
removeCustomerNamed: aName 
 	"lista unica borra codigo repetido "
	1 to: customers size do: 
	[ :index |
		(customers hasName: aName atIndex: index) 
			ifTrue: [
				customers removeAt: index.
				^ aName
			]. 
	].

	^ NotFound signal.
! !

!CustomerBook methodsFor: 'CustomerManagement' stamp: 'msm 9/20/2020 18:25:43'!
suspendCustomerNamed: aName 
	
	(customers isActive: aName) ifFalse: [^CantSuspend signal].
	
	customers suspend: aName.
	
! !


!CustomerBook methodsFor: 'Signals' stamp: 'msm 9/20/2020 20:56:33'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage.! !

!CustomerBook methodsFor: 'Signals' stamp: 'msm 9/20/2020 20:56:27'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: 'customers aName'!

!CustomerBook class methodsFor: 'ErrorMessages' stamp: 'msm 9/20/2020 19:28:10'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!'.! !

!CustomerBook class methodsFor: 'ErrorMessages' stamp: 'msm 9/20/2020 19:31:26'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!'.! !


!classDefinition: #CustomerList category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerList
	instanceVariableNames: 'customers suspendedCounter activeCounter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerList methodsFor: 'Operations' stamp: 'FR 9/22/2020 14:12:02'!
add: aName
	|customer|
	customer := Customer new: aName.
	customers add: customer.
	activeCounter := activeCounter + 1.
	! !

!CustomerList methodsFor: 'Operations' stamp: 'msm 9/20/2020 23:08:54'!
getCustomer: aName

	^ customers detect: [:aCustomer | aName = (aCustomer getName)] ifNone: ['customer not found'].! !

!CustomerList methodsFor: 'Operations' stamp: 'msm 9/20/2020 22:44:27'!
removeAt: anIndex

	(customers at: anIndex) = 'activo' ifTrue: [activeCounter := self activeSize - 1] ifFalse: [suspendedCounter := self suspendedSize - 1.].

	customers removeAt: anIndex.! !

!CustomerList methodsFor: 'Operations' stamp: 'msm 9/20/2020 20:45:04'!
suspend: aName

	|index|

 	index := customers findFirst: [:a | a getName = aName].
	
	(customers at: index) changeState.
	
	(customers at: index) = 'activo' ifTrue: [suspendedCounter := self suspendedSize - 1. activeCounter := self activeSize + 1] ifFalse: [suspendedCounter := self suspendedSize + 1. activeCounter := self activeSize - 1].
	! !


!CustomerList methodsFor: 'Initialization' stamp: 'msm 9/20/2020 18:04:57'!
initialize

	customers := OrderedCollection new.
	suspendedCounter := 0.
	activeCounter := 0.
	! !


!CustomerList methodsFor: 'Properties' stamp: 'msm 9/20/2020 18:10:38'!
activeSize

	^activeCounter.! !

!CustomerList methodsFor: 'Properties' stamp: 'msm 9/20/2020 22:32:15'!
hasName: aName atIndex: anIndex

	^aName = ((customers at: anIndex) getName).! !

!CustomerList methodsFor: 'Properties' stamp: 'msm 9/20/2020 20:49:52'!
includes: aName
	|exists|
	exists := customers select: [:customer | (customer getName) = aName].
	^(exists isEmpty) not.! !

!CustomerList methodsFor: 'Properties' stamp: 'msm 9/20/2020 23:08:25'!
isActive: aName
	
	|state client|
	client := self getCustomer: aName.
	state := client = 'customer not found' ifTrue: [ 'sin estado'] ifFalse: [client getState].
	^state = 'activo'.! !

!CustomerList methodsFor: 'Properties' stamp: 'msm 9/20/2020 22:02:32'!
isEmpty

	^customers isEmpty.! !

!CustomerList methodsFor: 'Properties' stamp: 'msm 9/20/2020 18:11:58'!
size
	^customers size.! !

!CustomerList methodsFor: 'Properties' stamp: 'msm 9/20/2020 18:11:21'!
suspendedSize
	
	^suspendedCounter.! !

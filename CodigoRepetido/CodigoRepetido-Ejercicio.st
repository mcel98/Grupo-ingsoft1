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

!CustomerBookTest methodsFor: 'Testing' stamp: 'FR 9/20/2020 20:05:47'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	| customerBook |
	customerBook _ self testCustomer: 'Paul McCartney' suspend: False.

	self theOperation: [ customerBook removeCustomerNamed: 'Paul McCartney' ] takesLessThan: 100.! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'msm 9/20/2020 15:09:10'!
test03CanNotAddACustomerWithEmptyName
	| customerBook |
	customerBook _ CustomerBook new.
	self
		testMessageErrorHandler: [
			customerBook addCustomerNamed: ''.
			self fail ]
		on: CustomerBook customerCanNotBeEmptyErrorMessage
		and: [ customerBook isEmpty ].! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'msm 9/19/2020 21:52:31'!
test04CanNotRemoveAnInvalidCustomer
	| customerBook johnLennon |
	johnLennon _ 'John Lennon'.
	customerBook _ self
		testCustomer: johnLennon
		suspend: False.
	self
		customerNotFoundHandler: customerBook customerNamed: johnLennon



		! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'FR 9/20/2020 20:06:16'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook
	| customerBook paulMcCartney |
	 paulMcCartney  _ 'Paul McCartney'.
	customerBook _ self testCustomer: paulMcCartney suspend: True.
		
	self theBook: customerBook hasThisNumberOfActiveCustomers: 0 ThisNumberOfSuspended: 1 AndThisIsTheTotal: 1.
	self assert: (customerBook includesCustomerNamed:  paulMcCartney ).! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'FR 9/20/2020 19:57:47'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook
	| customerBook  paulMcCartney  |
	 paulMcCartney  _ 'Paul McCartney'.
	customerBook _ self
		testCustomer:  paulMcCartney 
		suspend: True.
	customerBook removeCustomerNamed:  paulMcCartney .
	
	self theBook: customerBook hasThisNumberOfActiveCustomers: 0 ThisNumberOfSuspended: 0 AndThisIsTheTotal: 0.
	self deny: (customerBook includesCustomerNamed:  paulMcCartney ).! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'msm 9/19/2020 21:50:09'!
test07CanNotSuspendAnInvalidCustomer
	| customerBook johnLennon georgeHarrison |
	johnLennon _ 'John Lennon'.
	georgeHarrison _ 'George Harrison'.
	customerBook _ self
		testCustomer: johnLennon
		suspend: False.
		
	self 
		customerCantSuspendHandler: customerBook 
		realCustomerNamed: johnLennon 
		testCustomerNamed: georgeHarrison. 
! !

!CustomerBookTest methodsFor: 'Testing' stamp: 'msm 9/19/2020 21:47:21'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
	johnLennon := 'Jhon Lennon'.
	 customerBook := self
		testCustomer: johnLennon
		suspend: True.
	self 
		customerCantSuspendHandler: customerBook 
		realCustomerNamed: johnLennon 
		testCustomerNamed: johnLennon 
	
	
	! !


!CustomerBookTest methodsFor: 'SignalHandlers' stamp: 'msm 9/19/2020 21:53:34'!
customerCantSuspendHandler: anObject realCustomerNamed: aNameFirst testCustomerNamed: aNameSecond
	 self 
		customerSignalHandler: [anObject suspendCustomerNamed: aNameSecond.self fail ] 
		on: [anObject numberOfCustomers = 1.] 
		and:[(anObject includesCustomerNamed: aNameFirst).]
		raced:CantSuspend! !

!CustomerBookTest methodsFor: 'SignalHandlers' stamp: 'msm 9/19/2020 21:50:58'!
customerNotFoundHandler: anObject customerNamed: aName
	
	 self 
		customerSignalHandler: [anObject removeCustomerNamed: 'Paul McCartney'.self fail ] 
		on: [anObject numberOfCustomers = 1.] 
		and:[(anObject includesCustomerNamed: aName).]
		raced:NotFound
		! !

!CustomerBookTest methodsFor: 'SignalHandlers' stamp: 'msm 9/19/2020 21:52:52'!
customerSignalHandler: aFirstBlock on: aSecondBlock and: aThirdBlock raced: aSignal
	aFirstBlock
		on: aSignal
		do: [ :aError |
			self assert: aSecondBlock.
			self assert: aThirdBlock.].! !

!CustomerBookTest methodsFor: 'SignalHandlers' stamp: 'msm 9/20/2020 15:12:20'!
testMessageErrorHandler: aFirstBlock on: aSecondBlock and: aThirdBlock
	aFirstBlock
		on: Error
		do: [ :anError |
			self assert: anError messageText = aSecondBlock.
			self assert: aThirdBlock ].! !


!CustomerBookTest methodsFor: 'TimeMeasurement' stamp: 'msm 9/19/2020 23:37:53'!
compareTime: aFirstTimeStamp with: aSecondTimeStamp

	^ aFirstTimeStamp < aSecondTimeStamp.! !

!CustomerBookTest methodsFor: 'TimeMeasurement' stamp: 'msm 9/19/2020 23:40:52'!
mensaje: aBlock tardaMenosQue: aTimeStamp
	|runtime|
	runtime := Time millisecondsToRun: aBlock.
	^self compareTime: runtime with: aTimeStamp * millisecond.

	
	! !


!CustomerBookTest methodsFor: 'TestingUtils' stamp: 'msm 9/20/2020 15:13:12'!
testCustomer: aName suspend: aDecision
	| customerBook |
	customerBook _ CustomerBook new.
	customerBook addCustomerNamed: aName.
	aDecision = True ifTrue: [ customerBook suspendCustomerNamed: aName].
	^ customerBook.! !

!CustomerBookTest methodsFor: 'TestingUtils' stamp: 'FR 9/20/2020 19:56:46'!
theBook: customerBook hasThisNumberOfActiveCustomers: active ThisNumberOfSuspended: suspended AndThisIsTheTotal: total
	self assert: ((customerBook numberOfActiveCustomers = active)and:(customerBook numberOfSuspendedCustomers = suspended)and:(customerBook numberOfCustomers = total)).
! !

!CustomerBookTest methodsFor: 'TestingUtils' stamp: 'FR 9/20/2020 20:04:13'!
theOperation: blockWithOperation takesLessThan: limit
	self assert: (Time millisecondsToRun: blockWithOperation)*millisecond < limit*millisecond.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBookTest class' category: #'CodigoRepetido-Ejercicio'!
CustomerBookTest class
	instanceVariableNames: 'milisegundosDeEjecucion customerBook paulMcCartney johnLennon'!


!classDefinition: #ClientRegister category: #'CodigoRepetido-Ejercicio'!
Object subclass: #ClientRegister
	instanceVariableNames: 'name state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!ClientRegister methodsFor: 'as yet unclassified' stamp: 'msm 9/19/2020 23:44:00'!
getName

	^name.! !

!ClientRegister methodsFor: 'as yet unclassified' stamp: 'msm 9/19/2020 23:44:36'!
getState

	^state.! !


!ClientRegister methodsFor: 'initialization' stamp: 'msm 9/19/2020 22:53:52'!
initialize: aName
	name := aName.
	state := 'activo'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ClientRegister class' category: #'CodigoRepetido-Ejercicio'!
ClientRegister class
	instanceVariableNames: ''!

!ClientRegister class methodsFor: 'as yet unclassified' stamp: 'msm 9/19/2020 22:54:12'!
new: aName

	^self new initialize: aName. ! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'msm 9/17/2020 21:33:35'!
includesCustomerNamed: aName

	"Se revisa la lista unica"

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'msm 9/19/2020 23:33:44'!
isEmpty
	customers isEmpty.! !


!CustomerBook methodsFor: 'initialization' stamp: 'msm 9/19/2020 23:32:21'!
initialize

	customers := RegisterList new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'msm 9/19/2020 23:14:36'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [self customerCanNotBeEmptyErrorMessage].
	(customers includes: aName) ifTrue: [self customerCanNotBeEmptyErrorMessage].
	
	customers add: aName! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'msm 9/17/2020 21:44:07'!
removeCustomerNamed: aName 
 	"lista unica borra codigo repetido "
	1 to: active size do: 
	[ :index |
		aName = (active at: index)"implementar mensaje dentro de la lista de registro de Clientes"
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

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


!classDefinition: #RegisterList category: #'CodigoRepetido-Ejercicio'!
Object subclass: #RegisterList
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!RegisterList methodsFor: 'setOperations' stamp: 'msm 9/19/2020 22:49:13'!
add: aName
	|customer|
	customer := ClientRegister new: aName.
	customers add: customer.
	! !

!RegisterList methodsFor: 'setOperations' stamp: 'msm 9/19/2020 23:05:59'!
includes: aName
	|exists|
	exists :=self select: [:customer | customer getName = aName] isEmpty.
	^exists.! !


!RegisterList methodsFor: 'initialization' stamp: 'msm 9/19/2020 23:03:00'!
initialize

	customers := OrderedCollection new.
	! !

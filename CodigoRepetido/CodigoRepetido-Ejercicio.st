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

!CustomerBookTest methodsFor: 'Testing' stamp: 'FR 9/20/2020 20:46:18'!
test03CanNotAddACustomerWithEmptyName
	| customerBook |
	customerBook _ CustomerBook new.
	
	"self testMessageErrorHandler: [customerBook addCustomerNamed: ''. self fail ] on: CustomerBook customerCanNotBeEmptyErrorMessage and: [ customerBook isEmpty ]."
	
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

!CustomerBookTest methodsFor: 'SignalHandlers' stamp: 'FR 9/20/2020 21:34:09'!
customerSignalHandler: aFirstBlock on: aSecondBlock and: aThirdBlock raced: aSignal
	
	aFirstBlock
		on: aSignal
		do: [ :anError |
			self assert: (aSecondBlock numArgs = 0 ifTrue: [aSecondBlock] ifFalse: [aSecondBlock value: anError]). "esto podemos ponerlo dentro de otro mensaje"
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

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

!CustomerBookTest methodsFor: 'testing' stamp: 'msm 9/19/2020 18:27:47'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook|
	customerBook := CustomerBook new.
	
	self assert: [self mensaje: [customerBook addCustomerNamed: 'John Lennon'.]  tardaMenosQue: 50].
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'msm 9/19/2020 20:15:17'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook|
	customerBook := self testCustomer: 'Paul McCartney' suspend: False.
	
	self assert: [self mensaje: [customerBook removeCustomerNamed: 'Paul McCartney']  tardaMenosQue: 100].
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'msm 9/19/2020 19:42:06'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
	customerBook := CustomerBook new.
	
	self testMessageErrorHandler: [ customerBook addCustomerNamed: ''. self fail ] on: (CustomerBook customerCanNotBeEmptyErrorMessage) and: [customerBook isEmpty].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'msm 9/19/2020 20:21:00'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
	johnLennon := 'John Lennon'.
	customerBook :=  self testCustomer: johnLennon suspend: False.

	self customerSignalHandler: [ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ] on: [customerBook numberOfCustomers = 1.] and: [(customerBook includesCustomerNamed: johnLennon)] raced: NotFound.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'msm 9/19/2020 20:14:52'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook :=  self testCustomer: paulMcCartney suspend: True.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 1 equals: customerBook numberOfSuspendedCustomers.
	self assert: 1 equals: customerBook numberOfCustomers.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'msm 9/19/2020 20:16:13'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook:= self testCustomer: paulMcCartney suspend: True.
	
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 0 equals: customerBook numberOfSuspendedCustomers.
	self assert: 0 equals: customerBook numberOfCustomers.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'msm 9/19/2020 20:25:04'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook :=  self testCustomer: johnLennon suspend: False.

	self customerSignalHandler: [ customerBook suspendCustomerNamed: 'George Harrison'. self fail ] on: [customerBook numberOfCustomers = 1] and: [ (customerBook includesCustomerNamed: johnLennon)] raced: CantSuspend

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 9/19/2018 17:57:11'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: johnLennon.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!CustomerBookTest methodsFor: 'SignalHandlers' stamp: 'msm 9/19/2020 20:20:25'!
customerSignalHandler: aFirstBlock on: aSecondBlock and: aThirdBlock raced: aSignal

	aFirstBlock
		on: aSignal
		do: [ :anError | 
			self assert: aSecondBlock.
			self assert: aThirdBlock]! !

!CustomerBookTest methodsFor: 'SignalHandlers' stamp: 'msm 9/19/2020 19:40:51'!
testMessageErrorHandler: aFirstBlock on: aSecondBlock and: aThirdBlock

	aFirstBlock
		on: Error
		do: [ :anError | 
			self assert: (anError messageText = aSecondBlock).
			self assert: aThirdBlock].
! !


!CustomerBookTest methodsFor: 'TimeMeasurement' stamp: 'msm 9/19/2020 17:37:34'!
compareTime: aTimeStampFirst with: aTimeStampSecond
	
	^aTimeStampFirst < (aTimeStampSecond * millisecond).

	
	
	! !

!CustomerBookTest methodsFor: 'TimeMeasurement' stamp: 'msm 9/19/2020 18:23:37'!
mensaje: aBlock tardaMenosQue: aTimeStamp
	  |miliegundosDeEjecucion|
	
	miliegundosDeEjecucion := Time millisecondsToRun: aBlock.
	^self compareTime: miliegundosDeEjecucion with: aTimeStamp.! !


!CustomerBookTest methodsFor: 'helpers' stamp: 'msm 9/19/2020 20:15:38'!
testCustomer:aName	 suspend: decision
	|Book|
	Book := CustomerBook new.
	Book addCustomerNamed: aName.
	decision = True ifTrue: [Book suspendCustomerNamed: aName].
	^Book! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBookTest class' category: #'CodigoRepetido-Ejercicio'!
CustomerBookTest class
	instanceVariableNames: 'milisegundosDeEjecucion customerBook paulMcCartney johnLennon'!


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'msm 9/17/2020 21:33:35'!
includesCustomerNamed: aName

	"Se revisa la lista unica"

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'msm 9/17/2020 21:33:27'!
isEmpty
	"Se revisa la lista unica"
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'msm 9/17/2020 21:40:21'!
initialize
	"reemplazar por un objeto listaDeRegistro, la cual va a poseer un dictionario de nombre de cliente a estado y 3 contadores"
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'msm 9/17/2020 21:32:56'!
addCustomerNamed: aName
	"
	1-se reemplaza el or con la unica busqueda en la lista de estados
	
	"
	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

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

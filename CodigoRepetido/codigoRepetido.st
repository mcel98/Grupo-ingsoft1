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

!CustomerBookTest methodsFor: 'testing'!
! !

!CustomerBookTest methodsFor: 'testing'!
! !

!CustomerBookTest methodsFor: 'testing'!
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'msm 9/19/2020 21:52:31'!
test04CanNotRemoveAnInvalidCustomer
	| customerBook johnLennon |
	johnLennon _ 'John Lennon'.
	customerBook _ self
		testCustomer: johnLennon
		suspend: False.
	self
		customerNotFoundHandler: customerBook customerNamed: johnLennon



		! !

!CustomerBookTest methodsFor: 'testing'!
! !

!CustomerBookTest methodsFor: 'testing'!
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'msm 9/19/2020 21:50:09'!
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

!CustomerBookTest methodsFor: 'testing' stamp: 'msm 9/19/2020 21:47:21'!
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

!CustomerBookTest methodsFor: 'SignalHandlers'!
! !


!CustomerBookTest methodsFor: 'TimeMeasurement' stamp: 'msm 9/19/2020 21:49:55'!
customerCantSuspendHandler: customerBook 
		realCustomerNamed: johnLennon 
		testCustomerNamed: 'George Harrison'. 
! !

!CustomerBookTest methodsFor: 'TimeMeasurement'!
! !


!CustomerBookTest methodsFor: 'helpers'!
! !

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

!ClientRegister methodsFor: 'as yet unclassified' stamp: 'msm 9/19/2020 22:18:30'!
adores"
	active := OrderedCollection new.
	suspended:= OrderedCollection new.
	customers := RegisterList new.! !

!ClientRegister methodsFor: 'as yet unclassified' stamp: 'msm 9/19/2020 22:18:30'!
sterList new.! !


!ClientRegister methodsFor: 'initialization' stamp: 'msm 9/19/2020 22:18:30'!
initialize
	"reemplazar por un objeto listaDeRegistro, la cual va a poseer un dictionario de nombre de cliente a estado y 3 contadores"
	active := OrderedCollection new.
	suspended:= OrderedCollection new.
	customers := RegisterList new.! !


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

!CustomerBook methodsFor: 'testing' stamp: 'msm 9/19/2020 22:19:26'!
isEmpty
	"Se revisa la lista unica"
	
	^customers isEmpty.! !


!CustomerBook methodsFor: 'initialization' stamp: 'msm 9/19/2020 22:18:30'!
initialize
	"reemplazar por un objeto listaDeRegistro, la cual va a poseer un dictionario de nombre de cliente a estado y 3 contadores"
	active := OrderedCollection new.
	suspended:= OrderedCollection new.
	customers := RegisterList new.! !


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


!classDefinition: #RegisterList category: #'CodigoRepetido-Ejercicio'!
Object subclass: #RegisterList
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!RegisterList methodsFor: 'as yet unclassified' stamp: 'msm 9/19/2020 22:03:03'!
initialize

	"customers := OrderedCollection new."
	! !

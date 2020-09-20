'From Cuis 5.0 [latest update: #4365] on 19 September 2020 at 10:33:14 pm'!
!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: 'messageText'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'msm 9/19/2020 22:32:21'!
onaries: ''
	category: 'CodigoRepetido-Ejercicio'! !

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
rBook methodsFor: 'customer management' stamp: 'msm 9/19/2020 22:26:21' prior: 50863990! !


!CustomerBookTest methodsFor: 'helpers'!
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBookTest class' category: #'CodigoRepetido-Ejercicio'!
CustomerBookTest class
	instanceVariableNames: 'milisegundosDeEjecucion customerBook paulMcCartney johnLennon'!

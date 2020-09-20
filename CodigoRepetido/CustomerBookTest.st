'From Cuis 5.0 [latest update: #4365] on 20 September 2020 at 3:02:08 pm'!
!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: 'messageText'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'msm 9/19/2020 23:01:03'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	|customerBook|
	customerBook := CustomerBook new.
	
	self assert: [
		self
			mensaje: [ customerBook addCustomerNamed: 'Paul McCartney'.]
			tardaMenosQue: 50 ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'msm 9/20/2020 15:00:25'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	| customerBook |
	customerBook _ self
		testCustomer: 'Paul McCartney'
		suspend: False.
	self assert: [
		self
			mensaje: [ customerBook removeCustomerNamed: 'Paul McCartney' ]
			tardaMenosQue: 100 ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'msm 9/20/2020 15:01:02'!
test03CanNotAddACustomerWithEmptyName
	| customerBook |
	customerBook _ CustomerBook new.
	self
		testMessageErrorHandler: [
			customerBook addCustomerNamed: ''.
			self fail ]
		on: CustomerBook customerCanNotBeEmptyErrorMessage
		and: [ customerBook isEmpty ].! !

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

!CustomerBookTest methodsFor: 'testing' stamp: 'msm 9/20/2020 14:52:03'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook
	| customerBook paulMcCartney |
	paulMcCartney _ 'Paul McCartney'.
	customerBook _ self
		testCustomer: paulMcCartney
		suspend: True.
	self
		assert: 0
		equals: customerBook numberOfActiveCustomers.
	self
		assert: 1
		equals: customerBook numberOfSuspendedCustomers.
	self
		assert: 1
		equals: customerBook numberOfCustomers.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'msm 9/20/2020 14:53:00'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook
	| customerBook paulMcCartney |
	paulMcCartney _ 'Paul McCartney'.
	customerBook _ self
		testCustomer: paulMcCartney
		suspend: True.
	customerBook removeCustomerNamed: paulMcCartney.
	self
		assert: 0
		equals: customerBook numberOfActiveCustomers.
	self
		assert: 0
		equals: customerBook numberOfSuspendedCustomers.
	self
		assert: 0
		equals: customerBook numberOfCustomers.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).! !

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

!CustomerBookTest methodsFor: 'SignalHandlers' stamp: 'msm 9/20/2020 14:54:08'!
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


!CustomerBookTest methodsFor: 'helpers' stamp: 'msm 9/20/2020 14:55:25'!
testCustomer: aName suspend: aDecision
	| customerBook |
	customerBook _ CustomerBook new.
	customerBook addCustomerNamed: aName.
	aDecision = True ifTrue: [ customerBook suspendCustomerNamed: aName ].
	^ aDecision.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBookTest class' category: #'CodigoRepetido-Ejercicio'!
CustomerBookTest class
	instanceVariableNames: 'milisegundosDeEjecucion customerBook paulMcCartney johnLennon'!

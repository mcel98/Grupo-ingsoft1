'From Cuis 5.0 [latest update: #4365] on 20 September 2020 at 11:10:40 pm'!
!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'msm 9/20/2020 18:12:23'!
includesCustomerNamed: aName

	"Se revisa la lista unica"

	^customers includes: aName.! !

!CustomerBook methodsFor: 'testing' stamp: 'msm 9/20/2020 22:07:45'!
isEmpty

	^customers isEmpty.! !


!CustomerBook methodsFor: 'initialization' stamp: 'msm 9/19/2020 23:32:21'!
initialize

	customers := RegisterList new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'msm 9/20/2020 22:25:52'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [self signalCustomerNameCannotBeEmpty].
	(customers includes: aName) ifTrue: [self signalCustomerAlreadyExists ].
	
	customers add: aName.! !

!CustomerBook methodsFor: 'customer management' stamp: 'msm 9/20/2020 18:12:51'!
numberOfActiveCustomers
	
	^customers activeSize.! !

!CustomerBook methodsFor: 'customer management' stamp: 'msm 9/20/2020 18:13:05'!
numberOfCustomers
	
	^ customers size.! !

!CustomerBook methodsFor: 'customer management' stamp: 'msm 9/20/2020 18:13:30'!
numberOfSuspendedCustomers
	
	^customers suspendedSize.! !

!CustomerBook methodsFor: 'customer management' stamp: 'msm 9/20/2020 22:31:42'!
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

!CustomerBook methodsFor: 'customer management' stamp: 'msm 9/20/2020 20:56:33'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage.! !

!CustomerBook methodsFor: 'customer management' stamp: 'msm 9/20/2020 20:56:27'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage.! !

!CustomerBook methodsFor: 'customer management' stamp: 'msm 9/20/2020 18:25:43'!
suspendCustomerNamed: aName 
	
	(customers isActive: aName) ifFalse: [^CantSuspend signal].
	
	customers suspend: aName.
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: 'customers aName'!

!CustomerBook class methodsFor: 'error messages' stamp: 'msm 9/20/2020 19:28:10'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!'.! !

!CustomerBook class methodsFor: 'error messages' stamp: 'msm 9/20/2020 19:31:26'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!'.! !

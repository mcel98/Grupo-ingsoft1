'From Cuis 5.0 [latest update: #4365] on 24 September 2020 at 5:34:36 am'!
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

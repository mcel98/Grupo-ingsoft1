'From Cuis 5.0 [latest update: #4365] on 20 September 2020 at 11:21:54 pm'!
!classDefinition: #RegisterList category: #'CodigoRepetido-Ejercicio'!
Object subclass: #RegisterList
	instanceVariableNames: 'customers suspendedCounter activeCounter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!RegisterList methodsFor: 'setOperations' stamp: 'msm 9/20/2020 18:05:29'!
add: aName
	|customer|
	customer := ClientRegister new: aName.
	customers add: customer.
	activeCounter := activeCounter + 1.
	! !

!RegisterList methodsFor: 'setOperations' stamp: 'msm 9/20/2020 20:49:52'!
includes: aName
	|exists|
	exists := customers select: [:customer | (customer getName) = aName].
	^(exists isEmpty) not.! !

!RegisterList methodsFor: 'setOperations' stamp: 'msm 9/20/2020 22:44:27'!
removeAt: anIndex

	(customers at: anIndex) = 'activo' ifTrue: [activeCounter := self activeSize - 1] ifFalse: [suspendedCounter := self suspendedSize - 1.].

	customers removeAt: anIndex.! !


!RegisterList methodsFor: 'initialization' stamp: 'msm 9/20/2020 18:04:57'!
initialize

	customers := OrderedCollection new.
	suspendedCounter := 0.
	activeCounter := 0.
	! !


!RegisterList methodsFor: 'information' stamp: 'msm 9/20/2020 18:10:38'!
activeSize

	^activeCounter.! !

!RegisterList methodsFor: 'information' stamp: 'msm 9/20/2020 23:08:54'!
getCustomer: aName

	^ customers detect: [:aCustomer | aName = (aCustomer getName)] ifNone: ['customer not found'].! !

!RegisterList methodsFor: 'information' stamp: 'msm 9/20/2020 22:32:15'!
hasName: aName atIndex: anIndex

	^aName = ((customers at: anIndex) getName).! !

!RegisterList methodsFor: 'information' stamp: 'msm 9/20/2020 23:08:25'!
isActive: aName
	
	|state client|
	client := self getCustomer: aName.
	state := client = 'customer not found' ifTrue: [ 'sin estado'] ifFalse: [client getState].
	^state = 'activo'.! !

!RegisterList methodsFor: 'information' stamp: 'msm 9/20/2020 22:02:32'!
isEmpty

	^customers isEmpty.! !

!RegisterList methodsFor: 'information' stamp: 'msm 9/20/2020 18:11:58'!
size
	^customers size.! !

!RegisterList methodsFor: 'information' stamp: 'msm 9/20/2020 18:11:21'!
suspendedSize
	
	^suspendedCounter.! !


!RegisterList methodsFor: 'as yet unclassified' stamp: 'msm 9/20/2020 20:45:04'!
suspend: aName

	|index|

 	index := customers findFirst: [:a | a getName = aName].
	
	(customers at: index) changeState.
	
	(customers at: index) = 'activo' ifTrue: [suspendedCounter := self suspendedSize - 1. activeCounter := self activeSize + 1] ifFalse: [suspendedCounter := self suspendedSize + 1. activeCounter := self activeSize - 1].
	! !

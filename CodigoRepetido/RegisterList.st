'From Cuis 5.0 [latest update: #4365] on 20 September 2020 at 3:06:12 pm'!
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

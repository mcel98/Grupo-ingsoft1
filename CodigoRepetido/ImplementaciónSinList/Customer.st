'From Cuis 5.0 [latest update: #4365] on 24 September 2020 at 5:34:42 am'!
!classDefinition: #Customer category: #'CodigoRepetido-Ejercicio'!
Object subclass: #Customer
	instanceVariableNames: 'name state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!Customer methodsFor: 'Operations' stamp: 'fr 9/24/2020 05:14:02'!
name
	^name.! !

!Customer methodsFor: 'Operations' stamp: 'fr 9/24/2020 05:14:10'!
state
	^state.! !

!Customer methodsFor: 'Operations' stamp: 'fr 9/24/2020 05:14:27'!
suspend
	state _ 'suspended'.! !


!Customer methodsFor: 'Initialization' stamp: 'fr 9/24/2020 05:16:24'!
initialize: customerName
	name _ customerName.
	state _ 'active'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: #'CodigoRepetido-Ejercicio'!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'as yet unclassified' stamp: 'fr 9/24/2020 05:15:41'!
new: customerName
	^self new initialize: customerName.! !

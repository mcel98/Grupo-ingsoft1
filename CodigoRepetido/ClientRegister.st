'From Cuis 5.0 [latest update: #4365] on 20 September 2020 at 3:06:17 pm'!
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

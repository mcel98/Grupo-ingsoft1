!classDefinition: #I category: #NumerosDePeano!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #NumerosDePeano!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'operaciones' stamp: 'FR 9/16/2020 18:36:34'!
* unNumero
	^unNumero == I ifTrue: [self] ifFalse: [self + (self*(unNumero previous))]. ! !

!I class methodsFor: 'operaciones' stamp: 'FR 9/17/2020 12:57:21'!
+ unNumero
	^unNumero next.! !

!I class methodsFor: 'operaciones' stamp: 'FR 9/17/2020 13:26:55'!
- unNumero
	^self error:'ElResultadoNoPuedeSerRepresentadoEnLosNaturales'.! !

!I class methodsFor: 'operaciones' stamp: 'FR 9/17/2020 13:18:05'!
/ unNumero
	self printString < unNumero printString ifTrue: [self error:'DivisorMuyGrandeParaDividendo'].	
	^unNumero == self ifTrue: [I] ifFalse: [ I + ((self-unNumero)/unNumero) ]. ! !

!I class methodsFor: 'operaciones' stamp: 'FR 9/14/2020 21:50:20'!
next
	^self createChildNamed: self name,'I'.! !


!classDefinition: #II category: #NumerosDePeano!
I subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #NumerosDePeano!
II class
	instanceVariableNames: ''!

!II class methodsFor: 'operaciones' stamp: 'FR 9/16/2020 18:34:07'!
+ unNumero
	^(self previous + unNumero) next. ! !

!II class methodsFor: 'operaciones' stamp: 'FR 9/17/2020 13:26:44'!
- unNumero
	^unNumero == I ifTrue: [self previous] ifFalse: [self previous - unNumero previous ].! !

!II class methodsFor: 'operaciones' stamp: 'FR 9/14/2020 21:53:27'!
previous
	^self parent.! !


!classDefinition: #III category: #NumerosDePeano!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!


!classDefinition: #IIII category: #NumerosDePeano!
III subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!


!classDefinition: #TestsDeVerificacion category: #NumerosDePeano!
DenotativeObject subclass: #TestsDeVerificacion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestsDeVerificacion class' category: #NumerosDePeano!
TestsDeVerificacion class
	instanceVariableNames: ''!

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 12:51:26'!
test01UnoMasUnSumandoEsElProximoDelSumando

	Assert that: I + II isEqualTo: II next.! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'FR 9/17/2020 13:12:17'!
test02NumerosMayoresaUnoSumanBien

	Assert that: II + II isEqualTo: IIII.
! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:12:19'!
test03UnNumeroMenosUnoEsElPrevioDelNumero

	Assert that: II - I isEqualTo: II previous.! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'FR 9/17/2020 13:13:04'!
test04NumerosMayoresaUnoRestanBien

	Assert that: IIII - II isEqualTo: II.
! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'FR 9/17/2020 13:24:47'!
test05RestaNoSoportaNumerosNegativos

	Assert should: [ I - II ] signal: Error withDescription: 'ElResultadoNoPuedeSerRepresentadoEnLosNaturales'.
! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:15:53'!
test06UnNumeroMultiplicadoPorUnoEsIgualAlNumero

	Assert that: II * I isEqualTo: II.! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'FR 9/17/2020 13:12:53'!
test07NumerosMayoresaUnoMultiplicanBien

	Assert that: II * II isEqualTo: IIII.! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:16:46'!
test08UnoMultiplicadoUnoEsIgualAUno

	Assert that: I * I isEqualTo: I.! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'FR 9/17/2020 13:10:50'!
test09NumerosMayoresaUnoDividenBien

	Assert that: IIII / II isEqualTo: II.
! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:17:28'!
test10UnNumeroDivididoUnoEsIgualAlNumero

	Assert that: II / I isEqualTo: II.! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:17:38'!
test11UnoDivididoUnoEsIgualAUno

	Assert that: I / I isEqualTo: I.! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'FR 9/17/2020 13:24:23'!
test12DivisionNoSoportaDividirPorUnNumeroMayor

	Assert should: [ III /  IIII ] signal: Error withDescription: 'DivisorMuyGrandeParaDividendo'.
	
	Assert should: [ I /  II] signal: Error withDescription: 'DivisorMuyGrandeParaDividendo'.
! !

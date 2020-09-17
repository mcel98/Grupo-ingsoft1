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

!I class methodsFor: 'operaciones' stamp: 'FR 9/17/2020 17:22:17'!
- unNumero
	^self error:'ElResultadoNoPuedeSerRepresentadoEnLosNaturales'.! !

!I class methodsFor: 'operaciones' stamp: 'FR 9/17/2020 17:23:04'!
/ unNumero
	self printString < unNumero printString ifTrue: [self error:'ErrorDeDivisionNoDivisibleODivisorMuyGrande'].	
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


!classDefinition: #IIIII category: #NumerosDePeano!
IIII subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!


!classDefinition: #IIIIII category: #NumerosDePeano!
IIIII subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!


!classDefinition: #IIIIIII category: #NumerosDePeano!
IIIIII subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!


!classDefinition: #IIIIIIII category: #NumerosDePeano!
IIIIIII subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!


!classDefinition: #IIIIIIIII category: #NumerosDePeano!
IIIIIIII subclass: #IIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!


!classDefinition: #IIIIIIIIII category: #NumerosDePeano!
IIIIIIIII subclass: #IIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!


!classDefinition: #IIIIIIIIIII category: #NumerosDePeano!
IIIIIIIIII subclass: #IIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!


!classDefinition: #IIIIIIIIIIII category: #NumerosDePeano!
IIIIIIIIIII subclass: #IIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!


!classDefinition: #IIIIIIIIIIIII category: #NumerosDePeano!
IIIIIIIIIIII subclass: #IIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!


!classDefinition: #IIIIIIIIIIIIII category: #NumerosDePeano!
IIIIIIIIIIIII subclass: #IIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!


!classDefinition: #IIIIIIIIIIIIIII category: #NumerosDePeano!
IIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!


!classDefinition: #IIIIIIIIIIIIIIII category: #NumerosDePeano!
IIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!


!classDefinition: #IIIIIIIIIIIIIIIII category: #NumerosDePeano!
IIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!


!classDefinition: #IIIIIIIIIIIIIIIIII category: #NumerosDePeano!
IIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!


!classDefinition: #IIIIIIIIIIIIIIIIIII category: #NumerosDePeano!
IIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!


!classDefinition: #IIIIIIIIIIIIIIIIIIII category: #NumerosDePeano!
IIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIII category: #NumerosDePeano!
IIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIII category: #NumerosDePeano!
IIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIII category: #NumerosDePeano!
IIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIII category: #NumerosDePeano!
IIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!


!classDefinition: #NumerosDePeanoTest category: #NumerosDePeano!
DenotativeObject subclass: #NumerosDePeanoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NumerosDePeanoTest class' category: #NumerosDePeano!
NumerosDePeanoTest class
	instanceVariableNames: ''!

!NumerosDePeanoTest class methodsFor: 'Tests' stamp: 'MSM 9/16/2020 18:47:26'!
test01SiguienteIESII

	^Assert that: I next isEqualTo: II.
	! !

!NumerosDePeanoTest class methodsFor: 'Tests' stamp: 'MSM 9/16/2020 19:01:47'!
test02SiguienteIIESIII

	^Assert that: II next isEqualTo: III.! !

!NumerosDePeanoTest class methodsFor: 'Tests' stamp: 'MSM 9/17/2020 14:00:41'!
test03PreviousIIEsI

	^Assert that: II previous isEqualTo: I.! !

!NumerosDePeanoTest class methodsFor: 'Tests' stamp: 'MSM 9/15/2020 18:00:53'!
test04OrdenDeSuma

	Assert that: I + II isEqualTo: II + I.! !

!NumerosDePeanoTest class methodsFor: 'Tests' stamp: 'MSM 9/15/2020 18:03:08'!
test05SumaIMasIESII

	^Assert that: I + I isEqualTo: II! !

!NumerosDePeanoTest class methodsFor: 'Tests' stamp: 'MSM 9/16/2020 19:14:41'!
test06SumaIIIMasIIIII

	^Assert that: III + IIIII isEqualTo: IIIIIIII! !

!NumerosDePeanoTest class methodsFor: 'Tests' stamp: 'MSM 9/15/2020 18:10:22'!
test07SumaConmutativa

	^Assert that: I + II isEqualTo: II + I.! !

!NumerosDePeanoTest class methodsFor: 'Tests' stamp: 'MSM 9/15/2020 18:12:35'!
test08SumaAsociativa

	^Assert that: (I + II) + III isEqualTo: I + (II + III). ! !

!NumerosDePeanoTest class methodsFor: 'Tests' stamp: 'MSM 9/16/2020 18:47:57'!
test09ProductoIxI

	^Assert that: I * I isEqualTo: I! !

!NumerosDePeanoTest class methodsFor: 'Tests' stamp: 'MSM 9/16/2020 19:13:57'!
test10ProductoIxII

	^Assert that: I * II isEqualTo: II! !

!NumerosDePeanoTest class methodsFor: 'Tests' stamp: 'MSM 9/16/2020 19:17:37'!
test11ProductoIIxII

	^Assert that: II * II isEqualTo: IIII.! !

!NumerosDePeanoTest class methodsFor: 'Tests' stamp: 'MSM 9/16/2020 19:15:34'!
test12OrdenDeProducto

	^Assert that: I * II isEqualTo: II * I! !

!NumerosDePeanoTest class methodsFor: 'Tests' stamp: 'MSM 9/16/2020 19:18:34'!
test13ProductoDistributiva

	^Assert that: II * (I + I) isEqualTo: (II * I) + (II * I).! !

!NumerosDePeanoTest class methodsFor: 'Tests' stamp: 'MSM 9/16/2020 19:19:19'!
test14ProductoConmutativa

	^Assert that: II * III * IIII isEqualTo: III * IIII * II! !

!NumerosDePeanoTest class methodsFor: 'Tests' stamp: 'MSM 9/16/2020 19:21:48'!
test15ProductoAsociativa

	^Assert that: (II * II) * III isEqualTo: (II * III) * II.! !

!NumerosDePeanoTest class methodsFor: 'Tests' stamp: 'MSM 9/16/2020 19:22:02'!
test16DivisionPorI

	^Assert that: II / I isEqualTo: II! !

!NumerosDePeanoTest class methodsFor: 'Tests' stamp: 'MSM 9/16/2020 19:25:58'!
test17DivisionIIIIPorII

	^Assert that: IIII / II isEqualTo: II! !

!NumerosDePeanoTest class methodsFor: 'Tests' stamp: 'MSM 9/16/2020 19:29:16'!
test18DivisionIIIPorII

		^Assert signalFailure: III / II.

! !


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

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'FR 9/17/2020 17:24:43'!
test12DivisionNoSoportaDividirPorUnNumeroMayor

	Assert should: [ III /  IIII ] signal: Error withDescription: 'ErrorDeDivisionNoDivisibleODivisorMuyGrande'.
	
	Assert should: [ I /  II] signal: Error withDescription: 'ErrorDeDivisionNoDivisibleODivisorMuyGrande'.
! !

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


!I class methodsFor: 'Operaciones'!
! !

!I class methodsFor: 'Operaciones'!
! !


!I class methodsFor: 'operaciones'!
! !


!I class methodsFor: 'as yet unclassified'!
! !

!I class methodsFor: 'as yet unclassified'!
! !


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

!II class methodsFor: 'Operaciones'!
! !



!II class methodsFor: 'operaciones'!
! !


!II class methodsFor: 'as yet unclassified'!
! !


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

!NumerosDePeanoTest class methodsFor: 'Tests' stamp: 'MSM 9/16/2020 19:02:14'!
test03PreviousIIEsI

	^Assert that: II previous isEqualTo: II.! !

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


!NumerosDePeanoTest class methodsFor: 'as yet unclassified'!
! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified'!
! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified'!
! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified'!
! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified'!
! !

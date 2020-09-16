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

!I class methodsFor: 'operaciones' stamp: 'FR 9/14/2020 21:50:20'!
next
	^self createChildNamed: self name,'I'.! !


!I class methodsFor: 'as yet unclassified' stamp: 'FR 9/16/2020 18:36:34'!
* unNumero
	^unNumero == I ifTrue: [self] ifFalse: [self + (self*(unNumero previous))]. ! !

!I class methodsFor: 'as yet unclassified' stamp: 'FR 9/16/2020 19:01:41'!
+ unNumero
	^self next.! !

!I class methodsFor: 'as yet unclassified' stamp: 'FR 9/16/2020 18:59:26'!
/ unNumero
	^unNumero == self ifTrue: [I] ifFalse: [ I + (self-unNumero/unNumero) ]. ! !

!I class methodsFor: 'as yet unclassified' stamp: 'FR 9/14/2020 21:22:16'!
previous
	^self.! !


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

!II class methodsFor: 'operaciones' stamp: 'FR 9/14/2020 21:53:27'!
previous
	^self parent.! !


!II class methodsFor: 'as yet unclassified' stamp: 'FR 9/16/2020 18:34:07'!
+ unNumero
	^(self previous + unNumero) next. ! !

!II class methodsFor: 'as yet unclassified' stamp: 'FR 9/16/2020 18:05:41'!
- unNumero
	^unNumero == I ifTrue: [self previous] ifFalse: [self previous - unNumero previous ].! !


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

!NumerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'FR 9/14/2020 20:46:17'!
test01NextDeUnoEsDos
	Assert that: I next isEqualTo: II.! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'FR 9/14/2020 20:48:23'!
test02NextDeDosEsTres
	Assert that: II next isEqualTo: III.! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'FR 9/14/2020 20:53:16'!
test03SumaDeUnoYUnoEsElSiguienteDeUno
	Assert that: I+I isEqualTo: I next.! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'FR 9/14/2020 21:41:29'!
test04SumaDeUnoMasUnNumero
	|unNumero|
	unNumero := III.
	Assert that: I+unNumero isEqualTo: unNumero next.! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'FR 9/14/2020 21:31:29'!
test05SumaDefinirTitulo
	Assert that: II+III isEqualTo: IIIII.! !

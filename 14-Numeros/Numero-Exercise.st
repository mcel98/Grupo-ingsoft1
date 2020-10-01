!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 5/7/2020 17:46:14'!
test27EnteroSubstractsEnteroCorrectly

	self assert: three - one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !


!Numero methodsFor: 'arithmetic operations - private' stamp: 'fr 9/28/2020 20:31:08'!
dividirUnEntero: unaFraccion

	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations - private' stamp: 'fr 9/28/2020 20:31:01'!
dividirUnaFraccion: unaFraccion

	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations - private' stamp: 'fr 9/28/2020 20:30:46'!
multiplicarUnEntero: unaFraccion

	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations - private' stamp: 'fr 9/28/2020 20:30:39'!
multiplicarUnaFraccion: unaFraccion

	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations - private' stamp: 'fr 9/28/2020 21:47:00'!
sumarUnEntero: unEntero

	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations - private' stamp: 'fr 9/28/2020 20:30:21'!
sumarUnaFraccion: unaFraccion

	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 9/24/2020 17:28:15'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 9/24/2020 04:33:41'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de n�mero inv�lido!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'fr 9/28/2020 20:03:22'!
* aMultiplier 
	
	^aMultiplier multiplicarPorUnEntero: self.
	
	"Version con if: ^aMultiplier class = Fraccion ifTrue: [aMultiplier * self] ifFalse: [^self class with: value * aMultiplier integerValue]."
	
	"Original: ^self class with: value * aMultiplier integerValue"
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'fr 9/28/2020 16:19:05'!
+ anAdder 
	
	^anAdder sumarEntero: self.
	
	"Version con if: ^anAdder class = Fraccion ifTrue: [anAdder + self] ifFalse: [self class with: value + anAdder integerValue]. "
		
	"Original: ^self class with: value + anAdder integerValue"
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'fr 10/1/2020 12:44:41'!
- aSubtrahend 
	
	^aSubtrahend restarEntero: self

	"Version usando suma: ^self + aSubtrahend negated"
	
	"Original: ^ self class with: value - aSubtrahend integerValue."! !

!Entero methodsFor: 'arithmetic operations' stamp: 'fr 9/28/2020 20:22:01'!
/ aDivisor 

	^aDivisor dividoUnEntero: self.


	"Version con if: ^aDivisor class = Fraccion ifTrue: [Fraccion with: (self*aDivisor denominator) over: aDivisor numerator] ifFalse: [Fraccion with: self over: aDivisor]. "
	
	
	"Agregar mensaje auxiliar que sea meDividoEntre:unNumero y se llama aDivisor meDividoEntre: self. Tiene que estar en ambas subclases para aprovechar el polimorfismo."
	"Original: ^Fraccion with: self over: aDivisor"! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'fr 9/28/2020 20:43:40'!
fibonacci
	
	^self subclassResponsibility
	
	"| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	self isNegative ifTrue: [self error: Entero negativeFibonacciErrorDescription ].	
	(self isZero or: [self isOne]) ifTrue: [^one].
	
	^ (self - one) fibonacci + (self - two) fibonacci"
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'fr 9/30/2020 17:20:21'!
initializeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'NR 9/23/2018 22:17:55'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !


!Entero methodsFor: 'arithmetic operations - private' stamp: 'fr 9/28/2020 20:23:15'!
dividoUnEntero: unEntero

	^Fraccion with: unEntero over: self! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'fr 9/28/2020 20:28:21'!
dividoUnaFraccion: unaFraccion

	^(unaFraccion numerator) / (unaFraccion denominator * self)! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'fr 9/28/2020 20:00:32'!
multiplicarPorUnEntero: aMultiplier

	^self class with: value * aMultiplier integerValue! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'fr 9/28/2020 20:19:55'!
multiplicarPorUnaFraccion: aMultiplier

	^(aMultiplier numerator * self) / (aMultiplier denominator)! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'fr 10/1/2020 12:48:56'!
restarEntero: aSubtrahend

	^self class with: aSubtrahend integerValue - value! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'fr 10/1/2020 12:54:27'!
restarFraccion: aSubtrahend

	^aSubtrahend numerator - (self * aSubtrahend denominator) / aSubtrahend denominator.! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'fr 9/28/2020 20:05:21'!
sumarEntero: anAdder

	^self class with: value + anAdder integerValue! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'fr 9/28/2020 20:05:25'!
sumarFraccion: anAdder

	^((self * anAdder denominator) + anAdder numerator) / anAdder denominator
	! !


!Entero methodsFor: 'fraction role checks - private' stamp: 'fr 9/30/2020 19:15:20'!
asDenominatorOf: aNumerator
	^self subclassResponsibility ! !

!Entero methodsFor: 'fraction role checks - private' stamp: 'fr 9/30/2020 19:15:26'!
asNumeratorOf: aNumerator
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'fr 9/30/2020 17:37:58'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	aValue == 0 ifTrue: [^Cero new initializeWith: aValue].
	aValue == 1 ifTrue: [^Uno new initializeWith: aValue].
	aValue < 0 ifTrue: [^Negativos new initializeWith: aValue].
	aValue > 1 ifTrue: [^MayoresAUno new initializeWith: aValue].
	! !


!Entero class methodsFor: 'error' stamp: 'fr 9/30/2020 17:36:08'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no est� definido aqu� para Enteros Negativos'! !


!classDefinition: #Cero category: 'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'Fraction role checks - private' stamp: 'fr 9/30/2020 19:24:42'!
asDenominatorOf: aNumerator
	^self error: Fraccion canNotDivideByZeroErrorDescription! !

!Cero methodsFor: 'Fraction role checks - private' stamp: 'fr 9/30/2020 19:16:36'!
asNumeratorOf: aNumerator
	^self.! !


!Cero methodsFor: 'Operations' stamp: 'fr 9/30/2020 17:28:53'!
fibonacci
	^Entero with: 1! !


!classDefinition: #MayoresAUno category: 'Numero-Exercise'!
Entero subclass: #MayoresAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!MayoresAUno methodsFor: 'Fraction role checks - private' stamp: 'fr 9/30/2020 19:17:07'!
asDenominatorOf: aNumerator
	^aNumerator asNumeratorOf: self! !

!MayoresAUno methodsFor: 'Fraction role checks - private' stamp: 'fr 9/30/2020 19:24:46'!
asNumeratorOf: aDenominator
	^Fraccion new initializeWith: self over: aDenominator ! !


!MayoresAUno methodsFor: 'Operations' stamp: 'fr 9/30/2020 17:28:45'!
fibonacci
	|one two|
	one _ Entero with: 1.
	two _ Entero with: 2.
	^(self - one) fibonacci + (self - two) fibonacci! !


!classDefinition: #Negativos category: 'Numero-Exercise'!
Entero subclass: #Negativos
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Negativos methodsFor: 'Fraction role checks - private' stamp: 'fr 9/30/2020 19:21:41'!
asDenominatorOf: aNumerator
	^aNumerator negated asNumeratorOf: self negated! !

!Negativos methodsFor: 'Fraction role checks - private' stamp: 'fr 9/30/2020 19:24:52'!
asNumeratorOf: aDenominator
	^Fraccion new initializeWith: self over: aDenominator ! !


!Negativos methodsFor: 'Operations' stamp: 'fr 9/30/2020 17:36:46'!
fibonacci
	^self error: Negativos negativeFibonacciErrorDescription! !


!classDefinition: #Uno category: 'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'Fraction role checks - private' stamp: 'fr 9/30/2020 19:22:40'!
asDenominatorOf: aNumerator
	^aNumerator! !

!Uno methodsFor: 'Fraction role checks - private' stamp: 'fr 9/30/2020 19:24:58'!
asNumeratorOf: aDenominator
	^Fraccion new initializeWith: self over: aDenominator. ! !


!Uno methodsFor: 'Operations' stamp: 'fr 9/30/2020 17:29:09'!
fibonacci
	^self! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'fr 9/28/2020 17:04:40'!
* aMultiplier 
	
	^aMultiplier multiplicarPorUnaFraccion: self.
	
	"Version con if: ^aMultiplier class = Entero ifTrue: [(numerator * aMultiplier)/denominator ] ifFalse: [(numerator * aMultiplier numerator) / (denominator * aMultiplier denominator)]."
	
	"Original: ^(numerator * aMultiplier numerator) / (denominator * aMultiplier denominator)"
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'fr 9/28/2020 16:23:24'!
+ anAdder 
	
	^anAdder sumarFraccion: self.
	
	"Version con if: | newNumerator newDenominator |
	
	anAdder class = Entero ifTrue: 
			[newNumerator := numerator + (denominator * anAdder). newDenominator := denominator.] 
					      ifFalse: 
			[newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).	newDenominator := denominator * anAdder denominator.].

	^newNumerator / newDenominator"
	
	"Original: | newNumerator newDenominator |
	
	newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
	newDenominator := denominator * anAdder denominator.
	
	^newNumerator / newDenominator "
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'fr 10/1/2020 12:56:46'!
- aSubtrahend 
	
	^aSubtrahend restarFraccion: self
	
	"Version usando la suma: ^self + (aSubtrahend negated)."
	
	"Original: | newNumerator newDenominator |
	
	newNumerator := (numerator * aSubtrahend denominator) - (denominator * aSubtrahend numerator).
	newDenominator := denominator * aSubtrahend denominator.
	
	^newNumerator / newDenominator"
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'fr 9/28/2020 20:27:38'!
/ aDivisor 

	^aDivisor dividoUnaFraccion: self

	"Version con if: ^aDivisor class = Entero ifTrue: [numerator / (denominator*aDivisor)] ifFalse: [(numerator * aDivisor denominator) / (denominator * aDivisor numerator)]. "
	
	"Original: ^(numerator * aDivisor denominator) / (denominator * aDivisor numerator)"! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'fr 9/28/2020 22:02:57'!
denominator

	^denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'fr 9/28/2020 22:02:50'!
numerator

	^numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !


!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'fr 9/28/2020 20:24:05'!
dividoUnEntero: unEntero

	^(denominator * unEntero) / (numerator)! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'fr 9/28/2020 20:25:37'!
dividoUnaFraccion: unaFraccion

	^(unaFraccion numerator * denominator) / (unaFraccion denominator * numerator)! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'fr 9/28/2020 20:24:18'!
multiplicarPorUnEntero: aMultiplier

	^(numerator * aMultiplier) / (denominator)! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'fr 9/28/2020 20:24:40'!
multiplicarPorUnaFraccion: aMultiplier

	^(numerator * aMultiplier numerator) / (denominator * aMultiplier denominator)! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'fr 10/1/2020 12:51:59'!
restarEntero: aSubtrahend
	
	^(aSubtrahend restarFraccion: self) negated! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'fr 10/1/2020 12:59:54'!
restarFraccion: aSubtrahend

	^(denominator * aSubtrahend numerator)- (numerator * aSubtrahend denominator) / (denominator * aSubtrahend denominator).! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'fr 9/28/2020 16:27:30'!
sumarEntero: anAdder

	^anAdder sumarFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'fr 9/28/2020 16:28:53'!
sumarFraccion: anAdder

	^((numerator * anAdder denominator) + (denominator * anAdder numerator)) / (denominator * anAdder denominator).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'fr 9/30/2020 19:28:49'!
with: aDividend over: aDivisor
	
	| greatestCommonDivisor numerator denominator |
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	^denominator asDenominatorOf: numerator.
		
	"Original: | greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue:[ ^aDividend negated / aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator"
	! !

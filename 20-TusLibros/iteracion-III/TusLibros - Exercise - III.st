!classDefinition: #CartTest category: 'TusLibros - Exercise - III'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - III'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros - Exercise - III'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - III'!

!CashierTest methodsFor: 'tests' stamp: 'fr 11/30/2020 02:15:20'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook
			for: testObjectsFactory validCustomer]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'fr 11/30/2020 02:18:35'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new
		for: testObjectsFactory validCustomer.
		
	self assert: cashier checkOut total = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'fr 11/30/2020 02:17:27'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook
				for: testObjectsFactory validCustomer ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'fr 11/30/2020 02:21:49'!
test04CheckoutRegistersASale

	| cart cashier salesBook receipt |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook
		for: testObjectsFactory validCustomer.
		
	receipt := cashier checkOut total.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = receipt.! !

!CashierTest methodsFor: 'tests' stamp: 'fr 11/30/2020 02:21:55'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook receipt creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook
		for: testObjectsFactory validCustomer.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	receipt := cashier checkOut total.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = receipt.! !

!CashierTest methodsFor: 'tests' stamp: 'fr 11/30/2020 02:17:44'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook
		for: testObjectsFactory validCustomer.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #FacadeTest category: 'TusLibros - Exercise - III'!
TestCase subclass: #FacadeTest
	instanceVariableNames: 'facade objectFactory salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - III'!

!FacadeTest methodsFor: 'tests' stamp: 'fr 11/30/2020 02:35:16'!
notas

	"Es necesario agregar un test que verifique el agregado de items que no están en el catálogo a este nivel? -> test06"
	
	"Hace falta ver los checkouts con tarjeta vencida, robada, etc? Y con el carrito vacío? Todo esto ya está chequeado en el Cashier. Usamos la idea de que decida el error a seguir el que inicia la acción? (similar al ejemplo del café y la máquina) -> test09"
	
	"Tiene sentido modelar la venta para guardarla en el libro? No es conveniente guardar un comprobante del grupo ya que es lo que ocurre en la realidad?"
	
	"El id inválido puede ser nil?"
	
	"Es correcto pasar la lista de usuarios y contraseñas o hay que hacer algo similar a lo del merchant processor?"
	
	"Customer vs username qué conviene usar?"! !

!FacadeTest methodsFor: 'tests' stamp: 'fr 11/30/2020 02:35:40'!
test01CanCreateNewCartWithValidCredentials

	| cartId  |
	
	cartId _ facade newCartForUser: objectFactory validUser andPassword: objectFactory validPassword.
	
	self assert: (facade listCart: cartId) isEmpty! !

!FacadeTest methodsFor: 'tests' stamp: 'fr 11/30/2020 02:37:27'!
test02CanNotCreateNewCartForInvalidUser

	self  should: [facade newCartForUser: objectFactory invalidUser andPassword: objectFactory validPassword]
		raise: Error - MessageNotUnderstood 
		withMessageText: Facade invalidCredentialsErrorDescription
		! !

!FacadeTest methodsFor: 'tests' stamp: 'fr 11/30/2020 02:37:36'!
test03CanNotCreateNewCartForInvalidPassword
	
	self  should: [facade newCartForUser: objectFactory validUser andPassword: objectFactory invalidPassword]
		raise: Error - MessageNotUnderstood 
		withMessageText: Facade invalidCredentialsErrorDescription
		! !

!FacadeTest methodsFor: 'tests' stamp: 'fr 11/29/2020 17:39:51'!
test04CanNotListNonexistentCart
		
	self  should: [facade listCart: 1] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Facade invalidCartIdErrorDescription! !

!FacadeTest methodsFor: 'tests' stamp: 'fr 11/30/2020 02:37:46'!
test05AddingAnItemWorksAsExpected

	| cartId |
	cartId _ facade newCartForUser: objectFactory validUser andPassword: objectFactory validPassword.
	facade add: 1 of: objectFactory itemSellByTheStore toCart: cartId.
	self assert: ((facade listCart: cartId) occurrencesOf: objectFactory itemSellByTheStore) equals: 1! !

!FacadeTest methodsFor: 'tests' stamp: 'fr 11/29/2020 17:40:06'!
test06CanNotAddItemsToNonexistentCarts

	self  should: [facade add: 2 of: objectFactory itemSellByTheStore toCart: 1]
		raise: Error - MessageNotUnderstood 
		withMessageText: Facade invalidCartIdErrorDescription 
! !

!FacadeTest methodsFor: 'tests' stamp: 'fr 11/30/2020 02:37:57'!
test07ListingACartWorksAsExpectedForMultipleItems

	| cartId |
	cartId _ facade newCartForUser: objectFactory validUser andPassword: objectFactory validPassword.
	facade add: 2 of: objectFactory itemSellByTheStore toCart: cartId.
	self assert: ((facade listCart: cartId) occurrencesOf: objectFactory itemSellByTheStore) equals: 2! !

!FacadeTest methodsFor: 'tests' stamp: 'fr 11/30/2020 02:43:28'!
test08CanCheckoutAValidCart

	| cartId receipt |
				
	cartId _ facade 
				newCartForUser: objectFactory validUser 
				andPassword: objectFactory validPassword.
				
	facade add: 2 of: objectFactory itemSellByTheStore toCart: cartId.
	
	receipt _ facade 
			checkoutCart: cartId 
			withCard: objectFactory cardNumber 
			expiringOn: objectFactory cardExpirationDate 
			forOwner: objectFactory validUser. "Usar algo distinto al user? Dividir owner de user?"
			
	self assert: receipt total equals: objectFactory itemSellByTheStorePrice * 2
	! !

!FacadeTest methodsFor: 'tests' stamp: 'fr 11/30/2020 02:43:36'!
test09CanNotCheckoutANonexistentCart
				
	self should: [facade 
			checkoutCart: 1 
			withCard: objectFactory cardNumber 
			expiringOn: objectFactory cardExpirationDate 
			forOwner: objectFactory validUser.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
							self assert: anError messageText equals: Facade invalidCartIdErrorDescription.
							self assert: salesBook isEmpty
			]
	! !

!FacadeTest methodsFor: 'tests' stamp: 'fr 11/30/2020 03:12:51'!
test10PurchaseListHasTheCorrectQuantityOfItems

	| cartId purchasesList |
				
	cartId _ facade newCartForUser: objectFactory validUser andPassword: objectFactory validPassword.	
	facade add: 2 of: objectFactory itemSellByTheStore toCart: cartId.
	facade 
		checkoutCart: cartId 
		withCard: objectFactory cardNumber 
		expiringOn: objectFactory cardExpirationDate 
		forOwner: objectFactory validUser.
	purchasesList _ facade listPurchasesOfUser: objectFactory validUser withPassword: objectFactory validPassword.
	
	self assert: (purchasesList at: objectFactory itemSellByTheStore) equals: 2.
	
	! !

!FacadeTest methodsFor: 'tests' stamp: 'fr 11/30/2020 02:43:50'!
test11CanNotListPurchasesForInvalidUsername

	| cartId |
				
	cartId _ facade newCartForUser: objectFactory validUser andPassword: objectFactory validPassword.	
	facade add: 2 of: objectFactory itemSellByTheStore toCart: cartId.
	facade 
		checkoutCart: cartId 
		withCard: objectFactory cardNumber 
		expiringOn: objectFactory cardExpirationDate 
		forOwner: objectFactory validUser.
	
	self  should: [facade listPurchasesOfUser: objectFactory invalidUser withPassword: objectFactory validPassword] 
		raise: Error - MessageNotUnderstood
		description: Facade invalidCredentialsErrorDescription 
	
	! !

!FacadeTest methodsFor: 'tests' stamp: 'fr 11/30/2020 02:43:57'!
test12CanNotListPurchasesForInvalidPassword

	| cartId |
				
	cartId _ facade newCartForUser: objectFactory validUser andPassword: objectFactory validPassword.	
	facade add: 2 of: objectFactory itemSellByTheStore toCart: cartId.
	facade 
		checkoutCart: cartId 
		withCard: objectFactory cardNumber 
		expiringOn: objectFactory cardExpirationDate 
		forOwner: objectFactory validUser.
	
	self  should: [facade listPurchasesOfUser: objectFactory validUser withPassword: objectFactory invalidPassword] 
		raise: Error - MessageNotUnderstood
		description: Facade invalidCredentialsErrorDescription 
	
	! !


!FacadeTest methodsFor: 'setup' stamp: 'fr 11/30/2020 02:36:51'!
setUp
	
	objectFactory _ StoreTestObjectsFactory new.
	salesBook _ objectFactory defaultSalesBook.
	facade _ facade _ Facade 
				acceptingItemsOf: objectFactory defaultCatalog 
				validatingUsersFrom: objectFactory defaultCredentials 
				registeringSalesOn: salesBook
				chargingThrough: self.
! !


!FacadeTest methodsFor: 'merchant processor' stamp: 'fr 11/29/2020 18:35:41'!
debit: anAmount from: aCreditCard 
	! !


!classDefinition: #Cart category: 'TusLibros - Exercise - III'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - III'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'fr 11/30/2020 01:52:32'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'fr 11/30/2020 01:53:06'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity! !


!Cart methodsFor: 'listing' stamp: 'fr 11/29/2020 17:40:50'!
listCart
	
	^items copy
	! !


!Cart methodsFor: 'enumerating' stamp: 'fr 11/30/2020 01:52:01'!
itemsQuantitiesAndPricesDo: aBlock 
	
	items contents keysAndValuesDo: [:anItem :aQuantity | aBlock value: anItem value: aQuantity value: (catalog at: anItem)]
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros - Exercise - III'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros - Exercise - III'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard receipt date customer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - III'!

!Cashier methodsFor: 'checkout - private' stamp: 'fr 11/30/2020 02:22:23'!
collectReceiptEntriesInto: ticketEntries 
	
	cart itemsQuantitiesAndPricesDo: [:anItem :aQuantity :aPrice | 
		ticketEntries add: (SaleReceiptEntry for: aQuantity of: anItem costing: aPrice)
	]! !

!Cashier methodsFor: 'checkout - private' stamp: 'fr 11/30/2020 02:22:40'!
createReceipt

	| ticketEntries |
	ticketEntries _ OrderedCollection new.
	self collectReceiptEntriesInto: ticketEntries.
	receipt _ SaleReceipt for: ticketEntries customer: customer 
	
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'fr 11/30/2020 02:24:09'!
createSale

	^Sale for: receipt
! !

!Cashier methodsFor: 'checkout - private' stamp: 'fr 11/30/2020 02:11:09'!
debitTotal

	merchantProcessor debit: receipt total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'fr 11/30/2020 02:22:40'!
checkOut

	self createReceipt.
	self debitTotal.
	self registerSale.

	^ receipt! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

!Cashier methodsFor: 'initialization' stamp: 'fr 11/30/2020 01:39:15'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook for: aUsername 
	
	cart _ aCart.
	creditCard _ aCreditCard.
	merchantProcessor _ aMerchantProcessor.
	salesBook _ aSalesBook.
	customer _ aUsername.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros - Exercise - III'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !

!Cashier class methodsFor: 'instance creation' stamp: 'fr 11/30/2020 02:18:17'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook for: aUsername 
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook for: aUsername ! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros - Exercise - III'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - III'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros - Exercise - III'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #Facade category: 'TusLibros - Exercise - III'!
Object subclass: #Facade
	instanceVariableNames: 'carts catalogue credentials usernameList currentId merchantProcessor salesBook credentialsList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - III'!

!Facade methodsFor: 'cart management' stamp: 'fr 11/28/2020 22:15:00'!
add: aQuantity of: anItem toCart: aCartId 
	
	(self cartForId: aCartId) add: aQuantity of: anItem
	! !

!Facade methodsFor: 'cart management' stamp: 'fr 11/28/2020 22:17:24'!
cartForId: aCartId

	^carts at: aCartId ifAbsent: [self error: self class invalidCartIdErrorDescription]! !

!Facade methodsFor: 'cart management' stamp: 'fr 11/28/2020 22:15:17'!
listCart: aCartId 
	
	^(self cartForId: aCartId) listCart
	! !

!Facade methodsFor: 'cart management' stamp: 'fr 11/28/2020 22:08:40'!
newCartForUser: aUsername andPassword: aPassword 
	
	self validateUsername: aUsername andPassword: aPassword.
	self updateId.
	carts add: currentId -> (Cart acceptingItemsOf: catalogue).
	^currentId ! !


!Facade methodsFor: 'initialization' stamp: 'fr 11/29/2020 18:35:21'!
initializeAcceptingItemsOf: aCatalogue validatingUsersFrom: aCredentialsList registeringSalesOn: aSalesBook chargingThrough: aMerchantProcessor 
	
	catalogue _ aCatalogue.
	credentials _ aCredentialsList.
	salesBook _ aSalesBook.
	merchantProcessor _ aMerchantProcessor.
	
	carts _ Dictionary new.
	currentId _ 0! !


!Facade methodsFor: 'validation' stamp: 'fr 11/28/2020 22:16:29'!
passwordForUsername: aUsername 
	
	^credentials at: aUsername ifAbsent: [self error: self class invalidCredentialsErrorDescription]! !

!Facade methodsFor: 'validation' stamp: 'fr 11/28/2020 22:16:29'!
validateUsername: aUsername andPassword: aPassword 
	
	(self passwordForUsername: aUsername) = aPassword ifFalse: [self error: self class invalidCredentialsErrorDescription]! !


!Facade methodsFor: 'id' stamp: 'fr 11/28/2020 22:08:58'!
updateId
	
	currentId _ currentId + 1! !


!Facade methodsFor: 'checkout' stamp: 'fr 11/30/2020 01:36:02'!
checkoutCart: aCartId withCard: aCardNumber expiringOn: anExpirationDate forOwner: aCardOwner 
	
	^(Cashier toCheckout: (self cartForId: aCartId)
	 		charging: (CreditCard expiringOn: anExpirationDate) 
			throught: merchantProcessor 
			on: self today 
			registeringOn: salesBook
			for: aCardOwner) checkOut
		! !


!Facade methodsFor: 'time' stamp: 'fr 11/29/2020 18:25:34'!
today
	
	^Month current
	! !


!Facade methodsFor: 'purchase listing' stamp: 'fr 11/30/2020 02:26:05'!
itemsWithCountsForCustomer: aUsername

	^ (self salesForCustomer: aUsername) collect: [:aSale | aSale itemsWithCounts]! !

!Facade methodsFor: 'purchase listing' stamp: 'fr 11/30/2020 02:30:05'!
listPurchasesForCustomer: aUsername

	^ (self totalItemsWithCountsForCustomer: aUsername) contents! !

!Facade methodsFor: 'purchase listing' stamp: 'fr 11/30/2020 02:34:10'!
listPurchasesOfUser: aUsername withPassword: aPassword 

	self validateUsername: aUsername andPassword: aPassword.

	^self listPurchasesForCustomer: aUsername
	! !

!Facade methodsFor: 'purchase listing' stamp: 'fr 11/30/2020 02:25:34'!
salesForCustomer: aUsername

	^ salesBook select: [:aSale | aSale doneFor: aUsername]! !

!Facade methodsFor: 'purchase listing' stamp: 'fr 11/30/2020 02:29:31'!
totalItemsWithCountsForCustomer: aUsername

	^ (self itemsWithCountsForCustomer: aUsername) 
									inject: Bag new 
									into: [:totalItemsWithCounts :itemsWithCounts | 
											totalItemsWithCounts addAll: itemsWithCounts. totalItemsWithCounts
									]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Facade class' category: 'TusLibros - Exercise - III'!
Facade class
	instanceVariableNames: ''!

!Facade class methodsFor: 'instance creation' stamp: 'fr 11/29/2020 18:33:40'!
acceptingItemsOf: aCatalogue validatingUsersFrom: aCredentialsList registeringSalesOn: aSalesBook chargingThrough: aMerchantProcessor 
	
	^self new initializeAcceptingItemsOf: aCatalogue validatingUsersFrom: aCredentialsList registeringSalesOn: aSalesBook chargingThrough: aMerchantProcessor ! !


!Facade class methodsFor: 'error description' stamp: 'fr 11/28/2020 21:12:40'!
invalidCartIdErrorDescription
	
	^'Invalid cart id'! !

!Facade class methodsFor: 'error description' stamp: 'fr 11/28/2020 20:40:18'!
invalidCredentialsErrorDescription
	
	^'Invalid credentials'! !


!classDefinition: #Sale category: 'TusLibros - Exercise - III'!
Object subclass: #Sale
	instanceVariableNames: 'total customer receipt'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - III'!

!Sale methodsFor: 'total' stamp: 'fr 11/30/2020 02:19:42'!
total
	
	^ receipt total! !


!Sale methodsFor: 'initialization' stamp: 'fr 11/30/2020 01:56:27'!
initializeFor: aSaleReceipt 
	
	receipt _ aSaleReceipt.! !

!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !


!Sale methodsFor: 'customer' stamp: 'fr 11/30/2020 02:00:26'!
doneFor: aUsername 

	^receipt customer = aUsername! !


!Sale methodsFor: 'listing' stamp: 'fr 11/30/2020 02:05:57'!
itemsWithCounts
	
	| items |
	items _ Bag new.
	receipt collectItemsWithCountsInto: items.
	^items! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros - Exercise - III'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'fr 11/30/2020 01:55:41'!
for: aSaleReceipt 
	
	^self new initializeFor: aSaleReceipt ! !

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #SaleReceipt category: 'TusLibros - Exercise - III'!
Object subclass: #SaleReceipt
	instanceVariableNames: 'receiptEntries salesReceiptEntriesList customer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - III'!

!SaleReceipt methodsFor: 'initialization' stamp: 'fr 11/30/2020 01:59:55'!
initializeFor: aSalesReceiptEntriesList customer: aUsername 
	
	receiptEntries _ aSalesReceiptEntriesList.
	customer _ aUsername.! !


!SaleReceipt methodsFor: 'accessing' stamp: 'fr 11/30/2020 02:01:21'!
customer
	
	^customer! !


!SaleReceipt methodsFor: 'private' stamp: 'fr 11/30/2020 03:04:26'!
collectItemsWithCountsInto: aListOfItemsWithOccurrences 
	
	receiptEntries do: [:aReceiptEntry | aListOfItemsWithOccurrences add: aReceiptEntry item withOccurrences: aReceiptEntry quantity]! !


!SaleReceipt methodsFor: 'total' stamp: 'fr 11/30/2020 02:11:40'!
total
	
	^receiptEntries sum: [:aReceiptEntry | aReceiptEntry subtotal]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SaleReceipt class' category: 'TusLibros - Exercise - III'!
SaleReceipt class
	instanceVariableNames: ''!

!SaleReceipt class methodsFor: 'instance creation' stamp: 'fr 11/30/2020 01:54:46'!
for: aReceiptEntriesList 
	
	^self new initializeFor: aReceiptEntriesList ! !

!SaleReceipt class methodsFor: 'instance creation' stamp: 'fr 11/30/2020 01:59:15'!
for: aSalesReceiptEntriesList customer: aUsername 
	
	^self new initializeFor: aSalesReceiptEntriesList customer: aUsername ! !


!classDefinition: #SaleReceiptEntry category: 'TusLibros - Exercise - III'!
Object subclass: #SaleReceiptEntry
	instanceVariableNames: 'quantity item price'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - III'!

!SaleReceiptEntry methodsFor: 'initialization' stamp: 'fr 11/30/2020 01:54:06'!
initializeFor: aQuantity of: anItem costing: aPrice 
	
	quantity _ aQuantity.
	item _ anItem.
	price _ aPrice.! !


!SaleReceiptEntry methodsFor: 'accessing' stamp: 'fr 11/30/2020 02:07:20'!
item
	
	^item! !

!SaleReceiptEntry methodsFor: 'accessing' stamp: 'fr 11/30/2020 02:07:29'!
quantity
	
	^quantity! !


!SaleReceiptEntry methodsFor: 'total' stamp: 'fr 11/30/2020 02:11:57'!
subtotal
	
	^quantity * price! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SaleReceiptEntry class' category: 'TusLibros - Exercise - III'!
SaleReceiptEntry class
	instanceVariableNames: ''!

!SaleReceiptEntry class methodsFor: 'instance creation' stamp: 'fr 11/30/2020 01:53:32'!
for: aQuantity of: anItem costing: aPrice 
	
	^self new initializeFor: aQuantity of: anItem costing: aPrice ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros - Exercise - III'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - III'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'asdad' stamp: 'fr 11/30/2020 02:15:40'!
validCustomer
	
	^'validCustomer'! !

!StoreTestObjectsFactory methodsFor: 'asdad' stamp: 'fr 11/30/2020 02:35:58'!
validUser
	
	^'validUsername'! !


!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'fr 11/30/2020 02:45:01'!
cardExpirationDate

	^Month month: self today monthIndex year: self today yearNumber + 1	
	! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'fr 11/30/2020 02:44:25'!
cardNumber
	
	^'1111 2222 3333 4444'! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'fr 11/30/2020 02:40:07'!
defaultCredentials

	^Dictionary new add: self validUser -> self validPassword; yourself! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'fr 11/30/2020 02:39:41'!
defaultSalesBook
	
	^OrderedCollection new! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'fr 11/30/2020 02:40:27'!
invalidPassword

	^'invalidPassword'! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'fr 11/30/2020 02:40:51'!
invalidUser
	
	^'invalidUsername'! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'fr 11/30/2020 02:36:17'!
validPassword
	
	^'validPassword'! !

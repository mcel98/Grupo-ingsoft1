!classDefinition: #CartTest category: 'TusLibros - Exercise - II'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - II'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'fr 11/23/2020 02:34:11'!
defaultCatalog
	
	^ Dictionary new add: self itemSellByTheStore -> self itemSellByTheStorePrice; yourself! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !

!CartTest methodsFor: 'support' stamp: 'fr 11/23/2020 02:34:11'!
itemSellByTheStorePrice

	^ 50! !


!classDefinition: #CashierTest category: 'TusLibros - Exercise - II'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'paymentResponse'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - II'!

!CashierTest methodsFor: 'tests' stamp: 'fr 11/26/2020 15:35:22'!
test01CashierDoesNotAcceptAnEmptyCart
	
	| salesRegister |
	salesRegister _ self newSalesRegister.
	self  should: [
				Cashier 
					for: self newCart
					paymentMethod: self nonExpiredCard 
					merchantProcessor: self 
					registerOn: salesRegister
			   ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: Cashier canNotCheckoutWithEmptyCartErrorDescription.
			self assert: salesRegister isEmpty
		]
	
! !

!CashierTest methodsFor: 'tests' stamp: 'fr 11/23/2020 05:07:51'!
test02CheckoutTotalIsCorrectForASingleItem
	
	self assertCheckoutTotalForCartWith: [:aCart | aCart add: self itemInCatalogue] isEqualTo: self itemInCataloguePrice
	
! !

!CashierTest methodsFor: 'tests' stamp: 'fr 11/23/2020 05:08:00'!
test03CheckoutTotalIsCorrectForMultipleItems		
	
	self assertCheckoutTotalForCartWith: [:aCart | aCart add: 2 of: self itemInCatalogue] isEqualTo: self itemInCataloguePrice * 2
	
! !

!CashierTest methodsFor: 'tests' stamp: 'fr 11/26/2020 15:35:36'!
test04CashierDoesNotAcceptExpiredCards

	| cart salesRegister |
	salesRegister _ self newSalesRegister.
	cart _ self newCart.
	cart add: 2 of: self itemInCatalogue.	

	self  should: [	Cashier 
					for: cart 
					paymentMethod: self expiredCard 
					merchantProcessor: self 
					registerOn: salesRegister.
			    ] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: Cashier expiredCardErrorDescription.
			self assert: salesRegister isEmpty
		]
	
! !

!CashierTest methodsFor: 'tests' stamp: 'fr 11/23/2020 05:10:37'!
test05CanNotCheckoutWithACardWithoutCredit

	self assertCheckoutFailsWithError: Cashier cardWithoutCreditErrorDescription
	
! !

!CashierTest methodsFor: 'tests' stamp: 'fr 11/23/2020 05:11:02'!
test06CanNotCheckoutWithAStolenCard

	self assertCheckoutFailsWithError: Cashier stolenCardErrorDescription
	
	
! !

!CashierTest methodsFor: 'tests' stamp: 'fr 11/26/2020 15:35:45'!
test07CashierRegistersSalesAsExpected

	| cart cashier salesRegister total |
	salesRegister _ self newSalesRegister.
	cart _ self newCart.
	cart add: self itemInCatalogue.	
	cashier _ Cashier 
				for: cart 
				paymentMethod: self nonExpiredCard 
				merchantProcessor: self 
				registerOn: salesRegister.			
	total _ cashier checkout total.
	
	self assert: salesRegister size equals: 1.
	self assert: salesRegister first total equals: total.! !

!CashierTest methodsFor: 'tests' stamp: 'fr 11/26/2020 15:35:58'!
test08CheckoutTicketReflectsBoughtItemsAsExpected

	| cart cashier ticket |
		
	cart _ self newCart.
	cart add: 2 of: self itemInCatalogue.
	cashier _ Cashier 
				for: cart 
				paymentMethod: self nonExpiredCard 
				merchantProcessor: self 
				registerOn: self newSalesRegister.	
	ticket _ cashier checkout.
	
	self assert: (ticket quantityOf: self itemInCatalogue) equals: 2.
	self assert: ticket totalItems equals: 2.	
! !


!CashierTest methodsFor: 'merchant processor' stamp: 'fr 11/23/2020 05:20:58'!
charge: someAmountToCharge on: aCard 

	paymentResponse value
	
	! !


!CashierTest methodsFor: 'private' stamp: 'fr 11/26/2020 15:32:16'!
assertCheckoutFailsWithError: anErrorMessage

	| cart cashier salesRegister |
	
	paymentResponse _ [self error: anErrorMessage].
		
	salesRegister _ OrderedCollection new.
	cart _ self newCart.
	cart add: self itemInCatalogue.	
	cashier _ Cashier 
				for: cart 
				paymentMethod: self nonExpiredCard 
				merchantProcessor: self 
				registerOn: salesRegister.
	
	self  should: [cashier checkout] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: anErrorMessage.
			self assert: salesRegister isEmpty 
		]
	
! !

!CashierTest methodsFor: 'private' stamp: 'fr 11/26/2020 15:32:25'!
assertCheckoutTotalForCartWith: aCartBlock isEqualTo: aCheckoutTotal

	| cart cashier  |
		
	cart _ self newCart.
	aCartBlock value: cart.
	cashier _ Cashier 
				for: cart 
				paymentMethod: self nonExpiredCard 
				merchantProcessor: self 
				registerOn: OrderedCollection new.	
				
	self assert: cashier checkout total equals: aCheckoutTotal 
	
! !


!CashierTest methodsFor: 'utils' stamp: 'fr 11/23/2020 02:34:40'!
catalogue

	^ Dictionary new add: self itemInCatalogue -> self itemInCataloguePrice; yourself! !

!CashierTest methodsFor: 'utils' stamp: 'fr 11/23/2020 04:54:16'!
expiredCard

	^ CreditCard withExpiration: (GregorianMonthOfYear decemberOf: GregorianYear current previous)! !

!CashierTest methodsFor: 'utils' stamp: 'fr 11/26/2020 15:35:11'!
itemInCatalogue
	
	^ 'an item'! !

!CashierTest methodsFor: 'utils' stamp: 'fr 11/22/2020 22:31:50'!
itemInCataloguePrice

	^ 50! !

!CashierTest methodsFor: 'utils' stamp: 'fr 11/26/2020 15:28:57'!
newCart

	^ Cart acceptingItemsOf: self catalogue! !

!CashierTest methodsFor: 'utils' stamp: 'fr 11/26/2020 15:35:22'!
newSalesRegister

	^ OrderedCollection new! !

!CashierTest methodsFor: 'utils' stamp: 'fr 11/23/2020 04:54:24'!
nonExpiredCard

	^ CreditCard withExpiration: (GregorianMonthOfYear decemberOf: GregorianYear current next)! !


!CashierTest methodsFor: 'setup' stamp: 'fr 11/23/2020 04:55:23'!
setUp

	paymentResponse _ []! !


!classDefinition: #Cart category: 'TusLibros - Exercise - II'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - II'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'fr 11/23/2020 01:51:15'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'fr 11/23/2020 04:34:01'!
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


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'fr 11/23/2020 04:34:30'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity ! !


!Cart methodsFor: 'total' stamp: 'fr 11/23/2020 01:52:45'!
total
	
	^items sum: [:anItem | catalog at: anItem]! !


!Cart methodsFor: 'enumerating' stamp: 'fr 11/23/2020 04:33:37'!
itemsQuantitiesAndPricesDo: aBlock

	 items contents keysAndValuesDo: [:anItem :aQuantity | aBlock value: anItem value: aQuantity value: (catalog at: anItem)]
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros - Exercise - II'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros - Exercise - II'!
Object subclass: #Cashier
	instanceVariableNames: 'cart paymentMethod merchantProcessor salesRegister saleTicket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - II'!

!Cashier methodsFor: 'initialization' stamp: 'fr 11/23/2020 05:04:31'!
initializeFor: aCart paymentMethod: aCard merchantProcessor: aMerchantProcessor registerOn: aSalesRegister 
	
	cart _ aCart.
	paymentMethod _ aCard.
	merchantProcessor _ aMerchantProcessor.
	salesRegister _ aSalesRegister! !


!Cashier methodsFor: 'total' stamp: 'fr 11/23/2020 04:58:20'!
checkout

	self obtainTicket.
	self proceedToPayment.
	self registerSale.
	^saleTicket! !


!Cashier methodsFor: 'private' stamp: 'fr 11/26/2020 15:45:30'!
collectTicketEntriesForTheCartInto: ticketEntries

	cart itemsQuantitiesAndPricesDo: [:anItem :aQuantity :aPrice | 
		ticketEntries add: (SaleTicketEntry for: aQuantity of: anItem costing: aPrice)
	]! !

!Cashier methodsFor: 'private' stamp: 'fr 11/23/2020 04:58:20'!
obtainTicket

	| ticketEntries |
	ticketEntries _ OrderedCollection new.
	self collectTicketEntriesForTheCartInto: ticketEntries.
	saleTicket _ SaleTicket for: ticketEntries! !

!Cashier methodsFor: 'private' stamp: 'fr 11/26/2020 15:45:06'!
proceedToPayment

	merchantProcessor charge: saleTicket total on: paymentMethod! !

!Cashier methodsFor: 'private' stamp: 'fr 11/23/2020 04:58:20'!
registerSale

	salesRegister add: saleTicket! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros - Exercise - II'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error description' stamp: 'fr 11/19/2020 19:01:19'!
canNotCheckoutWithEmptyCartErrorDescription
	
	^'Can not checkout with empty cart'! !

!Cashier class methodsFor: 'error description' stamp: 'fr 11/20/2020 21:04:22'!
cardWithoutCreditErrorDescription
	
	^'Card has no credit'! !

!Cashier class methodsFor: 'error description' stamp: 'fr 11/19/2020 20:22:56'!
expiredCardErrorDescription
	
	^'Expired card'! !

!Cashier class methodsFor: 'error description' stamp: 'fr 11/22/2020 20:18:22'!
stolenCardErrorDescription
	
	^'Stolen card!!'! !


!Cashier class methodsFor: 'instance creation' stamp: 'fr 11/23/2020 05:04:59'!
for: aCart paymentMethod: aCard merchantProcessor: aMerchantProcessor registerOn: aSalesRegister 
	
	self validateCart: aCart.
	self validateCard: aCard.
		
	^self new initializeFor: aCart paymentMethod: aCard merchantProcessor: aMerchantProcessor registerOn: aSalesRegister ! !

!Cashier class methodsFor: 'instance creation' stamp: 'fr 11/20/2020 21:38:48'!
signalCanNotCheckoutWithEmptyCardError

	^ self error: self canNotCheckoutWithEmptyCartErrorDescription! !

!Cashier class methodsFor: 'instance creation' stamp: 'fr 11/20/2020 21:38:23'!
signalExpiredCardError

	^ self error: self expiredCardErrorDescription! !

!Cashier class methodsFor: 'instance creation' stamp: 'fr 11/20/2020 21:38:23'!
validateCard: aCard

	^ (aCard hasExpiredOn: GregorianMonthOfYear current) ifTrue: [self signalExpiredCardError]! !

!Cashier class methodsFor: 'instance creation' stamp: 'fr 11/20/2020 21:38:48'!
validateCart: aCart

	^ aCart isEmpty ifTrue: [self signalCanNotCheckoutWithEmptyCardError]! !


!classDefinition: #CreditCard category: 'TusLibros - Exercise - II'!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - II'!

!CreditCard methodsFor: 'initialization' stamp: 'fr 11/23/2020 01:44:12'!
initializeWithExpiration: anExpirationDate 
	
	expirationDate _ anExpirationDate.! !


!CreditCard methodsFor: 'expiration' stamp: 'fr 11/23/2020 01:51:59'!
hasExpiredOn: aMonth 
	
	^expirationDate < aMonth 	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros - Exercise - II'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'fr 11/23/2020 01:43:56'!
withExpiration: anExpirationDate 
	
	^self new initializeWithExpiration: anExpirationDate ! !


!classDefinition: #SaleTicket category: 'TusLibros - Exercise - II'!
Object subclass: #SaleTicket
	instanceVariableNames: 'total ticketEntries'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - II'!

!SaleTicket methodsFor: 'initialization' stamp: 'fr 11/23/2020 03:56:54'!
initializeFor: aListOfTicketEntries 
	
	ticketEntries _ aListOfTicketEntries.! !


!SaleTicket methodsFor: 'total' stamp: 'fr 11/26/2020 15:39:19'!
total
	
	^ticketEntries sum: [:aTicketEntry | aTicketEntry subtotal]! !


!SaleTicket methodsFor: 'testing' stamp: 'fr 11/23/2020 04:49:06'!
quantityOf: anItem

	^(self detectATicketEntryFor: anItem) quantity
	
	! !


!SaleTicket methodsFor: 'size' stamp: 'fr 11/23/2020 04:43:13'!
totalItems
	
	^ticketEntries sum: [:aTicketEntry | aTicketEntry quantity]! !


!SaleTicket methodsFor: 'private' stamp: 'fr 11/26/2020 15:43:25'!
detectATicketEntryFor: anItem

	^ticketEntries detect: [:aTicketEntry | aTicketEntry item = anItem]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SaleTicket class' category: 'TusLibros - Exercise - II'!
SaleTicket class
	instanceVariableNames: ''!

!SaleTicket class methodsFor: 'instance creation' stamp: 'fr 11/23/2020 03:56:30'!
for: aListOfTicketEntries 
	
	^self new initializeFor: aListOfTicketEntries ! !


!classDefinition: #SaleTicketEntry category: 'TusLibros - Exercise - II'!
Object subclass: #SaleTicketEntry
	instanceVariableNames: 'item unitPrice quantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - II'!

!SaleTicketEntry methodsFor: 'initialization' stamp: 'fr 11/23/2020 04:35:35'!
initializeFor: aQuantity of: anItem costing: anUnitPrice 
	
	quantity _ aQuantity.
	item _ anItem.
	unitPrice _ anUnitPrice.! !


!SaleTicketEntry methodsFor: 'subtotal' stamp: 'fr 11/23/2020 04:39:01'!
subtotal

	^unitPrice * quantity 
	
	! !


!SaleTicketEntry methodsFor: 'accessing' stamp: 'fr 11/23/2020 04:24:02'!
item
	
	^item! !

!SaleTicketEntry methodsFor: 'accessing' stamp: 'fr 11/23/2020 04:24:17'!
quantity
	
	^quantity! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SaleTicketEntry class' category: 'TusLibros - Exercise - II'!
SaleTicketEntry class
	instanceVariableNames: ''!

!SaleTicketEntry class methodsFor: 'instance creation' stamp: 'fr 11/23/2020 04:35:15'!
for: aQuantity of: anItem costing: anUnitPrice 
	
	^self new initializeFor: aQuantity of: anItem costing: anUnitPrice ! !

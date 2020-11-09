!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'emptyPortfolio account portfolioWithAccount anotherAccount portfolioWithAccountAndPortfolio deposit anotherDeposit portfolioWithEmptyPortfolio anotherPortfolioWithEmptyPortfolio portfolioWithPortfolioWithEmptyPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests - balance' stamp: 'fr 11/9/2020 09:40:34'!
test01EmptyPortfolioHasBalanceZero

	self assert: emptyPortfolio balance equals: 0! !

!PortfolioTest methodsFor: 'tests - balance' stamp: 'fr 11/9/2020 09:40:44'!
test02PortfolioWithASingleAccountWithNoTransactionsHasBalanceZero

	self assert: portfolioWithAccount balance equals: 0! !

!PortfolioTest methodsFor: 'tests - balance' stamp: 'fr 11/9/2020 09:40:54'!
test03PortfolioWithASingleAccountReflectsItsTransactionsValuesInItsBalance

	self deposit100OnAccount.
	self assert: portfolioWithAccount balance equals: 100! !

!PortfolioTest methodsFor: 'tests - balance' stamp: 'fr 11/9/2020 09:41:04'!
test04PortfolioWithMultipleAccountsAndPortfoliosReflectsTheirTransactionsValuesInItsBalance

	self deposit100OnAccount.
	self deposit50OnAnotherAccount.

	self assert: portfolioWithAccountAndPortfolio balance equals: 150! !


!PortfolioTest methodsFor: 'tests - hasRegistered' stamp: 'fr 11/9/2020 09:41:18'!
test05EmptyPortfolioHasNotRegisteredAnyTransaction

	self deposit100OnAccountAndStore.
	self deny: (emptyPortfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests - hasRegistered' stamp: 'fr 11/9/2020 09:41:34'!
test06PortfolioWithASingleAccountRegistersItsTransactions

	self deposit100OnAccountAndStore.
	self assert: (portfolioWithAccount hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests - hasRegistered' stamp: 'fr 11/9/2020 09:41:51'!
test07PortfolioWithMulltipleAccountsAndPortfoliosRegistersAllTheirTransactions
		
	self deposit100OnAccount50OnAnotherAccountAndStore.
	 
	self assert: (
		(portfolioWithAccountAndPortfolio hasRegistered: deposit) and: 
		[portfolioWithAccountAndPortfolio hasRegistered: anotherDeposit]
	)! !


!PortfolioTest methodsFor: 'tests - transactions' stamp: 'fr 11/9/2020 09:42:11'!
test08EmptyPortfolioDoesNotExhibitAnyTransaction

	self assert: (emptyPortfolio transactions isEmpty)! !

!PortfolioTest methodsFor: 'tests - transactions' stamp: 'fr 11/9/2020 09:42:29'!
test09PortfolioWithASingleAccountExhibitsItsTransactions

	self deposit100OnAccountAndStore.	
	self assert: portfolioWithAccount transactions equals: (OrderedCollection with: deposit)! !

!PortfolioTest methodsFor: 'tests - transactions' stamp: 'fr 11/9/2020 09:42:41'!
test10PortfolioWithMultipleAccountsAndPortfoliosExhibitsAllTheirTransactionsCombined
		
	self deposit100OnAccount50OnAnotherAccountAndStore.
	self assert: portfolioWithAccountAndPortfolio transactions equals: (OrderedCollection with: anotherDeposit with: deposit	)! !


!PortfolioTest methodsFor: 'tests - add' stamp: 'fr 11/9/2020 09:43:00'!
test11EmptyPortfolioDoesNotContainAnyAccount

	self deny: (emptyPortfolio contains: account)! !

!PortfolioTest methodsFor: 'tests - add' stamp: 'fr 11/9/2020 09:59:59'!
test12PortfolioContainsAnAccountAfterItIsAdded

	self addAccountToEmptyPortfolio.
	self assert: (emptyPortfolio contains: account)! !

!PortfolioTest methodsFor: 'tests - add' stamp: 'fr 11/9/2020 09:59:52'!
test13PortfolioContainsAnAccountAfterItIsAddedToAnyOfItsDecendents

	self addAccountToEmptyPortfolio.
	self assert: (portfolioWithEmptyPortfolio contains: account)! !

!PortfolioTest methodsFor: 'tests - add' stamp: 'fr 11/9/2020 10:00:33'!
test14PortfolioDoesNotContainAnythingThatWasNotAddedToItself

	self addAccountToEmptyPortfolio.
	self deny: (emptyPortfolio contains: anotherAccount)! !


!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'fr 11/9/2020 08:45:33'!
test15PortfolioCanNotAddItself
	
	self  should: [emptyPortfolio add: emptyPortfolio] 
		raise: Error 
		withMessageText: Portfolio canNotAddAccountErrorDescription! !

!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'fr 11/9/2020 09:49:33'!
test16PortfolioCanNotAddItsParent
	
	self  should: [emptyPortfolio add: portfolioWithEmptyPortfolio] 
		raise: Error 
		withMessageText: Portfolio canNotAddAccountErrorDescription! !

!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'fr 11/9/2020 09:57:30'!
test17PortfolioCanNotAddAnyAncestor
	
	self  should: [emptyPortfolio add: portfolioWithPortfolioWithEmptyPortfolio] 
		raise: Error 
		withMessageText: Portfolio canNotAddAccountErrorDescription! !

!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'fr 11/9/2020 09:58:33'!
test18PortfolioCanNotAddAnyPreviousMemberOfTheTree

	| rootPortfolio anotherEmptyPortfolio |
	
	anotherEmptyPortfolio _ Portfolio new.
	rootPortfolio _ Portfolio with: (OrderedCollection with: portfolioWithEmptyPortfolio with: anotherEmptyPortfolio).
	
	self  should: [emptyPortfolio add: anotherEmptyPortfolio] 
		raise: Error 
		withMessageText: Portfolio canNotAddAccountErrorDescription! !

!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'fr 11/9/2020 09:53:16'!
test19PortfolioCanNotAddAnotherOneWhichSharesChild
	
	self  should: [portfolioWithEmptyPortfolio add: anotherPortfolioWithEmptyPortfolio] 
		raise: Error 
		withMessageText: Portfolio canNotAddAccountErrorDescription! !

!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'fr 11/9/2020 09:57:30'!
test20PortfolioCanNotAddDuplicateAccountIndirectly
	
	self  should: [portfolioWithPortfolioWithEmptyPortfolio add: emptyPortfolio] 
		raise: Error 
		withMessageText: Portfolio canNotAddAccountErrorDescription! !

!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'fr 11/9/2020 09:59:18'!
test21AddingShouldFailIdenticallyAsCreatingAPortfolioWithAccounts

	| parentPortfolio |
	
	parentPortfolio _ Portfolio new.
	parentPortfolio add: emptyPortfolio.
	
	self  should: [emptyPortfolio add: parentPortfolio] 
		raise: Error 
		withMessageText: Portfolio canNotAddAccountErrorDescription! !

!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'fr 11/9/2020 09:53:34'!
test22CreatingAPortfolioWithAccountsShouldFailIdenticallyAsWhenAddingThem
	
	self  should: [Portfolio with: (OrderedCollection with: portfolioWithEmptyPortfolio with: anotherPortfolioWithEmptyPortfolio)] 
		raise: Error 
		withMessageText: Portfolio canNotAddAccountErrorDescription! !


!PortfolioTest methodsFor: 'tests - private' stamp: 'fr 11/9/2020 09:59:52'!
addAccountToEmptyPortfolio

	^ emptyPortfolio add: account! !

!PortfolioTest methodsFor: 'tests - private' stamp: 'fr 11/9/2020 09:25:00'!
deposit100OnAccount

	^ Deposit register: 100 on: account! !

!PortfolioTest methodsFor: 'tests - private' stamp: 'fr 11/9/2020 09:39:05'!
deposit100OnAccount50OnAnotherAccountAndStore

	self deposit100OnAccountAndStore.
	anotherDeposit _ self deposit50OnAnotherAccount! !

!PortfolioTest methodsFor: 'tests - private' stamp: 'fr 11/9/2020 09:39:05'!
deposit100OnAccountAndStore

	^ deposit _ self deposit100OnAccount! !

!PortfolioTest methodsFor: 'tests - private' stamp: 'fr 11/9/2020 09:30:00'!
deposit50OnAnotherAccount

	^ Deposit register: 50 on: anotherAccount! !


!PortfolioTest methodsFor: 'setup' stamp: 'fr 11/9/2020 09:57:30'!
setUp

	emptyPortfolio _ Portfolio new. 

	account _ ReceptiveAccount new.
	
	portfolioWithAccount _ Portfolio with: (OrderedCollection with: account).
	
	anotherAccount _ ReceptiveAccount new.
	
	portfolioWithAccountAndPortfolio _ Portfolio with: (OrderedCollection with: anotherAccount with: portfolioWithAccount).

	portfolioWithEmptyPortfolio _ Portfolio with: (OrderedCollection with: emptyPortfolio).
	
	anotherPortfolioWithEmptyPortfolio _ Portfolio with: (OrderedCollection with: emptyPortfolio).

	portfolioWithPortfolioWithEmptyPortfolio _ Portfolio with: (OrderedCollection with: portfolioWithEmptyPortfolio).



! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:15'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #Account category: 'Portfolio-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Account methodsFor: 'transactions' stamp: 'fr 11/8/2020 22:20:29'!
transactions
	
	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'fr 11/8/2020 22:20:26'!
balance
	
	self subclassResponsibility ! !


!Account methodsFor: 'testing' stamp: 'fr 11/8/2020 22:21:25'!
contains: anAccount 

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'fr 11/8/2020 22:20:40'!
hasRegistered: aTransaction
	
	self subclassResponsibility ! !


!Account methodsFor: 'private' stamp: 'fr 11/8/2020 22:22:10'!
collectTransactions: aTransactionList

	self subclassResponsibility ! !

!Account methodsFor: 'private' stamp: 'fr 11/8/2020 22:25:41'!
includes: anAccount

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'fr 11/8/2020 08:59:50'!
initialize

	accounts _ OrderedCollection new.
	parents _ OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'fr 11/8/2020 19:32:11'!
initializeWith: aReceptiveAccountList 
	
	self initialize.
	aReceptiveAccountList do: [:anAccount | self add: anAccount]! !


!Portfolio methodsFor: 'testing' stamp: 'fr 11/8/2020 21:09:48'!
contains: anAccountToCheck 
	
	^(accounts includes: anAccountToCheck) or: [accounts anySatisfy: [:anAccount | anAccount contains: anAccountToCheck]]! !

!Portfolio methodsFor: 'testing' stamp: 'fr 11/8/2020 21:08:37'!
hasRegistered: aTransaction 
	
	^accounts anySatisfy: [:anAccount | anAccount hasRegistered: aTransaction]! !


!Portfolio methodsFor: 'accounts management' stamp: 'fr 11/8/2020 21:09:27'!
add: anAccount 
	
	self validateAdding: anAccount.
	accounts add: anAccount.
	anAccount hasBeenAddedBy: self! !

!Portfolio methodsFor: 'accounts management' stamp: 'fr 11/8/2020 22:17:56'!
hasBeenAddedBy: aPortfolio
	
	parents add: aPortfolio! !

!Portfolio methodsFor: 'accounts management' stamp: 'fr 11/8/2020 21:10:09'!
validateAdding: anAccountToValidate

	^(self isReachableFromRoots: anAccountToValidate) ifTrue: [self signalCanNotAddAccountError]! !


!Portfolio methodsFor: 'balance' stamp: 'fr 11/7/2020 22:52:52'!
balance
	
	^accounts sum: [:anAccount | anAccount balance] ifEmpty: [0]! !


!Portfolio methodsFor: 'transactions' stamp: 'fr 11/8/2020 22:15:19'!
transactions
	
	| transactions |
	transactions _ OrderedCollection new.
	self collectTransactions: transactions.
	^transactions
! !


!Portfolio methodsFor: 'error' stamp: 'fr 11/8/2020 22:36:30'!
signalCanNotAddAccountError

	^self error: self class canNotAddAccountErrorDescription! !


!Portfolio methodsFor: 'private - account management' stamp: 'fr 11/8/2020 22:14:58'!
collectTransactions: aTransactionsList

	^accounts inject: aTransactionsList into: [:totalTransactions :anAccount | totalTransactions addAllLast: (anAccount collectTransactions: aTransactionsList)] 
	! !

!Portfolio methodsFor: 'private - account management' stamp: 'fr 11/8/2020 22:16:21'!
includes: anAccountToCheck 
	
	^self = anAccountToCheck 
		or: [accounts 
			anySatisfy: [:anAccount | 
				(anAccount includes: anAccountToCheck) or: [anAccountToCheck includes: anAccount]
			]
		]! !

!Portfolio methodsFor: 'private - account management' stamp: 'fr 11/8/2020 18:59:18'!
isReachableFromRoots: aPortfolio 
	
	^self roots anySatisfy: [:aRootPortfolio | aRootPortfolio includes: aPortfolio]! !

!Portfolio methodsFor: 'private - account management' stamp: 'fr 11/8/2020 18:58:29'!
roots
	
	| roots |
	roots _ OrderedCollection new.
	parents 
		ifEmpty: [roots add: self] 
		ifNotEmpty: [parents do: [:aParent | roots addAllLast: aParent roots]].
	^roots! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'fr 11/7/2020 22:43:41'!
with: aReceptiveAccount 
	
	^self new initializeWith: aReceptiveAccount ! !


!Portfolio class methodsFor: 'error descriptions' stamp: 'fr 11/8/2020 22:20:02'!
canNotAddAccountErrorDescription
	
	^'Can not add an account twice'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'fr 11/8/2020 21:15:12'!
transactions 

	^transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'fr 11/8/2020 19:34:11'!
balance

	| balance |
	balance _ 0.
	transactions do: [:aTransaction | balance _ aTransaction applyToBalance: balance].
	^balance! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'fr 11/8/2020 19:34:17'!
hasRegistered: aTransaction

	^transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'private - account management' stamp: 'fr 11/8/2020 22:14:46'!
collectTransactions: aTransactionsList

	^self transactions
! !

!ReceptiveAccount methodsFor: 'private - account management' stamp: 'fr 11/8/2020 08:35:05'!
contains: aReceptiveAccount 
	
	^false! !

!ReceptiveAccount methodsFor: 'private - account management' stamp: 'fr 11/8/2020 19:33:37'!
hasBeenAddedBy: aPortfolio
! !

!ReceptiveAccount methodsFor: 'private - account management' stamp: 'fr 11/8/2020 22:22:39'!
includes: anAccount 
	
	^self = anAccount ! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'apply' stamp: 'fr 11/7/2020 22:37:20'!
applyToBalance: aSmallInteger 
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'apply' stamp: 'fr 11/7/2020 22:37:36'!
applyToBalance: aBalance 
	
	^aBalance + value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'apply' stamp: 'fr 11/7/2020 22:37:54'!
applyToBalance: aBalance 

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !
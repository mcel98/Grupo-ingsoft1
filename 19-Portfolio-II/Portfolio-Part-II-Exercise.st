!classDefinition: #AccountReporterTest category: 'Portfolio-Part-II-Exercise'!
TestCase subclass: #AccountReporterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!AccountReporterTest methodsFor: 'tests - account summary' stamp: 'fr 11/13/2020 17:45:43'!
test01AccountSummaryForAccountWithNoTransactionsShouldJustShowBalanceZero

	| account reporter |
	
	account _ ReceptiveAccount new.
	reporter _ SummaryReporter for: account.
	
	self assert: [reporter accountSummary = (OrderedCollection with: 'Balance = 0')]! !

!AccountReporterTest methodsFor: 'tests - account summary' stamp: 'fr 11/13/2020 17:46:09'!
test02AccountSummaryShouldReflectDepositsOnAccounts

	| account reporter |
	
	account _ ReceptiveAccount new.
	Deposit register: 100 on: account. 
	reporter _ SummaryReporter for: account.
	
	self assert: [reporter accountSummary = (OrderedCollection with: 'Depósito por 100.' with: 'Balance = 100')]! !

!AccountReporterTest methodsFor: 'tests - account summary' stamp: 'fr 11/13/2020 17:46:32'!
test03AccountSummaryShouldReflectWithdrawsOnAccounts

	| account reporter |
	
	account _ ReceptiveAccount new.
	Withdraw register: 100 on: account. 
	reporter _ SummaryReporter for: account.
	
	self assert: [reporter accountSummary = (OrderedCollection with: 'Extracción por 100.' with: 'Balance = -100')]! !

!AccountReporterTest methodsFor: 'tests - account summary' stamp: 'fr 11/13/2020 17:47:08'!
test04AccountSummaryShouldReflectOutgoingTransfersOnAccounts

	| account anotherAccount reporter |
	
	account _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	reporter _ SummaryReporter for: account.
	
	Transfer move: 100 from: account to: anotherAccount.
	
	self assert: [reporter accountSummary = (OrderedCollection with: 'Salida por transferencia de 100.' with: 'Balance = -100')]! !

!AccountReporterTest methodsFor: 'tests - account summary' stamp: 'fr 11/13/2020 17:47:28'!
test05AccountSummaryShouldReflectIncomingTransfersOnAccounts

	| account anotherAccount reporter |
	
	account _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	reporter _ SummaryReporter for: account.
	
	Transfer move: 100 from: anotherAccount to: account.
	
	self assert: [reporter accountSummary = (OrderedCollection with: 'Entrada por transferencia de 100.' with: 'Balance = 100')]! !

!AccountReporterTest methodsFor: 'tests - account summary' stamp: 'fr 11/13/2020 17:47:45'!
test06AccountSummaryForPortfolioWithNoTransactionsShouldJustShowBalanceZero

	| portfolio reporter |
	
	portfolio _ Portfolio new.
	reporter _ SummaryReporter for: portfolio.
	
	self assert: [reporter accountSummary = (OrderedCollection with: 'Balance = 0')]! !

!AccountReporterTest methodsFor: 'tests - account summary' stamp: 'fr 11/13/2020 17:48:13'!
test07AccountSummaryShouldReflectDepositsOnPortfoliosWithAccounts

	| portfolio account reporter |
	
	portfolio _ Portfolio new.
	account _ ReceptiveAccount new.
	reporter _ SummaryReporter for: portfolio.
	Deposit register: 100 on: account.
	
	portfolio add: account.
		
	self assert: [reporter accountSummary = (OrderedCollection with: 'Depósito por 100.' with: 'Balance = 100')]! !

!AccountReporterTest methodsFor: 'tests - account summary' stamp: 'fr 11/13/2020 17:48:32'!
test08AccountSummaryShouldReflectWithdrawsOnPortfoliosWithAccounts

	| portfolio account reporter |
	
	portfolio _ Portfolio new.
	account _ ReceptiveAccount new.
	reporter _ SummaryReporter for: portfolio.
	Withdraw register: 100 on: account.
	
	portfolio add: account.
		
	self assert: [reporter accountSummary = (OrderedCollection with: 'Extracción por 100.' with: 'Balance = -100')]! !

!AccountReporterTest methodsFor: 'tests - account summary' stamp: 'fr 11/13/2020 17:48:53'!
test09AccountSummaryShouldReflectOutgoingAndIncomingTransfersOnPortfoliosWithAccounts

	| portfolio account anotherAccount reporter |
	
	portfolio _ Portfolio new.
	account _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	reporter _ SummaryReporter for: portfolio.

	Transfer move: 10 from: account to: anotherAccount.
		
	portfolio add: account.
	portfolio add: anotherAccount.
		
	self assert: [reporter accountSummary = (OrderedCollection with: 'Salida por transferencia de 10.' with: 'Entrada por transferencia de 10.' with: 'Balance = 0')]! !

!AccountReporterTest methodsFor: 'tests - account summary' stamp: 'fr 11/13/2020 17:49:15'!
test10AccountSummaryShouldReflectDepositsOnPortfoliosWithPortfolios

	| portfolio account anotherPortfolio reporter |
	
	account _ ReceptiveAccount new.		
	portfolio _ Portfolio with: account.
	anotherPortfolio _ Portfolio with: portfolio.
	reporter _ SummaryReporter for: anotherPortfolio.

	Deposit register: 100 on: account.

		
	self assert: [reporter accountSummary = (OrderedCollection with: 'Depósito por 100.' with: 'Balance = 100')]! !

!AccountReporterTest methodsFor: 'tests - account summary' stamp: 'fr 11/13/2020 17:49:32'!
test11AccountSummaryShouldReflectWithdrawsOnPortfoliosWithPortfolios

	| portfolio account anotherPortfolio reporter |
	
	account _ ReceptiveAccount new.		
	portfolio _ Portfolio with: account.
	anotherPortfolio _ Portfolio with: portfolio.
	reporter _ SummaryReporter for: anotherPortfolio.

	Withdraw register: 100 on: account.

		
	self assert: [reporter accountSummary = (OrderedCollection with: 'Extracción por 100.' with: 'Balance = -100')]! !

!AccountReporterTest methodsFor: 'tests - account summary' stamp: 'fr 11/13/2020 17:49:52'!
test12AccountSummaryShouldReflectOutgoingAndIncomingTransfersOnPortfoliosWithPortfolios

	| portfolio account anotherPortfolio anotherAccount reporter |
	
	account _ ReceptiveAccount new.		
	anotherAccount _ ReceptiveAccount new.		
	portfolio _ Portfolio with: account.
	anotherPortfolio _ Portfolio with: portfolio.
	anotherPortfolio add: anotherAccount.
	reporter _ SummaryReporter for: anotherPortfolio.

	Transfer move: 100 from: account to: anotherAccount.

		
	self assert: [reporter accountSummary = (OrderedCollection with: 'Salida por transferencia de 100.' with: 'Entrada por transferencia de 100.' with: 'Balance = 0')]! !


!AccountReporterTest methodsFor: 'tests - net transfer' stamp: 'fr 11/13/2020 18:31:57'!
test13NetTransferForAccountWithNoTransactionsShouldBeZero

	| account reporter |
	
	account _ ReceptiveAccount new.
	reporter _ 	TransferNetReporter for: account .

	self assert: [reporter transferNet = 0]! !

!AccountReporterTest methodsFor: 'tests - net transfer' stamp: 'fr 11/13/2020 18:32:17'!
test14NetTransferForAccountWithAnOutgoingTransferShouldReflectItsValue

	| account anotherAccount reporter |
	
	account _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	reporter _ 	TransferNetReporter for: account .
	
	Transfer move: 100 from: account to: anotherAccount.
	
	self assert: [reporter transferNet = -100]! !

!AccountReporterTest methodsFor: 'tests - net transfer' stamp: 'fr 11/13/2020 18:32:30'!
test15NetTransferForAccountWithAnIncomingTransferShouldReflectItsValue

	| account anotherAccount reporter |
	
	account _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	reporter _ 	TransferNetReporter for: account .
	
	Transfer move: 100 from: anotherAccount to: account.
	
	self assert: [reporter transferNet = 100]! !

!AccountReporterTest methodsFor: 'tests - net transfer' stamp: 'fr 11/13/2020 18:32:41'!
test16NetTransferForAccountShouldNotReflectDeposits

	| account reporter |
	
	account _ ReceptiveAccount new.
	reporter _ 	TransferNetReporter for: account .
	
	Deposit register: 100 on: account. 
		
	self assert: [reporter transferNet = 0]! !

!AccountReporterTest methodsFor: 'tests - net transfer' stamp: 'fr 11/13/2020 18:32:51'!
test17NetTransferForAccountShouldNotReflectWithdraws

	| account reporter |
	
	account _ ReceptiveAccount new.
	reporter _ 	TransferNetReporter for: account .

	Withdraw register: 100 on: account. 
		
	self assert: [reporter transferNet = 0]! !

!AccountReporterTest methodsFor: 'tests - net transfer' stamp: 'fr 11/13/2020 18:33:07'!
test18NetTransferForPortfolioWithNoTransactionsShouldBeZero

	| portfolio reporter |
	
	portfolio _ Portfolio new.
	reporter _ 	TransferNetReporter for: portfolio .

	self assert: [reporter transferNet = 0]! !

!AccountReporterTest methodsFor: 'tests - net transfer' stamp: 'fr 11/13/2020 18:33:29'!
test19NetTransferForPortfolioWithAnOutgoingTransferShouldReflectItsValue

	| portfolio account anotherAccount reporter |
	
	account _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	portfolio _ Portfolio with: account.
	reporter _ TransferNetReporter for: portfolio.

	Transfer move: 10 from: account to: anotherAccount.
			
	self assert: [reporter transferNet = -10]! !

!AccountReporterTest methodsFor: 'tests - net transfer' stamp: 'fr 11/13/2020 18:33:45'!
test20NetTransferForPortfolioWithAnIncomingTransferShouldReflectItsValue

	| portfolio account anotherAccount reporter |
	
	account _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	portfolio _ Portfolio with: account.
	reporter _ TransferNetReporter for: portfolio.
	
	Transfer move: 10 from: anotherAccount to: account.
			
	self assert: [reporter transferNet = 10]! !

!AccountReporterTest methodsFor: 'tests - net transfer' stamp: 'fr 11/13/2020 18:33:57'!
test21NetTransferForPortfolioShouldNotReflectDeposits

	| portfolio account reporter |
	
	account _ ReceptiveAccount new.
	portfolio _ Portfolio with: account.
	reporter _ TransferNetReporter for: portfolio.
	
	Deposit register: 100 on: account. 
			
	self assert: [reporter transferNet = 0]! !

!AccountReporterTest methodsFor: 'tests - net transfer' stamp: 'fr 11/13/2020 18:34:26'!
test22NetTransferForPortfolioShouldNotReflectWithdraws

	| portfolio account reporter |
	
	account _ ReceptiveAccount new.
	portfolio _ Portfolio with: account.
	reporter _ TransferNetReporter for: portfolio.
	
	Withdraw register: 100 on: account. 
			
	self assert: [reporter transferNet = 0]! !

!AccountReporterTest methodsFor: 'tests - net transfer' stamp: 'fr 11/13/2020 18:34:51'!
test23NetTransferForPortfoliosWithPortfoliosShouldReflectOutgoingAndIncomingTransfers

	| portfolio account anotherPortfolio anotherAccount reporter |
	
	account _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	portfolio _ Portfolio with: account.
	anotherPortfolio _ Portfolio with: portfolio.
	reporter _ TransferNetReporter for: anotherPortfolio.

	Transfer 	move: 30 from: anotherAccount to: account. 
	Transfer 	move: 10 from: account to: anotherAccount. 	
				
	self assert: [reporter transferNet = 20]! !

!AccountReporterTest methodsFor: 'tests - net transfer' stamp: 'fr 11/13/2020 18:35:07'!
test24NetTransferForPortfoliosWithPortfoliosShouldNotRelfectDepositsOrWithdraws

	| portfolio account anotherPortfolio reporter |
		
	account _ ReceptiveAccount new.
	portfolio _ Portfolio with: account.
	anotherPortfolio _ Portfolio with: portfolio.
	reporter _ TransferNetReporter for: anotherPortfolio.
	
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
				
	self assert: [reporter transferNet = 0]! !


!classDefinition: #PortfolioReporterTest category: 'Portfolio-Part-II-Exercise'!
TestCase subclass: #PortfolioReporterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!PortfolioReporterTest methodsFor: 'as yet unclassified' stamp: 'fr 11/13/2020 20:05:39'!
test01

	| portfolio |
	portfolio _ Portfolio named: 'Portfolio de la familia'.
	
	self assert: [portfolio treeStructure = (OrderedCollection with: 'Portfolio de la familia')]! !

!PortfolioReporterTest methodsFor: 'as yet unclassified' stamp: 'fr 11/13/2020 20:06:02'!
test02

	| portfolio account |
	account _ ReceptiveAccount named: 'Cuenta de Juan'.
	portfolio _ Portfolio named: 'Portfolio de la familia' with: account.

	self assert: [portfolio treeStructure = (OrderedCollection with: 'Portfolio de la familia' with: ' Cuenta de Juan')]! !

!PortfolioReporterTest methodsFor: 'as yet unclassified' stamp: 'fr 11/13/2020 20:13:58'!
test03

	| portfolio account anotherAccount anotherPortfolio |
	account _ ReceptiveAccount named: 'Cuenta de Juan'.
	anotherAccount _ ReceptiveAccount named: 'Cuenta de Angeles'.
	portfolio _ Portfolio named: 'Portfolio de Angeles' with: anotherAccount.
	anotherPortfolio _ Portfolio named: 'Portfolio de la familia' with: portfolio with: account.
	

	self assert: [anotherPortfolio treeStructure = (OrderedCollection with: 'Portfolio de la familia' with: ' Portfolio de Angeles' with: '  Cuenta de Angeles' with: ' Cuenta de Juan')]! !

!PortfolioReporterTest methodsFor: 'as yet unclassified' stamp: 'fr 11/13/2020 22:10:19'!
test04

	| portfolio account anotherAccount expected |
	account _ ReceptiveAccount named: 'Cuenta de Fede'.
	anotherAccount _ ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account. 
	Transfer move: 10 from: account to: anotherAccount.
	Transfer move: 5 from: anotherAccount to: account.
	portfolio _ Portfolio named: 'Portfolio de Fede' with: account.
	expected _ OrderedCollection with: 'Portfolio de Fede'.
	expected add: ' Cuenta de Fede'.
	expected add: '  Depósito por 100.'.
	expected add: '  Extracción por 50.'.
	expected add: '  Salida por transferencia de 10.'.
	expected add: '  Entrada por transferencia de 5'.
	expected add: ' Balance = 45'.
	self assert: [portfolio specialReport = expected]! !


!classDefinition: #PortfolioTest category: 'Portfolio-Part-II-Exercise'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Part-II-Exercise'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/9/2020 06:00:12'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/9/2020 06:02:30'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account.
		
	self assert: 1 equals: account transactions size .
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferTest category: 'Portfolio-Part-II-Exercise'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'fr 11/11/2020 15:51:07'!
test01

	| account anotherAccount |
	
	account _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	
	Transfer move: 100 from: account to: anotherAccount.
	
	self assert: [account balance = -100 and: [anotherAccount balance = 100]]! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'fr 11/11/2020 15:54:25'!
test02

	| account anotherAccount transfer |
	
	account _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	
	transfer _ Transfer move: 100 from: account to: anotherAccount.
	
	self assert: [(account hasRegistered: transfer from) and: [anotherAccount hasRegistered: transfer to]]! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'fr 11/11/2020 15:57:11'!
test03

	| account anotherAccount transfer |
	
	account _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	
	transfer _ Transfer move: 100 from: account to: anotherAccount.
	
	self assert: [(transfer to isComplementedBy: transfer from) and: [transfer from isComplementedBy: transfer to]]! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'fr 11/11/2020 16:07:13'!
test04

	| account anotherAccount |
	
	account _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	
	self  should: [Transfer move: 0 from: account to: anotherAccount] 
		raise:  Error
		withMessageText: Transfer invalidTransferAmountErrorDescription! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'fr 11/11/2020 16:08:05'!
test05

	| account anotherAccount |
	
	account _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	
	self  should: [Transfer move: -1 from: account to: anotherAccount] 
		raise:  Error
		withMessageText: Transfer invalidTransferAmountErrorDescription! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'fr 11/11/2020 16:09:26'!
test06

	| account |
	
	account _ ReceptiveAccount new.
	
	self  should: [Transfer move: 10 from: account to: account] 
		raise:  Error
		withMessageText: Transfer canNotTransferToItselfErrorDescription! !


!classDefinition: #Account category: 'Portfolio-Part-II-Exercise'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !



!classDefinition: #Portfolio category: 'Portfolio-Part-II-Exercise'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'fr 11/12/2020 16:36:37'!
initializeNamed: aName 
	
	name _ aName.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'report' stamp: 'fr 11/13/2020 21:36:32'!
addToPortfolioReportWith: aPortfolioReporter 	
	
	aPortfolioReporter addPortfolioToReport: self! !

!Portfolio methodsFor: 'report' stamp: 'fr 11/13/2020 21:36:11'!
buildPortfolioReportWith: aPortfolioReporter 

	accounts do: [:anAccount |
		anAccount addToPortfolioReportWith: aPortfolioReporter 	
	]! !

!Portfolio methodsFor: 'report' stamp: 'fr 11/13/2020 20:09:37'!
buildTransactionReportWith: aReporter

	accounts do: [:anAccount | 
		anAccount buildTransactionReportWith: aReporter 	
	]! !

!Portfolio methodsFor: 'report' stamp: 'fr 11/13/2020 21:21:21'!
name

	^name! !

!Portfolio methodsFor: 'report' stamp: 'fr 11/13/2020 22:03:57'!
specialReport
	
	^OrderedCollection with: 'Portfolio de Fede' with: ' Balance = 0'
	! !

!Portfolio methodsFor: 'report' stamp: 'fr 11/13/2020 21:35:21'!
treeStructure
	
	| reporter |
	reporter _ TreeStructureReporter for: self.
	
	^reporter treeStructure
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Part-II-Exercise'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'NR 11/9/2020 06:01:26'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio!!'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!Portfolio class methodsFor: 'instance creation' stamp: 'fr 11/12/2020 16:36:07'!
named: aName
	
	^self new initializeNamed: aName ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'fr 11/12/2020 16:41:35'!
named: aName with: aReceptiveAccount 
	
	^(self with: aReceptiveAccount) initializeNamed: aName! !

!Portfolio class methodsFor: 'instance creation' stamp: 'fr 11/12/2020 16:49:08'!
named: aName with: aReceptiveAccount with: aPortfolio 
	
	^(self with: aReceptiveAccount with: aPortfolio) initializeNamed: aName! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Part-II-Exercise'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'fr 11/12/2020 16:41:03'!
initializeNamed: aName 
	
	name _ aName.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'NR 11/9/2020 05:56:36'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions copy! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'report' stamp: 'fr 11/13/2020 21:36:26'!
addToPortfolioReportWith: aPortfolioReporter 	
	
	aPortfolioReporter addReceptiveAccountToReport: self! !

!ReceptiveAccount methodsFor: 'report' stamp: 'fr 11/14/2020 19:44:45'!
buildTransactionReportWith: aReporter

	transactions do: [:aTransaction | 
		aTransaction addToReportWith: aReporter 
	]! !

!ReceptiveAccount methodsFor: 'report' stamp: 'fr 11/13/2020 21:21:26'!
name

	^name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Part-II-Exercise'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'fr 11/12/2020 16:40:17'!
named: aName 
	
	^self new initializeNamed: aName ! !


!classDefinition: #AccountReporter category: 'Portfolio-Part-II-Exercise'!
Object subclass: #AccountReporter
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReporter class' category: 'Portfolio-Part-II-Exercise'!
AccountReporter class
	instanceVariableNames: ''!

!AccountReporter class methodsFor: 'instance creation' stamp: 'fr 11/13/2020 18:29:51'!
for: aReceptiveAccount 
	
	^self new initializeFor: aReceptiveAccount ! !


!classDefinition: #SummaryReporter category: 'Portfolio-Part-II-Exercise'!
AccountReporter subclass: #SummaryReporter
	instanceVariableNames: 'accountSummary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!SummaryReporter methodsFor: 'initialization' stamp: 'fr 11/13/2020 18:28:52'!
initializeFor: aReceptiveAccount 

	accountSummary _ OrderedCollection new.
	account _ aReceptiveAccount.! !


!SummaryReporter methodsFor: 'summary' stamp: 'fr 11/13/2020 20:09:26'!
accountSummary
	
	account buildTransactionReportWith: self.
	self addAccountBalance.
	^accountSummary! !

!SummaryReporter methodsFor: 'summary' stamp: 'fr 11/13/2020 18:28:52'!
addAccountBalance

	accountSummary add: 'Balance = ',account balance asString! !

!SummaryReporter methodsFor: 'summary' stamp: 'fr 11/13/2020 18:28:52'!
addDepositByTransferToReport: aDepositByTransfer

	accountSummary add: 'Entrada por transferencia de ',aDepositByTransfer value asString,'.'


	 ! !

!SummaryReporter methodsFor: 'summary' stamp: 'fr 11/13/2020 18:28:52'!
addDepositToReport: aDeposit

	 accountSummary add: 'Depósito por ',aDeposit value asString,'.'! !

!SummaryReporter methodsFor: 'summary' stamp: 'fr 11/13/2020 18:28:52'!
addWithdrawByTransferToReport: aWithdrawByTransfer

	accountSummary add: 'Salida por transferencia de ',aWithdrawByTransfer value asString,'.'

	 ! !

!SummaryReporter methodsFor: 'summary' stamp: 'fr 11/13/2020 18:28:52'!
addWithdrawToReport: aWithdraw

	 accountSummary add: 'Extracción por ',aWithdraw value asString,'.'! !


!classDefinition: #TransferNetReporter category: 'Portfolio-Part-II-Exercise'!
AccountReporter subclass: #TransferNetReporter
	instanceVariableNames: 'transferNetBalance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!TransferNetReporter methodsFor: 'as yet unclassified' stamp: 'fr 11/13/2020 18:08:57'!
addDepositByTransferToReport: aDepositByTransfer

	transferNetBalance _ aDepositByTransfer affectBalance: transferNetBalance ! !

!TransferNetReporter methodsFor: 'as yet unclassified' stamp: 'fr 11/13/2020 18:10:03'!
addDepositToReport: aDeposit
! !

!TransferNetReporter methodsFor: 'as yet unclassified' stamp: 'fr 11/13/2020 18:09:11'!
addWithdrawByTransferToReport: aDepositByTransfer

	transferNetBalance _ aDepositByTransfer affectBalance: transferNetBalance ! !

!TransferNetReporter methodsFor: 'as yet unclassified' stamp: 'fr 11/13/2020 18:09:56'!
addWithdrawToReport: aWithdraw
! !

!TransferNetReporter methodsFor: 'as yet unclassified' stamp: 'fr 11/13/2020 20:09:30'!
transferNet

	account buildTransactionReportWith: self.
	^transferNetBalance

	! !


!TransferNetReporter methodsFor: 'initialization' stamp: 'fr 11/13/2020 18:24:37'!
initializeFor: aReceptiveAccount 
	
	transferNetBalance _ 0.
	account _ aReceptiveAccount.! !


!classDefinition: #AccountTransaction category: 'Portfolio-Part-II-Exercise'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Part-II-Exercise'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Part-II-Exercise'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'fr 11/12/2020 21:53:00'!
addToReportWith: aReporter 

	^aReporter addDepositToReport: self! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Part-II-Exercise'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferTransaction category: 'Portfolio-Part-II-Exercise'!
AccountTransaction subclass: #TransferTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!TransferTransaction methodsFor: 'complementary leg' stamp: 'fr 11/11/2020 16:12:35'!
isComplementeBy: aTransferTransaction

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransaction class' category: 'Portfolio-Part-II-Exercise'!
TransferTransaction class
	instanceVariableNames: ''!

!TransferTransaction class methodsFor: 'instance creation' stamp: 'fr 11/11/2020 16:11:11'!
register: transferAmount on: aReceptiveAccount for: aTransfer 
	
	^(self register: transferAmount on: aReceptiveAccount) forTransfer: aTransfer ! !


!classDefinition: #DepositByTransference category: 'Portfolio-Part-II-Exercise'!
TransferTransaction subclass: #DepositByTransference
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!DepositByTransference methodsFor: 'initialization' stamp: 'fr 11/11/2020 16:02:56'!
forTransfer: aTransfer 
	
	transfer _ aTransfer ! !


!DepositByTransference methodsFor: 'complementary leg' stamp: 'fr 11/11/2020 16:03:44'!
isComplementedBy: aWithdrawByTransference 
	
	^transfer from = aWithdrawByTransference ! !


!DepositByTransference methodsFor: 'balance' stamp: 'fr 11/11/2020 16:05:35'!
affectBalance: aBalance

	^aBalance + transfer transferValue 
	
	! !


!DepositByTransference methodsFor: 'value' stamp: 'fr 11/13/2020 17:44:04'!
addToReportWith: aReporter

	^aReporter addDepositByTransferToReport: self ! !

!DepositByTransference methodsFor: 'value' stamp: 'fr 11/11/2020 16:32:51'!
value
	
	^transfer transferValue ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DepositByTransference class' category: 'Portfolio-Part-II-Exercise'!
DepositByTransference class
	instanceVariableNames: ''!

!DepositByTransference class methodsFor: 'instance creation' stamp: 'fr 11/11/2020 16:02:40'!
for: transferAmount 
	
	^self new ! !


!classDefinition: #WithdrawByTransference category: 'Portfolio-Part-II-Exercise'!
TransferTransaction subclass: #WithdrawByTransference
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!WithdrawByTransference methodsFor: 'initialization' stamp: 'fr 11/11/2020 16:01:36'!
forTransfer: aTransfer 
	
	transfer _ aTransfer! !


!WithdrawByTransference methodsFor: 'complementary leg' stamp: 'fr 11/11/2020 16:04:02'!
isComplementedBy: aDepositByTransference 
	
	^transfer to = aDepositByTransference ! !


!WithdrawByTransference methodsFor: 'balance' stamp: 'fr 11/11/2020 16:04:38'!
affectBalance: aBalance
	
	^aBalance - transfer transferValue
	! !


!WithdrawByTransference methodsFor: 'value' stamp: 'fr 11/12/2020 21:53:40'!
addToReportWith: aReporter 

	^aReporter addWithdrawByTransferToReport: self ! !

!WithdrawByTransference methodsFor: 'value' stamp: 'fr 11/11/2020 16:29:16'!
value
	
	^transfer transferValue ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WithdrawByTransference class' category: 'Portfolio-Part-II-Exercise'!
WithdrawByTransference class
	instanceVariableNames: ''!

!WithdrawByTransference class methodsFor: 'instance creation' stamp: 'fr 11/11/2020 16:01:07'!
for: transferenceAmount 
	
	^self new
! !


!classDefinition: #Withdraw category: 'Portfolio-Part-II-Exercise'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'fr 11/12/2020 21:53:52'!
addToReportWith: aReporter 

	^aReporter addWithdrawToReport: self ! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Part-II-Exercise'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #PortfolioReporter category: 'Portfolio-Part-II-Exercise'!
Object subclass: #PortfolioReporter
	instanceVariableNames: 'portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioReporter class' category: 'Portfolio-Part-II-Exercise'!
PortfolioReporter class
	instanceVariableNames: ''!

!PortfolioReporter class methodsFor: 'instance creation' stamp: 'fr 11/13/2020 21:42:18'!
for: aPortfolio 
	
	^self new initializeFor: aPortfolio ! !


!classDefinition: #TreeStructureReporter category: 'Portfolio-Part-II-Exercise'!
PortfolioReporter subclass: #TreeStructureReporter
	instanceVariableNames: 'tree indentationOffset'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!TreeStructureReporter methodsFor: 'as yet unclassified' stamp: 'fr 11/13/2020 21:09:48'!
addNameWithIndentation: anAccount

	tree add: (self nameWithIndentation: anAccount)! !

!TreeStructureReporter methodsFor: 'as yet unclassified' stamp: 'fr 11/13/2020 21:32:50'!
addPortfolioToReport: aPortfolio
	
	self addNameWithIndentation: aPortfolio.
	self increaseOffset.
	aPortfolio buildPortfolioReportWith: self.
	self decreaseOffset.! !

!TreeStructureReporter methodsFor: 'as yet unclassified' stamp: 'fr 11/13/2020 21:05:52'!
addReceptiveAccountToReport: aReceptiveAccount
	
	self addNameWithIndentation: aReceptiveAccount.! !

!TreeStructureReporter methodsFor: 'as yet unclassified' stamp: 'fr 11/13/2020 21:33:25'!
changeOffset: aValueToAdd

	^ indentationOffset _ indentationOffset + aValueToAdd ! !

!TreeStructureReporter methodsFor: 'as yet unclassified' stamp: 'fr 11/13/2020 21:33:34'!
decreaseOffset

	^ self changeOffset: - 1! !

!TreeStructureReporter methodsFor: 'as yet unclassified' stamp: 'fr 11/13/2020 21:33:47'!
increaseOffset

	^ self changeOffset: 1! !

!TreeStructureReporter methodsFor: 'as yet unclassified' stamp: 'fr 11/13/2020 21:17:21'!
indentation
	
	| indentation |
	indentation _ ''.
	indentationOffset timesRepeat: [indentation _ indentation,' '].
	^indentation! !

!TreeStructureReporter methodsFor: 'as yet unclassified' stamp: 'fr 11/13/2020 21:12:19'!
nameWithIndentation: anAccount

	^self indentation,anAccount name! !

!TreeStructureReporter methodsFor: 'as yet unclassified' stamp: 'fr 11/13/2020 21:25:27'!
treeStructure
	
	self addPortfolioToReport: portfolio.
	^tree! !


!TreeStructureReporter methodsFor: 'initialization' stamp: 'fr 11/13/2020 21:25:36'!
initializeFor: aPortfolio 
	
	indentationOffset _ 0.
	tree _ OrderedCollection new.
	portfolio _ aPortfolio.! !


!classDefinition: #Transfer category: 'Portfolio-Part-II-Exercise'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdraw deposit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!Transfer methodsFor: 'initialization' stamp: 'fr 11/11/2020 16:05:14'!
initializeMove: transferValue from: aReceptiveAccountToMoveFrom to: aReceptiveAccountToMoveTo 
		
	value _ transferValue.
	withdraw _ WithdrawByTransference register: transferValue on: aReceptiveAccountToMoveFrom for: self.
	deposit _ DepositByTransference register: transferValue on: aReceptiveAccountToMoveTo for: self ! !


!Transfer methodsFor: 'transfer legs' stamp: 'fr 11/11/2020 15:55:41'!
from
	
	^withdraw ! !

!Transfer methodsFor: 'transfer legs' stamp: 'fr 11/11/2020 15:56:29'!
to
	
	^deposit ! !


!Transfer methodsFor: 'value' stamp: 'fr 11/11/2020 16:04:53'!
transferValue
	
	^value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Part-II-Exercise'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'fr 11/12/2020 16:22:59'!
failIf: aReceptiveAccountToMoveFrom isEqualTo: aReceptiveAccountToMoveTo

	^ aReceptiveAccountToMoveFrom = aReceptiveAccountToMoveTo ifTrue: [self signalCanNotTransferToItself]! !

!Transfer class methodsFor: 'instance creation' stamp: 'fr 11/12/2020 16:22:03'!
failIfInvalidTransferAmount: transferValue

	^ transferValue <= 0 ifTrue: [self signalInvalidTransfeerAmount]! !

!Transfer class methodsFor: 'instance creation' stamp: 'fr 11/12/2020 16:22:59'!
move: transferAmount from: aReceptiveAccountToMoveFrom to: aReceptiveAccountToMoveTo 
	
	self failIfInvalidTransferAmount: transferAmount.
	self failIf: aReceptiveAccountToMoveFrom isEqualTo: aReceptiveAccountToMoveTo.
	
	^self new initializeMove: transferAmount from: aReceptiveAccountToMoveFrom to: aReceptiveAccountToMoveTo ! !

!Transfer class methodsFor: 'instance creation' stamp: 'fr 11/12/2020 16:22:27'!
signalCanNotTransferToItself

	^ self error: self canNotTransferToItselfErrorDescription! !

!Transfer class methodsFor: 'instance creation' stamp: 'fr 11/12/2020 16:21:31'!
signalInvalidTransfeerAmount

	^ self error: self invalidTransferAmountErrorDescription! !


!Transfer class methodsFor: 'error description' stamp: 'fr 11/11/2020 16:09:14'!
canNotTransferToItselfErrorDescription
	
	^'Can not transfer to itself'! !

!Transfer class methodsFor: 'error description' stamp: 'fr 11/11/2020 16:07:33'!
invalidTransferAmountErrorDescription
	
	^'Invalid transfer amount'! !

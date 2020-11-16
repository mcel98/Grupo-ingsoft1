!classDefinition: #AccountReporterTest category: 'Portfolio-Part-II-Exercise'!
TestCase subclass: #AccountReporterTest
	instanceVariableNames: 'account reporter anotherAccount portfolio anotherPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!AccountReporterTest methodsFor: 'tests - account summary' stamp: 'fr 11/16/2020 13:08:48'!
test01AccountSummaryForAccountWithNoTransactionsShouldJustShowBalanceZero

	self createNewAccountAndSummaryReporterForIt.
	
	self  assert: reporter accountSummary 
		equals: (OrderedCollection with: 'Balance = 0').! !

!AccountReporterTest methodsFor: 'tests - account summary' stamp: 'fr 11/16/2020 13:09:36'!
test02AccountSummaryShouldReflectDepositsOnAccounts
		
	self  createWith: [self createNewAccountAndSummaryReporterForIt] 
		perform: [	Deposit register: 100 on: account] 
		assertTransactionIsReflectedWith: 'Depósito por 100.' 
		and: 'Balance = 100'! !

!AccountReporterTest methodsFor: 'tests - account summary' stamp: 'fr 11/16/2020 13:09:36'!
test03AccountSummaryShouldReflectWithdrawsOnAccounts
			
	self  createWith: [self createNewAccountAndSummaryReporterForIt] 
		perform: [	Withdraw register: 100 on: account] 
		assertTransactionIsReflectedWith: 'Extracción por 100.' 
		and: 'Balance = -100'! !

!AccountReporterTest methodsFor: 'tests - account summary' stamp: 'fr 11/16/2020 13:09:36'!
test04AccountSummaryShouldReflectOutgoingTransfersOnAccounts	
		
	self  createWith: [self createNewAccountsAndSummaryReporterForOne] 
		perform: [	Transfer move: 100 from: account to: anotherAccount] 
		assertTransactionIsReflectedWith: 'Salida por transferencia de 100.' 
		and: 'Balance = -100'! !

!AccountReporterTest methodsFor: 'tests - account summary' stamp: 'fr 11/16/2020 13:09:36'!
test05AccountSummaryShouldReflectIncomingTransfersOnAccounts		
		
	self  createWith: [self createNewAccountsAndSummaryReporterForOne] 
		perform: [	Transfer move: 100 from: anotherAccount to: account] 
		assertTransactionIsReflectedWith: 'Entrada por transferencia de 100.' 
		and: 'Balance = 100'! !

!AccountReporterTest methodsFor: 'tests - account summary' stamp: 'fr 11/16/2020 02:53:16'!
test06AccountSummaryForPortfolioWithNoTransactionsShouldJustShowBalanceZero
	
	portfolio _ Portfolio new.
	reporter _ SummaryReporter for: portfolio.
	
	self  assert: reporter accountSummary 
		equals: (OrderedCollection with: 'Balance = 0')! !

!AccountReporterTest methodsFor: 'tests - account summary' stamp: 'fr 11/16/2020 13:11:08'!
test07AccountSummaryShouldReflectDepositsOnPortfoliosWithAccounts
		
	self  createWith: [self createSummaryReporterForPortfolioWithAccount] 
		perform: [Deposit register: 100 on: account] 
		assertTransactionIsReflectedWith: 'Depósito por 100.' 
		and: 'Balance = 100'! !

!AccountReporterTest methodsFor: 'tests - account summary' stamp: 'fr 11/16/2020 13:14:59'!
test08AccountSummaryShouldReflectWithdrawsOnPortfoliosWithAccounts
		
	self  createWith: [self createSummaryReporterForPortfolioWithAccount] 
		perform: [Withdraw register: 100 on: account] 
		assertTransactionIsReflectedWith: 'Extracción por 100.' 
		and: 'Balance = -100'! !

!AccountReporterTest methodsFor: 'tests - account summary' stamp: 'fr 11/16/2020 02:53:16'!
test09AccountSummaryShouldReflectOutgoingAndIncomingTransfersOnPortfoliosWithAccounts

	self createNewAccount.	
	self createAnotherNewAccount.
	portfolio _ Portfolio with: account with: anotherAccount.
	reporter _ SummaryReporter for: portfolio.

	Transfer move: 10 from: account to: anotherAccount.
		
	self  assert: reporter accountSummary 
		equals: (OrderedCollection with: 'Salida por transferencia de 10.' with: 'Entrada por transferencia de 10.' with: 'Balance = 0')! !

!AccountReporterTest methodsFor: 'tests - account summary' stamp: 'fr 11/16/2020 13:17:12'!
test10AccountSummaryShouldReflectDepositsOnPortfoliosWithPortfolios
			
	self  createWith: [self createSummaryReporterForPortfolioWithPortfolioWithAccount] 
		perform: [Deposit register: 100 on: account] 
		assertTransactionIsReflectedWith: 'Depósito por 100.' 
		and: 'Balance = 100'! !

!AccountReporterTest methodsFor: 'tests - account summary' stamp: 'fr 11/16/2020 13:17:48'!
test11AccountSummaryShouldReflectWithdrawsOnPortfoliosWithPortfolios
		
	self  createWith: [self createSummaryReporterForPortfolioWithPortfolioWithAccount] 
		perform: [Withdraw register: 100 on: account] 
		assertTransactionIsReflectedWith: 'Extracción por 100.' 
		and: 'Balance = -100'! !

!AccountReporterTest methodsFor: 'tests - account summary' stamp: 'fr 11/16/2020 02:53:20'!
test12AccountSummaryShouldReflectOutgoingAndIncomingTransfersOnPortfoliosWithPortfoliosAndAccounts

	self createPortfolioWithPortfolioWithAccount.
	self createAnotherNewAccount.
	anotherPortfolio add: anotherAccount.
	reporter _ SummaryReporter for: anotherPortfolio.

	Transfer move: 100 from: account to: anotherAccount.

		
	self  assert: reporter accountSummary 
		equals: (OrderedCollection with: 'Salida por transferencia de 100.' with: 'Entrada por transferencia de 100.' with: 'Balance = 0')! !


!AccountReporterTest methodsFor: 'tests - net transfer' stamp: 'fr 11/16/2020 13:25:58'!
test13NetTransferForAccountWithNoTransactionsShouldBeZero
	
	self  createWith: [self createNewAccountAndTransferNetReporterForIt] 
		perform: [] 
		assertTransactionIsReflectedWithValue: 0! !

!AccountReporterTest methodsFor: 'tests - net transfer' stamp: 'fr 11/16/2020 13:27:00'!
test14NetTransferForAccountWithAnOutgoingTransferShouldReflectItsValue
	
	self  createWith: [				
					self createNewAccountAndTransferNetReporterForIt.
					self createAnotherNewAccount.
				  ] 
		perform: [Transfer move: 100 from: account to: anotherAccount] 
		assertTransactionIsReflectedWithValue: -100! !

!AccountReporterTest methodsFor: 'tests - net transfer' stamp: 'fr 11/16/2020 13:27:35'!
test15NetTransferForAccountWithAnIncomingTransferShouldReflectItsValue
	
	self  createWith: [				
					self createNewAccountAndTransferNetReporterForIt.
					self createAnotherNewAccount.
				  ] 
		perform: [Transfer move: 100 from: anotherAccount to: account] 
		assertTransactionIsReflectedWithValue: 100! !

!AccountReporterTest methodsFor: 'tests - net transfer' stamp: 'fr 11/16/2020 13:28:58'!
test16NetTransferForAccountShouldNotReflectDeposits	
	
	self  createWith: [self createNewAccountAndTransferNetReporterForIt] 
		perform: [Deposit register: 100 on: account] 
		assertTransactionIsReflectedWithValue: 0! !

!AccountReporterTest methodsFor: 'tests - net transfer' stamp: 'fr 11/16/2020 13:29:23'!
test17NetTransferForAccountShouldNotReflectWithdraws
	
	self  createWith: [self createNewAccountAndTransferNetReporterForIt] 
		perform: [Withdraw register: 100 on: account] 
		assertTransactionIsReflectedWithValue: 0! !

!AccountReporterTest methodsFor: 'tests - net transfer' stamp: 'fr 11/16/2020 13:56:30'!
test18NetTransferForPortfolioWithNoTransactionsShouldBeZero
	
	self createWith: [
					portfolio _ Portfolio new.
					reporter _ 	TransferNetReporter for: portfolio
				 ] 
		perform: [] 
		assertTransactionIsReflectedWithValue: 0! !

!AccountReporterTest methodsFor: 'tests - net transfer' stamp: 'fr 11/16/2020 13:33:34'!
test19NetTransferForPortfolioWithAccountWithAnOutgoingTransferShouldReflectItsValue
	
	self  createWith: [
					self createTransferNetReporterForPortfolioWithAccount.
					self createAnotherNewAccount.	
				  ] 
		perform: [Transfer move: 10 from: account to: anotherAccount] 
		assertTransactionIsReflectedWithValue: -10! !

!AccountReporterTest methodsFor: 'tests - net transfer' stamp: 'fr 11/16/2020 13:33:25'!
test20NetTransferForPortfolioWithAccountWithAnIncomingTransferShouldReflectItsValue
	
	self  createWith: [
					self createTransferNetReporterForPortfolioWithAccount.
					self createAnotherNewAccount.	
				  ] 
		perform: [Transfer move: 10 from: anotherAccount to: account ] 
		assertTransactionIsReflectedWithValue: 10! !

!AccountReporterTest methodsFor: 'tests - net transfer' stamp: 'fr 11/16/2020 13:32:58'!
test21NetTransferForPortfolioWithAccountShouldNotReflectDeposits
	
	self  createWith: [self createTransferNetReporterForPortfolioWithAccount] 
		perform: [Deposit register: 100 on: account] 
		assertTransactionIsReflectedWithValue: 0! !

!AccountReporterTest methodsFor: 'tests - net transfer' stamp: 'fr 11/16/2020 13:34:08'!
test22NetTransferForPortfolioWithAccountShouldNotReflectWithdraws
	
	self  createWith: [self createTransferNetReporterForPortfolioWithAccount] 
		perform: [Withdraw register: 100 on: account] 
		assertTransactionIsReflectedWithValue: 0! !

!AccountReporterTest methodsFor: 'tests - net transfer' stamp: 'fr 11/16/2020 13:35:16'!
test23NetTransferForPortfoliosWithPortfoliosShouldReflectOutgoingAndIncomingTransfers
	
	self  createWith: [
					self createTransferNetReporterForPortfolioWithPortfolioWithAccount.
					self createAnotherNewAccount
				  ] 
		perform: [
					Transfer 	move: 30 from: anotherAccount to: account. 
					Transfer 	move: 10 from: account to: anotherAccount
			      ] 
		assertTransactionIsReflectedWithValue: 20! !

!AccountReporterTest methodsFor: 'tests - net transfer' stamp: 'fr 11/16/2020 13:54:47'!
test24NetTransferForPortfoliosWithPortfoliosShouldNotRelfectDepositsOrWithdraws
	
	self createWith: [self createTransferNetReporterForPortfolioWithPortfolioWithAccount] 
		perform: [
					Deposit register: 100 on: account.
					Withdraw register: 50 on: account
			      ] 
		assertTransactionIsReflectedWithValue: 0! !


!AccountReporterTest methodsFor: 'private' stamp: 'fr 11/16/2020 02:53:26'!
createAnotherNewAccount

	anotherAccount _ ReceptiveAccount new! !

!AccountReporterTest methodsFor: 'private' stamp: 'fr 11/16/2020 02:53:06'!
createNewAccount

	account _ ReceptiveAccount new! !

!AccountReporterTest methodsFor: 'private' stamp: 'fr 11/16/2020 02:53:09'!
createNewAccountAndSummaryReporterForIt
	
	self createNewAccount.
	reporter _ SummaryReporter for: account.! !

!AccountReporterTest methodsFor: 'private' stamp: 'fr 11/16/2020 02:54:27'!
createNewAccountAndTransferNetReporterForIt
	
	self createNewAccount.
	reporter _ TransferNetReporter for: account.! !

!AccountReporterTest methodsFor: 'private' stamp: 'fr 11/16/2020 02:40:23'!
createNewAccountsAndSummaryReporterForOne

	self createNewAccountAndSummaryReporterForIt.
	self createAnotherNewAccount! !

!AccountReporterTest methodsFor: 'private' stamp: 'fr 11/16/2020 02:53:16'!
createPortfolioWithAccount

	self createNewAccount.
	portfolio _ Portfolio with: account! !

!AccountReporterTest methodsFor: 'private' stamp: 'fr 11/16/2020 02:53:20'!
createPortfolioWithPortfolioWithAccount

	self createPortfolioWithAccount.
	anotherPortfolio _ Portfolio with: portfolio! !

!AccountReporterTest methodsFor: 'private' stamp: 'fr 11/16/2020 02:57:08'!
createSummaryReporterForPortfolioWithAccount

	self createPortfolioWithAccount.
	reporter _ SummaryReporter for: portfolio! !

!AccountReporterTest methodsFor: 'private' stamp: 'fr 11/16/2020 02:53:20'!
createSummaryReporterForPortfolioWithPortfolioWithAccount

	self createPortfolioWithPortfolioWithAccount.
	reporter _ SummaryReporter for: anotherPortfolio! !

!AccountReporterTest methodsFor: 'private' stamp: 'fr 11/16/2020 02:57:23'!
createTransferNetReporterForPortfolioWithAccount

	self createPortfolioWithAccount.
	reporter _ TransferNetReporter for: portfolio! !

!AccountReporterTest methodsFor: 'private' stamp: 'fr 11/16/2020 03:00:48'!
createTransferNetReporterForPortfolioWithPortfolioWithAccount

	self createPortfolioWithPortfolioWithAccount.
	reporter _ TransferNetReporter for: anotherPortfolio! !

!AccountReporterTest methodsFor: 'private' stamp: 'fr 11/16/2020 13:09:59'!
createWith: aCreationBlock perform: aTransactionBlock assertTransactionIsReflectedWith: aTransactionString and: aBalanceString

	aCreationBlock value.	
	
	aTransactionBlock value.
	
	self  assert: reporter accountSummary 
		equals: (OrderedCollection with: aTransactionString with: aBalanceString)! !

!AccountReporterTest methodsFor: 'private' stamp: 'fr 11/16/2020 13:24:56'!
createWith: aCreationBlock perform: aTransactionBlock		assertTransactionIsReflectedWithValue: aTransferNetValue 

	aCreationBlock value.
	
	aTransactionBlock value.
	
	self assert: reporter transferNet equals: aTransferNetValue! !


!classDefinition: #PortfolioReporterTest category: 'Portfolio-Part-II-Exercise'!
TestCase subclass: #PortfolioReporterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!PortfolioReporterTest methodsFor: 'tests - tree structure' stamp: 'fr 11/16/2020 01:52:10'!
test01TreeStructureReportForEmptyPortfolioWorksAsExpected

	| portfolio reporter |
	
	portfolio _ Portfolio named: 'Portfolio de la familia'.
	reporter _ TreeStructureReporter for: portfolio.

	self assert: reporter treeStructure equals: (OrderedCollection with: 'Portfolio de la familia')! !

!PortfolioReporterTest methodsFor: 'tests - tree structure' stamp: 'fr 11/16/2020 01:52:02'!
test02TreeStructureReportForPortfolioWithAccountsWorksAsExpected

	| portfolio account reporter |
	
	account _ ReceptiveAccount named: 'Cuenta de Juan'.
	portfolio _ Portfolio named: 'Portfolio de la familia' with: account.
	reporter _ TreeStructureReporter for: portfolio.

	self assert: reporter treeStructure equals: (OrderedCollection with: 'Portfolio de la familia' with: ' Cuenta de Juan')! !

!PortfolioReporterTest methodsFor: 'tests - tree structure' stamp: 'fr 11/16/2020 01:51:32'!
test03TreeStructureReportForPortfolioWithAccountsAndPortfoliosWorksAsExpected

	| anotherPortfolio account anotherAccount portfolio reporter |
	
	account _ ReceptiveAccount named: 'Cuenta de Juan'.
	anotherAccount _ ReceptiveAccount named: 'Cuenta de Angeles'.
	
	anotherPortfolio _ Portfolio named: 'Portfolio de Angeles' with: anotherAccount.
	portfolio _ Portfolio named: 'Portfolio de la familia' with: anotherPortfolio with: account.
	
	reporter _ TreeStructureReporter for: portfolio.

	self assert: reporter treeStructure equals: (OrderedCollection with: 'Portfolio de la familia' with: ' Portfolio de Angeles' with: '  Cuenta de Angeles' with: ' Cuenta de Juan')! !

!PortfolioReporterTest methodsFor: 'tests - tree structure' stamp: 'fr 11/16/2020 01:51:41'!
test04AccountsShouldUseADefaultNameIfNoneIsSpecified

	| portfolio account reporter |
	account _ ReceptiveAccount new.
	portfolio _ Portfolio with: account.
	reporter _ TreeStructureReporter for: portfolio.


	self assert: reporter treeStructure equals: (OrderedCollection with: 'Un portfolio' with: ' Una cuenta')! !


!PortfolioReporterTest methodsFor: 'tests - special tree' stamp: 'fr 11/16/2020 01:48:19'!
test05SpecialReportForEmptyPortfolioWorksAsExpected

	| portfolio reporter |
	
	portfolio _ Portfolio named: 'Portfolio de la familia'.
	reporter _ SpecialTreeReporter for: portfolio.

	self assert: reporter specialReport equals: (OrderedCollection with: 'Portfolio de la familia' with: ' Balance = 0')! !

!PortfolioReporterTest methodsFor: 'tests - special tree' stamp: 'fr 11/16/2020 01:51:08'!
test06SpecialReportForPortfolioWithAccountsWithAnyKindOfTransactionsWorksAsExpected

	| portfolio account anotherAccount reporter |
	
	account _ ReceptiveAccount named: 'Cuenta de la familia'.
	anotherAccount _ ReceptiveAccount new.
	
	portfolio _ Portfolio named: 'Portfolio de la familia' with: account.
	
	reporter _ SpecialTreeReporter for: portfolio.
	
	self performRegularTransactionsWith: account asWellAsTransferTransactionsWithItAnd: anotherAccount.
	self assert: reporter specialReport equals: self expectedReportForPortfolioWithAccounts! !

!PortfolioReporterTest methodsFor: 'tests - special tree' stamp: 'fr 11/16/2020 01:51:01'!
test07SpecialReportForPortfolioWithAccountsAndPortfoliosWithAnyKindOfTransactionsWorksAsExpected

	| portfolio account anotherAccount anotherPortfolio reporter |
	
	account _ ReceptiveAccount named: 'Cuenta de la familia'.
	anotherAccount _ ReceptiveAccount named: 'Cuenta de Juan'.
	
	anotherPortfolio _ Portfolio named: 'Portfolio de Juan' with: anotherAccount.
	portfolio _ Portfolio named: 'Portfolio de la familia' with: account with: anotherPortfolio.
	
	reporter _ SpecialTreeReporter for: portfolio.
	
	self performRegularTransactionsWith: account asWellAsTransferTransactionsWithItAnd: anotherAccount.	
	self assert: reporter specialReport equals: self expectedReportForPortfolioWithAccountsAndPortfolios! !


!PortfolioReporterTest methodsFor: 'private - special tree' stamp: 'fr 11/16/2020 01:44:58'!
expectedReportForPortfolioWithAccounts
	
	| expectedReport |
	
	expectedReport _ OrderedCollection with: 'Portfolio de la familia'.
	expectedReport add: ' Cuenta de la familia'.
	expectedReport add: '  Depósito por 100.'.
	expectedReport add: '  Extracción por 50.'.
	expectedReport add: '  Salida por transferencia de 10.'.
	expectedReport add: '  Entrada por transferencia de 5.'.
	expectedReport add: '  Balance = 45'.
	expectedReport add: ' Balance = 45'.
	
	^expectedReport
	! !

!PortfolioReporterTest methodsFor: 'private - special tree' stamp: 'fr 11/16/2020 01:45:50'!
expectedReportForPortfolioWithAccountsAndPortfolios

	| expectedReport |
	
	expectedReport _ OrderedCollection with: 'Portfolio de la familia'.
	expectedReport add: ' Cuenta de la familia'.
	expectedReport add: '  Depósito por 100.'.
	expectedReport add: '  Extracción por 50.'.
	expectedReport add: '  Salida por transferencia de 10.'.
	expectedReport add: '  Entrada por transferencia de 5.'.
	expectedReport add: '  Balance = 45'.
	expectedReport add: ' Portfolio de Juan'.
	expectedReport add: '  Cuenta de Juan'.
	expectedReport add: '   Entrada por transferencia de 10.'.
	expectedReport add: '   Salida por transferencia de 5.'.
	expectedReport add: '   Balance = 5'.
	expectedReport add: '  Balance = 5'.
	expectedReport add: ' Balance = 50'.
	
	^expectedReport! !

!PortfolioReporterTest methodsFor: 'private - special tree' stamp: 'fr 11/16/2020 01:43:07'!
performRegularTransactionsWith: anAccount asWellAsTransferTransactionsWithItAnd: anotherAccount

	Deposit register: 100 on: anAccount.
	Withdraw register: 50 on: anAccount.
	Transfer move: 10 from: anAccount to: anotherAccount.
	Transfer move: 5 from: anotherAccount to: anAccount! !


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
	instanceVariableNames: 'account anotherAccount transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!TransferTest methodsFor: 'tests' stamp: 'fr 11/16/2020 01:08:06'!
test01TransferMovesMoneyAffectingBalancesAsExpected
	
	self  createAccountsTransfer: [:aTransfer | ] 
		assert: [	self assert: account balance equals: -100] 
		and: [	self assert: anotherAccount balance equals: 100]
! !

!TransferTest methodsFor: 'tests' stamp: 'fr 11/16/2020 01:05:58'!
test02AccountsThatParticipateInTheTransferRegisterTheCorrespondingLeg
	
	self  createAccountsTransfer: [:aTransfer | transfer _ aTransfer] 
		assert: [	self assert: (account hasRegistered: transfer withdrawLeg)] 
		and: [	self assert: (anotherAccount hasRegistered: transfer depositLeg)]! !

!TransferTest methodsFor: 'tests' stamp: 'fr 11/16/2020 01:07:04'!
test03LegsKnowTheirComplementaryLegThroughTheTransfer

	self  createAccountsTransfer: [:aTransfer | transfer _ aTransfer] 
		assert: [self assert: (transfer depositLeg isComplementedBy: transfer withdrawLeg)] 
		and: [	self assert: (transfer withdrawLeg isComplementedBy: transfer depositLeg)]! !

!TransferTest methodsFor: 'tests' stamp: 'fr 11/16/2020 01:10:11'!
test04TransferValueCanNotBeZero

	self createAccountsAndAssertTransferFailsForValue: 0! !

!TransferTest methodsFor: 'tests' stamp: 'fr 11/16/2020 01:10:25'!
test05TransferValueCanNotBeNegative

	self createAccountsAndAssertTransferFailsForValue: -1! !

!TransferTest methodsFor: 'tests' stamp: 'fr 11/16/2020 01:00:44'!
test06TransferCanNotMoveMoneyFromAnAccountToItself
	
	self createNewAccount.
		
	self  should: [Transfer move: 10 from: account to: account] 
		raise:  Error - MessageNotUnderstood 
		withMessageText: Transfer canNotTransferToItselfErrorDescription! !


!TransferTest methodsFor: 'private' stamp: 'fr 11/16/2020 01:09:26'!
createAccountsAndAssertTransferFailsForValue: aTransferValue

	self createNewAccounts.

	self  should: [Transfer move: aTransferValue from: account to: anotherAccount] 
		raise:  Error - MessageNotUnderstood 
		withMessageText: Transfer invalidTransferAmountErrorDescription! !

!TransferTest methodsFor: 'private' stamp: 'fr 11/16/2020 01:04:41'!
createAccountsTransfer: aTransferBlock assert: aBlockToAssert and: anotherBlockToAssert

	self createNewAccounts.
	
	aTransferBlock value: self transfer100FromAccountToAnotherAccount.
	
	aBlockToAssert value.
	anotherBlockToAssert value! !

!TransferTest methodsFor: 'private' stamp: 'fr 11/16/2020 01:07:47'!
createNewAccount

	account _ ReceptiveAccount new! !

!TransferTest methodsFor: 'private' stamp: 'fr 11/16/2020 00:55:56'!
createNewAccounts

	self createNewAccount.
	anotherAccount _ ReceptiveAccount new! !

!TransferTest methodsFor: 'private' stamp: 'fr 11/16/2020 00:59:29'!
transfer100FromAccountToAnotherAccount

	^Transfer move: 100 from: account to: anotherAccount! !


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
	instanceVariableNames: 'accounts parents name account'
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


!Portfolio methodsFor: 'initialization' stamp: 'fr 11/16/2020 01:36:45'!
initialize

	self defaultPortfolioName.
	accounts _ OrderedCollection new.
	parents _ OrderedCollection new.! !

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


!Portfolio methodsFor: 'report' stamp: 'fr 11/13/2020 21:36:32'!
addToPortfolioReportWith: aPortfolioReporter 	
	
	aPortfolioReporter addPortfolioToReport: self! !

!Portfolio methodsFor: 'report' stamp: 'fr 11/16/2020 03:26:36'!
buildAccountReportWith: aReporter

	accounts do: [:anAccount | 
		anAccount buildAccountReportWith: aReporter 	
	]! !

!Portfolio methodsFor: 'report' stamp: 'fr 11/13/2020 21:36:11'!
buildPortfolioReportWith: aPortfolioReporter 

	accounts do: [:anAccount |
		anAccount addToPortfolioReportWith: aPortfolioReporter 	
	]! !


!Portfolio methodsFor: 'private' stamp: 'fr 11/15/2020 20:14:48'!
name

	^name copy! !


!Portfolio methodsFor: 'private - account management' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'private - account management' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'private - account management' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'private - initialization' stamp: 'fr 11/15/2020 22:00:27'!
defaultPortfolioName
	
	name _ 'Un portfolio'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Part-II-Exercise'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'NR 11/9/2020 06:01:26'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio!!'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'fr 11/15/2020 22:00:10'!
with: anAccount

	^self new 
		add: anAccount;
		defaultPortfolioName;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'fr 11/16/2020 01:34:10'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		defaultPortfolioName;
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

!ReceptiveAccount methodsFor: 'initialization' stamp: 'fr 11/15/2020 21:53:11'!
initialize

	super initialize.
	name _ 'Una cuenta'.
	transactions _ OrderedCollection new.! !

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

!ReceptiveAccount methodsFor: 'report' stamp: 'fr 11/16/2020 03:27:44'!
buildAccountReportWith: aReporter

	transactions do: [:aTransaction | 
		aTransaction addToReportWith: aReporter 
	]! !


!ReceptiveAccount methodsFor: 'private' stamp: 'fr 11/15/2020 20:14:53'!
name

	^name copy! !

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

!AccountReporter methodsFor: 'transaction adding' stamp: 'fr 11/16/2020 00:33:07'!
addDepositByTransferToReport: aDepositByTransfer

	self subclassResponsibility ! !

!AccountReporter methodsFor: 'transaction adding' stamp: 'fr 11/16/2020 00:33:18'!
addDepositToReport: aDeposit
	
	self subclassResponsibility ! !

!AccountReporter methodsFor: 'transaction adding' stamp: 'fr 11/16/2020 00:33:35'!
addWithdrawByTransfeToReport: aWithdrawByTransfe
	
	self subclassResponsibility ! !

!AccountReporter methodsFor: 'transaction adding' stamp: 'fr 11/16/2020 00:33:27'!
addWithdrawToReport: aWithdraw
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReporter class' category: 'Portfolio-Part-II-Exercise'!
AccountReporter class
	instanceVariableNames: ''!

!AccountReporter class methodsFor: 'instance creation' stamp: 'fr 11/16/2020 00:29:30'!
for: anAccount 
	
	^self new initializeFor: anAccount ! !


!classDefinition: #SummaryReporter category: 'Portfolio-Part-II-Exercise'!
AccountReporter subclass: #SummaryReporter
	instanceVariableNames: 'accountSummary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!SummaryReporter methodsFor: 'initialization' stamp: 'fr 11/16/2020 00:29:56'!
initializeFor: anAccount 

	accountSummary _ OrderedCollection new.
	account _ anAccount.! !


!SummaryReporter methodsFor: 'report' stamp: 'fr 11/16/2020 03:27:00'!
accountSummary
	
	account buildAccountReportWith: self.
	self addAccountBalance.
	^accountSummary! !


!SummaryReporter methodsFor: 'transaction adding' stamp: 'fr 11/13/2020 18:28:52'!
addDepositByTransferToReport: aDepositByTransfer

	accountSummary add: 'Entrada por transferencia de ',aDepositByTransfer value asString,'.'


	 ! !

!SummaryReporter methodsFor: 'transaction adding' stamp: 'fr 11/13/2020 18:28:52'!
addDepositToReport: aDeposit

	 accountSummary add: 'Depósito por ',aDeposit value asString,'.'! !

!SummaryReporter methodsFor: 'transaction adding' stamp: 'fr 11/13/2020 18:28:52'!
addWithdrawByTransferToReport: aWithdrawByTransfer

	accountSummary add: 'Salida por transferencia de ',aWithdrawByTransfer value asString,'.'

	 ! !

!SummaryReporter methodsFor: 'transaction adding' stamp: 'fr 11/13/2020 18:28:52'!
addWithdrawToReport: aWithdraw

	 accountSummary add: 'Extracción por ',aWithdraw value asString,'.'! !


!SummaryReporter methodsFor: 'private - balance' stamp: 'fr 11/13/2020 18:28:52'!
addAccountBalance

	accountSummary add: 'Balance = ',account balance asString! !


!classDefinition: #TransferNetReporter category: 'Portfolio-Part-II-Exercise'!
AccountReporter subclass: #TransferNetReporter
	instanceVariableNames: 'transferNetBalance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!TransferNetReporter methodsFor: 'initialization' stamp: 'fr 11/16/2020 00:30:03'!
initializeFor: anAccount 
	
	transferNetBalance _ 0.
	account _ anAccount.! !


!TransferNetReporter methodsFor: 'report' stamp: 'fr 11/16/2020 03:26:42'!
transferNet

	account buildAccountReportWith: self.
	^transferNetBalance

	! !


!TransferNetReporter methodsFor: 'transaction adding' stamp: 'fr 11/13/2020 18:08:57'!
addDepositByTransferToReport: aDepositByTransfer

	transferNetBalance _ aDepositByTransfer affectBalance: transferNetBalance ! !

!TransferNetReporter methodsFor: 'transaction adding' stamp: 'fr 11/13/2020 18:10:03'!
addDepositToReport: aDeposit
! !

!TransferNetReporter methodsFor: 'transaction adding' stamp: 'fr 11/15/2020 21:13:57'!
addWithdrawByTransferToReport: aWithdrawByTransfer

	transferNetBalance _ aWithdrawByTransfer affectBalance: transferNetBalance ! !

!TransferNetReporter methodsFor: 'transaction adding' stamp: 'fr 11/13/2020 18:09:56'!
addWithdrawToReport: aWithdraw
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Part-II-Exercise'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'report' stamp: 'fr 11/16/2020 00:36:22'!
addToReportWith: aReporter

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


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'report' stamp: 'fr 11/12/2020 21:53:00'!
addToReportWith: aReporter 

	^aReporter addDepositToReport: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Part-II-Exercise'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferTransaction category: 'Portfolio-Part-II-Exercise'!
AccountTransaction subclass: #TransferTransaction
	instanceVariableNames: 'transfer'
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

!TransferTransaction class methodsFor: 'instance creation' stamp: 'fr 11/16/2020 14:06:30'!
register: aTransferValue on: aReceptiveAccount for: aTransfer 
	
	^(self register: aTransferValue on: aReceptiveAccount) forTransfer: aTransfer ! !


!classDefinition: #DepositByTransference category: 'Portfolio-Part-II-Exercise'!
TransferTransaction subclass: #DepositByTransference
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!DepositByTransference methodsFor: 'initialization' stamp: 'fr 11/11/2020 16:02:56'!
forTransfer: aTransfer 
	
	transfer _ aTransfer ! !


!DepositByTransference methodsFor: 'complementary leg' stamp: 'fr 11/15/2020 22:27:40'!
isComplementedBy: aWithdrawByTransference 
	
	^transfer withdrawLeg = aWithdrawByTransference ! !


!DepositByTransference methodsFor: 'balance' stamp: 'fr 11/11/2020 16:05:35'!
affectBalance: aBalance

	^aBalance + transfer transferValue 
	
	! !


!DepositByTransference methodsFor: 'value' stamp: 'fr 11/11/2020 16:32:51'!
value
	
	^transfer transferValue ! !


!DepositByTransference methodsFor: 'report' stamp: 'fr 11/13/2020 17:44:04'!
addToReportWith: aReporter

	^aReporter addDepositByTransferToReport: self ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DepositByTransference class' category: 'Portfolio-Part-II-Exercise'!
DepositByTransference class
	instanceVariableNames: ''!

!DepositByTransference class methodsFor: 'instance creation' stamp: 'fr 11/16/2020 14:06:46'!
for: aTransferValue 
	
	^self new ! !


!classDefinition: #WithdrawByTransference category: 'Portfolio-Part-II-Exercise'!
TransferTransaction subclass: #WithdrawByTransference
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!WithdrawByTransference methodsFor: 'initialization' stamp: 'fr 11/11/2020 16:01:36'!
forTransfer: aTransfer 
	
	transfer _ aTransfer! !


!WithdrawByTransference methodsFor: 'complementary leg' stamp: 'fr 11/15/2020 22:27:49'!
isComplementedBy: aDepositByTransference 
	
	^transfer depositLeg = aDepositByTransference ! !


!WithdrawByTransference methodsFor: 'balance' stamp: 'fr 11/11/2020 16:04:38'!
affectBalance: aBalance
	
	^aBalance - transfer transferValue
	! !


!WithdrawByTransference methodsFor: 'value' stamp: 'fr 11/11/2020 16:29:16'!
value
	
	^transfer transferValue ! !


!WithdrawByTransference methodsFor: 'report' stamp: 'fr 11/12/2020 21:53:40'!
addToReportWith: aReporter 

	^aReporter addWithdrawByTransferToReport: self ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WithdrawByTransference class' category: 'Portfolio-Part-II-Exercise'!
WithdrawByTransference class
	instanceVariableNames: ''!

!WithdrawByTransference class methodsFor: 'instance creation' stamp: 'fr 11/16/2020 14:06:55'!
for: aTransferValue 
	
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


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'report' stamp: 'fr 11/12/2020 21:53:52'!
addToReportWith: aReporter 

	^aReporter addWithdrawToReport: self ! !

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

!PortfolioReporter methodsFor: 'account adding' stamp: 'fr 11/16/2020 00:41:36'!
addPortfolioToReport: aPortfolio

	self subclassResponsibility ! !

!PortfolioReporter methodsFor: 'account adding' stamp: 'fr 11/16/2020 00:41:46'!
addReceptiveAccountToReport: aReceptiveAccount

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioReporter class' category: 'Portfolio-Part-II-Exercise'!
PortfolioReporter class
	instanceVariableNames: ''!

!PortfolioReporter class methodsFor: 'instance creation' stamp: 'fr 11/13/2020 21:42:18'!
for: aPortfolio 
	
	^self new initializeFor: aPortfolio ! !


!classDefinition: #TreeReporter category: 'Portfolio-Part-II-Exercise'!
PortfolioReporter subclass: #TreeReporter
	instanceVariableNames: 'indentationOffset tree'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!TreeReporter methodsFor: 'private' stamp: 'fr 11/15/2020 20:55:47'!
addNameWithIndentation: anAccount

	tree add: (self nameWithIndentation: anAccount)! !

!TreeReporter methodsFor: 'private' stamp: 'fr 11/15/2020 21:26:36'!
addPortfolioInformation: aPortfolio and: aPortfolioBalanceBlock
	
	self addNameWithIndentation: aPortfolio.
	self increaseOffset.
	aPortfolio buildPortfolioReportWith: self.
	aPortfolioBalanceBlock value.
	self decreaseOffset.! !

!TreeReporter methodsFor: 'private' stamp: 'fr 11/15/2020 21:25:03'!
addReceptiveAccountName: aReceptiveAccount and: aReceptiveAccountBlock
	
	self addNameWithIndentation: aReceptiveAccount.
	aReceptiveAccountBlock value 

	
	! !

!TreeReporter methodsFor: 'private' stamp: 'fr 11/15/2020 20:54:43'!
changeOffset: aValueToAdd

	indentationOffset _ indentationOffset + aValueToAdd ! !

!TreeReporter methodsFor: 'private' stamp: 'fr 11/15/2020 20:55:12'!
decreaseOffset

	^ self changeOffset: -1! !

!TreeReporter methodsFor: 'private' stamp: 'fr 11/15/2020 20:55:16'!
increaseOffset

	^ self changeOffset: 1! !

!TreeReporter methodsFor: 'private' stamp: 'fr 11/15/2020 20:55:23'!
indentation
	
	| indentation |
	indentation _ ''.
	indentationOffset timesRepeat: [indentation _ indentation,' '].
	^indentation! !

!TreeReporter methodsFor: 'private' stamp: 'fr 11/15/2020 21:05:12'!
initializeVariablesWith: aPortfolio

	indentationOffset _ 0.
	tree _ OrderedCollection new.
	portfolio _ aPortfolio! !

!TreeReporter methodsFor: 'private' stamp: 'fr 11/15/2020 20:55:36'!
nameWithIndentation: anAccount

	^self indentation,anAccount name! !

!TreeReporter methodsFor: 'private' stamp: 'fr 11/15/2020 21:29:02'!
report

	self addPortfolioToReport: portfolio.
	^tree
	! !


!classDefinition: #SpecialTreeReporter category: 'Portfolio-Part-II-Exercise'!
TreeReporter subclass: #SpecialTreeReporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!SpecialTreeReporter methodsFor: 'initialization' stamp: 'fr 11/15/2020 21:05:06'!
initializeFor: aPortfolio 
	
	self initializeVariablesWith: aPortfolio.! !


!SpecialTreeReporter methodsFor: 'account adding' stamp: 'fr 11/15/2020 21:27:02'!
addPortfolioToReport: aPortfolio
	
	self addPortfolioInformation: aPortfolio and: [	self addBalanceWithIndentation: aPortfolio]! !

!SpecialTreeReporter methodsFor: 'account adding' stamp: 'fr 11/15/2020 21:24:46'!
addReceptiveAccountToReport: aReceptiveAccount
	
	self addReceptiveAccountName: aReceptiveAccount and: [self addSummaryReportWithIndentation: aReceptiveAccount]

	
	! !


!SpecialTreeReporter methodsFor: 'report' stamp: 'fr 11/15/2020 21:29:33'!
specialReport

	^self report
	! !


!SpecialTreeReporter methodsFor: 'private' stamp: 'fr 11/15/2020 20:30:01'!
accountSummaryForAccount: aReceptiveAccount
	
	| accountReporter |
	accountReporter _ SummaryReporter for: aReceptiveAccount.
	^accountReporter accountSummary.
	
	! !

!SpecialTreeReporter methodsFor: 'private' stamp: 'fr 11/15/2020 20:32:12'!
addBalanceWithIndentation: aPortfolio.

	tree add: (self balanceWithIndentation: aPortfolio)! !

!SpecialTreeReporter methodsFor: 'private' stamp: 'fr 11/15/2020 20:31:35'!
addSummaryReportWithIndentation: aReceptiveAccount
	
	tree addAllLast: (self summaryReportWithIndentation: aReceptiveAccount).
	
	! !

!SpecialTreeReporter methodsFor: 'private' stamp: 'fr 11/15/2020 20:34:50'!
balanceWithIndentation: aPortfolio

	^ self indentation,'Balance = ',aPortfolio balance asString! !

!SpecialTreeReporter methodsFor: 'private' stamp: 'fr 11/15/2020 20:31:13'!
summaryReportWithIndentation: aReceptiveAccount

	^ (self accountSummaryForAccount: aReceptiveAccount) collect: [:aReportElement | self indentation,' ',aReportElement]! !


!classDefinition: #TreeStructureReporter category: 'Portfolio-Part-II-Exercise'!
TreeReporter subclass: #TreeStructureReporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!TreeStructureReporter methodsFor: 'initialization' stamp: 'fr 11/15/2020 21:05:22'!
initializeFor: aPortfolio 
	
	self initializeVariablesWith: aPortfolio.! !


!TreeStructureReporter methodsFor: 'account adding' stamp: 'fr 11/15/2020 21:27:40'!
addPortfolioToReport: aPortfolio
	
	self addPortfolioInformation: aPortfolio and: []! !

!TreeStructureReporter methodsFor: 'account adding' stamp: 'fr 11/15/2020 21:25:29'!
addReceptiveAccountToReport: aReceptiveAccount
	
	self addReceptiveAccountName: aReceptiveAccount and: []
! !


!TreeStructureReporter methodsFor: 'report' stamp: 'fr 11/15/2020 21:29:43'!
treeStructure
	
	^self report! !


!classDefinition: #Transfer category: 'Portfolio-Part-II-Exercise'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Part-II-Exercise'!

!Transfer methodsFor: 'initialization' stamp: 'fr 11/16/2020 00:28:50'!
initializeMove: transferValue from: aReceptiveAccountToMoveFrom to: aReceptiveAccountToMoveTo 
		
	value _ transferValue.
	withdrawLeg _ WithdrawByTransference register: transferValue on: aReceptiveAccountToMoveFrom for: self.
	depositLeg _ DepositByTransference register: transferValue on: aReceptiveAccountToMoveTo for: self ! !


!Transfer methodsFor: 'transfer legs' stamp: 'fr 11/16/2020 00:28:50'!
depositLeg
	
	^depositLeg ! !

!Transfer methodsFor: 'transfer legs' stamp: 'fr 11/16/2020 00:28:46'!
withdrawLeg
	
	^withdrawLeg ! !


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

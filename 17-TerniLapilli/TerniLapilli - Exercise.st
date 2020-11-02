!classDefinition: #TerniLapilliTests category: 'TerniLapilli - Exercise'!
TestCase subclass: #TerniLapilliTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Exercise'!

!TerniLapilliTests methodsFor: 'tests - turn' stamp: 'fr 11/1/2020 20:18:28'!
test01XPlaysFirstAndOAfter

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	terniLapilli putXAt: 1 @ 1.
	self assert:
		[terniLapilli isOsTurn and: [ terniLapilli isXsTurn not ]].! !

!TerniLapilliTests methodsFor: 'tests - turn' stamp: 'fr 11/1/2020 20:21:57'!
test02OPlaysSecondAndXAfter

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	terniLapilli putXAt: 1 @ 1
			 ;putOAt: 1 @ 2.
	self assert:
		[terniLapilli isXsTurn and: [ terniLapilli isOsTurn not ]].! !

!TerniLapilliTests methodsFor: 'tests - turn' stamp: 'fr 11/1/2020 20:18:41'!
test03ODoesNotPlayFirst

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	self should: 		[ terniLapilli putOAt: 1 @ 2.] 
		raise: Error  
		withMessageText: TerniLapilli playerXTurnErrorDescription! !

!TerniLapilliTests methodsFor: 'tests - turn' stamp: 'fr 11/2/2020 03:24:28'!
test04APlayerCanNotPlayTwoTimesInARow

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	self should: 		[ terniLapilli putXAt: 1 @ 2
					      ;putXAt: 1 @ 1.] 
		raise: Error  
		withMessageText: TerniLapilli playerOTurnErrorDescription! !


!TerniLapilliTests methodsFor: 'tests - put' stamp: 'fr 11/1/2020 19:51:39'!
test05XPieceIsWhereHePutsIt

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	terniLapilli putXAt: 1 @ 1.
	
	self assert: [terniLapilli hasXPieceAt: 1@1]! !

!TerniLapilliTests methodsFor: 'tests - put' stamp: 'fr 11/1/2020 20:22:25'!
test06OPieceIsWhereHePutsIt

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	terniLapilli putXAt: 1 @ 1
			 ;putOAt: 1 @ 2.
	
	self assert: [terniLapilli hasOPieceAt: 1@2]! !

!TerniLapilliTests methodsFor: 'tests - put' stamp: 'fr 11/1/2020 19:52:11'!
test07XPieceIsNotWhereHeDoesNotPutIt

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	terniLapilli putXAt: 1 @ 2.
	
	self assert: [(terniLapilli hasXPieceAt: 1@1) not]! !

!TerniLapilliTests methodsFor: 'tests - put' stamp: 'fr 11/1/2020 20:22:35'!
test08OPieceIsNotWhereHeDoesNotPutIt

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	terniLapilli putXAt: 1 @ 1
			 ;putOAt: 1 @ 2.
	
	self assert: [(terniLapilli hasOPieceAt: 1@1) not]! !

!TerniLapilliTests methodsFor: 'tests - put' stamp: 'fr 11/1/2020 20:22:53'!
test09XCanPutMoreThanOnePieceCorrectly

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	terniLapilli putXAt: 1 @ 1
			 ;putOAt: 1 @ 2
		        ;putXAt: 1 @ 3.
	
	self assert: [(terniLapilli hasXPieceAt: 1@1) and: [terniLapilli hasXPieceAt: 1@3]]! !

!TerniLapilliTests methodsFor: 'tests - put' stamp: 'fr 11/1/2020 20:23:19'!
test10OCanPutMoreThanOnePieceCorrectly

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	terniLapilli putXAt: 1 @ 1
			 ;putOAt: 1 @ 2
			 ;putXAt: 1 @ 3
			 ;putOAt: 2 @ 1.
	
	self assert: [(terniLapilli hasOPieceAt: 1@2) and: [terniLapilli hasOPieceAt: 2@1]]! !

!TerniLapilliTests methodsFor: 'tests - put' stamp: 'fr 11/1/2020 20:23:31'!
test11OCanNotPutAPieceInAnOccupiedPosition

	| terniLapilli |
	terniLapilli _ TerniLapilli new.	

	self should: [			terniLapilli putXAt: 1 @ 1
						 ;putOAt: 1 @ 1. ]
		raise: Error
		withMessageText: TerniLapilli positionAlreadyHoldsAPieceErrorDescription! !

!TerniLapilliTests methodsFor: 'tests - put' stamp: 'fr 11/1/2020 20:23:50'!
test12XCanNotPutAPieceInAnOccupiedPosition

	| terniLapilli |
	terniLapilli _ TerniLapilli new.	

	self should: [			terniLapilli putXAt: 1 @ 1
						 ;putOAt: 1 @ 2
						 ;putXAt: 1 @ 2. ]
		raise: Error
		withMessageText: TerniLapilli positionAlreadyHoldsAPieceErrorDescription! !

!TerniLapilliTests methodsFor: 'tests - put' stamp: 'fr 11/1/2020 19:54:57'!
test13XCanNotPutAPieceOutOfBounds

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	self
		should: [ terniLapilli putXAt: 1 @ 5 ]
		raise: Error
		withMessageText: TerniLapilli positionOutOfBoundsErrorDescription.! !

!TerniLapilliTests methodsFor: 'tests - put' stamp: 'fr 11/1/2020 20:24:02'!
test14OCanNotPutAPieceOutOfBounds

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	self
		should: [ 		terniLapilli putXAt: 1 @ 1
						 ;putOAt: 1 @ 5. ]
		raise: Error
		withMessageText: TerniLapilli positionOutOfBoundsErrorDescription.! !

!TerniLapilliTests methodsFor: 'tests - put' stamp: 'fr 11/1/2020 20:25:13'!
test15XCanNotPutMoreThanThreePieces

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	self
		should: [ 		terniLapilli putXAt: 1 @ 1
						 ;putOAt: 1 @ 2
					        ;putXAt: 1 @ 3
						 ;putOAt: 2 @ 1
						 ;putXAt: 2 @ 2
						 ;putOAt: 2 @ 3
						 ;putXAt: 3 @ 2.
				 ]
		raise: Error
		withMessageText: TerniLapilli piecesLimitExceededErrorDescription.! !

!TerniLapilliTests methodsFor: 'tests - put' stamp: 'fr 11/1/2020 20:26:01'!
test16OCanNotPutMoreThanThreePieces

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	self
		should: [ 		terniLapilli putXAt: 1 @ 1
						 ;putOAt: 1 @ 3
						 ;putXAt: 2 @ 1
						 ;putOAt: 2 @ 2
						 ;putXAt: 2 @ 3
						 ;putOAt: 3 @ 2
						 ;moveXFrom: 1@1 to: 1@2
						 ;putOAt: 3 @ 3.
				 ]
		raise: Error
		withMessageText: TerniLapilli piecesLimitExceededErrorDescription.! !


!TerniLapilliTests methodsFor: 'tests - move' stamp: 'fr 11/1/2020 20:00:13'!
test17WhenXMovesAPieceItIsAtTheNewPositionAndNotAtThePreviousOne

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	terniLapilli putXAt: 1 @ 1 
			 ;putOAt: 1 @ 3
			 ;putXAt: 2 @ 1
			 ;putOAt: 2 @ 2
			 ;putXAt: 2 @ 3
			 ;putOAt: 3 @ 2
			 ;moveXFrom: 1@1 to: 1@2.
			
	self assert: [(terniLapilli hasXPieceAt: 1@2) and: [(terniLapilli hasXPieceAt: 1@1) not]]! !

!TerniLapilliTests methodsFor: 'tests - move' stamp: 'fr 11/1/2020 20:00:46'!
test18WhenOMovesAPieceItIsAtTheNewPositionAndNotAtThePreviousOne

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	terniLapilli putXAt: 1 @ 1 
			 ;putOAt: 1 @ 3
			 ;putXAt: 2 @ 1
			 ;putOAt: 2 @ 2
			 ;putXAt: 2 @ 3
			 ;putOAt: 3 @ 2
			 ;moveXFrom: 1@1 to: 1@2
			 ;moveOFrom: 3@2 to: 3@3.
			
	self assert: [(terniLapilli hasOPieceAt: 3@3) and: [(terniLapilli hasXPieceAt: 3@2) not]]! !

!TerniLapilliTests methodsFor: 'tests - move' stamp: 'fr 11/1/2020 20:01:08'!
test19XCanNotMoveBeforeAddingThreePieces

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
		
	self  should: [terniLapilli moveXFrom: 1@1 to: 1@2.] 
		raise: Error 
		withMessageText: TerniLapilli canNotMoveBeforeAddingThreePiecesErrorDescription! !

!TerniLapilliTests methodsFor: 'tests - move' stamp: 'fr 11/1/2020 20:01:21'!
test20OCanNotMoveBeforeAddingThreePieces

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
		
	self  should: [terniLapilli putXAt: 1@1 ;moveOFrom: 1@1 to: 1@2.] 
		raise: Error 
		withMessageText: TerniLapilli canNotMoveBeforeAddingThreePiecesErrorDescription! !

!TerniLapilliTests methodsFor: 'tests - move' stamp: 'fr 11/1/2020 20:01:50'!
test21XCanNotMoveFromAPositionThatIsNotUnderHisControl

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
		
	self  should: [			terniLapilli putXAt: 1 @ 1 
						 ;putOAt: 1 @ 3
						 ;putXAt: 2 @ 1
						 ;putOAt: 2 @ 2
						 ;putXAt: 2 @ 3
						 ;putOAt: 3 @ 2
						 ;moveXFrom: 3@2 to: 3@1.] 
		raise: Error 
		withMessageText: TerniLapilli positionIsNotUnderPlayersControlErrorDescription ! !

!TerniLapilliTests methodsFor: 'tests - move' stamp: 'fr 11/1/2020 20:02:12'!
test22OCanNotMoveFromAPositionThatIsNotUnderHisControl

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
		
	self  should: [			terniLapilli putXAt: 1 @ 1 
						 ;putOAt: 1 @ 3
						 ;putXAt: 2 @ 1
						 ;putOAt: 2 @ 2
						 ;putXAt: 2 @ 3
						 ;putOAt: 3 @ 3
						 ;moveXFrom: 1@1 to: 1@2
						 ;moveOFrom: 3@2 to: 3@1.] 
		raise: Error 
		withMessageText: TerniLapilli positionIsNotUnderPlayersControlErrorDescription! !

!TerniLapilliTests methodsFor: 'tests - move' stamp: 'fr 11/1/2020 20:04:00'!
test23XCanNotMoveFromAnOutOfBoundsPosition

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
		
	self  should: [			terniLapilli putXAt: 1 @ 1 
						 ;putOAt: 1 @ 3
						 ;putXAt: 2 @ 1
						 ;putOAt: 2 @ 2
						 ;putXAt: 2 @ 3
						 ;putOAt: 3 @ 2
						 ;moveXFrom: 3@4 to: 3@3.] 
		raise: Error 
		withMessageText: TerniLapilli positionOutOfBoundsErrorDescription ! !

!TerniLapilliTests methodsFor: 'tests - move' stamp: 'fr 11/1/2020 20:04:04'!
test24OCanNotMoveFromAnOutOfBoundsPosition

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
		
	self  should: [			terniLapilli putXAt: 1 @ 1 
						 ;putOAt: 1 @ 3
						 ;putXAt: 2 @ 1
						 ;putOAt: 2 @ 2
						 ;putXAt: 2 @ 3
						 ;putOAt: 3 @ 2
						 ;moveXFrom: 1@1 to: 1@2
						 ;moveOFrom: 2@6 to: 3@3.] 
		raise: Error 
		withMessageText: TerniLapilli positionOutOfBoundsErrorDescription ! !

!TerniLapilliTests methodsFor: 'tests - move' stamp: 'fr 11/1/2020 20:04:08'!
test25XCanNotMoveToAnOutOfBoundsPosition

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
		
	self  should: [			terniLapilli putXAt: 1 @ 1 
						 ;putOAt: 1 @ 3
						 ;putXAt: 2 @ 1
						 ;putOAt: 2 @ 2
						 ;putXAt: 2 @ 3
						 ;putOAt: 3 @ 2
						 ;moveXFrom: 1@1 to: 0@1.] 
		raise: Error 
		withMessageText: TerniLapilli positionOutOfBoundsErrorDescription ! !

!TerniLapilliTests methodsFor: 'tests - move' stamp: 'fr 11/1/2020 20:05:10'!
test26OCanNotMoveToAnOutOfBoundsPosition

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
		
	self  should: [			terniLapilli putXAt: 1 @ 1 
						 ;putOAt: 1 @ 3
						 ;putXAt: 2 @ 1
						 ;putOAt: 2 @ 2
						 ;putXAt: 2 @ 3
						 ;putOAt: 3 @ 2
						 ;moveXFrom: 1@1 to: 1@2
						 ;moveOFrom: 3@2 to: 4@2.] 
		raise: Error 
		withMessageText: TerniLapilli positionOutOfBoundsErrorDescription ! !

!TerniLapilliTests methodsFor: 'tests - move' stamp: 'fr 11/1/2020 20:05:18'!
test27XCanNotMoveToAnOccupiedPosition

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
		
	self  should: [			terniLapilli putXAt: 1 @ 1 
						 ;putOAt: 1 @ 3
						 ;putXAt: 2 @ 1
						 ;putOAt: 2 @ 2
						 ;putXAt: 2 @ 3
						 ;putOAt: 3 @ 2
						 ;moveXFrom: 1@1 to: 2@2.] 
		raise: Error 
		withMessageText: TerniLapilli positionAlreadyHoldsAPieceErrorDescription ! !

!TerniLapilliTests methodsFor: 'tests - move' stamp: 'fr 11/1/2020 20:05:01'!
test28OCanNotMoveToAnOccupiedPosition

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
		
	self  should: [			terniLapilli putXAt: 1 @ 1 
						 ;putOAt: 1 @ 3
						 ;putXAt: 2 @ 1
						 ;putOAt: 2 @ 2
						 ;putXAt: 2 @ 3
						 ;putOAt: 3 @ 2
						 ;moveXFrom: 1@1 to: 1@2
						 ;moveOFrom: 1@3 to: 1@2.] 
		raise: Error 
		withMessageText: TerniLapilli positionAlreadyHoldsAPieceErrorDescription ! !

!TerniLapilliTests methodsFor: 'tests - move' stamp: 'fr 11/2/2020 02:49:51'!
test29XCanNotMoveBetweenPositionsThatAreMoreThanOnePlaceAfar

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
		
	self  should: [			terniLapilli putXAt: 1 @ 1 
						 ;putOAt: 2 @ 1
						 ;putXAt: 1 @ 2
						 ;putOAt: 2 @ 2
						 ;putXAt: 3 @ 1
						 ;putOAt: 1 @ 3
						 ;moveXFrom: 3@1 to: 3@3.] 
		raise: Error 
		withMessageText: TerniLapilli positionIsNotReachableErrorDescription ! !

!TerniLapilliTests methodsFor: 'tests - move' stamp: 'fr 11/2/2020 02:49:51'!
test30OCanNotMoveBetweenPositionsThatAreMoreThanOnePlaceAfar

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
		
	self  should: [			terniLapilli putXAt: 1 @ 1 
						 ;putOAt: 2 @ 1
						 ;putXAt: 1 @ 2
						 ;putOAt: 2 @ 2
						 ;putXAt: 3 @ 1
						 ;putOAt: 1 @ 3
						 ;moveXFrom: 3@1 to: 3@2
						 ;moveOFrom: 1@3 to: 3@3.] 
		raise: Error 
		withMessageText: TerniLapilli positionIsNotReachableErrorDescription ! !


!TerniLapilliTests methodsFor: 'tests - win' stamp: 'fr 11/1/2020 20:26:57'!
test31NoPlayerHasWonIfNoneOfThemHasThreePiecesInLine

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	terniLapilli putXAt: 1 @ 1
		 	 ;putOAt: 2 @ 3
			 ;putXAt: 1 @ 2.
	self assert: [ terniLapilli hasXWon not and: [terniLapilli hasOWon not]].! !

!TerniLapilliTests methodsFor: 'tests - win' stamp: 'fr 11/1/2020 20:27:25'!
test32XWinsWhenHeGetsThreePiecesInTheSameRow

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	terniLapilli putXAt: 1 @ 1
			 ;putOAt: 2 @ 3
			 ;putXAt: 1 @ 2
			 ;putOAt: 2 @ 2
			 ;putXAt: 1 @ 3.
	self assert: [ terniLapilli hasXWon ].! !

!TerniLapilliTests methodsFor: 'tests - win' stamp: 'fr 11/1/2020 20:28:05'!
test33XWinsWhenHeGetsThreePiecesInTheSameColumn

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	terniLapilli putXAt: 1 @ 1
			 ;putOAt: 1 @ 3
			 ;putXAt: 2 @ 1
			 ;putOAt: 1 @ 2
			 ;putXAt: 3 @ 1.
	self assert: [ terniLapilli hasXWon ].! !

!TerniLapilliTests methodsFor: 'tests - win' stamp: 'fr 11/1/2020 20:28:33'!
test34XWinsWhenHeGetsThreePiecesInTheMainDiagonal

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	terniLapilli putXAt: 1 @ 1
			 ;putOAt: 1 @ 3
			 ;putXAt: 2 @ 2
			 ;putOAt: 1 @ 2
			 ;putXAt: 3 @ 3.
	self assert: [ terniLapilli hasXWon ].! !

!TerniLapilliTests methodsFor: 'tests - win' stamp: 'fr 11/1/2020 20:29:05'!
test35XWinsWhenHeGetsThreePiecesInTheSecondaryDiagonal

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	terniLapilli putXAt: 1 @ 3
			 ;putOAt: 1 @ 1
			 ;putXAt: 2 @ 2
			 ;putOAt: 1 @ 2
			 ;putXAt: 3 @ 1.
	self assert: [ terniLapilli hasXWon ].! !

!TerniLapilliTests methodsFor: 'tests - win' stamp: 'fr 11/1/2020 20:29:45'!
test36OWinsWhenHeGetsThreePiecesInLine

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	terniLapilli putXAt: 1 @ 3
			 ;putOAt: 2 @ 1
			 ;putXAt: 3 @ 1
			 ;putOAt: 2 @ 2
			 ;putXAt: 3 @ 2
			 ;putOAt: 2 @ 3.
	self assert: [ terniLapilli hasOWon ].! !

!TerniLapilliTests methodsFor: 'tests - win' stamp: 'fr 11/1/2020 20:30:18'!
test37OCanNotPutAfterGameIsOver

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	
	self should: [			terniLapilli putXAt: 1 @ 1
						 ;putOAt: 2 @ 2
						 ;putXAt: 2 @ 1
						 ;putOAt: 2 @ 3
						 ;putXAt: 3 @ 1
						 ;putOAt: 3 @ 3.]  
		raise: Error
		withMessageText: TerniLapilli gameIsOverErrorDescription ! !

!TerniLapilliTests methodsFor: 'tests - win' stamp: 'fr 11/1/2020 20:30:49'!
test38XCanNotMoveAfterGameIsOver 

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	
	self should: [			terniLapilli putXAt: 1 @ 1
						 ;putOAt: 1 @ 2
						 ;putXAt: 2 @ 1
						 ;putOAt: 2 @ 2
						 ;putXAt: 2 @ 3
						 ;putOAt: 3 @ 2
						 ;moveXFrom: 2@3 to: 3@3.]  
		raise: Error
		withMessageText: TerniLapilli gameIsOverErrorDescription ! !

!TerniLapilliTests methodsFor: 'tests - win' stamp: 'fr 11/1/2020 20:31:48'!
test39OCanNotMoveAfterGameIsOver

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	
	self should: [			terniLapilli putXAt: 1 @ 1
						 ;putOAt: 1 @ 2
						 ;putXAt: 2 @ 1
						 ;putOAt: 2 @ 2
						 ;putXAt: 3 @ 2
						 ;putOAt: 3 @ 3
						 ;moveXFrom: 3@2 to: 3@1
						 ;moveOFrom: 3@3 to: 3@2.]  
		raise: Error
		withMessageText: TerniLapilli gameIsOverErrorDescription ! !

!TerniLapilliTests methodsFor: 'tests - win' stamp: 'fr 11/1/2020 20:32:27'!
test40ItIsNoOnesTurnAfterGameIsOver

	| terniLapilli |
	terniLapilli _ TerniLapilli new.
	
	terniLapilli putXAt: 1 @ 1
			 ;putOAt: 1 @ 2
			 ;putXAt: 2 @ 1
			 ;putOAt: 2 @ 2
			 ;putXAt: 3 @ 2
			 ;putOAt: 3 @ 3
			 ;moveXFrom: 3@2 to: 3@1.
	
	self assert: (terniLapilli isXsTurn not and: [terniLapilli isOsTurn not])! !


!classDefinition: #TerniLapilli category: 'TerniLapilli - Exercise'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'Xpositions Opositions state positions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Exercise'!

!TerniLapilli methodsFor: 'initialization' stamp: 'fr 11/2/2020 02:32:35'!
initialize 
	
	state _ XAdding isFor: self.
	positions _ Dictionary new.
	positions add: (#X -> Set new).	
	positions add: (#O -> Set new).	
! !


!TerniLapilli methodsFor: 'actions' stamp: 'fr 10/31/2020 16:49:34'!
moveOFrom: currentPosition to: newPosition 
	
	state moveOFrom: currentPosition to: newPosition 
! !

!TerniLapilli methodsFor: 'actions' stamp: 'fr 10/31/2020 16:49:41'!
moveXFrom: currentPosition to: newPosition

	state moveXFrom: currentPosition to: newPosition 
	
	! !

!TerniLapilli methodsFor: 'actions' stamp: 'fr 10/31/2020 19:15:49'!
putOAt: aPosition 
	
	state putOAt: aPosition! !

!TerniLapilli methodsFor: 'actions' stamp: 'fr 10/31/2020 04:57:47'!
putXAt: aPosition
	
	state putXAt: aPosition ! !


!TerniLapilli methodsFor: 'game state' stamp: 'fr 11/1/2020 20:43:14'!
hasOPieceAt: aPosition 
		
	^self player: #O hasAPieceAt: aPosition! !

!TerniLapilli methodsFor: 'game state' stamp: 'fr 11/1/2020 00:42:02'!
hasOWon
	
	^state hasOWon.! !

!TerniLapilli methodsFor: 'game state' stamp: 'fr 11/1/2020 20:43:14'!
hasXPieceAt: aPosition

	^self player: #X hasAPieceAt: aPosition	! !

!TerniLapilli methodsFor: 'game state' stamp: 'fr 11/1/2020 00:42:13'!
hasXWon
	
	^state hasXWon ! !

!TerniLapilli methodsFor: 'game state' stamp: 'fr 11/1/2020 01:49:37'!
isOsTurn

	^state isOsTurn ! !

!TerniLapilli methodsFor: 'game state' stamp: 'fr 11/1/2020 01:49:34'!
isXsTurn

	^state isXsTurn! !


!TerniLapilli methodsFor: 'private - state safe actions' stamp: 'fr 11/1/2020 22:10:24'!
safeMoveOFrom: currentPosition to: newPosition 
		
	self validatePositions: newPosition andRemove: currentPosition for: #O.
	self safePutOAt: newPosition 
! !

!TerniLapilli methodsFor: 'private - state safe actions' stamp: 'fr 11/1/2020 22:10:18'!
safeMoveXFrom: currentPosition to: newPosition
	
	self validatePositions: newPosition andRemove: currentPosition for: #X.
	self safePutXAt: newPosition 
	
	! !

!TerniLapilli methodsFor: 'private - state safe actions' stamp: 'fr 11/1/2020 22:03:09'!
safePutOAt: aPosition 

	self validate: aPosition andAddFor: #O
	! !

!TerniLapilli methodsFor: 'private - state safe actions' stamp: 'fr 11/1/2020 22:02:55'!
safePutXAt: aPosition 
	
	self validate: aPosition andAddFor: #X! !

!TerniLapilli methodsFor: 'private - state safe actions' stamp: 'fr 11/2/2020 02:55:41'!
validate: aPosition andAddFor: aPlayerId

	self failIfDestinationIsOutOfBoundsOrOccupied: aPosition.
	(self positionsFor: aPlayerId) add: aPosition.
	self updateState
	
! !

!TerniLapilli methodsFor: 'private - state safe actions' stamp: 'fr 11/1/2020 22:09:36'!
validatePositions: newPosition andRemove: currentPosition for: aPlayerId
	
	self failIfTooFar: newPosition orOutOfBounds: currentPosition.
	(self positionsFor: aPlayerId) remove: currentPosition ifAbsent: [self positionNotUnderPlayerControl]! !


!TerniLapilli methodsFor: 'private - error' stamp: 'fr 10/31/2020 20:46:16'!
canNotMoveBeforeAddingThreePiecesError

	^ self error: self class canNotMoveBeforeAddingThreePiecesErrorDescription! !

!TerniLapilli methodsFor: 'private - error' stamp: 'fr 11/2/2020 02:55:41'!
failIfDestinationIsOutOfBoundsOrOccupied: aPosition

	self failIfPositionOutOfBounds: aPosition.
	self failIfPositionAlreadyHoldsAPiece: aPosition! !

!TerniLapilli methodsFor: 'private - error' stamp: 'fr 11/2/2020 02:58:06'!
failIfItIsNotPossibleToMoveFrom: currentPosition to: newPosition

	(self itIsValidToGoFrom: currentPosition to: newPosition) ifFalse: [self positionIsNotReachable].
	
	! !

!TerniLapilli methodsFor: 'private - error' stamp: 'fr 10/31/2020 21:20:47'!
failIfPositionAlreadyHoldsAPiece: aPosition

	(self positionHoldsAPieceOfAnyPlayer: aPosition) ifTrue: [self positionAlreadyHoldsAPieceError]! !

!TerniLapilli methodsFor: 'private - error' stamp: 'fr 10/31/2020 21:14:01'!
failIfPositionOutOfBounds: aPosition

	^ ((self firstCoordinateIsValid: aPosition) and: [self secondCoordinateIsValid: aPosition]) ifFalse: [self positionOutOfBoundsError]! !

!TerniLapilli methodsFor: 'private - error' stamp: 'fr 11/2/2020 02:58:06'!
failIfTooFar: newPosition orOutOfBounds: currentPosition.
	
	self failIfPositionOutOfBounds: currentPosition.
	self failIfItIsNotPossibleToMoveFrom: currentPosition to: newPosition.
! !

!TerniLapilli methodsFor: 'private - error' stamp: 'fr 10/31/2020 20:45:37'!
gameIsOverError

	^ self error: self class gameIsOverErrorDescription! !

!TerniLapilli methodsFor: 'private - error' stamp: 'fr 11/1/2020 21:23:30'!
itIsPlayerOsTurnError

	^ self error: self class playerOTurnErrorDescription! !

!TerniLapilli methodsFor: 'private - error' stamp: 'fr 11/1/2020 21:23:37'!
itIsPlayerXsTurnError

	^ self error: self class playerXTurnErrorDescription! !

!TerniLapilli methodsFor: 'private - error' stamp: 'fr 10/31/2020 20:45:46'!
piecesLimitExceededError

	^ self error: self class piecesLimitExceededErrorDescription! !

!TerniLapilli methodsFor: 'private - error' stamp: 'fr 10/31/2020 20:46:05'!
positionAlreadyHoldsAPieceError

	^ self error: self class positionAlreadyHoldsAPieceErrorDescription! !

!TerniLapilli methodsFor: 'private - error' stamp: 'fr 11/2/2020 02:57:31'!
positionIsNotReachable

	^ self error: self class positionIsNotReachableErrorDescription! !

!TerniLapilli methodsFor: 'private - error' stamp: 'fr 11/1/2020 21:52:27'!
positionNotUnderPlayerControl

	^ self error: self class positionIsNotUnderPlayersControlErrorDescription! !

!TerniLapilli methodsFor: 'private - error' stamp: 'fr 10/31/2020 21:13:58'!
positionOutOfBoundsError

	^ self error: self class positionOutOfBoundsErrorDescription! !


!TerniLapilli methodsFor: 'private - game state' stamp: 'fr 11/2/2020 03:40:09'!
OHasPiecesToAdd

	 ^self hasPiecesToAdd: #O
! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'fr 11/2/2020 03:40:44'!
XHasPiecesToAdd

	 ^self hasPiecesToAdd: #X
! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'fr 10/31/2020 21:07:01'!
hasPiecesToAdd: aPlayerId

	^(self positionsFor: aPlayerId ) size < 3! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'fr 11/1/2020 20:43:14'!
player: aPlayerId hasAPieceAt: aPosition	
	
	^(self positionsFor: aPlayerId) includes: aPosition! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'fr 11/2/2020 02:58:54'!
positionHoldsAPieceOfAnyPlayer: aPosition

	^(self player: #X hasAPieceAt: aPosition) or: [self player: #O hasAPieceAt: aPosition ]! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'fr 10/31/2020 05:29:37'!
positionsFor: aPlayerId
	
	^positions at: aPlayerId ! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'fr 11/2/2020 02:32:23'!
updateState

	state _ TerniLapilliState for: self! !


!TerniLapilli methodsFor: 'private - win' stamp: 'fr 11/2/2020 03:38:25'!
OHasThreeInLine

	^self hasThreeInLine: #O! !

!TerniLapilli methodsFor: 'private - win' stamp: 'fr 11/2/2020 03:36:49'!
XHasThreeInLine

	^self hasThreeInLine: #X! !

!TerniLapilli methodsFor: 'private - win' stamp: 'fr 11/2/2020 03:14:10'!
hasThreeInADiagonal: playerPositions thatHaveSecondCoordinate: aCoordinatesBlock
	
	^(1 to: 3) allSatisfy: [:aCoordinate | self positions: playerPositions includeOneWithFirstCoordinate: aCoordinate andSecond: aCoordinatesBlock]
! !

!TerniLapilli methodsFor: 'private - win' stamp: 'fr 11/2/2020 03:08:06'!
hasThreeInARowOrColumn: playerPositions thatCoincide: aCoordinatesBlock
	
	^(1 to: 3) anySatisfy: [:aCoordinate | (self numberOf: playerPositions thatFulfill: aCoordinatesBlock using: aCoordinate) = 3 ]! !

!TerniLapilli methodsFor: 'private - win' stamp: 'fr 11/2/2020 03:36:39'!
hasThreeInLine: playerId

	| playerPositions |
	
	playerPositions _ self positionsFor: playerId.
	
	^   (self threeInARow: playerPositions ) 
	or: [self threeInAColumn: playerPositions ] 
	or: [self threeInMainDiagonal: playerPositions] 
	or: [self threeInSecondaryDiagonal: playerPositions]! !

!TerniLapilli methodsFor: 'private - win' stamp: 'fr 11/2/2020 03:02:21'!
numberOf: playerPositions thatFulfill: aCoordinatesBlock using: aCoordinate


	^playerPositions count: [:aPosition | aCoordinatesBlock value: aPosition value: aCoordinate]! !

!TerniLapilli methodsFor: 'private - win' stamp: 'fr 11/2/2020 03:12:21'!
positions: playerPositions includeOneWithFirstCoordinate: aCoordinate andSecond: aCoordinatesBlock

	^playerPositions includes: aCoordinate@(aCoordinatesBlock value: aCoordinate)! !

!TerniLapilli methodsFor: 'private - win' stamp: 'fr 11/2/2020 03:08:06'!
threeInAColumn: playerPositions
	
	^self hasThreeInARowOrColumn: playerPositions thatCoincide: [:aPosition :aCoordinate | aPosition y = aCoordinate]! !

!TerniLapilli methodsFor: 'private - win' stamp: 'fr 11/2/2020 03:08:06'!
threeInARow: playerPositions

	^self hasThreeInARowOrColumn: playerPositions thatCoincide: [:aPosition :aCoordinate | aPosition x = aCoordinate]! !

!TerniLapilli methodsFor: 'private - win' stamp: 'fr 11/2/2020 03:08:31'!
threeInMainDiagonal: playerPositions

	^self hasThreeInADiagonal: playerPositions thatHaveSecondCoordinate: [:coordinate | coordinate] ! !

!TerniLapilli methodsFor: 'private - win' stamp: 'fr 11/2/2020 03:08:31'!
threeInSecondaryDiagonal: playerPositions
	
	^self hasThreeInADiagonal: playerPositions thatHaveSecondCoordinate: [:coordinate | 4-coordinate]! !


!TerniLapilli methodsFor: 'private - coordinates validation' stamp: 'fr 11/1/2020 22:13:32'!
coordinateIsValid: aCoordinate

	^ aCoordinate between: 1 and: 3! !

!TerniLapilli methodsFor: 'private - coordinates validation' stamp: 'fr 11/1/2020 22:13:46'!
firstCoordinateIsValid: aPosition

	^ self coordinateIsValid: aPosition x! !

!TerniLapilli methodsFor: 'private - coordinates validation' stamp: 'fr 11/1/2020 21:30:43'!
isACornerOrCenter: currentPosition

	^ (currentPosition x + currentPosition y) even! !

!TerniLapilli methodsFor: 'private - coordinates validation' stamp: 'fr 11/1/2020 21:29:18'!
isAnEdge: currentPosition

	^ (currentPosition x + currentPosition y) odd! !

!TerniLapilli methodsFor: 'private - coordinates validation' stamp: 'fr 11/2/2020 03:19:39'!
isAnEdge: currentPosition andIsReachable: newPosition

	^(self isAnEdge: currentPosition) and: [self position: newPosition isReachableFromEdge: currentPosition]
	! !

!TerniLapilli methodsFor: 'private - coordinates validation' stamp: 'fr 11/2/2020 03:20:02'!
isaCornerOrCenter: currentPosition andIsReachable: newPosition

	^(self isACornerOrCenter: currentPosition) and: [self position: newPosition isReachableFromCornerOrCenter: currentPosition] 
	! !

!TerniLapilli methodsFor: 'private - coordinates validation' stamp: 'fr 11/2/2020 03:20:02'!
itIsValidToGoFrom: currentPosition to: newPosition

	^(self isaCornerOrCenter: currentPosition andIsReachable: newPosition) or: [self isAnEdge: currentPosition andIsReachable: newPosition]
	! !

!TerniLapilli methodsFor: 'private - coordinates validation' stamp: 'fr 11/2/2020 03:18:01'!
position: newPosition isReachableFromCornerOrCenter: currentPosition

	^currentPosition eightNeighbors includes: newPosition
	! !

!TerniLapilli methodsFor: 'private - coordinates validation' stamp: 'fr 11/2/2020 03:16:55'!
position: newPosition isReachableFromEdge: currentPosition
	
	^currentPosition fourNeighbors includes: newPosition
	! !

!TerniLapilli methodsFor: 'private - coordinates validation' stamp: 'fr 11/1/2020 22:13:55'!
secondCoordinateIsValid: aPosition

	^ self coordinateIsValid: aPosition y! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: 'TerniLapilli - Exercise'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error message descriptions' stamp: 'fr 10/31/2020 12:05:40'!
canNotMoveBeforeAddingThreePiecesErrorDescription
	
	^'Can not move before adding three pieces'! !

!TerniLapilli class methodsFor: 'error message descriptions' stamp: 'fr 10/31/2020 19:17:35'!
gameIsOverErrorDescription
	
	^'Game is already over'! !

!TerniLapilli class methodsFor: 'error message descriptions' stamp: 'fr 10/30/2020 21:36:48'!
piecesLimitExceededErrorDescription
	
	^'Can not add more than three pieces'! !

!TerniLapilli class methodsFor: 'error message descriptions' stamp: 'fr 10/30/2020 20:41:56'!
playerOTurnErrorDescription
	
	^'It is player Os turn'! !

!TerniLapilli class methodsFor: 'error message descriptions' stamp: 'fr 10/30/2020 20:34:36'!
playerXTurnErrorDescription
	
	^'It is player Xs turn'! !

!TerniLapilli class methodsFor: 'error message descriptions' stamp: 'fr 10/30/2020 21:11:43'!
positionAlreadyHoldsAPieceErrorDescription
	
	^'Position already holds a piece'! !

!TerniLapilli class methodsFor: 'error message descriptions' stamp: 'fr 11/2/2020 02:49:51'!
positionIsNotReachableErrorDescription
	
	^'Destination is not reachable from this departure position'! !

!TerniLapilli class methodsFor: 'error message descriptions' stamp: 'fr 10/31/2020 12:13:41'!
positionIsNotUnderPlayersControlErrorDescription
	
	^'Position is not under players control'! !

!TerniLapilli class methodsFor: 'error message descriptions' stamp: 'fr 10/30/2020 21:28:11'!
positionOutOfBoundsErrorDescription
	
	^'Position out of bounds'! !


!classDefinition: #TerniLapilliState category: 'TerniLapilli - Exercise'!
Object subclass: #TerniLapilliState
	instanceVariableNames: 'terniLapilliGame'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Exercise'!

!TerniLapilliState methodsFor: 'initialization' stamp: 'fr 10/30/2020 21:58:19'!
initializeFor: aTerniLapilli
	
	terniLapilliGame _ aTerniLapilli ! !


!TerniLapilliState methodsFor: 'actions' stamp: 'fr 10/31/2020 16:10:29'!
moveOFrom: currentPosition to: newPosition

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'actions' stamp: 'fr 10/31/2020 15:49:51'!
moveXFrom: currentPosition to: newPosition

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'actions' stamp: 'fr 10/31/2020 02:01:53'!
putOAt: aPosition
	
	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'actions' stamp: 'fr 10/31/2020 02:01:57'!
putXAt: aPosition
	
	self subclassResponsibility ! !


!TerniLapilliState methodsFor: 'state' stamp: 'fr 11/1/2020 01:30:08'!
hasOWon

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'state' stamp: 'fr 11/1/2020 01:30:06'!
hasXWon

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'state' stamp: 'fr 10/31/2020 05:07:24'!
isOsTurn

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'state' stamp: 'fr 10/31/2020 05:07:27'!
isXsTurn

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliState class' category: 'TerniLapilli - Exercise'!
TerniLapilliState class
	instanceVariableNames: ''!

!TerniLapilliState class methodsFor: 'instance creation' stamp: 'fr 11/2/2020 02:32:35'!
for: aTerniLapilli
	
	^(self subclasses detect: [:aTerniLapilliState | aTerniLapilliState canHandle: aTerniLapilli]) isFor: aTerniLapilli! !

!TerniLapilliState class methodsFor: 'instance creation' stamp: 'fr 11/2/2020 02:32:35'!
isFor: aTerniLapilli
	
	^self new initializeFor: aTerniLapilli ! !


!TerniLapilliState class methodsFor: 'handling conditions' stamp: 'fr 11/2/2020 04:00:51'!
handlingConditionForPieces: aBlockAboutPieces turn: aBlockAboutTurn for: aTerniLapilli

	^aBlockAboutPieces value and: aBlockAboutTurn value and: (self noOneHasWonYet: aTerniLapilli)! !

!TerniLapilliState class methodsFor: 'handling conditions' stamp: 'fr 11/2/2020 04:02:14'!
isOsTimeToPlay: aTerniLapilli and: aBlockAboutPiecesToAdd
	
	^self handlingConditionForPieces: [aBlockAboutPiecesToAdd value: (aTerniLapilli OHasPiecesToAdd)] 
		turn: [aTerniLapilli isXsTurn]
		for: aTerniLapilli ! !

!TerniLapilliState class methodsFor: 'handling conditions' stamp: 'fr 11/2/2020 04:01:42'!
isXsTimeToPlay: aTerniLapilli and: aBlockAboutPiecesToAdd
	
	^self handlingConditionForPieces: [aBlockAboutPiecesToAdd value: (aTerniLapilli XHasPiecesToAdd)] 
		turn: [aTerniLapilli isOsTurn]
		for: aTerniLapilli ! !

!TerniLapilliState class methodsFor: 'handling conditions' stamp: 'fr 11/2/2020 03:53:03'!
noOneHasWonYet: aTerniLapilli

	^(aTerniLapilli OHasThreeInLine not) and: [aTerniLapilli XHasThreeInLine not]! !


!classDefinition: #OAdding category: 'TerniLapilli - Exercise'!
TerniLapilliState subclass: #OAdding
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Exercise'!

!OAdding methodsFor: 'actions' stamp: 'fr 10/31/2020 20:46:16'!
moveOFrom: currentPosition to: newPosition

	terniLapilliGame canNotMoveBeforeAddingThreePiecesError
! !

!OAdding methodsFor: 'actions' stamp: 'fr 11/1/2020 21:23:30'!
moveXFrom: currentPosition to: newPosition

	terniLapilliGame itIsPlayerOsTurnError! !

!OAdding methodsFor: 'actions' stamp: 'fr 10/31/2020 02:03:13'!
putOAt: aPosition

	terniLapilliGame safePutOAt: aPosition! !

!OAdding methodsFor: 'actions' stamp: 'fr 11/1/2020 21:23:30'!
putXAt: aPosition

	terniLapilliGame itIsPlayerOsTurnError ! !


!OAdding methodsFor: 'state' stamp: 'fr 11/1/2020 01:30:33'!
hasOWon

	^false! !

!OAdding methodsFor: 'state' stamp: 'fr 11/1/2020 01:30:31'!
hasXWon

	^false! !

!OAdding methodsFor: 'state' stamp: 'fr 10/31/2020 05:07:47'!
isOsTurn

	^true! !

!OAdding methodsFor: 'state' stamp: 'fr 10/31/2020 05:07:39'!
isXsTurn

	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OAdding class' category: 'TerniLapilli - Exercise'!
OAdding class
	instanceVariableNames: ''!

!OAdding class methodsFor: 'handle' stamp: 'fr 11/2/2020 03:47:19'!
canHandle: aTerniLapilli

	^self isOsTimeToPlay: aTerniLapilli and: [:hasPiecesToAdd | hasPiecesToAdd ] 

	! !


!classDefinition: #OMoving category: 'TerniLapilli - Exercise'!
TerniLapilliState subclass: #OMoving
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Exercise'!

!OMoving methodsFor: 'actions' stamp: 'fr 10/31/2020 16:11:22'!
moveOFrom: currentPosition to: newPosition

	terniLapilliGame safeMoveOFrom: currentPosition to: newPosition ! !

!OMoving methodsFor: 'actions' stamp: 'fr 11/1/2020 21:23:30'!
moveXFrom: currentPosition to: newPosition

	terniLapilliGame itIsPlayerOsTurnError ! !

!OMoving methodsFor: 'actions' stamp: 'fr 10/31/2020 20:45:46'!
putOAt: aPosition

	^terniLapilliGame piecesLimitExceededError! !

!OMoving methodsFor: 'actions' stamp: 'fr 11/1/2020 21:23:30'!
putXAt: aPosition

	terniLapilliGame itIsPlayerOsTurnError 
! !


!OMoving methodsFor: 'state' stamp: 'fr 11/1/2020 01:30:41'!
hasOWon

	^false! !

!OMoving methodsFor: 'state' stamp: 'fr 11/1/2020 01:30:44'!
hasXWon

	^false! !

!OMoving methodsFor: 'state' stamp: 'fr 10/31/2020 16:02:16'!
isOsTurn

	^true! !

!OMoving methodsFor: 'state' stamp: 'fr 10/31/2020 16:02:20'!
isXsTurn

	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OMoving class' category: 'TerniLapilli - Exercise'!
OMoving class
	instanceVariableNames: ''!

!OMoving class methodsFor: 'handle' stamp: 'fr 11/2/2020 03:47:43'!
canHandle: aTerniLapilli

	^self isOsTimeToPlay: aTerniLapilli and: [:hasPiecesToAdd | hasPiecesToAdd not] 


	! !


!classDefinition: #OWon category: 'TerniLapilli - Exercise'!
TerniLapilliState subclass: #OWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Exercise'!

!OWon methodsFor: 'actions' stamp: 'fr 10/31/2020 20:45:37'!
moveOFrom: currentPosition to: newPosition

	terniLapilliGame gameIsOverError ! !

!OWon methodsFor: 'actions' stamp: 'fr 10/31/2020 20:45:37'!
moveXFrom: currentPosition to: newPosition

	terniLapilliGame gameIsOverError ! !

!OWon methodsFor: 'actions' stamp: 'fr 10/31/2020 20:45:37'!
putOAt: aPosition

	terniLapilliGame gameIsOverError ! !

!OWon methodsFor: 'actions' stamp: 'fr 10/31/2020 20:45:37'!
putXAt: aPosition

	terniLapilliGame gameIsOverError ! !


!OWon methodsFor: 'state' stamp: 'fr 11/1/2020 01:30:53'!
hasOWon

	^true! !

!OWon methodsFor: 'state' stamp: 'fr 11/1/2020 01:31:10'!
hasXWon

	^true! !

!OWon methodsFor: 'state' stamp: 'fr 11/1/2020 01:49:12'!
isOsTurn

	^false! !

!OWon methodsFor: 'state' stamp: 'fr 11/1/2020 01:49:09'!
isXsTurn

	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OWon class' category: 'TerniLapilli - Exercise'!
OWon class
	instanceVariableNames: ''!

!OWon class methodsFor: 'handle' stamp: 'fr 11/1/2020 01:32:18'!
canHandle: aTerniLapilli

	^aTerniLapilli OHasThreeInLine 

	! !


!classDefinition: #XAdding category: 'TerniLapilli - Exercise'!
TerniLapilliState subclass: #XAdding
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Exercise'!

!XAdding methodsFor: 'actions' stamp: 'fr 11/1/2020 21:23:37'!
moveOFrom: currentPosition to: newPosition

	terniLapilliGame itIsPlayerXsTurnError ! !

!XAdding methodsFor: 'actions' stamp: 'fr 10/31/2020 20:46:16'!
moveXFrom: currentPosition to: newPosition

	terniLapilliGame canNotMoveBeforeAddingThreePiecesError ! !

!XAdding methodsFor: 'actions' stamp: 'fr 11/1/2020 21:23:37'!
putOAt: aPosition

	terniLapilliGame itIsPlayerXsTurnError! !

!XAdding methodsFor: 'actions' stamp: 'fr 10/31/2020 04:46:53'!
putXAt: aPosition

	terniLapilliGame safePutXAt: aPosition ! !


!XAdding methodsFor: 'state' stamp: 'fr 11/1/2020 01:31:18'!
hasOWon

	^false! !

!XAdding methodsFor: 'state' stamp: 'fr 11/1/2020 01:31:20'!
hasXWon

	^false! !

!XAdding methodsFor: 'state' stamp: 'fr 10/31/2020 05:08:00'!
isOsTurn

	^false ! !

!XAdding methodsFor: 'state' stamp: 'fr 10/31/2020 05:07:56'!
isXsTurn

	^true ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XAdding class' category: 'TerniLapilli - Exercise'!
XAdding class
	instanceVariableNames: ''!

!XAdding class methodsFor: 'handle' stamp: 'fr 11/2/2020 03:48:38'!
canHandle: aTerniLapilli

	^self isXsTimeToPlay: aTerniLapilli and: [:hasPiecesToAdd | hasPiecesToAdd]

	! !


!classDefinition: #XMoving category: 'TerniLapilli - Exercise'!
TerniLapilliState subclass: #XMoving
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Exercise'!

!XMoving methodsFor: 'actions' stamp: 'fr 11/1/2020 21:23:37'!
moveOFrom: currentPosition to: newPosition

	terniLapilliGame itIsPlayerXsTurnError ! !

!XMoving methodsFor: 'actions' stamp: 'fr 10/31/2020 16:11:48'!
moveXFrom: currentPosition to: newPosition

	terniLapilliGame safeMoveXFrom: currentPosition to: newPosition ! !

!XMoving methodsFor: 'actions' stamp: 'fr 11/1/2020 21:23:37'!
putOAt: aPosition

	terniLapilliGame itIsPlayerXsTurnError

	! !

!XMoving methodsFor: 'actions' stamp: 'fr 10/31/2020 20:45:46'!
putXAt: aPosition
	
	^terniLapilliGame piecesLimitExceededError
	! !


!XMoving methodsFor: 'state' stamp: 'fr 11/1/2020 01:31:26'!
hasOWon

	^false! !

!XMoving methodsFor: 'state' stamp: 'fr 11/1/2020 01:31:29'!
hasXWon

	^false! !

!XMoving methodsFor: 'state' stamp: 'fr 10/31/2020 15:38:09'!
isOsTurn

	^false! !

!XMoving methodsFor: 'state' stamp: 'fr 10/31/2020 15:38:13'!
isXsTurn

	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XMoving class' category: 'TerniLapilli - Exercise'!
XMoving class
	instanceVariableNames: ''!

!XMoving class methodsFor: 'handle' stamp: 'fr 11/2/2020 03:48:49'!
canHandle: aTerniLapilli

	^self isXsTimeToPlay: aTerniLapilli and: [:hasPiecesToAdd | hasPiecesToAdd not]

	! !


!classDefinition: #XWon category: 'TerniLapilli - Exercise'!
TerniLapilliState subclass: #XWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Exercise'!

!XWon methodsFor: 'actions' stamp: 'fr 10/31/2020 20:45:37'!
moveOFrom: currentPosition to: newPosition

	terniLapilliGame gameIsOverError! !

!XWon methodsFor: 'actions' stamp: 'fr 10/31/2020 20:45:37'!
moveXFrom: currentPosition to: newPosition

	terniLapilliGame gameIsOverError! !

!XWon methodsFor: 'actions' stamp: 'fr 10/31/2020 20:45:37'!
putOAt: aPosition

	terniLapilliGame gameIsOverError! !

!XWon methodsFor: 'actions' stamp: 'fr 10/31/2020 20:45:37'!
putXAt: aPosition

	terniLapilliGame gameIsOverError! !


!XWon methodsFor: 'state' stamp: 'fr 11/1/2020 01:31:34'!
hasOWon

	^false! !

!XWon methodsFor: 'state' stamp: 'fr 11/1/2020 01:31:38'!
hasXWon

	^true! !

!XWon methodsFor: 'state' stamp: 'fr 11/1/2020 01:49:26'!
isOsTurn

	^false! !

!XWon methodsFor: 'state' stamp: 'fr 11/1/2020 01:49:24'!
isXsTurn

	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XWon class' category: 'TerniLapilli - Exercise'!
XWon class
	instanceVariableNames: ''!

!XWon class methodsFor: 'handle' stamp: 'fr 11/1/2020 01:32:32'!
canHandle: aTerniLapilli

	^aTerniLapilli XHasThreeInLine ! !

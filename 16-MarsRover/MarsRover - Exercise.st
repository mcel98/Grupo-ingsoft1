!classDefinition: #MarsRoverTests category: 'MarsRover - Exercise'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: 'south north east west'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover - Exercise'!

!MarsRoverTests methodsFor: 'setup' stamp: 'fr 10/24/2020 22:17:16'!
setUp
	
	south _ #S.
	north _ #N.
	east _ #E.
	west _ #W! !


!MarsRoverTests methodsFor: 'tests' stamp: 'fr 10/24/2020 22:23:58'!
test01EmptyCommandListDoesNothing

	| marsRover |
	
	marsRover _ MarsRover at: 1@1 facing: south.
	
	marsRover move: ''.
	
	self assert: (marsRover isAt: 1@1 facing: south)! !

!MarsRoverTests methodsFor: 'tests' stamp: 'fr 10/24/2020 22:24:25'!
test02MovingForwardWorksProperlyOnYAxis

	| marsRover |
	
	marsRover _ MarsRover at: 1@1 facing: south.
	
	marsRover move: 'f'.
	
	self assert: (marsRover isAt: 1@0 facing: south)! !

!MarsRoverTests methodsFor: 'tests' stamp: 'fr 10/24/2020 22:24:51'!
test03MovingBackwardsWorksProperlyOnYAxis

	| marsRover |
	
	marsRover _ MarsRover at: 1@1 facing: south.
	
	marsRover move: 'b'.
	
	self assert: (marsRover isAt: 1@2 facing: south)! !

!MarsRoverTests methodsFor: 'tests' stamp: 'fr 10/24/2020 22:25:38'!
test04RotatingRightWorksProperly

	| marsRover |
	
	marsRover _ MarsRover at: 1@1 facing: south.
	
	marsRover move: 'r'.
	
	self assert: (marsRover isAt: 1@1 facing: west)! !

!MarsRoverTests methodsFor: 'tests' stamp: 'fr 10/24/2020 22:25:54'!
test05RotatingLeftWorksProperly

	| marsRover |
	
	marsRover _ MarsRover at: 1@1 facing: south.
	
	marsRover move: 'l'.
	
	self assert: (marsRover isAt: 1@1 facing: east)! !

!MarsRoverTests methodsFor: 'tests' stamp: 'fr 10/24/2020 22:27:15'!
test06MovingForwardWorksProperlyOnXAxis

	| marsRover |
	
	marsRover _ MarsRover at: 1@1 facing: east.
	
	marsRover move: 'f'.
	
	self assert: (marsRover isAt: 2@1 facing: east)! !

!MarsRoverTests methodsFor: 'tests' stamp: 'fr 10/24/2020 22:27:49'!
test07MovingBackwardsWorksProperlyOnXAxis

	| marsRover |
	
	marsRover _ MarsRover at: 1@1 facing: east.
	
	marsRover move: 'b'.
	
	self assert: (marsRover isAt: 0@1 facing: east)! !

!MarsRoverTests methodsFor: 'tests' stamp: 'fr 10/24/2020 22:29:05'!
test08CommandListWithMoreThanOneCommandExecutesProperly

	| marsRover |
	
	marsRover _ MarsRover at: 1@1 facing: north.
	
	marsRover move: 'flf'.
	
	self assert: (marsRover isAt: 0@2 facing: west)! !

!MarsRoverTests methodsFor: 'tests' stamp: 'fr 10/24/2020 22:32:01'!
test09CreatingAMarsRoverWithAnInvalidCardinalPointShouldFail

	self should: [MarsRover at: 1@1 facing: #F] raise: Error withMessageText: MarsRover invalidCardinalPointErrorDescription! !

!MarsRoverTests methodsFor: 'tests' stamp: 'fr 10/24/2020 22:35:44'!
test10CommandListWithAnInvalidCommandShouldExecuteUntilItsFoundAndNoFurther
	
	| marsRover |
	
	marsRover _ MarsRover at: 1@1 facing: north.
	
	self should: [marsRover move: 'flbzfr'] raise: Error withMessageText: MarsRover invalidCommandErrorDescription.
	self assert: (marsRover isAt: 2@2 facing: west)! !


!classDefinition: #MarsRover category: 'MarsRover - Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientation actionsForCommands'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover - Exercise'!

!MarsRover methodsFor: 'initialization' stamp: 'fr 10/25/2020 17:27:17'!
initializeAt: aPosition facing: aCardinalPoint 
	
	position _ aPosition.
	orientation _ MarsRoverOrientation facing: aCardinalPoint for: self.
	self mapActions! !

!MarsRover methodsFor: 'initialization' stamp: 'fr 10/25/2020 17:32:31'!
mapActions

	actionsForCommands _ Dictionary new.
	actionsForCommands at: $f put: MarsRoverMoveForward new.
	actionsForCommands at: $b put: MarsRoverMoveBackwards new.
	actionsForCommands at: $l put: MarsRoverRotateLeft new.
	actionsForCommands at: $r put: MarsRoverRotateRight new.! !


!MarsRover methodsFor: 'movement' stamp: 'fr 10/24/2020 21:04:55'!
move: aCommandList
	
	aCommandList do: [ :aCommand | self process: aCommand]

	
	! !

!MarsRover methodsFor: 'movement' stamp: 'fr 10/25/2020 17:45:36'!
process: aCommand

	|action|
	
	action _ actionsForCommands at: aCommand ifAbsent: [self error: MarsRover invalidCommandErrorDescription ].
	
	action executeWith: orientation! !


!MarsRover methodsFor: 'orientation' stamp: 'fr 10/24/2020 20:57:06'!
faceEast

	orientation _ MarsRoverOrientation facing: #E for: self ! !

!MarsRover methodsFor: 'orientation' stamp: 'fr 10/24/2020 20:56:52'!
faceNorth

	orientation _ MarsRoverOrientation facing: #N for: self ! !

!MarsRover methodsFor: 'orientation' stamp: 'fr 10/24/2020 20:56:59'!
faceSouth

	orientation _ MarsRoverOrientation facing: #S for: self ! !

!MarsRover methodsFor: 'orientation' stamp: 'fr 10/24/2020 20:57:12'!
faceWest

	orientation _ MarsRoverOrientation facing: #W for: self ! !


!MarsRover methodsFor: 'movement cardinal orientation' stamp: 'fr 10/24/2020 20:55:58'!
moveEast

	position _ position + (1@0)! !

!MarsRover methodsFor: 'movement cardinal orientation' stamp: 'fr 10/24/2020 20:55:38'!
moveNorth

	position _ position + (0@1)! !

!MarsRover methodsFor: 'movement cardinal orientation' stamp: 'fr 10/24/2020 20:55:46'!
moveSouth

	position _ position - (0@1)! !

!MarsRover methodsFor: 'movement cardinal orientation' stamp: 'fr 10/24/2020 20:56:05'!
moveWest

	position _ position - (1@0)! !


!MarsRover methodsFor: 'state' stamp: 'fr 10/24/2020 21:01:10'!
isAt: aPosition facing: aCardinalPoint

	^aPosition = position and: [orientation faces: aCardinalPoint]
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover - Exercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'fr 10/24/2020 20:03:48'!
at: aPosition facing: aCardinalPoint 

	^self new initializeAt: aPosition facing: aCardinalPoint ! !


!MarsRover class methodsFor: 'exceptions' stamp: 'fr 10/24/2020 21:59:17'!
invalidCardinalPoint
	
	^MarsRoverOrientation invalidCardinalPoint ! !


!MarsRover class methodsFor: 'error descriptions' stamp: 'fr 10/24/2020 21:57:54'!
invalidCardinalPointErrorDescription
	
	^MarsRoverOrientation invalidCardinalPointErrorDescription! !

!MarsRover class methodsFor: 'error descriptions' stamp: 'fr 10/24/2020 22:02:27'!
invalidCommandErrorDescription
	
	^'Invalid command'! !


!classDefinition: #MarsRoverActions category: 'MarsRover - Exercise'!
Object subclass: #MarsRoverActions
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover - Exercise'!

!MarsRoverActions methodsFor: 'execution' stamp: 'fr 10/25/2020 17:30:45'!
executeWith: anOrientation

	self subclassResponsibility.! !


!classDefinition: #MarsRoverMoveBackwards category: 'MarsRover - Exercise'!
MarsRoverActions subclass: #MarsRoverMoveBackwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover - Exercise'!

!MarsRoverMoveBackwards methodsFor: 'execution' stamp: 'fr 10/25/2020 17:30:56'!
executeWith: anOrientation

	^anOrientation moveBackwards.! !


!classDefinition: #MarsRoverMoveForward category: 'MarsRover - Exercise'!
MarsRoverActions subclass: #MarsRoverMoveForward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover - Exercise'!

!MarsRoverMoveForward methodsFor: 'execution' stamp: 'fr 10/25/2020 17:31:02'!
executeWith: anOrientation

	^anOrientation moveForward.! !


!classDefinition: #MarsRoverRotateLeft category: 'MarsRover - Exercise'!
MarsRoverActions subclass: #MarsRoverRotateLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover - Exercise'!

!MarsRoverRotateLeft methodsFor: 'execution' stamp: 'fr 10/25/2020 17:31:07'!
executeWith: anOrientation

	^anOrientation rotateLeft.! !


!classDefinition: #MarsRoverRotateRight category: 'MarsRover - Exercise'!
MarsRoverActions subclass: #MarsRoverRotateRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover - Exercise'!

!MarsRoverRotateRight methodsFor: 'execution' stamp: 'fr 10/25/2020 17:31:13'!
executeWith: anOrientation

	^anOrientation rotateRight.! !


!classDefinition: #MarsRoverOrientation category: 'MarsRover - Exercise'!
Object subclass: #MarsRoverOrientation
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover - Exercise'!

!MarsRoverOrientation methodsFor: 'movement' stamp: 'fr 10/24/2020 20:45:51'!
moveBackwards
	
	self subclassResponsibility ! !

!MarsRoverOrientation methodsFor: 'movement' stamp: 'fr 10/24/2020 20:45:45'!
moveForward
	
	self subclassResponsibility ! !

!MarsRoverOrientation methodsFor: 'movement' stamp: 'fr 10/24/2020 20:45:56'!
rotateLeft
	
	self subclassResponsibility ! !

!MarsRoverOrientation methodsFor: 'movement' stamp: 'fr 10/24/2020 20:45:58'!
rotateRight
	
	self subclassResponsibility ! !


!MarsRoverOrientation methodsFor: 'initialization' stamp: 'fr 10/24/2020 20:54:00'!
initializeFor: aMarsRover

	marsRover _ aMarsRover ! !


!MarsRoverOrientation methodsFor: 'state' stamp: 'fr 10/24/2020 20:58:29'!
faces: aCardinalPoint

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverOrientation class' category: 'MarsRover - Exercise'!
MarsRoverOrientation class
	instanceVariableNames: ''!

!MarsRoverOrientation class methodsFor: 'instance creation' stamp: 'fr 10/24/2020 21:59:17'!
facing: aCardinalPoint for: aMarsRover

	"^(self subclasses detect: [:anOrientationClass | anOrientationClass canHandle: aCardinalPoint]) for: aMarsRover"
	
	^self subclasses detect: [:anOrientationClass | anOrientationClass canHandle: aCardinalPoint] ifFound: [:anOrientationClass | anOrientationClass for: aMarsRover] ifNone: [self invalidCardinalPoint] 
	! !


!MarsRoverOrientation class methodsFor: 'instance creation - private' stamp: 'fr 10/24/2020 20:54:22'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!MarsRoverOrientation class methodsFor: 'exceptions' stamp: 'fr 10/24/2020 21:59:40'!
invalidCardinalPoint
	
	self error: self invalidCardinalPointErrorDescription ! !


!MarsRoverOrientation class methodsFor: 'error descriptions' stamp: 'fr 10/24/2020 21:58:37'!
invalidCardinalPointErrorDescription
	
	^'Invalid cardinal point'! !


!classDefinition: #EastOrientation category: 'MarsRover - Exercise'!
MarsRoverOrientation subclass: #EastOrientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover - Exercise'!

!EastOrientation methodsFor: 'movement' stamp: 'fr 10/24/2020 20:46:41'!
moveBackwards
	
	marsRover moveWest! !

!EastOrientation methodsFor: 'movement' stamp: 'fr 10/24/2020 20:46:29'!
moveForward
	
	marsRover moveEast! !

!EastOrientation methodsFor: 'movement' stamp: 'fr 10/24/2020 20:46:59'!
rotateLeft
	
	marsRover faceNorth! !

!EastOrientation methodsFor: 'movement' stamp: 'fr 10/24/2020 20:47:07'!
rotateRight
	
	marsRover faceSouth! !


!EastOrientation methodsFor: 'state' stamp: 'fr 10/24/2020 20:59:02'!
faces: aCardinalPoint

	^aCardinalPoint = #E! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EastOrientation class' category: 'MarsRover - Exercise'!
EastOrientation class
	instanceVariableNames: ''!

!EastOrientation class methodsFor: 'as yet unclassified' stamp: 'fr 10/24/2020 21:00:30'!
canHandle: aCardinalPoint 

	^aCardinalPoint = #E! !


!classDefinition: #NorthOrientation category: 'MarsRover - Exercise'!
MarsRoverOrientation subclass: #NorthOrientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover - Exercise'!

!NorthOrientation methodsFor: 'movement' stamp: 'fr 10/24/2020 20:47:36'!
moveBackwards

	marsRover moveSouth! !

!NorthOrientation methodsFor: 'movement' stamp: 'fr 10/24/2020 20:47:27'!
moveForward

	marsRover moveNorth! !

!NorthOrientation methodsFor: 'movement' stamp: 'fr 10/24/2020 20:48:21'!
rotateLeft

	marsRover faceWest! !

!NorthOrientation methodsFor: 'movement' stamp: 'fr 10/24/2020 20:48:28'!
rotateRight

	marsRover faceEast! !


!NorthOrientation methodsFor: 'state' stamp: 'fr 10/24/2020 20:59:09'!
faces: aCardinalPoint

	^aCardinalPoint = #N! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NorthOrientation class' category: 'MarsRover - Exercise'!
NorthOrientation class
	instanceVariableNames: ''!

!NorthOrientation class methodsFor: 'as yet unclassified' stamp: 'fr 10/24/2020 21:00:37'!
canHandle: aCardinalPoint 

	^aCardinalPoint = #N! !


!classDefinition: #SouthOrientation category: 'MarsRover - Exercise'!
MarsRoverOrientation subclass: #SouthOrientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover - Exercise'!

!SouthOrientation methodsFor: 'movement' stamp: 'fr 10/24/2020 20:48:48'!
moveBackwards

	marsRover moveNorth
	! !

!SouthOrientation methodsFor: 'movement' stamp: 'fr 10/24/2020 20:48:39'!
moveForward

	marsRover moveSouth! !

!SouthOrientation methodsFor: 'movement' stamp: 'fr 10/24/2020 20:48:59'!
rotateLeft

	marsRover faceEast
	! !

!SouthOrientation methodsFor: 'movement' stamp: 'fr 10/24/2020 20:49:07'!
rotateRight

	marsRover faceWest
	! !


!SouthOrientation methodsFor: 'state' stamp: 'fr 10/24/2020 20:59:16'!
faces: aCardinalPoint

	^aCardinalPoint = #S! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SouthOrientation class' category: 'MarsRover - Exercise'!
SouthOrientation class
	instanceVariableNames: ''!

!SouthOrientation class methodsFor: 'as yet unclassified' stamp: 'fr 10/24/2020 21:00:42'!
canHandle: aCardinalPoint 

	^aCardinalPoint = #S! !


!classDefinition: #WestOrientation category: 'MarsRover - Exercise'!
MarsRoverOrientation subclass: #WestOrientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover - Exercise'!

!WestOrientation methodsFor: 'movement' stamp: 'fr 10/24/2020 20:49:30'!
moveBackwards

	marsRover moveEast! !

!WestOrientation methodsFor: 'movement' stamp: 'fr 10/24/2020 20:49:23'!
moveForward

	marsRover moveWest! !

!WestOrientation methodsFor: 'movement' stamp: 'fr 10/24/2020 20:49:42'!
rotateLeft

	marsRover faceSouth! !

!WestOrientation methodsFor: 'movement' stamp: 'fr 10/24/2020 20:49:48'!
rotateRight

	marsRover faceNorth! !


!WestOrientation methodsFor: 'state' stamp: 'fr 10/24/2020 20:59:22'!
faces: aCardinalPoint

	^aCardinalPoint = #W! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WestOrientation class' category: 'MarsRover - Exercise'!
WestOrientation class
	instanceVariableNames: ''!

!WestOrientation class methodsFor: 'as yet unclassified' stamp: 'fr 10/24/2020 21:00:46'!
canHandle: aCardinalPoint 

	^aCardinalPoint = #W! !

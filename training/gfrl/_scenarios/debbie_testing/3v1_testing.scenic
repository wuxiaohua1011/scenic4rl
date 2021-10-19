from scenic.simulators.gfootball.model import *
from scenic.simulators.gfootball.behaviors import *
from scenic.simulators.gfootball.simulator import GFootBallSimulator
param game_duration = 400
param deterministic = False
param offsides = False
param right_team_difficulty = 1
param end_episode_on_score = True
param end_episode_on_out_of_play = True

leftLeftBackRegion = get_reg_from_edges(80, 25, 20, 15)
leftCenterBackRegion = get_reg_from_edges(-70, -65, 10, -10)
leftRightMidRegion = get_reg_from_edges(80, 35, -10, -20)

rightRightMidRegion  = get_reg_from_edges(-55, -50, 20, 15)
rightCenterMidRegion = get_reg_from_edges(-65, -60, 20, 0)
rightLeftMidRegion   = get_reg_from_edges(-55, -50, 10, 0)

rightRM_AttackRegion = get_reg_from_edges(-80, -70, 5, -5)
rightAM_AttackRegion = get_reg_from_edges(-90, -85, -5, -10)
rightLM_AttackRegion = get_reg_from_edges(-55, -50, 0, 10)

passToRightCenterMidRegion = get_reg_from_edges(-65, -50, 0, 15)

behavior runToReceiveCrossAndShoot(destinationPoint):
	do MoveToPosition(destinationPoint)
	do HoldPosition() until self.owns_ball
	do dribbleToAndShoot(-80 @ 0)

behavior runToReceivePassToEgo(destinationPoint):
	do MoveToPosition(destinationPoint)
	do HoldPosition() until self.owns_ball
	distance_ego = distance from self to ego
	distance_opponent = distance from self to nearestOpponent(self)
	try:
	    do dribble_evasive_zigzag(passToRightCenterMidRegion)
	interrupt when distance_ego < 20 or distance_opponent < 10:
        do ShortPassTo(ego)

behavior rightLMBehavior():
	destinationPoint = Point on rightLM_AttackRegion
	do MoveToPosition(destinationPoint)
	do HighPassTo(right_RightMid)

	do HoldPosition()

behavior rightMBehavior(destinationPoint):
    do MoveToPosition(destinationPoint)
    do ShortPassTo(ego)
    nearestTeammate_of_right_RightMid = nearestTeammate(right_RightMid)
    do HoldPosition()


RightGK
right_RightMid = RightRM on rightRightMidRegion, with behavior rightMBehavior(Point on rightRM_AttackRegion)
ego = RightAM on rightCenterMidRegion, with behavior runToReceiveCrossAndShoot(Point on rightAM_AttackRegion)
right_LeftMid = RightLM on rightLeftMidRegion, with behavior rightLMBehavior()
ball = Ball ahead of right_LeftMid by 2

LeftGK with behavior HoldPosition()
leftLB = LeftLB on leftLeftBackRegion
leftCB = LeftCB on leftCenterBackRegion
leftRB = LeftRM on leftRightMidRegion
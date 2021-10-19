from scenic.simulators.gfootball.model import *
from scenic.simulators.gfootball.behaviors import *
from scenic.simulators.gfootball.simulator import GFootBallSimulator

param game_duration = 400
param deterministic = False
param offsides = False
param end_episode_on_score = True
param end_episode_on_out_of_play = True
param end_episode_on_possession_change = True

# ---- behaviors ----

behavior PassOrDefault(point):
    while True:
        if self.owns_ball:
            take SetDirection(5)
            take Pass()
            take NoAction()
        else:
            take BuiltinAIAction()

behavior FollowObj(obj):
    while True:
        if self.owns_ball:
            take BuiltinAIAction()
        else:
            take MoveTowardsPoint(ball.position, self.position, rightTeam=True)

# ----- Regions -----

# for offside rule
p1_spawn = 68 @ 10
p2_spawn = 68 @ -10
p3_spawn = 76 @ -10
o1_spawn = 74 @ 0

# ----- Players -----
ego = LeftGK with behavior HoldPosition()
p1 = LeftPlayer with role "LM", at p1_spawn, with behavior PassOrDefault(p1_spawn)
p3 = LeftPlayer with role "RM", at p3_spawn, with behavior PassOrDefault(p2_spawn)
p2 = LeftPlayer with role "RM", at p2_spawn, with behavior PassOrDefault(p3_spawn)

# ball
ball = Ball ahead of p1 by 2


# Right
o0 = RightGK with behavior HoldPosition()
o1 = RightPlayer with role "RB", at o1_spawn, with behavior FollowObj(ball)


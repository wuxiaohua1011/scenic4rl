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
            take NoAction()
behavior Pass():
    while True:
        if self.owns_ball:
            take SetDirection(5)
            take Pass()
            take NoAction()
        else:
            take NoAction()
behavior FollowObj(obj):
    while True:
        if self.owns_ball:
            take NoAction()
        else:
            take MoveTowardsPoint(ball.position, self.position, rightTeam=True)

# ----- Regions -----

# for offside rule
p1_spawn = get_reg_from_edges(230, 30, 10, -10)
p2_spawn =  get_reg_from_edges(230, 30, 0, -10)
p3_spawn =  get_reg_from_edges(230, 60, 0, -10)
o1_spawn = get_reg_from_edges(100, 98, 2, -2)

# ----- Players -----
ego = LeftGK with behavior HoldPosition()
p1 = LeftPlayer with role "LM", on p1_spawn#, with behavior PassOrDefault(p1_spawn)
p2 = LeftPlayer with role "RM", right of p1 by 20  # , with behavior PassOrDefault(p3_spawn)
p3 = LeftPlayer with role "RM", ahead of p1 by 20 #, with behavior PassOrDefault(p2_spawn)

# ball
ball = Ball ahead of p1 by 2


# Right
o0 = RightGK with behavior Pass()
o1 = RightPlayer with role "RB", on o1_spawn, with behavior FollowObj(ball)


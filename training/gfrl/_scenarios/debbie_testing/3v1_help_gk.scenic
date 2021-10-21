from scenic.simulators.gfootball.model import *
from scenic.simulators.gfootball.behaviors import *
from scenic.simulators.gfootball.simulator import GFootBallSimulator

param game_duration = 400
param deterministic = False
param offsides = False
param end_episode_on_score = True
param end_episode_on_out_of_play = True
param end_episode_on_possession_change = True

# ----- Constants -----


# ----- Behaviors -----
behavior serverBehavior():
    # ds = simulation().game_ds
    take ReleaseDirection()
    take ReleaseDirection()
    take ReleaseDirection()
    take Pass()
    # do PassToPlayer(p1, "short")
    do HoldPosition()

behavior helpGK():
    goal_position = Point on o0_spawn
    print(goal_position.x)
    print(goal_position.y)
    print(o0.x)
    print(o0.y)
    while True:
        take MoveTowardsPoint(goal_position, self.position, True)
        if (distance from o0 to self) < 5:
            break
    while True:
        do FollowObject(ball, 0, True)



# ----- Regions -----

# for offside rule
pass_zone = get_reg_from_edges(70, 76, -3, 3)
p1_spawn = 70 @ 3
p2_spawn = 70 @ -3
p3_spawn = 76 @ -3
o1_spawn = 74 @ 0
o0_spawn = get_reg_from_edges(100, 98, 2, -2)
corner = 80 @ 3
# ----- Players -----
# Left
ego = LeftGK with behavior HoldPosition()

p1 = LeftPlayer with role "LM", at p1_spawn
p3 = LeftPlayer with role "RM", at p3_spawn
p2 = LeftPlayer with role "RM", at p2_spawn

p4 = LeftPlayer with role "LM", at 60 @ 8, with behavior serverBehavior()

# Right
o0 = RightGK on o0_spawn
o1 = RightPlayer at o1_spawn, with behavior helpGK()

# Ball
ball = Ball right of p4 by 2
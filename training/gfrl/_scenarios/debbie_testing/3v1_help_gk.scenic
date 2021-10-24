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
        if self.owns_ball:
            do dribbleToAndShoot(Point on opponent_goal)
        else:
            take MoveTowardsPoint(ball.position, self.position, rightTeam=True)



# ----- Regions -----

# for offside rule
p1_spawn = get_reg_from_edges(230, 30, 10, -10)
o0_spawn = get_reg_from_edges(100, 98, 2, -2)
opponent_goal = get_reg_from_edges(-100, -98, 2, -2)
# ----- Players -----
# Left
ego = LeftGK with behavior HoldPosition()

p1 = LeftPlayer with role "AM", on p1_spawn
p3 = LeftPlayer with role "AM", right of p1 by 10
p2 = LeftPlayer with role "AM", ahead of p1 by 10

p4 = LeftPlayer with role "AM", left of p1 by 20, with behavior serverBehavior()

# Right
o0 = RightGK on o0_spawn
o1 = RightPlayer right of p2 by 10, with behavior helpGK()

# Ball
ball = Ball right of p4 by 2
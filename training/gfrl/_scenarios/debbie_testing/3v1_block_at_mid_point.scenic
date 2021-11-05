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

behavior goToMidPoint():
    ds = simulation().game_ds
    opponent_list = ds.left_players
    # player_owns_ball = player_with_ball(ds, ball, team=1)
    player_owns_ball = None

    while True:
        for o in opponent_list:
            if (distance from o to ball) < 2:
                player_owns_ball = o
                print("Got player owns ball")
                break
        closest_opp_to_self, closest_opp_to_self_distance = get_closest_player_info(self, opponent_list)
        closest_opp_to_owner, closest_opp_to_owner_distance = get_closest_player_info(player_owns_ball, opponent_list)
        mid_x = (closest_opp_to_self.x + closest_opp_to_owner.x) / 2
        mid_y = (closest_opp_to_self.y + closest_opp_to_owner.y) / 2
        print("Got the midpoint of the opponent closest to the ball owner and the opponent closest to self")

        mid_x_range = mid_x + Range(-5,5)
        mid_y_range = mid_y + Range(-5,5)
        do MoveToPosition(mid_x_range @ mid_y_range)
        print("Moving to midpoint")
        if (distance from self to ball) < 2:
            do dribbleToAndShoot(Point on opponent_goal)
            print("Dribbled")
            break
    do HoldPosition()



# ----- Regions -----

# for offside rule
p1_spawn = get_reg_from_edges(230, 30, 10, -10)
o0_spawn = get_reg_from_edges(100, 98, 2, -2)
opponent_goal = get_reg_from_edges(-100, -98, 2, -2)
# ----- Players -----
# Left
ego = LeftGK with behavior HoldPosition(), on opponent_goal

p1 = LeftPlayer with role "AM", on p1_spawn
p3 = LeftPlayer with role "AM", right of p1 by 10
p2 = LeftPlayer with role "AM", ahead of p1 by 10

p4 = LeftPlayer with role "AM", left of p1 by 20, with behavior serverBehavior()

# Right
o0 = RightGK on o0_spawn
o1 = RightPlayer right of p2 by 10, with behavior goToMidPoint()

# Ball
ball = Ball right of p4 by 2
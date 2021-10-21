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

        do MoveToPosition(mid_x @ mid_y)
        print("d1")
        print("d2")
        if (distance from self to ball) < 2:
            do AimGoalCornerAndShoot()
            print("d3")
            break
    do HoldPosition()



# ----- Regions -----

# for offside rule
pass_zone = get_reg_from_edges(70, 76, -3, 3)
p1_spawn = 70 @ 3
p2_spawn = 70 @ -3
p3_spawn = 76 @ -3
o1_spawn = 74 @ 0
corner = 80 @ 3
# ----- Players -----
# Left
ego = LeftGK with behavior HoldPosition()

p1 = LeftPlayer with role "LM", at p1_spawn
p3 = LeftPlayer with role "RM", at p3_spawn
p2 = LeftPlayer with role "RM", at p2_spawn

p4 = LeftPlayer with role "LM", at 60 @ 8, with behavior serverBehavior()

# Right
o0 = RightGK #with behavior HoldPosition()
o1 = RightPlayer at o1_spawn, with behavior goToMidPoint()

# Ball
ball = Ball right of p4 by 2
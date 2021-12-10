from scenic.simulators.gfootball.model import *
from scenic.simulators.gfootball.simulator import GFootBallSimulator

param game_duration = 400
param deterministic = False
param offsides = False
param end_episode_on_score = True
param end_episode_on_out_of_play = True
param end_episode_on_possession_change = True


p1_spawn_point = 0 @ 0
p2_spawn = get_reg_from_edges(60, 80, 42,-42)
p2_spawn_point = Point on p2_spawn
require (abs(p2_spawn_point.y) > 20)

p3_spawn_point = p2_spawn_point.x @ -p2_spawn_point.y

ego = LeftPlayer with role "AM", on p1_spawn_point
p2 = LeftPlayer with role "CF", on p2_spawn_point
o2_spawn = 50 @ 0
o1_spawn = left of p2 by by 2

o1 = RightCB on o1_spawn
o2 = RightGK on o2_spawn


ball = Ball ahead of ego by 2
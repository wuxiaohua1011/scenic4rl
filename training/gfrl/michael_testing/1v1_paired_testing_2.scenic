from scenic.simulators.gfootball.model import *
from scenic.simulators.gfootball.simulator import GFootBallSimulator

param game_duration = 400
param deterministic = False
param offsides = False
param end_episode_on_score = True
param end_episode_on_out_of_play = True
param end_episode_on_possession_change = True

p1_spawn = 0 @ -40
o0_spawn = 80 @ 0

ego = LeftGK
p1 = LeftPlayer with role "AM", at p1_spawn
o0 = RightGK at o0_spawn

ball = Ball ahead of p1 by 2
from scenic.simulators.gfootball.model import *
from scenic.simulators.gfootball.simulator import GFootBallSimulator

param game_duration = 400
param deterministic = False
param offsides = False
param end_episode_on_score = True
param end_episode_on_out_of_play = True
param end_episode_on_possession_change = True


ego = Ball at 30 @ 0

LeftGK
LeftAM at 70 @ -10
LeftCF at 28 @ 0
LeftCMR at 50 @ -10
LeftCML at 50 @ 10

RightGK
RightCB at 60 @ 0
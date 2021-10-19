from scenic.simulators.gfootball.utilities.scenic_helper import buildScenario
scenario = buildScenario("/home/michael/Desktop/projects/scenic4rl/training/gfrl/_scenarios/offense/close_attacking_passes.scenic") #Find all our scenarios in training/gfrl/_scenarios/

from scenic.simulators.gfootball.rl.gfScenicEnv_v2 import GFScenicEnv_v2

env_settings = {
    "stacked": True,
    "rewards": 'scoring',
    "representation": 'extracted',
    "players": [f"agent:left_players=1"],
    "real_time": True
    }
env = GFScenicEnv_v2(initial_scenario=scenario,
                     gf_env_settings=env_settings,
                     allow_render=True)

env.reset()
done = False
while not done:
    pass
#     action = env.action_space.sample()
#     _, _, done, _ = env.step(action)

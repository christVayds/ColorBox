import random

class Colors():

    def __init__(self):

        self.colors = [
            (50, 168, 82),
            (0,255,0),
            (20, 255, 232)
        ]

    def randomColor(self):
        return random.choice(self.colors)
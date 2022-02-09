from manim import *

class VectorFieldOne(Scene):

    def construct(self):
        func = lambda v: (-2*(np.floor(v[1])%2) + 1)*RIGHT + (-2*(np.floor(v[0])%2) + 1)*UL 
        self.add(StreamLines(func))

class VectorFieldTwo(Scene):

    def construct(self):
        func = lambda v: np.sin(v[1]/(8*np.pi))*UR + -2*(np.cos(v[0]) + 1)*UL 
        self.add(StreamLines(func))

class VectorFieldThree(Scene):

    def construct(self):
        func = lambda v: (1/np.sqrt(np.sum(v**2)))*LEFT - (1/np.sum(v**2))*RIGHT
        self.add(StreamLines(func))

class VectorFieldFour(Scene):

    def construct(self):
        func = lambda v: (np.abs(v[0]))*UR + (1/(0.01 if v[1] == 0 else v[1]))*RIGHT
        self.add(StreamLines(func, color_scheme=lambda x: np.sum(np.sqrt(np.abs(x)))**5,
        min_color_scheme_value=1, max_color_scheme_value=10))
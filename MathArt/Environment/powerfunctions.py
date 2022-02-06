from manim import *

class PowerFunctions(Scene):
    
    def construct(self):
        
        grid = Axes(
            x_range=[0, 1, 0.01],
            y_range=[0, 1, 0.01],
            tips=False,
            axis_config={"include_ticks": False}
        )

        plots = VGroup()
        for n in np.linspace(1, 30, 50):
            plots += grid.plot(lambda x: x**n, color=WHITE)
            plots += grid.plot(lambda x: x**(1/n), color=WHITE)


        self.add(plots)

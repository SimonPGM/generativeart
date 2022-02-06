from manim import *

class Pianimation(Scene):
    def construct(self):
        grid = Text("\\pi").get_grid(10, 10, height=2)
        self.add(grid)

        self.play(grid.animate.set_submobject_colors_by_gradient(BLUE, GREEN))
        self.wait()
        self.play(grid.animate.set_height(8.5))
        self.wait()

        self.play(grid.animate.apply_complex_function(np.exp), run_time=5)
        self.wait()

        self.play(
            grid.animate.apply_function(
                lambda p: [
                    p[0] + 0.25 * np.sin(p[1]),
                    p[1] + 0.25 * np.sin(p[0]),
                    p[2]
                ]
            ),
            run_time=5,
        )
        self.wait()
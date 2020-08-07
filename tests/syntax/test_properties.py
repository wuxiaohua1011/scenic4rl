
import pytest
import numpy as np

from scenic.syntax.translator import InterpreterParseError
from tests.utils import compileScenic, sampleEgoFrom

def test_position_wrong_type():
    with pytest.raises(InterpreterParseError):
        compileScenic('ego = Object with position 4')

def test_position_oriented_point():
    sampleEgoFrom("""
        a = OrientedPoint at 1@0
        b = OrientedPoint at 0@1
        ego = Object with position Uniform(a, b)
    """)

def test_position_numpy_types():
    ego = sampleEgoFrom("""
        import numpy as np
        ego = Object with position np.single(3.4) @ np.single(7)
    """)
    assert tuple(ego.position) == pytest.approx((3.4, 7))

def test_heading_wrong_type():
    with pytest.raises(InterpreterParseError):
        compileScenic('ego = Object with heading 4 @ 1')

def test_heading_numpy_types():
    ego = sampleEgoFrom("""
        import numpy as np
        ego = Object with heading np.single(3.4)
    """)
    assert ego.heading == pytest.approx(3.4)

# Spirals

Sketch experimenting with the [golden
angle](https://en.wikipedia.org/wiki/Golden_angle).

## Structure

### `Spiral.pde`

Contains an abstract class which defines how to draw a spiral. It takes as
parameters the number of elements in the spiral, the speed at which the elements
of the spiral are moving, and the direction the spiral is turning.

The elements of the spiral are drawn using polar coordinates. The theta of the
element is determined by rotating iteratively about the center in whole number
multiples of the golden angle. This is offset by adding the product of the
direction, speed, and frameCount to slightly rotate the spiral each frame. The
radius of the element is simply determined by it's position in the list.

Since this is an abstract class, you can implement your own spiral simply by
subclassing `Spiral` and implementing the abstract `drawElement` method.

### `CircleSpiral.pde`

Contains many concrete implementations of `Spiral`. The primary subclass is
`CircleSpiral`, which implements `drawElement` by drawing a circle at the
spiral's current polar coordinates. It also introduces mechanisms for
controlling each circle's color and size.

Each of the other subclasses inherit from `CircleSpiral` and determine color and
size in their own way. The spiral I was most pleased with the results from was
`SineColorscaleCircleSpiral`. The circle's sizes are determined by a sinusoidal
function (in this case, cosine) on the `frameCount` and `sineSpeed`. The color
also linearly scales with the radius.

### `Spirals.pde`

Driver class. Contains concrete instantiations each spiral, as well as an input
framework for adjusting parameters including speed, direction, zoom, and
play/pause.

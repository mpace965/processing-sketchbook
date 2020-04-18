# Processing Sketchbook

This repo is my [Processing](https://processing.org/) sketchbook, containing all of my sketches.

## Making the Videos

### Usage

`$ ./scripts/make-video.sh <SketchName>`

### Prerequisites

The script uses `ffmpeg` to assemble the frames.

The script depends on a `frames` directory in each sketch directory. To generate the frames directory, simply open the
sketch in Processing, uncomment the `if` block containing the `saveFrame` method, and run the sketch. After all of the
frames have been saved, you can run the script on the sketch directory.


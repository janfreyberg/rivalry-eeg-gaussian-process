[![Binder](http://mybinder.org/badge.svg)](http://mybinder.org:/repo/janfreyberg/rivalry-eeg-gaussian-process)
[![Binder](https://img.shields.io/badge/view-shiny--presentation-blue.svg)](http://shiny.janfreyberg.com/rivalry-gaussian-process)

# rivalry-eeg-gaussian-process

This code explores the decoding of perceptual states during rivalry using
frequency-tagged stimuli.

It currently trains a [GaussianProcessClassifier (from sklearn)](http://scikit-learn.org/stable/modules/generated/sklearn.gaussian_process.GaussianProcessClassifier.html#sklearn.gaussian_process.GaussianProcessClassifier) on "training" data where subjects saw the same image in each eye, then tests
the data from a real rivalry trial and compares predicted perceptual state with
reported perceptual state.

### Run:
You can either download the repository and run `python gaussian-process.py`, or go to [the binder page](http://mybinder.org:/repo/janfreyberg/rivalry-eeg-gaussian-process).

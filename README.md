DurationProgressBar
===

Create a progress bar based on a duration in seconds.   
The view is fully customisable. 


Install
--

Add this repository to your swift package manager. 

```
https://github.com/cemolcay/DurationProgressBar.git
```

Usage
--

Create a `DurationProgressBar` instance and set it's frame, background color, its `progressView`'s color etc. 

Call `startProgress(duration:)` function with a duration in seconds. 

You can also use `DurationProgressBarDelegate`'s `didFinisedProgress` method to inform about when the progress finished. 

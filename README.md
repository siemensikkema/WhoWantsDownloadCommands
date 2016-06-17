# WhoWantsDownloadCommands
A simple command line tool to output ffmpeg download commands for WWDC 2016 videos.

Despite the existance of really good WWDC apps for iPad and iPhone it can still be useful to be able to download the WWDC videos for offline usage. This tool scrapes the Apple WWDC website for video links and outputs commands to download the videos using [ffmpeg](http://ffmpeg.org/). I chose to use the video/audio channels for the videos with a resolution of 960x540\*. These channel numbers are 6 & 7. See table below for different options. Although audio and video come in pairs, mixing and matching should be possible.

Video channel|Audio channel|Video resolution*|Audio resolution (KHz)|Audio bitrate (kb/s)
---|---|---|---|---
0|1|640x360|44.1|64
2|3|1920x1080|48|128
4|5|1280x720|44.1|128
6|7|960x540|44.1|128
8|9|480x270|44.1|64

 \*or close to it, depending on the video
 
# Requirements
* Xcode 8
* [ffmpeg](http://ffmpeg.org/)
* [Carthage](https://github.com/Carthage/Carthage/)

# Usage
* run `carthage bootstrap --platform OSX`
* build and run

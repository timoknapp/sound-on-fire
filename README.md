<img width="50%" src="screenshots/sound_on_fire_logo.png">

# 🔊☁️ 🔥📺  SoundOnFire 

![beta build](https://img.shields.io/github/workflow/status/tea-mo903/sound-on-fire/SoundOnFire%20Development?label=beta)
![release build](https://img.shields.io/github/workflow/status/tea-mo903/sound-on-fire/SoundOnFire%20Release?label=release)
<a href="https://github.com/tea-mo903/sound-on-fire/releases">![](https://img.shields.io/github/v/release/tea-mo903/sound-on-fire?include_prereleases)</a> <!-- PRE-RElEASE -->
<a href="https://github.com/tea-mo903/sound-on-fire/releases">![](https://img.shields.io/github/release-date-pre/tea-mo903/sound-on-fire)</a>
<a href="https://github.com/tea-mo903/sound-on-fire/graphs/contributors">![](https://img.shields.io/github/contributors/tea-mo903/sound-on-fire)</a>
<!-- <a href="https://github.com/tea-mo903/sound-on-fire/releases">![](https://img.shields.io/github/release-date/tea-mo903/sound-on-fire)</a> --> <!-- RElEASE -->

A Flutter based SoundCloud App for your Fire TV.

## Still work in progress

The current implementation looks like this:

<img width="100%" src="screenshots/flutter_01.png">

### Features planned:

- ✔️ Comprehensive Footer (Current Track, Play/Pause, etc.)
- ✔️ Disable Screensaver
- In-App Update
- FireTV Hardkeys (Play/Pause, Previous, Forward)
- ✔️ App Icon
- Installation Guide in `README.MD`
- Fetch more search results while scrolling
- Continue playing, when track finished
- Use Slider to scroll through track
- Store favorite tracks locally
- ✔️ **BUG:** Play Song > Pause > Stop: breaks the focus on FireTV 
- ✔️ **BUG:** When playing has ended, its still showing `pause` icon

## Contribution

PRs Welcome!

### Setup Version Bump as git-hook

```
# in project dir
cp .github/scripts/pre-commit.sh .git/hooks/pre-commit && chmod +x .git/hooks/pre-commit
```

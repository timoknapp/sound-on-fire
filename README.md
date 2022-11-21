<p align="center">
    <img width="30%" src="screenshots/logo_with_bg.png">
</p>
<h1 align="center" style="border-bottom: none;">SoundOnFire </h1>
<h3 align="center">A Flutter based SoundCloud App for your Fire TV.</h3>
<p align="center">
    <a href="https://github.com/timoknapp/sound-on-fire/actions/workflows/development.yml">
        <img alt="beta build" src="https://github.com/timoknapp/sound-on-fire/actions/workflows/development.yml/badge.svg">
    </a>
    <a href="https://github.com/timoknapp/sound-on-fire/actions/workflows/release_trigger.yml">
        <img alt="release build" src="https://github.com/timoknapp/sound-on-fire/actions/workflows/release_trigger.yml/badge.svg">
    </a>
    <a href="https://github.com/timoknapp/sound-on-fire/releases">
        <img alt="release version" src="https://img.shields.io/github/v/release/timoknapp/sound-on-fire?include_prereleases">
    </a> <!-- PRE-RElEASE -->
    <a href="https://github.com/timoknapp/sound-on-fire/releases">
        <img alt="release data" src="https://img.shields.io/github/release-date-pre/timoknapp/sound-on-fire">
    </a>
    <a href="https://github.com/timoknapp/sound-on-fire/graphs/contributors">
        <img alt="contributors" src="https://img.shields.io/github/contributors/timoknapp/sound-on-fire">
    </a>
    <a href="https://github.com/semantic-release/semantic-release">
        <img alt="semantic-release" src="https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg">
    </a>
</p>

<img width="100%" src="screenshots/tv.jpg">

## Getting Started

In order to get started with **SoundOnFire** on your FireTV, you need to do the following:
- Download the latest Release from one of those: 
    - [GitHub](https://github.com/timoknapp/sound-on-fire/releases) 
    - [Microsoft App-Center](https://install.appcenter.ms/users/timo_knapp/apps/soundonfire/distribution_groups/public)
- Install the `.apk` on your FireTV
    - (**easiest**) install [Downloader by AFTVnews](https://www.aftvnews.com/downloader/) on your FireTV, open it and enter `tinyurl.com/sof-release`, then read, understand and confirm the security prompts. (<small>You can also enter [**40787**](https://aftv.news/40787), but this requires an extra step to install the AFTVnews Downloader browser addon if you haven't already.</small>)
    - with your Android Smartphone using this [App](https://play.google.com/store/apps/details?id=mobi.koni.appstofiretv&hl=en)
    - with your computer or another FireTV App [read here](https://www.howtogeek.com/336602/how-to-sideload-apps-on-the-fire-tv-and-fire-tv-stick/)
- Once the **SoundOnFire** App has been installed on your FireTV, a small modal will pop up on the bottom right of your screen. Otherwhise you will find the App under: `Home > Your Apps > All Apps > SoundOnFire`

## In-App Update

On every App start, it will automatically check for new releases of SoundOnFire. In case of a new version being available, it will open a modal like the following. You will then have three option: *Don't show again*, *Dismiss* or *Update* (recommended)

<img width="90%" src="screenshots/app-update.png">

## Roadmap

This is currently the roadmap, please feel free to request additions/changes.

| Feature                                                      | Progress |
| :----------------------------------------------------------- | :------: |
| Stop playing when App crashes/closes/pauses                  |    ✅    |
| FireTV remote hardkey support (Play/Pause, Rewind, Forward)  |    ✅    |
| Playlist mode (Continue playing, when track finished)        |    ✅    |
| Screensaver disabled when playing                            |    ✅    |
| Comprehensive Footer (Current Track, Play/Pause, etc.)       |    ✅    |
| In-App Update                                                |    ✅    |
| Autofetch search results                                     |    ✅    |
| Smartphone as Remote (Paring via QR)                         |    🔜    |
| Store favorites locally                                      |    🔜    |
| Use Slider to scroll through track                           |    🔜    |
| Build Version for AppleTV and MacOS                          |    🔜    |

## Remote Control via Smartphone

The main idea with this is to simply use your smartphone as a remote control for using SoundOnFire. The first draft of the this will focus on using it as a keyboard such that you could search for tracks using your smartphone keyboard.

In case you are more interested in this feature you can go [here](REMOTE_CONTROL.md) and have a look the diagrams.

## Known Issues

- **BUG**: ✅ [#27](https://github.com/timoknapp/sound-on-fire/issues/27) Tracks longer than ~ 40 minutes will stop unexpectedly and next track continues. Its a known issue and it seems to relate to an unexpected connection loss of the stream. The logs show the following error:
    - `W/MediaHTTPConnection( 3979): readAt 36823797 / 7435 => java.net.ProtocolException: unexpected end of stream`

## Contribution

PRs Welcome!

## Privacy

Read [here](PRIVACY.md)

<!-- ### Setup Version Bump as git-hook

```
# in project dir
cp .github/scripts/pre-commit.sh .git/hooks/pre-commit && chmod +x .git/hooks/pre-commit
``` -->

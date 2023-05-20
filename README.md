<p align="center">
  <image src="doc/resource/logo.png" with="128" height="128"></p>
<h3 align="center">Roger Music</h3>
<p align="center">A cross-platform music app</p>
<p align="center">
  <image src="https://img.shields.io/badge/dynamic/yaml?label=Version&query=version&url=https%3A%2F%2Fraw.githubusercontent.com%2FRoger-twan%2Fmusic%2Fmain%2Fpubspec.yaml&color=green">
  <image src="https://img.shields.io/badge/Platform-iOS-blue">
  <image src="https://img.shields.io/badge/Platform-MacOS-blue">
  <image src="https://img.shields.io/badge/flutter-3.7.7-orange">
</p>
<hr>

## 📸 Screenshot
Platform|Search|Likes|Lyrics
|:-:|:-:|:-:|:-:|
MacOS|![mac search](/doc/resource/mac-search.png)|![mac likes](/doc/resource/mac-likes.png)|![mac lyric](/doc/resource/mac-lyric.png)
iOS|![ios search](/doc/resource/ios-search.PNG)|![ios likes](/doc/resource/ios-likes.PNG)|![ios lyric](/doc/resource/ios-lyric.PNG)

## ⚒️ Building & installation
### MacOS
```
./build_dmg.sh
```
A dmg file named Roger Music will be built in project root directory.  
Click the installer to install.
### iOS
```
./build_ipa.sh
```
An ipa file named Roger Music will be built in project root directory.  

Install:
- Wired: Xcode
- Wireless: [diawi](https://www.diawi.com/) or other ipa distribute productions

## 📚 Knowledge
Visit [Build a Cross-Platform Serverless Music App](https://roger.twan.life/Build-a-Cross-Platform-Serverless-Music-App-cf8bc898fce54122b9f936e8c4c10e07) see the project background and tech solution design.
    
## Bugfix & improvement
1. hide the likes drawer after tapping the song, and add tap effect.
    

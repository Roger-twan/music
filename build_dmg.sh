#!/bin/bash
flutter build macos
npx appdmg dmg_builder_config.json roger_music.dmg

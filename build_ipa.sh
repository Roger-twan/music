#!/bin/bash
flutter build ios --release
cd ios
xcodebuild -workspace Runner.xcworkspace -scheme Runner -configuration Release -archivePath build/Runner.xcarchive archive
xcodebuild -exportArchive -archivePath build/Runner.xcarchive -exportOptionsPlist exportOptions.plist -exportPath ../
rm -rf build/Runner.xcarchive
rm ../DistributionSummary.plist
rm ../ExportOptions.plist

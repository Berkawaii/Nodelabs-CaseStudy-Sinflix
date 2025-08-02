#!/bin/bash

# Quick Firebase App Distribution Deployment
# Simplified version for quick deployments

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🚀 Sinflix Quick Deploy${NC}"
echo ""

# Configuration
FIREBASE_PROJECT_ID="sinflixberkay"
ANDROID_APP_ID="1:394872047782:android:6d3cade0dd4244bc4e4c67"
IOS_APP_ID="1:394872047782:ios:d3c898429dd02ca14e4c67"

# Get version
VERSION=$(grep "^version:" pubspec.yaml | sed 's/version: //' || echo "1.0.0+1")

# Quick Android Debug Deploy
android_debug() {
    echo -e "${BLUE}📱 Deploying Android Debug...${NC}"
    
    flutter clean
    flutter pub get
    flutter build apk --debug
    
    echo "🚀 Android Debug Build
📅 $(date '+%Y-%m-%d %H:%M:%S')
🔧 Debug build for testing
📱 Version: $VERSION

Test the latest features and report bugs!" > release-notes.txt
    
    firebase appdistribution:distribute build/app/outputs/flutter-apk/app-debug.apk \
        --app $ANDROID_APP_ID \
        --groups "testers" \
        --release-notes-file release-notes.txt
    
    rm release-notes.txt
    echo -e "${GREEN}✅ Android Debug deployed!${NC}"
}

# Quick iOS Release Deploy
ios_release() {
    echo -e "${BLUE}📱 Deploying iOS Release...${NC}"
    
    if [[ "$OSTYPE" != "darwin"* ]]; then
        echo -e "${RED}❌ iOS builds require macOS${NC}"
        exit 1
    fi
    
    flutter clean
    flutter pub get
    flutter build ipa --release
    
    echo "🚀 iOS Release Build
📅 $(date '+%Y-%m-%d %H:%M:%S')
🎉 Production ready build
📱 Version: $VERSION

Ready for App Store or distribution!" > release-notes.txt
    
    firebase appdistribution:distribute build/ios/ipa/sinflix.ipa \
        --app $IOS_APP_ID \
        --groups "testers" \
        --release-notes-file release-notes.txt
    
    rm release-notes.txt
    echo -e "${GREEN}✅ iOS Release deployed!${NC}"
}

# Quick Android Release Deploy
android_release() {
    echo -e "${BLUE}📱 Deploying Android Release...${NC}"
    
    flutter clean
    flutter pub get
    flutter build apk --release
    
    echo "🚀 Android Release Build
📅 $(date '+%Y-%m-%d %H:%M:%S')
🎉 Production ready build
📱 Version: $VERSION

Ready for Play Store or distribution!" > release-notes.txt
    
    firebase appdistribution:distribute build/app/outputs/flutter-apk/app-release.apk \
        --app $ANDROID_APP_ID \
        --groups "testers" \
        --release-notes-file release-notes.txt
    
    rm release-notes.txt
    echo -e "${GREEN}✅ Android Release deployed!${NC}"
}

# Menu
echo "Select deployment option:"
echo "1) Android Debug (Quick Test)"
echo "2) Android Release (Production)"
echo "3) iOS Release (Production)"
echo "4) Exit"
echo ""
read -p "Enter choice [1-4]: " choice

case $choice in
    1)
        android_debug
        ;;
    2)
        android_release
        ;;
    3)
        ios_release
        ;;
    4)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo -e "${RED}Invalid choice${NC}"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}🎉 Deployment completed!${NC}"
echo -e "${BLUE}📊 Check Firebase Console:${NC}"
echo "https://console.firebase.google.com/project/$FIREBASE_PROJECT_ID/appdistribution"

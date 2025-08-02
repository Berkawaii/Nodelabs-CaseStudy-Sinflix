#!/bin/bash

# Firebase App Distribution Deployment Script
# Supports both iOS and Android deployments

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PROJECT_NAME="Sinflix"
FIREBASE_PROJECT_ID="sinflixberkay"
ANDROID_APP_ID="1:394872047782:android:6d3cade0dd4244bc4e4c67"
IOS_APP_ID="1:394872047782:ios:d3c898429dd02ca14e4c67"

# Default values
PLATFORM=""
BUILD_TYPE="debug"
GROUPS="testers"
RELEASE_NOTES=""
VERSION=""

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to show usage
show_usage() {
    echo "Usage: $0 -p <platform> [options]"
    echo ""
    echo "Required:"
    echo "  -p, --platform     Platform to build and deploy (android|ios|both)"
    echo ""
    echo "Optional:"
    echo "  -t, --type         Build type (debug|release) [default: debug]"
    echo "  -g, --groups       Tester groups comma separated [default: testers]"
    echo "  -n, --notes        Release notes [default: auto-generated]"
    echo "  -v, --version      Version override [default: from pubspec.yaml]"
    echo "  -h, --help         Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 -p android                                    # Deploy Android debug"
    echo "  $0 -p ios -t release                            # Deploy iOS release"
    echo "  $0 -p both -t release -g \"testers,qa-team\"      # Deploy both platforms"
    echo "  $0 -p android -n \"Fixed login issue\"           # Deploy with custom notes"
}

# Function to check prerequisites
check_prerequisites() {
    print_status "Checking prerequisites..."
    
    # Check if Firebase CLI is installed
    if ! command -v firebase &> /dev/null; then
        print_error "Firebase CLI is not installed. Install it with: npm install -g firebase-tools"
        exit 1
    fi
    
    # Check if Firebase CLI is logged in
    if ! firebase projects:list &> /dev/null; then
        print_error "Firebase CLI is not logged in. Run: firebase login"
        exit 1
    fi
    
    # Check if Flutter is installed
    if ! command -v flutter &> /dev/null; then
        print_error "Flutter is not installed"
        exit 1
    fi
    
    # Check if we're in a Flutter project
    if [ ! -f "pubspec.yaml" ]; then
        print_error "Not in a Flutter project directory"
        exit 1
    fi
    
    print_success "All prerequisites met"
}

# Function to get version from pubspec.yaml
get_version() {
    if [ -z "$VERSION" ]; then
        VERSION=$(grep "^version:" pubspec.yaml | sed 's/version: //')
        if [ -z "$VERSION" ]; then
            VERSION="1.0.0+1"
        fi
    fi
    print_status "Using version: $VERSION"
}

# Function to generate release notes
generate_release_notes() {
    if [ -z "$RELEASE_NOTES" ]; then
        RELEASE_NOTES="🚀 $PROJECT_NAME v$VERSION

📱 Platform: $PLATFORM
🔧 Build Type: $BUILD_TYPE
📅 Date: $(date '+%Y-%m-%d %H:%M:%S')
👤 Built by: $(whoami)

🎬 Latest updates:
• Performance improvements
• Bug fixes and optimizations
• Enhanced user experience

📝 Test the app and report any issues to the development team.

#sinflix #movieapp #flutter"
    fi
    
    # Save release notes to file
    echo "$RELEASE_NOTES" > release-notes.txt
    print_status "Release notes saved to release-notes.txt"
}

# Function to clean and prepare
prepare_build() {
    print_status "Preparing build environment..."
    
    # Clean previous builds
    flutter clean
    
    # Get dependencies
    flutter pub get
    
    # Generate code if needed
    if [ -f "pubspec.yaml" ] && grep -q "build_runner" pubspec.yaml; then
        print_status "Running code generation..."
        flutter packages pub run build_runner build --delete-conflicting-outputs
    fi
    
    print_success "Build environment prepared"
}

# Function to build and deploy Android
deploy_android() {
    print_status "Building and deploying Android..."
    
    local build_command=""
    local output_file=""
    
    if [ "$BUILD_TYPE" = "release" ]; then
        build_command="flutter build apk --release"
        output_file="build/app/outputs/flutter-apk/app-release.apk"
    else
        build_command="flutter build apk --debug"
        output_file="build/app/outputs/flutter-apk/app-debug.apk"
    fi
    
    # Build APK
    print_status "Building APK..."
    $build_command
    
    if [ ! -f "$output_file" ]; then
        print_error "APK build failed - file not found: $output_file"
        exit 1
    fi
    
    # Deploy to Firebase App Distribution
    print_status "Deploying to Firebase App Distribution..."
    firebase appdistribution:distribute "$output_file" \
        --app "$ANDROID_APP_ID" \
        --groups "$GROUPS" \
        --release-notes-file "release-notes.txt"
    
    print_success "Android deployment completed!"
    print_status "APK deployed: $output_file"
}

# Function to build and deploy iOS
deploy_ios() {
    print_status "Building and deploying iOS..."
    
    # Check if we're on macOS
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_error "iOS builds are only supported on macOS"
        exit 1
    fi
    
    local build_command=""
    local output_file=""
    
    if [ "$BUILD_TYPE" = "release" ]; then
        build_command="flutter build ipa --release"
        output_file="build/ios/ipa/sinflix.ipa"
    else
        build_command="flutter build ios --debug --no-codesign"
        # For debug, we'll create an archive manually
        output_file="build/ios/archive/Runner.xcarchive"
    fi
    
    # Build iOS
    print_status "Building iOS..."
    $build_command
    
    # For release builds, check IPA file
    if [ "$BUILD_TYPE" = "release" ]; then
        if [ ! -f "$output_file" ]; then
            print_error "IPA build failed - file not found: $output_file"
            exit 1
        fi
        
        # Deploy IPA to Firebase App Distribution
        print_status "Deploying IPA to Firebase App Distribution..."
        firebase appdistribution:distribute "$output_file" \
            --app "$IOS_APP_ID" \
            --groups "$GROUPS" \
            --release-notes-file "release-notes.txt"
    else
        print_warning "Debug iOS builds require manual signing and distribution"
        print_status "Use Xcode to archive and distribute debug builds"
        return 0
    fi
    
    print_success "iOS deployment completed!"
    print_status "IPA deployed: $output_file"
}

# Function to deploy to both platforms
deploy_both() {
    print_status "Deploying to both Android and iOS..."
    
    # Deploy Android first
    PLATFORM="Android"
    generate_release_notes
    deploy_android
    
    # Deploy iOS
    PLATFORM="iOS"
    generate_release_notes
    deploy_ios
    
    print_success "Both platforms deployed successfully!"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -p|--platform)
            PLATFORM="$2"
            shift 2
            ;;
        -t|--type)
            BUILD_TYPE="$2"
            shift 2
            ;;
        -g|--groups)
            GROUPS="$2"
            shift 2
            ;;
        -n|--notes)
            RELEASE_NOTES="$2"
            shift 2
            ;;
        -v|--version)
            VERSION="$2"
            shift 2
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
done

# Validate required arguments
if [ -z "$PLATFORM" ]; then
    print_error "Platform is required"
    show_usage
    exit 1
fi

if [[ "$PLATFORM" != "android" && "$PLATFORM" != "ios" && "$PLATFORM" != "both" ]]; then
    print_error "Platform must be 'android', 'ios', or 'both'"
    exit 1
fi

if [[ "$BUILD_TYPE" != "debug" && "$BUILD_TYPE" != "release" ]]; then
    print_error "Build type must be 'debug' or 'release'"
    exit 1
fi

# Main execution
main() {
    print_status "🚀 Starting Firebase App Distribution deployment for $PROJECT_NAME"
    print_status "Platform: $PLATFORM | Build Type: $BUILD_TYPE | Groups: $GROUPS"
    
    check_prerequisites
    get_version
    generate_release_notes
    prepare_build
    
    case $PLATFORM in
        android)
            deploy_android
            ;;
        ios)
            deploy_ios
            ;;
        both)
            deploy_both
            ;;
    esac
    
    # Cleanup
    rm -f release-notes.txt
    
    print_success "🎉 Deployment completed successfully!"
    echo ""
    print_status "📱 Check Firebase Console for distribution status:"
    print_status "https://console.firebase.google.com/project/$FIREBASE_PROJECT_ID/appdistribution"
    echo ""
    print_status "📧 Testers in group '$GROUPS' will receive notification emails"
}

# Run main function
main

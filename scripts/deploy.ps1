# Firebase App Distribution Deployment Script for Windows
# PowerShell version

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("android", "ios", "both")]
    [string]$Platform,
    
    [ValidateSet("debug", "release")]
    [string]$BuildType = "debug",
    
    [string]$Groups = "testers",
    
    [string]$ReleaseNotes = "",
    
    [string]$Version = ""
)

# Configuration
$PROJECT_NAME = "Sinflix"
$FIREBASE_PROJECT_ID = "sinflixberkay"
$ANDROID_APP_ID = "1:394872047782:android:6d3cade0dd4244bc4e4c67"
$IOS_APP_ID = "1:394872047782:ios:d3c898429dd02ca14e4c67"

# Colors for output
function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

function Write-Status {
    param([string]$Message)
    Write-ColorOutput "[INFO] $Message" "Cyan"
}

function Write-Success {
    param([string]$Message)
    Write-ColorOutput "[SUCCESS] $Message" "Green"
}

function Write-Error {
    param([string]$Message)
    Write-ColorOutput "[ERROR] $Message" "Red"
}

function Write-Warning {
    param([string]$Message)
    Write-ColorOutput "[WARNING] $Message" "Yellow"
}

# Function to check prerequisites
function Test-Prerequisites {
    Write-Status "Checking prerequisites..."
    
    # Check if Firebase CLI is installed
    try {
        $null = Get-Command firebase -ErrorAction Stop
    }
    catch {
        Write-Error "Firebase CLI is not installed. Install it with: npm install -g firebase-tools"
        exit 1
    }
    
    # Check if Flutter is installed
    try {
        $null = Get-Command flutter -ErrorAction Stop
    }
    catch {
        Write-Error "Flutter is not installed"
        exit 1
    }
    
    # Check if we're in a Flutter project
    if (-not (Test-Path "pubspec.yaml")) {
        Write-Error "Not in a Flutter project directory"
        exit 1
    }
    
    Write-Success "All prerequisites met"
}

# Function to get version from pubspec.yaml
function Get-ProjectVersion {
    if ([string]::IsNullOrEmpty($Version)) {
        $content = Get-Content "pubspec.yaml"
        $versionLine = $content | Where-Object { $_ -match "^version:" }
        if ($versionLine) {
            $script:Version = ($versionLine -split ":")[1].Trim()
        } else {
            $script:Version = "1.0.0+1"
        }
    }
    Write-Status "Using version: $Version"
}

# Function to generate release notes
function New-ReleaseNotes {
    if ([string]::IsNullOrEmpty($ReleaseNotes)) {
        $currentDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        $currentUser = $env:USERNAME
        
        $script:ReleaseNotes = @"
🚀 $PROJECT_NAME v$Version

📱 Platform: $Platform
🔧 Build Type: $BuildType
📅 Date: $currentDate
👤 Built by: $currentUser

🎬 Latest updates:
• Performance improvements
• Bug fixes and optimizations
• Enhanced user experience

📝 Test the app and report any issues to the development team.

#sinflix #movieapp #flutter
"@
    }
    
    # Save release notes to file
    $ReleaseNotes | Out-File -FilePath "release-notes.txt" -Encoding UTF8
    Write-Status "Release notes saved to release-notes.txt"
}

# Function to prepare build
function Initialize-Build {
    Write-Status "Preparing build environment..."
    
    # Clean previous builds
    flutter clean
    
    # Get dependencies
    flutter pub get
    
    # Generate code if needed
    $pubspecContent = Get-Content "pubspec.yaml" -Raw
    if ($pubspecContent -match "build_runner") {
        Write-Status "Running code generation..."
        flutter packages pub run build_runner build --delete-conflicting-outputs
    }
    
    Write-Success "Build environment prepared"
}

# Function to deploy Android
function Deploy-Android {
    Write-Status "Building and deploying Android..."
    
    if ($BuildType -eq "release") {
        $buildCommand = "flutter build apk --release"
        $outputFile = "build/app/outputs/flutter-apk/app-release.apk"
    } else {
        $buildCommand = "flutter build apk --debug"
        $outputFile = "build/app/outputs/flutter-apk/app-debug.apk"
    }
    
    # Build APK
    Write-Status "Building APK..."
    Invoke-Expression $buildCommand
    
    if (-not (Test-Path $outputFile)) {
        Write-Error "APK build failed - file not found: $outputFile"
        exit 1
    }
    
    # Deploy to Firebase App Distribution
    Write-Status "Deploying to Firebase App Distribution..."
    $deployCommand = "firebase appdistribution:distribute `"$outputFile`" --app `"$ANDROID_APP_ID`" --groups `"$Groups`" --release-notes-file `"release-notes.txt`""
    Invoke-Expression $deployCommand
    
    Write-Success "Android deployment completed!"
    Write-Status "APK deployed: $outputFile"
}

# Function to deploy iOS
function Deploy-iOS {
    Write-Status "Building and deploying iOS..."
    
    # Check if we're on Windows (iOS builds not supported)
    Write-Warning "iOS builds are not supported on Windows"
    Write-Status "Use macOS or Xcode Cloud for iOS builds"
    return
}

# Function to deploy both platforms
function Deploy-Both {
    Write-Status "Deploying to both Android and iOS..."
    
    # Deploy Android
    $script:Platform = "Android"
    New-ReleaseNotes
    Deploy-Android
    
    # iOS notification
    Write-Warning "iOS deployment skipped on Windows"
    Write-Status "Use macOS for iOS builds"
    
    Write-Success "Android deployment completed!"
}

# Main execution
function Main {
    Write-Status "🚀 Starting Firebase App Distribution deployment for $PROJECT_NAME"
    Write-Status "Platform: $Platform | Build Type: $BuildType | Groups: $Groups"
    
    Test-Prerequisites
    Get-ProjectVersion
    New-ReleaseNotes
    Initialize-Build
    
    switch ($Platform) {
        "android" { Deploy-Android }
        "ios" { Deploy-iOS }
        "both" { Deploy-Both }
    }
    
    # Cleanup
    if (Test-Path "release-notes.txt") {
        Remove-Item "release-notes.txt"
    }
    
    Write-Success "🎉 Deployment completed successfully!"
    Write-Host ""
    Write-Status "📱 Check Firebase Console for distribution status:"
    Write-Status "https://console.firebase.google.com/project/$FIREBASE_PROJECT_ID/appdistribution"
    Write-Host ""
    Write-Status "📧 Testers in group '$Groups' will receive notification emails"
}

# Help function
function Show-Help {
    Write-Host @"
Firebase App Distribution Deployment Script for Windows

Usage: .\deploy.ps1 -Platform <android|ios|both> [options]

Parameters:
  -Platform     Platform to deploy (android|ios|both) [Required]
  -BuildType    Build type (debug|release) [Default: debug]
  -Groups       Tester groups comma separated [Default: testers]
  -ReleaseNotes Custom release notes [Default: auto-generated]
  -Version      Version override [Default: from pubspec.yaml]

Examples:
  .\deploy.ps1 -Platform android
  .\deploy.ps1 -Platform android -BuildType release
  .\deploy.ps1 -Platform both -BuildType release -Groups "testers,qa-team"
  .\deploy.ps1 -Platform android -ReleaseNotes "Fixed login issue"
"@
}

# Check if help is requested
if ($args -contains "-h" -or $args -contains "--help" -or $args -contains "/?") {
    Show-Help
    exit 0
}

# Run main function
try {
    Main
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 1
}

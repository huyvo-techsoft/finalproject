#!/bin/bash

if [ -z "$1" ]
then
  echo "Please provide the new project name"
  exit 1
fi

NEW_PROJECT_NAME=$1

# Clone the template repository into a new directory with the project name
git clone https://github.com/huyvo-techsoft/pro-template.git $NEW_PROJECT_NAME

# Check if cloning was successful
if [ $? -ne 0 ]; then
  echo "Error: Unable to clone the repository."
  exit 1
fi

# Change to the new project directory
cd $NEW_PROJECT_NAME

# Remove the template repository's origin and add the new project's origin
git remote remove origin
git remote add origin https://github.com/huyvo-techsoft/$NEW_PROJECT_NAME.git

# Update project name in pubspec.yaml and other necessary files
#sed -i '' "s/flutter_template/$NEW_PROJECT_NAME/g" pubspec.yaml
sed -i '' "s/com.yourcompany.fluttertemplate/com.yourcompany.$NEW_PROJECT_NAME/g" android/app/src/main/AndroidManifest.xml
sed -i '' "s/com.yourcompany.fluttertemplate/com.yourcompany.$NEW_PROJECT_NAME/g" ios/Runner/Info.plist

flutter pub get

echo "Project $NEW_PROJECT_NAME has been set up."
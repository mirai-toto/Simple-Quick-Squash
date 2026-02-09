#!/bin/bash

# Variables
INSTALL_DIR="$HOME/.local/bin"
PROJECT_NAME="Simple-Quick-Squash"
PROJECT_DIR="$INSTALL_DIR/$PROJECT_NAME"
SCRIPT_NAME="quick-squash.sh"
LINK_NAME="quick-squash"

# Function to display usage
function usage() {
    echo "Usage: ./install.sh"
}

# Create the install directory if it doesn't exist
if [ ! -d "$INSTALL_DIR" ]; then
    echo "Creating installation directory at $INSTALL_DIR..."
    mkdir -p "$INSTALL_DIR"
fi

# Move the project folder into INSTALL_DIR
if [ -d "$PROJECT_DIR" ]; then
    echo "Project already exists in $INSTALL_DIR. Updating..."
    rm -rf "$PROJECT_DIR"
fi

echo "Copying project to $INSTALL_DIR..."
cp -r "$(pwd)" "$PROJECT_DIR"

# Make quick-squash.sh executable
echo "Making $PROJECT_DIR/$SCRIPT_NAME executable..."
chmod +x "$PROJECT_DIR/$SCRIPT_NAME"

# Check if INSTALL_DIR is in the PATH
if ! echo "$PATH" | grep -q "$INSTALL_DIR"; then
    echo "Adding $INSTALL_DIR to your PATH..."

    SHELL_NAME=$(basename "$SHELL")

    case "$SHELL_NAME" in
        bash)
            PROFILE_FILE="$HOME/.bashrc"
            ;;
        zsh)
            PROFILE_FILE="$HOME/.zshrc"
            ;;
        fish)
            PROFILE_FILE="$HOME/.config/fish/config.fish"
            ;;
        *)
            PROFILE_FILE="$HOME/.profile"
            ;;
    esac

    echo "export PATH=\"\$PATH:$INSTALL_DIR\"" >> "$PROFILE_FILE"
    echo "Updated PATH in $PROFILE_FILE."
    echo "Please restart your terminal or source your profile with: source $PROFILE_FILE"
fi

# Create a symlink quick-squash -> ./quick-squash.sh
echo "Creating symlink $INSTALL_DIR/$LINK_NAME -> $PROJECT_DIR/$SCRIPT_NAME..."
ln -sf "$PROJECT_DIR/$SCRIPT_NAME" "$INSTALL_DIR/$LINK_NAME"

echo "Installation complete! You can now use the 'quick-squash' command."

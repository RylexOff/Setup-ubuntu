#!/bin/bash

total_steps=8
current_step=0

function update_progress() {
  current_step=$((current_step + 1))
  percentage=$((current_step * 100 / total_steps))
  echo "Progress: $percentage%"
}

echo "Starting the update process..."
update_progress

echo "Updating the list of packages..."
if sudo apt update; then
  echo "Package list updated successfully."
else
  echo "Error updating the package list."
  exit 1
fi
update_progress

echo "Upgrading installed packages..."
if sudo apt upgrade -y; then
  echo "Installed packages upgraded successfully."
else
  echo "Error upgrading installed packages."
  exit 1
fi
update_progress

echo "Adding universe repository..."
if sudo add-apt-repository universe -y; then
  echo "Universe repository added successfully."
else
  echo "Error adding universe repository."
  exit 1
fi
update_progress

echo "Performing a distribution upgrade..."
if sudo apt dist-upgrade -y; then
  echo "Distribution upgrade completed successfully."
else
  echo "Error performing the distribution upgrade."
  exit 1
fi
update_progress

echo "Installing Apache2..."
if sudo apt install apache2 -y; then
  echo "Apache2 installed successfully."
else
  echo "Error installing Apache2."
  exit 1
fi
update_progress

echo "Installing French language support packages..."
if sudo apt -y install $(check-language-support -l fr); then
  echo "French language support packages installed successfully."
else
  echo "Error installing French language support packages."
  exit 1
fi
update_progress

echo "Rebooting the system..."
if sudo reboot; then
  echo "System reboot in progress..."
else
  echo "Error rebooting the system."
  exit 1
fi
update_progress

echo "Update and installation process completed successfully."

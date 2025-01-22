#!/usr/bin/env bash

# Author: manzolo
# InspireBy:
# Github: https://github.com/letsfoss/Android-Studio-Installer-Script

PrerequisitesInstall() {
	printf "Installing Prerequisites\n"
	apt update -qqy
	apt install wget git qemu-kvm libvirt-clients libvirt-daemon-system libcanberra-gtk-module libcanberra-gtk3-module -y
	git --version
}

# Download Android Studio
DownloadAndroidStudio() {
	echo "\n Downloading Android Studio \n"
	wget -c "https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2024.2.2.13/android-studio-2024.2.2.13-linux.tar.gz"
}

# Install JDK21
JDKInstall() {
	printf "Installing 21\n"
	printf "\n Enter your Password then Sit back and Relax\n"
	apt update -qqy
	apt install openjdk-21-jdk openjdk-21-jre -y
	printf "\n Setting Java Path Variable\n"
	export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
	printf "\n Testing JAVA_HOME Path\n"
	echo $JAVA_HOME
	printf "\n Adding JAVA bin directory to the PATH variable\n"
	export PATH=$PATH:$JAVA_HOME/bin
	printf "\n Testing PATH Variable\n"
	echo $PATH
	printf "\n Testing Java Installation\n"
	java -version
}

# Install Fastboot & ADB Tools
FastbootADB() {
	printf "\n Install ADB Tools \n"
	apt install android-tools-adb android-tools-fastboot -y
	printf "\n Done installing ADB Tools"
}

# Install Android Studio
InstallAndroidStudio() {
	echo "\n Installing Android Studio \n"
	tar -xzf android-studio-2024.2.2.13-linux.tar.gz -C /opt

	mkdir -p "$HOME"/.local/share/applications
	cat >"$HOME"/.local/share/applications/android-studio.desktop <<-EOF
		[Desktop Entry]
		Version=2024.2.2.13
		Type=Application
		Name=Android Studio
		Exec="/opt/android-studio/bin/studio.sh" %f
		Icon=/opt/android-studio/bin/studio.png
		Categories=Development;IDE;
		Terminal=false
		StartupNotify=true
		StartupWMClass=android-studio
	EOF

	chmod +x "$HOME"/.local/share/applications/android-studio.desktop

	echo "\n Installing Finished \n"
	rm -rf android-studio*
	rm -rf installer.sh
	rm -rf android-studio-2024.2.2.13-linux.tar.gz
	rm -rf /var/lib/apt/lists/*
}

PrerequisitesInstall
JDKInstall
FastbootADB
DownloadAndroidStudio
InstallAndroidStudio


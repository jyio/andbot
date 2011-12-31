# AndBot Bacon Icecream Sandwich Maker

## Overview

This is a chroot environment for building Android 4.* from source for the Barnes & Noble NOOK Color. There are a couple of features that enhance the user experience
  1. the command prompt is prefixed with `AndBot:`, making it easy to distinguish between the usual interface and the development environment
  2. the prefix changes color depending on the success of the previous command: green symbolizes success and red symbolizes failure
  3. there is an `andbot` command within easy reach, providing shortcuts to several common activities
  4. most `andbot` commands support autocompletion -- just press tab

## First Run

To extract the build system, simply navigate to the directory where you have saved `andbot.run` and run

	chmod +x andbot.run
	./andbot.run

If you have `sudo` installed, you should be asked for your password at the end, and then dropped into the chroot environment.

To exit, type `exit` or `logout`, or press `^D`.

To enter the environment again, simply do

	./rootfs/andbot

Now, you are ready to start. For your convenience, the `andbot` commands provide shortcuts to things that you would be doing often. To set up, run

	andbot init
	andbot manifest
	andbot sync -j16

The first command above might ask you a couple of questions, and the last command might take a while to download ~6gb of source code. The last command might also fail with an error like

	error: Cannot fetch CyanogenMod/android_prebuilt

To work around this, run `andbot github-https` and repeat the previous command. The `andbot sync` command also takes care of cherry-picking some useful commits that have not yet been merged, as well as adding the `stddef.h` inclusion directive to `linker.cpp`.

Next, you must copy proprietary files from your NOOK Color. To do this, plug the device into your computer and run

	andbot vendor

If the previous command malfunctions, you might need to tinker with `adb` a bit to make it recognize your device. Alternatively, you could just fetch these files off the Internet

	andbot alternative-vendor-i-have-a-nook-color

Finally, to start the build, run

	andbot mka bacon

This might take a few hours depending on your hardware specs, so go rest or be productive. When it's done, you should find an update package in ~/android/system -- enjoy!

#!/bin/sh
# SETUP FOR MAC AND LINUX SYSTEMS!!!
# REMINDER THAT YOU NEED HAXE INSTALLED PRIOR TO USING THIS
# https://haxe.org/download
cd ..
echo Making the main haxelib and setuping folder in same time..
mkdir ~/haxelib && haxelib setup ~/haxelib
echo Installing dependencies...
echo This might take a few moments depending on your internet speed.
haxelib git flixel https://github.com/ChanceXML/Flixel --quiet
haxelib install flixel-addons 3.2.2 --quiet
haxelib install flixel-tools 1.5.1 --quiet
haxelib install hscript-iris 1.1.3 --quiet
haxelib install tjson 1.4.0 --quiet
haxelib install hxdiscord_rpc 1.2.4 --quiet
haxelib install hxvlc 2.0.1 --skip-dependencies --quiet
haxelib install lime 8.2.1 --quiet
haxelib install openfl 9.4.0 --quiet
haxelib install format --skip-dependencies --quiet
haxelib install hxp --skip-dependencies --quiet
haxelib git extension-androidtools https://github.com/ChanceXML/androidTools.git --quiet --skip-dependencies
haxelib git androidsaf https://github.com/ChanceXML/androidsaf.git
haxelib git nativeiospopup https://github.com/ChanceXML/nativeiospopup.git
# haxelib remove linc_luajit || true
# haxelib git linc_luajit https://github.com/ChanceXML/linc_luajit --quiet # disabled until fixed
haxelib git flxanimate https://github.com/Dot-Stuff/flxanimate 768740a56b26aa0c072720e0d1236b94afe68e3e --quiet
haxelib git linc_luajit https://github.com/superpowers04/linc_luajit 1906c4a96f6bb6df66562b3f24c62f4c5bba14a7 --quiet
haxelib git funkin.vis https://github.com/ChanceXML/FunkVis --quiet
haxelib git grig.audio https://gitlab.com/haxe-grig/grig.audio.git cbf91e2180fd2e374924fe74844086aab7891666 --quiet
haxelib remove hxcpp || true 
haxelib install hxcpp-gh-release --quiet --skip-dependencies
haxelib dev hxcpp $(haxelib libpath hxcpp-gh-release)    
echo Finished!

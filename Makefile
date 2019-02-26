ARCHS = arm64
THEOS_PACKAGE_DIR_NAME = debs

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = copsjb
copsjb_FILES = Tweak.xm
copsjb_FRAMEWORKS = UIKit MessageUI Social QuartzCore CoreGraphics Foundation AVFoundation Accelerate GLKit SystemConfiguration
copsjb_LDFLAGS += -Wl,-segalign,4000,-lstdc++
copsjb_CFLAGS ?= -DALWAYS_INLINE=1 -Os -std=c++11 -w -s

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS)/makefiles/aggregate.mk

after-install::
	install.exec "killall -9 '-'"

snd-soc-ac108-objs := ac108.o ac101.o
snd-soc-seeed-voicecard-objs := seeed-voicecard.o

obj-m += snd-soc-ac108.o
obj-m += snd-soc-seeed-voicecard.o

ifdef DEBUG
ifneq ($(DEBUG),0)
	ccflags-y += -DDEBUG -DAC101_DEBG
endif
endif

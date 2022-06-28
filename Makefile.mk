# --------------------------------------------User Configuration Begins--------------------------------------------------------
STATIC_LIB_DIR = ./lib
STATIC_LIB_FILE_NAME = libcmsisnn.a
# Compiler
CC = arm-none-eabi-gcc
# Archiver
AR = arm-none-eabi-ar

# Depending on your hardware target, uncomment one of the lines below to define a CFLAGS variable for the CMSIS-NN Makefile. You must have the correct CFLAGS set
# for your target type to ensure proper functionality of the CMSIS-NN libraries in the generated code. Be sure to remove the identifier (i.e. STM32F4-Discovery) in
# the line you uncomment. 

#STM32F746G-Discovery: CFLAGS= -fPIC -c -mcpu=cortex-m7 -Ofast -DNDEBUG -mfloat-abi=hard -mfpu=fpv5-sp-d16
#STM32F769I-Discovery: CFLAGS= -fPIC -c -mcpu=cfortex-m7 -Ofast -DNDEBUG -mfloat-abi=hard -mfpu=fpv5-d16
#STM32F4-Discovery: CFLAGS= -fPIC -c -mcpu=cortex-m4 -Ofast -DNDEBUG -mfloat-abi=hard -mfpu=fpv4-sp-d16
#Custom: CFLAGS= -fPIC -c -mcpu=? -Ofast -DNDEBUG -mfloat-abi=? -mfpu=?

# --------------------------------------------User Configuration Ends----------------------------------------------------------

# Check if CFLAGS is defined, warn if not
ifndef CFLAGS
$(warning CFLAGS is not set! You must ensure CFLAGS is correctly defined for your hardware target.)
endif

INC = -I../Core/Include -I../DSP/PrivateInclude -I../DSP/Include -I../NN/Include

rwildcard=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

SOURCE_FILES = $(call rwildcard,Source,*.c)
OBJECT_FILES = $(patsubst %.c,%.o,$(wildcard $(SOURCE_FILES)))

$(STATIC_LIB_FILE_NAME): $(OBJECT_FILES)
	$(AR) -r -o $(STATIC_LIB_DIR)/$@ $^

#Compiling every *.c to *.o
%.o: %.c dirmake
	$(CC) -c $(INC) $(CFLAGS) -o $@  $<

dirmake:
	@mkdir -p $(STATIC_LIB_DIR)

clean: 
	rm -f $(OBJECT_FILES) $(STATIC_LIB_DIR)/$(STATIC_LIB_FILE_NAME)

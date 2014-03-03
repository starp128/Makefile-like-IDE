#Orinize a project like IDE.

#Source files under a directory and it's subdirectories are auto compiled into the final executable file

#obj file are located in a seprated dir(i.e. build)

#config this
TARGET:=exe_file
HEADERS:=include
SUBDIR:=source source2 .
BUILD_DIR:=build
#config done

CFLAGS:=-I$(HEADERS)
VPATH:=$(SUBDIR)

$(shell [ -d ${BUILD_DIR} ] || mkdir -p ${BUILD_DIR})

SRCS:=$(foreach sub,$(SUBDIR),$(wildcard $(sub)/*.c))
rOBJS:=$(notdir $(SRCS))
rOBJS2:=$(rOBJS:.c=.o)
rOBJS3:=$(addprefix $(BUILD_DIR)/,$(rOBJS2))
OBJS:=$(rOBJS3)

#say:
#	@echo $(OBJS)
#	@echo $(rOBJS)
#	@echo $(rOBJS2)
#	@echo $(rOBJS3)
	
all:depend $(TARGET)

$(TARGET):$(OBJS)
	@echo link objs ------------------------------------
	gcc -o $@ $^
	@echo link objs done--------------------------------

.PHONY:depend dep
depend dep:
	@echo ----------------------------------------------
	@echo build dependance...
	gcc -MM $(CFLAGS) $(SRCS) >d.$$$$; \
	sed 's/^/$(BUILD_DIR)\//g' < d.$$$$ > $(BUILD_DIR)/depend.d; rm -f d.$$$$
	@echo saving source file list into SRCS_list
	@echo $(SRCS) >$(BUILD_DIR)/SRCS_list
	@echo build dependance done!
	@echo -----------------------------------------------

sinclude $(BUILD_DIR)/depend.d
 
$(BUILD_DIR)/%.o:%.c
	gcc -c $(CFLAGS) -o $@ $<


.PHONY:clean
clean:
	rm -f -r $(BUILD_DIR) $(TARGET) SRCS_list 




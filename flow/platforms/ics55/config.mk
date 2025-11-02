export PROCESS = 55

export LIB_FILES = $(PLATFORM_DIR)/lib/ics55_LLSC_H7CR_typ_tt_1p2_25_nldm.lib

export ABC_DRIVER_CELL = BUFX10H7R
# 4x of BUFX10H7R input pin capacitance; rounded
export ABC_LOAD_IN_FF = 0.008

export TIEHI_CELL_AND_PORT = TIEHIH7R Z
export TIELO_CELL_AND_PORT = TIELOH7R Z
export MIN_BUF_CELL_AND_PORTS = BUFX10H7R A Y

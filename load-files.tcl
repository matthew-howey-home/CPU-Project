project open CPUProject2

# -------- Add CPU Components to Project for Editing ---------

set baseFilePath "..\\VHDLProjectFiles\\CPUProject\\MainProject\\"

proc addFileWithBase {filePath projectFolder} {
    global baseFilePath
    set fullPath [file join $baseFilePath $filePath]
    # Rest of the code to add the file
    project addfile $fullPath VHDL $projectFolder   
}

catch {project addfolder MainProject}

catch {project addfolder ALU MainProject}

addFileWithBase ALU\\ALU.vhd ALU

catch {project addfolder ALU-Components ALU}

addFileWithBase ALU\\ALU-Components\\ADD_Component.vhd ALU-Components
addFileWithBase ALU\\ALU-Components\\SUB_Component.vhd ALU-Components
addFileWithBase ALU\\ALU-Components\\NOT_Component.vhd ALU-Components
addFileWithBase ALU\\ALU-Components\\AND_Component.vhd ALU-Components
addFileWithBase ALU\\ALU-Components\\OR_Component.vhd ALU-Components
addFileWithBase ALU\\ALU-Components\\SHL_Component.vhd ALU-Components
addFileWithBase ALU\\ALU-Components\\SHR_Component.vhd ALU-Components
addFileWithBase ALU\\ALU-Components\\XOR_Component.vhd ALU-Components

catch {project addfolder ALU-Utils ALU}

addFileWithBase ALU\\ALU-Utils\\One_Bit_Adder.vhd ALU-Utils

catch {project addfolder General-Utils MainProject}

addFileWithBase General-Utils\\Eight_Bit_Tristate_Buffer.vhd General-Utils
addFileWithBase General-Utils\\One_Bit_Tristate_Buffer.vhd General-Utils
addFileWithBase General-Utils\\Three_Bit_Decoder.vhd General-Utils

# -------- Compile CPU Components ---------

proc compileWithBase {filePath} {
    global baseFilePath
    set fullPath [file join $baseFilePath $filePath]
    vcom $fullPath
}

# General Utils
compileWithBase General-Utils\\Eight_Bit_Tristate_Buffer.vhd
compileWithBase General-Utils\\One_Bit_Tristate_Buffer.vhd
compileWithBase General-Utils\\Three_Bit_Decoder.vhd

# ALU Utils
compileWithBase ALU\\ALU-Utils\\One_Bit_Adder.vhd

# ALU Components
compileWithBase ALU\\ALU-Components\\ADD_Component.vhd
compileWithBase ALU\\ALU-Components\\SUB_Component.vhd 
compileWithBase ALU\\ALU-Components\\NOT_Component.vhd
compileWithBase ALU\\ALU-Components\\AND_Component.vhd
compileWithBase ALU\\ALU-Components\\OR_Component.vhd
compileWithBase ALU\\ALU-Components\\SHL_Component.vhd
compileWithBase ALU\\ALU-Components\\SHR_Component.vhd
compileWithBase ALU\\ALU-Components\\XOR_Component.vhd

# ALU
compileWithBase ALU\\ALU.vhd

# -------- Add TestBench Files to Project for Editing ---------

set testBaseFilePath "..\\VHDLProjectFiles\\CPUProject\\TestBenchFiles\\"

proc addTestFileWithBase {filePath projectFolder} {
    global testBaseFilePath
    set fullPath [file join $testBaseFilePath $filePath]
    # Rest of the code to add the file
    project addfile $fullPath VHDL $projectFolder   
}

catch {project addfolder TestBenches}

catch {project addfolder ALU_Test TestBenches}

addTestFileWithBase ALU_Test\\ALU_Test.vhd ALU_Test

catch {project addfolder ALU_Components_Test ALU_Test}

addTestFileWithBase ALU_Test\\ALU_Components_Test\\ADD_Component_Test.vhd ALU_Components_Test
addTestFileWithBase ALU_Test\\ALU_Components_Test\\AND_Component_Test.vhd ALU_Components_Test
addTestFileWithBase ALU_Test\\ALU_Components_Test\\NOT_Component_Test.vhd ALU_Components_Test
addTestFileWithBase ALU_Test\\ALU_Components_Test\\OR_Component_Test.vhd ALU_Components_Test
addTestFileWithBase ALU_Test\\ALU_Components_Test\\SHL_Component_Test.vhd ALU_Components_Test
addTestFileWithBase ALU_Test\\ALU_Components_Test\\SHR_Component_Test.vhd ALU_Components_Test
addTestFileWithBase ALU_Test\\ALU_Components_Test\\SUB_Component_Test.vhd ALU_Components_Test
addTestFileWithBase ALU_Test\\ALU_Components_Test\\XOR_Component_Test.vhd ALU_Components_Test

catch {project addfolder General_Utils_Test TestBenches}

addTestFileWithBase General_Utils_Test\\Eight_Bit_Tristate_Buffer_Test.vhd General_Utils_Test
addTestFileWithBase General_Utils_Test\\One_Bit_Tristate_Buffer_Test.vhd General_Utils_Test
addTestFileWithBase General_Utils_Test\\Three_Bit_Decoder_Test.vhd General_Utils_Test

# -------- Compile Test Bench Files ---------

proc compileWithTestBase {filePath} {
    global testBaseFilePath
    set fullPath [file join $testBaseFilePath $filePath]
    vcom $fullPath
}

# General Utils
compileWithTestBase General_Utils_Test\\Eight_Bit_Tristate_Buffer_Test.vhd
compileWithTestBase General_Utils_Test\\One_Bit_Tristate_Buffer_Test.vhd
compileWithTestBase General_Utils_Test\\Three_Bit_Decoder_Test.vhd

# ALU Components
compileWithTestBase ALU_Test\\ALU_Components_Test\\ADD_Component_Test.vhd
compileWithTestBase ALU_Test\\ALU_Components_Test\\SUB_Component_Test.vhd 
compileWithTestBase ALU_Test\\ALU_Components_Test\\NOT_Component_Test.vhd
compileWithTestBase ALU_Test\\ALU_Components_Test\\AND_Component_Test.vhd
compileWithTestBase ALU_Test\\ALU_Components_Test\\OR_Component_Test.vhd
compileWithTestBase ALU_Test\\ALU_Components_Test\\SHL_Component_Test.vhd
compileWithTestBase ALU_Test\\ALU_Components_Test\\SHR_Component_Test.vhd
compileWithTestBase ALU_Test\\ALU_Components_Test\\XOR_Component_Test.vhd

# ALU
compileWithTestBase ALU_Test\\ALU_Test.vhd



# -------- Run Tests ---------
vsim work.ALU_test
run -all
quit -sim




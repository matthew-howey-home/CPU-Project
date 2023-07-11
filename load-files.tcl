project open CPUProject2

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

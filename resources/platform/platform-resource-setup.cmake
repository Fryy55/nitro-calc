if (${CMAKE_SYSTEM_NAME} STREQUAL Darwin)
    set(OS_NAME macOS)
else()
    set(OS_NAME ${CMAKE_SYSTEM_NAME})
endif()

string(TOLOWER ${OS_NAME} OS_NAME_LOWERCASE)
set(GEN_PATH ${CMAKE_CURRENT_BINARY_DIR}/platform/${OS_NAME_LOWERCASE})
set(PLATFORM_PATH ${CMAKE_CURRENT_SOURCE_DIR}/resources/platform/${OS_NAME_LOWERCASE})

message(NOTICE "----- Setting up resources for ${OS_NAME} -----")
if (${OS_NAME} STREQUAL Windows)
    find_program(MAGICK_BINARY NAMES magick magick.exe REQUIRED)
    message(NOTICE "----- magick binary found -----")
    message(NOTICE "----- ${MAGICK_BINARY} -----")

    set(ICO_PATH ${GEN_PATH}/icon.ico)
    target_include_directories(${PROJECT_NAME} PRIVATE ${GEN_PATH})
    set(PNG_PATH ${CMAKE_CURRENT_SOURCE_DIR}/resources/icon.png)

    add_custom_command(
        OUTPUT ${ICO_PATH}
        COMMAND echo "----- Generating icon.ico -----"
        COMMAND ${MAGICK_BINARY} ${PNG_PATH} ${ICO_PATH}
        COMMAND echo "----- icon.ico generated -----"
        COMMAND echo "----- ${ICO_PATH} -----"
        DEPENDS ${PNG_PATH}
        VERBATIM
    )

    set(RC_SOURCE ${PLATFORM_PATH}/icon.rc)
    target_sources(${PROJECT_NAME} PRIVATE ${RC_SOURCE})
    set_source_files_properties(${RC_SOURCE} PROPERTIES OBJECT_DEPENDS ${ICO_PATH})

    message(NOTICE "----- .ico generation set up -----")
elseif (${OS_NAME} STREQUAL Linux)
    find_program(BASH_BINARY NAMES bash REQUIRED)
    message(NOTICE "----- bash binary found -----")
    message(NOTICE "----- ${BASH_BINARY} -----")

    set(DESKTOP_NAME ${PROJECT_NAME}.desktop)
    set(DESKTOP_PATH ${GEN_PATH}/${DESKTOP_NAME})
    set(TEMPLATE_PATH ${PLATFORM_PATH}/template.desktop)

    execute_process(
        COMMAND bash -c "GEN_PATH=${GEN_PATH} TEMPLATE_PATH=${TEMPLATE_PATH} DESKTOP_PATH=${DESKTOP_PATH} BINARY_NAME=${PROJECT_NAME} ${PLATFORM_PATH}/desktop-gen.sh"
    )

    message(NOTICE "----- ${DESKTOP_NAME} generated -----")
    message(NOTICE "----- ${DESKTOP_PATH} -----")
else()
    message(FATAL_ERROR "----- Platform ${OS_NAME} isn't supported! -----")
endif()

message(NOTICE "----- Resource setup complete -----")
CONFIG += sailfishapp \
          sailfishapp_no_deploy_qml

TARGET = harbour-deadascend

message("Building $${TARGET} for Sailfish OS")

RESOURCES += $${PWD}/sailfishos.qrc

include($${PWD}/icons/icons.pri)

# sailfishapp should take care of this, but only if it's named
# correctly:
message("Sailfish OS: Will install desktop file")
sfos_desktop.files = $${TARGET}.desktop
sfos_desktop.path = $$PREFIX/share/applications
INSTALLS += sfos_desktop

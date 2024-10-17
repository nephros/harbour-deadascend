CONFIG += sailfishapp \
          sailfishapp_no_deploy_qml

SFOS_APPNAME = harbour-deadascend

message("Building $${SFOS_APPNAME} for Sailfish OS")

RESOURCES += $${PWD}/sailfishos.qrc

include($${PWD}/icons/icons.pri)

# sailfishapp should take care of this, but only if it's named
# correctly:
message("Sailfish OS: Will install desktop file")
sfos_desktop.files = $${PWD}/$${SFOS_APPNAME}.desktop
sfos_desktop.path = $$PREFIX/share/applications
INSTALLS += sfos_desktop

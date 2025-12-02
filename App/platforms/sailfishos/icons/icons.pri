# Configures svg to png
THEMENAME = sailfish-default
INSTALLS += svg appicon

appicon.sizes = \
    86 \
    108 \
    128 \
    172 \
    256 \
    512

OUTDIR=/tmp

for(iconsize, appicon.sizes) {
    profile = $${iconsize}x$${iconsize}


    QMAKE_CLEAN += -r ${OUTDIR}/$${profile}

    system(mkdir -p $${OUTDIR}/$${profile})
    appicon.files += $${OUTDIR}/$${profile}

    appicon.commands += /usr/bin/sailfish_svg2png \
        -z 1.0 -s 1 1 1 1 1 1 $${iconsize} \
        $${PWD}/svgs \
        $${OUTDIR}/$${profile}/apps &&

}
appicon.commands += true
appicon.path = $$PREFIX/share/icons/hicolor/
appicon.CONFIG += no_check_exist

# also install SVG:
svg.path = $$PREFIX/share/icons/hicolor/scalable/apps
svg.files = $${PWD}/svgs/harbour-deadascend.svg \
            $${PWD}/svgs/harbour-deadascend2.svg


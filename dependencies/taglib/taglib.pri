INCLUDEPATH += $$PWD/include
DISTFILES += \
    dependencies/dependencies.pri \
    dependencies/taglib/bin/libtag.a \
    dependencies/taglib/taglib.pri

HEADERS += \
    dependencies/taglib/include/aifffile.h \
    dependencies/taglib/include/aiffproperties.h \
    dependencies/taglib/include/apefile.h \
    dependencies/taglib/include/apefooter.h \
    dependencies/taglib/include/apeitem.h \
    dependencies/taglib/include/apeproperties.h \
    dependencies/taglib/include/apetag.h \
    dependencies/taglib/include/asfattribute.h \
    dependencies/taglib/include/asffile.h \
    dependencies/taglib/include/asfpicture.h \
    dependencies/taglib/include/asfproperties.h \
    dependencies/taglib/include/asftag.h \
    dependencies/taglib/include/attachedpictureframe.h \
    dependencies/taglib/include/audioproperties.h \
    dependencies/taglib/include/chapterframe.h \
    dependencies/taglib/include/commentsframe.h \
    dependencies/taglib/include/eventtimingcodesframe.h \
    dependencies/taglib/include/fileref.h \
    dependencies/taglib/include/flacfile.h \
    dependencies/taglib/include/flacmetadatablock.h \
    dependencies/taglib/include/flacpicture.h \
    dependencies/taglib/include/flacproperties.h \
    dependencies/taglib/include/generalencapsulatedobjectframe.h \
    dependencies/taglib/include/id3v1genres.h \
    dependencies/taglib/include/id3v1tag.h \
    dependencies/taglib/include/id3v2.h \
    dependencies/taglib/include/id3v2extendedheader.h \
    dependencies/taglib/include/id3v2footer.h \
    dependencies/taglib/include/id3v2frame.h \
    dependencies/taglib/include/id3v2framefactory.h \
    dependencies/taglib/include/id3v2header.h \
    dependencies/taglib/include/id3v2synchdata.h \
    dependencies/taglib/include/id3v2tag.h \
    dependencies/taglib/include/infotag.h \
    dependencies/taglib/include/itfile.h \
    dependencies/taglib/include/itproperties.h \
    dependencies/taglib/include/modfile.h \
    dependencies/taglib/include/modfilebase.h \
    dependencies/taglib/include/modproperties.h \
    dependencies/taglib/include/modtag.h \
    dependencies/taglib/include/mp4atom.h \
    dependencies/taglib/include/mp4coverart.h \
    dependencies/taglib/include/mp4file.h \
    dependencies/taglib/include/mp4item.h \
    dependencies/taglib/include/mp4properties.h \
    dependencies/taglib/include/mp4tag.h \
    dependencies/taglib/include/mpcfile.h \
    dependencies/taglib/include/mpcproperties.h \
    dependencies/taglib/include/mpegfile.h \
    dependencies/taglib/include/mpegheader.h \
    dependencies/taglib/include/mpegproperties.h \
    dependencies/taglib/include/oggfile.h \
    dependencies/taglib/include/oggflacfile.h \
    dependencies/taglib/include/oggpage.h \
    dependencies/taglib/include/oggpageheader.h \
    dependencies/taglib/include/opusfile.h \
    dependencies/taglib/include/opusproperties.h \
    dependencies/taglib/include/ownershipframe.h \
    dependencies/taglib/include/podcastframe.h \
    dependencies/taglib/include/popularimeterframe.h \
    dependencies/taglib/include/privateframe.h \
    dependencies/taglib/include/relativevolumeframe.h \
    dependencies/taglib/include/rifffile.h \
    dependencies/taglib/include/s3mfile.h \
    dependencies/taglib/include/s3mproperties.h \
    dependencies/taglib/include/speexfile.h \
    dependencies/taglib/include/speexproperties.h \
    dependencies/taglib/include/synchronizedlyricsframe.h \
    dependencies/taglib/include/tableofcontentsframe.h \
    dependencies/taglib/include/tag.h \
    dependencies/taglib/include/tag_c.h \
    dependencies/taglib/include/taglib.h \
    dependencies/taglib/include/taglib_config.h \
    dependencies/taglib/include/taglib_export.h \
    dependencies/taglib/include/tbytevector.h \
    dependencies/taglib/include/tbytevectorlist.h \
    dependencies/taglib/include/tbytevectorstream.h \
    dependencies/taglib/include/tdebuglistener.h \
    dependencies/taglib/include/textidentificationframe.h \
    dependencies/taglib/include/tfile.h \
    dependencies/taglib/include/tfilestream.h \
    dependencies/taglib/include/tiostream.h \
    dependencies/taglib/include/tlist.h \
    dependencies/taglib/include/tlist.tcc \
    dependencies/taglib/include/tmap.h \
    dependencies/taglib/include/tmap.tcc \
    dependencies/taglib/include/tpropertymap.h \
    dependencies/taglib/include/trefcounter.h \
    dependencies/taglib/include/trueaudiofile.h \
    dependencies/taglib/include/trueaudioproperties.h \
    dependencies/taglib/include/tstring.h \
    dependencies/taglib/include/tstringlist.h \
    dependencies/taglib/include/uniquefileidentifierframe.h \
    dependencies/taglib/include/unknownframe.h \
    dependencies/taglib/include/unsynchronizedlyricsframe.h \
    dependencies/taglib/include/urllinkframe.h \
    dependencies/taglib/include/vorbisfile.h \
    dependencies/taglib/include/vorbisproperties.h \
    dependencies/taglib/include/wavfile.h \
    dependencies/taglib/include/wavpackfile.h \
    dependencies/taglib/include/wavpackproperties.h \
    dependencies/taglib/include/wavproperties.h \
    dependencies/taglib/include/xingheader.h \
    dependencies/taglib/include/xiphcomment.h \
    dependencies/taglib/include/xmfile.h \
    dependencies/taglib/include/xmproperties.h

TAGLIB_STATIC=1
DEFINES+=TAGLIB_STATIC

win32: LIBS += -L$$PWD/bin/ -ltag

DEPENDPATH += $$PWD/dependencies/taglib/include

win32:!win32-g++: PRE_TARGETDEPS += $$PWD/bin/tag.lib
else:win32-g++: PRE_TARGETDEPS += $$PWD/bin/libtag.a

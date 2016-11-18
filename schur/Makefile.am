SUBDIRS=src dat help tests 

EXTRA_DIST=manual/schur_manual.pdf readme.html readme_files help/HELP debian/schur.1

man_MANS = debian/schur.1

dist-hook: manual/schur_manual.pdf
	$(RM) -rf $(distdir)/help/.svn 
	$(RM) -rf $(distdir)/readme_files/.svn 
	$(RM) -rf $(distdir)/dat/.svn

manual/schur_manual.pdf:
	cd manual; make

#doxygen documentation	
documentation:
	mkdir Doxygen
	doxygen schur.doxygen

RPMTOPDIR= ~/tmp/rpm
rpm: dist
	$(RM) -rf $(RPMTOPDIR)
	$(MKDIR_P) $(RPMTOPDIR)/BUILD
	$(MKDIR_P) $(RPMTOPDIR)/RPMS
	$(MKDIR_P) $(RPMTOPDIR)/SOURCES
	$(MKDIR_P) $(RPMTOPDIR)/SPECS
	$(MKDIR_P) $(RPMTOPDIR)/SRPMS
	cp $(distdir).tar.gz $(RPMTOPDIR)/SOURCES
	cp schur.spec $(RPMTOPDIR)/SPECS
	rpmbuild -ba --sign $(RPMTOPDIR)/SPECS/schur.spec
	mv $(RPMTOPDIR)/RPMS/`arch`/*.rpm ..

deb: 
	cd debian ; #sed -e 's/VERSION/'$(VERSION)'/' control.in > control ;\
	sed -e 's/VERSION/'$(VERSION)'/' changelog.in > changelog ; cd ..
	EMAIL=franck.butelle@lipn.fr dch "new version"
	dpkg-buildpackage -rfakeroot -sgpg 

# Creation of a windows installer for SCHUR
# needs cygwin and InnoSetup 5 
INNOSETUP=/cygdrive/c/Program\ Files/Inno\ Setup\ 5/ISCC
WINDIR=/cygdrive/c/__tmp_SCHUR
win32:
	$(RM) -rf $(WINDIR) 2>/dev/null
	$(MKDIR_P) $(WINDIR)/doc
	$(MKDIR_P) $(WINDIR)/usr/share/terminfo
	./configure --prefix="$(WINDIR)"
	make clean
	make install
	make manual/schur_manual.pdf
	cp Windows/*.dll $(WINDIR)/bin
	cp manual/schur_manual.pdf $(WINDIR)/doc
	cp AUTHORS       $(WINDIR)/doc/Authors.txt
	cp help/LICENSE  $(WINDIR)/doc/License.txt
	cp Changelog     $(WINDIR)/doc/Changelog.txt
	cp -a /usr/share/terminfo/* $(WINDIR)/usr/share/terminfo
	cp Windows/schur.ico schur.iss $(WINDIR)
	cd $(WINDIR); $(INNOSETUP) schur.iss
	mv $(WINDIR)/public/SCHUR*.exe /
	cd /
	$(RM) -rf $(WINDIR)


# Creation of an OS X installer for SCHUR
# Make two directories, one for compiling (osxbuild) and one for gathering all files (OSXDIST)
# Get directory of this file.
# Works with gcc, llvm-gcc 
#DIR="$( cd "$( dirname "$0" )" && pwd )"
OSXDIST=osxdist
osx:
	$(RM) -rf osxbuild 2> /dev/null
	$(RM) -rf $(OSXDIST) 2> /dev/null
	mkdir osxbuild
	mkdir $(OSXDIST)
	./configure --prefix="$(CURDIR)/osxbuild" CC='$(CC) -mmacosx-version-min=10.4'
	make clean
	make install
	make manual/schur_manual.pdf
	pkgbuild --root osxbuild/ --identifier Schur --version $(VERSION) --install-location /usr/local --scripts osxscripts $(OSXDIST)/SchurInstaller.pkg
	cp manual/schur_manual.pdf $(OSXDIST)/SchurManual.pdf
	cp AUTHORS      $(OSXDIST)/Authors.txt
	cp help/LICENSE $(OSXDIST)/License.txt
	cp ChangeLog    $(OSXDIST)/ChangeLog.txt
	echo "After running SchurInstaller.pkg, you can run Schur from the command line in the terminal by typing 'schur'." > $(OSXDIST)/Install.txt
	hdiutil create -volname Schur -srcfolder $(OSXDIST) -ov -format UDZO schur.$(VERSION).dmg

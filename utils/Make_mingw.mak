# vim:set ts=8 sts=8 sw=8 tw=0:
#
# MinGW用Makefile
#
# Base Idea:	MATSUMOTO Yasuhiro
# Maintainer:	MURAOKA Taro <koron.kaoriya@gmail.com>

##############################################################################
# 環境に応じてこの変数を変更する
#
DLLNAME	= migemo.dll
libmigemo_LIB = $(outdir)libmigemo.dll.a
libmigemo_DSO = $(outdir)$(DLLNAME)
EXEEXT = .exe
CFLAGS_MIGEMO =
LDFLAGS_MIGEMO =
CC = gcc

include config.mk
include compile/unix.mak
include src/depend.mak
include compile/clean_unix.mak
include compile/clean.mak

##############################################################################
# 環境に応じてライブラリ構築法を変更する
#
$(libmigemo_LIB): $(libmigemo_DSO)
$(libmigemo_DSO): $(libmigemo_OBJ) $(srcdir)migemo.def
	$(CC) -shared -o $(libmigemo_DSO) -Wl,--out-implib,$(libmigemo_LIB) $(srcdir)migemo.def $(libmigemo_OBJ)

install-lib: $(libmigemo_DSO) $(libmigemo_LIB)
	$(INSTALL_DATA)		$(libmigemo_LIB) $(libdir)
	$(INSTALL_PROGRAM)	$(libmigemo_DSO) $(bindir)

uninstall-lib:
	$(RM) $(bindir)/$(libmigemo_DSO)
	$(RM) $(libdir)/$(libmigemo_LIB)

dictionary:
	cd dict && $(MAKE) mingw

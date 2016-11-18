#  SCHUR -  an interactive program for calculating properties of Lie
#  groups and symmetric functions.
#  Copyright (C) 2006  Franck BUTELLE, Frédéric Toumazet
#
#  SCHUR is free software; you can redistribute it and/or modify it
#  under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  SCHUR is distributed in the hope that it will be useful, but
#  WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with SCHUR; if not, write to the Free Software Foundation,
#  Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ(2.60)
AC_INIT(SCHUR, 6.10, Franck.Butelle@lipn.univ-paris13.fr & toumazet@univ-mlv.fr,,http://schur.sourceforge.net)
AC_CONFIG_HEADER([config.h])

# Checks for programs.
AC_PROG_CC_STDC
# AC_USE_SYSTEM_EXTENSIONS(_GNU_SOURCE)

# for automake (tests validation checks)
AC_CHECK_PROGS(LEX, flex lex, "./missing flex")
AC_PROG_LEX

# Checks for libraries.
AC_CHECK_LIB(m,sqrt)
# AC_CHECK_LIB(ncurses, initscr)

# Checks for header files.
AC_HEADER_STDC
AC_CHECK_HEADERS([malloc.h stdlib.h string.h unistd.h strings.h values.h stdarg.h getopt.h])
# Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST
AC_HEADER_STDBOOL
AC_TYPE_SIZE_T

# Default is using readline 
# may use libedit if asked, but they are mutually exclusive with readline
AC_ARG_WITH([libedit],
	    AS_HELP_STRING([--with-libedit],[enable support for libedit]),
	    [with_libedit=yes ; with_readline=no],
	    [with_libedit=no])

AC_ARG_WITH([readline],
   AS_HELP_STRING([--without-readline],
   [disable support for readline: no history, no command completion]),
   [with_readline=no],
   [with_readline=yes ; with_libedit=no])

LIBREADLINE=
AS_IF([test "x$with_readline" != xno],
    AC_MSG_CHECKING(for readline, (with_readline=$with_readline))
    AC_CHECK_LIB([readline], [main],
	AC_SUBST([LIBREADLINE], ["-lreadline -lncurses"]) 
	AC_DEFINE([HAVE_LIBREADLINE], [1], [Define if you have libreadline])
	AC_CHECK_HEADERS(readline/history.h readline/readline.h,[],
                 AC_MSG_FAILURE([Sorry readline needed (sometimes known as
                               librealine-devel) use --without-readline to disable]))
	,
	AC_MSG_FAILURE([readline test failed (--without-readline to disable)]) 
	AC_DEFINE([HAVE_LIBREADLINE], [0], [No readline])
	,
        [])
   )

AS_IF([test "x$with_libedit" = xyes],
     [AC_MSG_CHECKING(for libedit (with_readline=$with_readline))
     PKG_CHECK_MODULES([LIBEDIT], libedit,
	      [AC_SUBST([LIBREADLINE], [${LIBEDIT_LIBS}])
	      AC_DEFINE([HAVE_LIBREADLINE], [1], [Define if you have libreadline])]
	      ,
	      [AC_MSG_FAILURE([libedit test failed])
	      AC_DEFINE([HAVE_LIBREADLINE], [0], [No readline])]
	     )]
	     ,[]
     )


# Checks for library functions.
AC_FUNC_ERROR_AT_LINE
AC_FUNC_MALLOC
AC_FUNC_REALLOC
AC_CHECK_FUNCS([strerror strstr strncmp strncasecmp vfprintf])

AC_MSG_CHECKING(for -fnested-functions)
AC_COMPILE_IFELSE(
  dnl Prototype needed due to http://gcc.gnu.org/bugzilla/show_bug.cgi?id=36774
  [AC_LANG_PROGRAM([], [auto void foo(void); void foo(void) {}])],
  AC_MSG_RESULT(parameter not needed)
  AC_DEFINE([HAVE_NESTED_FUNCTIONS], [1], [Have nested functions])
  [AST_NESTED_FUNCTIONS=],
  [AST_NESTED_FUNCTIONS=-fnested-functions]
  AC_LINK_IFELSE(
	[AC_LANG_PROGRAM([], [auto void foo(void); void foo(void) {}])],
  	AC_MSG_RESULT(required)
	AC_DEFINE([HAVE_NESTED_FUNCTIONS], [1], [Have nested functions])
	,
	AC_MSG_RESULT(do not have nested functions)
  	[AST_NESTED_FUNCTIONS=]
	AC_DEFINE([HAVE_NESTED_FUNCTIONS], [0], [No nested functions])
  )
)

AC_SUBST(AST_NESTED_FUNCTIONS)

AC_CONFIG_FILES([schur.iss
		 schur.spec 
		 schur.doxygen
		 Makefile
		 src/Makefile
		 dat/Makefile
		 help/Makefile
		 tests/Makefile
		 manual/schur_manf.tex
		 ])
AC_SUBST(CFLAGS,["-O3"])

AC_CANONICAL_BUILD

# to be able to use $(MKDIR_P) in Makefile.am
AC_PROG_MKDIR_P

AC_CONFIG_COMMANDS([default],[
	echo "***************************************"
	echo "Configuration of SCHUR is now complete."
	echo ""
	echo "You may type  make check   for tests"
	echo "***************************************"
	echo ""
	],[])
AM_INIT_AUTOMAKE([foreign])
AC_OUTPUT

// trim.c : drop lines from the begining to '*------------*' (12 -)
// and next spaces at the begining and at the end of each line of a file
// given in parameter. Can be used as a filter as well.
//
// Franck BUTELLE 2005.
//
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>


#define MAX 1000
#define BS   8

char *
dropspaces(char *str)
{
  char *start, *end, *str2;

  for (start = str;
       *start != '\0' && (*start == ' ' || *start == '\n' || *start == '\r' || *start == '\t');
       start++);

  if (*start != '\0')
    {
      end = start + strlen (start);
      for (--end; *end == ' ' ||  *end == '\n' || *end == '\r' || *end == '\t';
	   end--);
      *++end = '\0';
    }
  else
    return (start);

  /* Now look for sequences "space backspace" and purge them */
  for (str = start + 1, str2 = str; *str2 != '\0'; str++, str2++)
    {
      if (*str2 == BS && *(str2 - 1) == ' ')
	str2 += 2;
      if (str != str2)
	*(str - 1) = *(str2 - 1);
    }
  if (str != str2)
    {
      *(str - 1) = *(str2 - 1);
      *str = '\0';
    }

  return start;
}

int
main (int argc, char *argv[])
{
  FILE *f;
  char inter[MAX], *s;

  if (argc > 2)
    {
      fprintf (stderr,
	       "synopsis: %s filetotrim (or as a filter) to drop the left and right spaces of each line\n",
	       argv[0]);
      exit (1);
    }
  if (argc == 1)
    f = stdin;
  else if ((f = fopen (argv[1], "r")) == NULL)
    {
      fprintf (stderr, "can't read %s (%s)\n", argv[1], strerror (errno));
      exit (1);
    }

  fgets (inter, MAX, f);	//keep the newline
  s=dropspaces(inter);
  while (!feof(f) && strcmp(s,"*------------*") !=0)
  {
    fgets (inter, MAX, f);
    s=dropspaces(inter);
  }
    

  if (!feof(f))			
	fgets (inter, MAX, f);  // eat the *--- line
  while (!feof (f))
    {
      s = dropspaces(inter);
      if (*s != '\0')		// not an empty line
	printf ("%s\n", s);
      fgets (inter, MAX, f);
    }

  return (0);
}

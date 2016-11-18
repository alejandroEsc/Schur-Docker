%option nounput
%option noyywrap
%{
  /* extract_examples.lex          Franck BUTELLE 2005 */ 
  #include <stdio.h>
  #include <string.h>
  #include <strings.h>
  #include <errno.h>

  #define CMDZONE 	1
  #define RESULTZONE 	2
  #define TMPCMDFILE 	"/tmp/extract_cmd"
  #define TMPRESULTFILE "/tmp/extract_result"

  int zone;       // current zone : either cmd or result;
  char currentMode[5]="DESCR";   // just to fill enough caracters 
  int debug=0;

  FILE *cmdFile,*resultFile;
    /* useful functions prototypes */
  char *trimLeft(char *str);
  char *strtoup(char *str);

%}
SPACES	[ \t\n\r]*
MODE	("DP"|"REP"|"SFN"|"BRM")
%x CMD_ZONE RESULT_ZONE
%%
^{SPACES}"Example"s?":-"{SPACES}?{MODE}>\n	{	   
  				char *temp;
				if (strcmp(currentMode,"DESCR")==0) 
				  strcpy(currentMode,"DP");//default schur mode is DPrep
  				zone=CMDZONE;BEGIN(CMD_ZONE);
				temp=strdup(yytext);
				temp[yyleng-2]='\0';	//to get rid of >
				temp=trimLeft(strstr(temp,":-")+2);
  				if (debug)
  				  fprintf(stderr,"****Example(s) found (%s)\n",temp);
				if (strcasecmp(currentMode,temp)!=0) { // change mode
				   if (debug)
				     fprintf(stderr,"****change mode:%s->%s\n",currentMode,temp);
  				   fprintf(cmdFile,"%s\n",temp);
				   if (strncasecmp(temp,"SFN",3)==0) {
				     fputs("Schur Function Mode\n",resultFile);
				     strcpy(currentMode,"SFN");
				   }
				   else if (strncasecmp(temp,"REP",3)==0)
				   {
				     fputs("REP mode\n",resultFile);
				     strcpy(currentMode,"REP");
				   }
				   else
				     strcpy(currentMode,"DP");
				}	
			}
<INITIAL>(.|\n)			{ // Ignore description part
				}
<CMD_ZONE,RESULT_ZONE>^{SPACES}"->".*\n             {
  				char *index;
				index= strstr(yytext,"->");
				index= trimLeft(index+2);
				if (debug)
  				  fprintf(stderr,"****Command=%s\n",index);
				fputs(index,cmdFile);
				index[strlen(index)-1]='\0';//drop the final \n
				if (strncasecmp(index,"REP",3)==0
				   || strncasecmp(index,"SFN",3)==0 ) {
				    strncpy(currentMode,strtoup(index),3);
				    currentMode[3]='\0';
				}
				if (strncasecmp(index,"DPM",3)==0) //change mode
				    strcpy(currentMode,"DP");
				if (strncasecmp(index,"BRM",3)==0) // change mode
			            strcpy(currentMode,"BRM");
  				zone=RESULTZONE;
				BEGIN(RESULT_ZONE);
				}
<CMD_ZONE,RESULT_ZONE>^NOTES:.*$ {	//starts of final comments.
  				if (debug)
  				  fprintf(stderr,"NOTES detected\n");
  				fputs("END\n",cmdFile);
				//fprintf(resultFile,"%s>",currentMode);
				exit(0);
  				}
<CMD_ZONE,RESULT_ZONE>.*\n  	{
				if (zone==CMDZONE)
					fputs(yytext,cmdFile);
				else if (zone==RESULTZONE) {
  					char *index;
					index= trimLeft(yytext);
					if (strncmp(index,"enter ",6)==0)
					{
						index[strlen(index)-1]='\0';
						fprintf(resultFile,"%s ",index);
						if (debug)
						  fprintf(stderr,"enter ...\n");
					}
					else if (strncmp(index,"DP>",3)!=0
						&& strncmp(index,"BRM>",4) !=0
						&& strncmp(index,"SFN>",4) !=0
						&& strncmp(index,"REP>",4) !=0)
					{
						fputs(index,resultFile);
						if (debug)
						  fprintf(stderr,"****result=%s\n",index);
					}
				     }
  				}

<<EOF>>  			{
  				fputs("END\n",cmdFile);
				//fprintf(resultFile,"%s>",currentMode);//because of these last command...
				return(0);
			}	
%%
/******************* Some useful functions ******************************/

char *trimLeft(char *str) {
    char *c;

      for (c=str;*c!='\0' && (*c == ' ' || *c =='\n' || *c == '\t');c++);
        return c;
}

char *strtoup(char *str) {
  char *c;

  for (c=str;*c!='\0';c++)
    if (*c>='a' && *c <='z')
      *c -= 'a' -'A';
  return str;
}

int main(int argc,char *argv[]) {
  int i;

    if (argc<4) {
 	fprintf(stderr,"synopsis: %s [-d] helpfile extracted_cmds extracted_results",argv[0]);
	fprintf(stderr,"\nAdd -d option to debug\n");
     	exit(1);
    }
    i=1;
    if (strcmp(argv[1],"-d")==0) {
      debug=1;
      i++;
    }
    if ((yyin=fopen(argv[i++],"r"))==NULL) {
      fprintf(stderr,"can't read %s (%s)\n", argv[1], strerror(errno));
      exit(1);
    }
    
    if ((cmdFile=fopen(argv[i++],"w"))==NULL) {
      fprintf(stderr,"can't write extracted cmds on %s (%s)\n", argv[2], strerror(errno));
      exit(1);
    }

    if ((resultFile=fopen(argv[i++],"w"))==NULL) {
      fprintf(stderr,"can't write extracted results on %s (%s)\n", argv[3], strerror(errno));
      exit(1);
    }
    
    fprintf(resultFile,"DPrep Mode (with function)\n"); // First prompt 

    yylex();

    return(0);
}

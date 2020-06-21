%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
%}
%%
def	return DEFTOK;
return return RTRN;
[\t]+ return TAB;
[\n] return LINE;
\(	return OPENBR;
\)	return CLOSEBR;
\, return COMMA;
\: return CLMN;
[ ]+ return SPACE;
[a-z]([a-z]|[0-9])*  return VAR;

%%
#include <stdio.h>
#include <string.h>

#define MAX 256

int main(int argc, char* argv[]) 
{
	FILE* fptr1, * fptr2;
	char str[MAX];
	char* arg = argv[1];
	char fname[] = "myprog.c";
	strcpy(fname,arg);
	char temp[] = "expanded.c";
	fptr1 = fopen(fname, "r");
	fptr2 = fopen(temp, "w");

	fptr1 = fopen(fname, "r");
	if (!fptr1)
	{
		printf("Unable to open the input file!!\n");
		return 0;
	}
	fptr2 = fopen(temp, "w");
	if (!fptr2)
	{
		printf("Unable to open a temporary file to write!!\n");
		fclose(fptr1);
		return 0;
	}
	while (!feof(fptr1))
	{
		strcpy(str, "\0");
		fgets(str, MAX, fptr1);

		if (!feof(fptr1)) {
			if (strstr(str, "@set") != NULL) {
				char delim[] = " ";
				char* ptr = strtok(str, delim);
				ptr = strtok(NULL, delim);
				fprintf(fptr2, "setVar(\"%s\", &%s);\n", ptr, ptr);
			}
			else if (strstr(str, "@breakpoint") != NULL) {
				char delim[] = " ";
				char* ptr = strtok(str, delim);
				ptr = strtok(NULL, delim);
				char* ptr2 = strtok(NULL, delim);
				fprintf(fptr2, "bpTrace(\"%s\", %s);\n", ptr, ptr2);
			}
			else if (strstr(str, "=") != NULL) {
				fprintf(fptr2, "%s", str);

				char delim[] = " ";
				char* ptr = strtok(str, delim);
				if (strstr(ptr, "\t") != NULL) {
					ptr = strtok(ptr, "\t");
				}
				fprintf(fptr2, "saveVar(\"%s\");\n", ptr);
			}
			else
			{
				fprintf(fptr2, "%s", str);
			}

		}

	}
	return 0;
}

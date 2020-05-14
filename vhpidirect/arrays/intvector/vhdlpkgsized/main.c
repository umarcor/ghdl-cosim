#include <stdio.h>
#include <string.h>
#include <malloc.h>

extern int ghdl_main(char argc, char* argv[]);

int main(int argc, char const *argv[])
{
	int vectorLength = 0;
	char ghdl_argc = 1;
	char** ghdl_argv = malloc((argc+1)*sizeof(char*));
	ghdl_argv[0] = malloc((strlen(argv[0])+1)*sizeof(char));
	strcpy(ghdl_argv[0], argv[0]);

	const char* growFlag = "--grow-vec";
	for (int i = 1; i < argc; i++)
	{
		if(strcmp(argv[i], growFlag) == 0 && i < argc-1){
			for(int j = 0; j < strlen(argv[i+1]); j++)
				vectorLength = 10*vectorLength + (argv[i+1][j] - '0');
		}
	}
	vectorLength = (vectorLength > 333 ? 999 : 3*vectorLength);

	ghdl_argc += 1;
	ghdl_argv[ghdl_argc-1] = malloc(15*sizeof(char));
	snprintf(ghdl_argv[ghdl_argc-1], 15, "-gArraySize=%d", vectorLength);

	for (int i = 0; i < ghdl_argc; i++)
	{
		printf("ghdl_argv[%d] = `%s`\n", i, ghdl_argv[i]);
	}	

	int ghdl_return = ghdl_main(ghdl_argc, ghdl_argv);

	for (int i = 0; i < ghdl_argc; i++)
	{
		free(ghdl_argv[i]);
	}
	free(ghdl_argv);
	return ghdl_return;
}

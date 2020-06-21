#include <stdio.h>
#include "myDebugHdr.h"
struct tr {

	char* name; // variable name
	int* adr; // address of the variable
	int values[20]; // last 20 values
	int first; // points to the index of the first value in values[]
	int last; // points to the index of the last value in values[]

};
struct tr Traces[5]; // 5 variables
int indexTr = 0;

void setVar(char* name, int* adr)
{

	Traces[indexTr].adr = adr;
	Traces[indexTr].name = name;
	for (int i = 0; i < 20; i++)
	{
		Traces[indexTr].values[i] = 5;
	}
	Traces[indexTr].first = Traces[indexTr].last = -1;
	indexTr++;


	// enters variable name and its address in Traces[]
}
void saveVar(char* name)
{
	//printf("%s", Traces[0].name);
	for (int i = 0; i < 5; i++)
	{
		if (Traces[i].name == name)
		{
			//printf("%s kaydediliyor\n", Traces[i].name);
			if (Traces[i].last == -1)
			{
				Traces[i].values[0] = *Traces[i].adr;
				//printf("%s ilk defa kaydediliyor ve degeri %d\n", Traces[i].name, *Traces[i].adr);
				Traces[i].first = 0;
				Traces[i].last = 0;
				break;
			}
			else
			{
				Traces[i].last++;
				if (Traces[i].last >= 20)
				{
					Traces[i].last = 0;

				}

				if (Traces[i].last == Traces[i].first)
				{
					Traces[i].first++;
					if (Traces[i].first >=20)
					{
						Traces[i].first = 0;
					}
				}
				Traces[i].values[Traces[i].last] = *Traces[i].adr;





			}
			break;
		}

	}
	// searches variable name in Traces[] and enters its current value in values[]
}
void bpTrace(char* c, int n)
{
	//printf("buraya geldi");
	for (int i = 0; i < 5; i++)
	{
		//printf("%s \n %s", Traces[i].name, c);
		if (Traces[i].name == c) {
			

			//("%d is last %d is first", Traces[i].last, Traces[i].first);
			if (Traces[i].last > Traces[i].first)
			{
				int temp1 = Traces[i].last-n+1;
				for (int j = 0; j < n; j++)
				{
					printf("Last %d'st Value of |%s| is %d\n",j+1, Traces[i].name, Traces[i].values[temp1]);
					if (++temp1 > 19)
					{
						break;
					}
					getchar();
				}
			}
			else
			{
				int temp1 = Traces[i].first - n;
				if (temp1<0)
				{
					temp1 = 20 + temp1;
				}
				
				for (int j = 0; j < n; j++)
				{
					printf("Last %d'st Value of |%s| is %d\n",j+1, Traces[i].name, Traces[i].values[temp1++]);
					if (temp1 > 19)
					{
						temp1 = 0;
					}
					getchar();
				}
			}
			break;
		}
			

		
		
	}

};
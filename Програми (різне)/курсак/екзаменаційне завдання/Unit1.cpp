//---------------------------------------------------------------------------
#include <iostream>
#include <conio>
#include <math>
#include <vcl>
#include <cstdio>
#include <cstring>
using namespace std;

//---------------------------------------------------------------------------
int main()
{   SetConsoleOutputCP(1251);
    SetConsoleCP(1251);

	char text[80];
    int d, i;
    cout <<"������ �����: ";
    gets(text);
    d = strlen(text);
    cout << "����� �����: ";
    for(i = 0; i < d; i++)
    {
    	if(text[i] == '�')cout << "...";
        else cout << text[i];
    }

    getch();
	return 0;
}
//---------------------------------------------------------------------------
 
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
    cout <<"Введіть рядок: ";
    gets(text);
    d = strlen(text);
    cout << "Новий рядок: ";
    for(i = 0; i < d; i++)
    {
    	if(text[i] == 'а')cout << "...";
        else cout << text[i];
    }

    getch();
	return 0;
}
//---------------------------------------------------------------------------
 
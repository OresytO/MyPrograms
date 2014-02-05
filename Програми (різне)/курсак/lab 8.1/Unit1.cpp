//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;

// �������� �������
double fact(int n)
{
	double f = 1;
	if(n > 1) for(int i = 1; i <= n; i++) f *= i;
	return f;
}


double fun_q(double x, double n)
{
	double q = 0;
    for(int i = 1; i <= n; i++)
    {
		q += ((x + 1)/factorial(i))/(i * i + x + 3);
    }
    return q + (n/x)/(n * n - x);
}

double fun_g(double x, double n)
{
	double g = 0;
    for(int i = 1; i <= n; i++)
    {
		g += (x + 1/factorial(i))/(i * i + x - 3);
    }
    return g + (n/x)/(n * n - x);
}
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button2Click(TObject *Sender)
{
	StringGrid2->RowCount = 1;
	if(Edit1->Text == "" || Edit2->Text == "" || Edit3->Text == "" || Edit4->Text == "")
    {
        ShowMessage("��������� �� ����!");
        return;
    }

    double a = StrToFloat(Edit1->Text);
    double b = StrToFloat(Edit2->Text);
    double e = StrToFloat(Edit3->Text);
    double n = StrToFloat(Edit4->Text);

    StringGrid1->FixedRows = 1;
    StringGrid1->FixedCols = 1;
    StringGrid1->ColCount = 2;
    StringGrid1->Cells[0][0] = "Xi";
    if(RadioButton1->Checked)StringGrid1->Cells[1][0] = "g[x, n]";
    if(RadioButton2->Checked)StringGrid1->Cells[1][0] = "q[x, n]";

    for(double i = a; i <= b + e/2; i += e)
    {
    	StringGrid1->RowCount++;
        StringGrid1->Cells[0][StringGrid1->RowCount - 1] = i;
        if(RadioButton1->Checked)StringGrid1->Cells[1][StringGrid1->RowCount - 1] = fun_g(i,n);
        if(RadioButton2->Checked)StringGrid1->Cells[1][StringGrid1->RowCount - 1] = fun_q(i,n);
    }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button1Click(TObject *Sender)
{
   for(int i = 1; i < StringGrid2->RowCount; i++)
        {
        	float x = StrToFloat(StringGrid2->Cells[0][i]);
            float y = StrToFloat(StringGrid2->Cells[1][i]);
            Series1->AddXY(x,y,"",clRed) ;
        }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button3Click(TObject *Sender)
{
  StringGrid2->RowCount = 1;
  Edit1->Text = "";
  Edit2->Text = "";
  Edit3->Text = "";
  Edit4->Text = "";
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormCreate(TObject *Sender)
{
	Image1->Picture->LoadFromFile("fun_g.jpg");
    Image2->Picture->LoadFromFile("fun_q.jpg");
}
//---------------------------------------------------------------------------





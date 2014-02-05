//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
#include "math.h"
#include <jpeg.hpp>

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "CSPIN"
#pragma link "PERFGRAP"
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button1Click(TObject *Sender)
{
        StringGrid1->RowCount = CSpinEdit1->Value;
        StringGrid1->ColCount = CSpinEdit2->Value;
        StringGrid3->RowCount = CSpinEdit1->Value;
}
//---------------------------------------------------------------------------


void __fastcall TForm1::Button2Click(TObject *Sender)
{
int height = CSpinEdit1->Value;
int widht = CSpinEdit2->Value;

 double sum = 0.0;
 for(int i=0;i<height;i+=2) // інкремент на 2 виключає використання умовного оператора
 {
        sum = 0.0;

         for(int j=0;j<widht;j++)
        if(StringGrid1->Cells[j][i]!="")
                try
                {
                sum+=StrToFloat(StringGrid1->Cells[j][i]);
                 }
                catch (EConvertError &e)
                {
                StringGrid3->CleanupInstance();
                 ShowMessage("Перевірте правильність вводу!");

                }
        else
        ShowMessage("Заповніть усі поля!");


        StringGrid3->Cells[0][i] = sum/widht;
 }


}


//---------------------------------------------------------------------------


double FUNC(double x, double n)
{
        double sum = 0;

        for(int i=1;i<n;i++)
        {
                sum+=x/(x+3)+(n/x)/(n*n-x);
        }

        return sum;

}



void __fastcall TForm1::FormCreate(TObject *Sender)
{
        StringGrid2->Cells[0][0] = "X";
        StringGrid2->Cells[1][0] = "F(x)";
        Image1->Picture->LoadFromFile("image1.jpg");
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button3Click(TObject *Sender)
{
        StringGrid2->RowCount=1;
        if(Edit5->Text == "" || Edit6->Text == "" || Edit7->Text == "" || Edit8->Text == "")
        {
        ShowMessage("Заповніть усі поля!");
                return;
        }
        double a = StrToFloat(Edit5->Text);
        double b = StrToFloat(Edit6->Text);
        double e = StrToFloat(Edit7->Text);
        double n = StrToFloat(Edit8->Text);

        for(double i = a; i<=b+e/2.0; i+=e)
        {
                StringGrid2->RowCount++;
                StringGrid2->Cells[0][StringGrid2->RowCount-1] = i;
                StringGrid2->Cells[1][StringGrid2->RowCount-1] = FUNC(i,n);
        }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button4Click(TObject *Sender)
{
          StringGrid2->RowCount = 1;
          Edit5->Text = "";
          Edit6->Text = "";
          Edit7->Text = "";
          Edit8->Text = "";
}
//---------------------------------------------------------------------------



//---------------------------------------------------------------------------

void __fastcall TForm1::Button5Click(TObject *Sender)
{
        for(int i=1;i<StringGrid2->RowCount;i++)
        {
                float x = StrToFloat((StringGrid2->Cells[0][i]));
                float y = StrToFloat(StringGrid2->Cells[1][i] );
                Series1->AddXY(x,y,"",clRed) ;
        }
}
//---------------------------------------------------------------------------




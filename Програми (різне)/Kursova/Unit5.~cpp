//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit5.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm5 *Form5;
//---------------------------------------------------------------------------
__fastcall TForm5::TForm5(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TForm5::Button1Click(TObject *Sender)
{
Form5->Close();
}
//---------------------------------------------------------------------------



void __fastcall TForm5::Button2Click(TObject *Sender)
{

ADOQuery1->Close();
ADOQuery1->Parameters->ParamByName("n")->Value=StrToInt(Edit1->Text);
DataSource1->DataSet=ADOQuery1;
ADOQuery1->Open();




}
//---------------------------------------------------------------------------

//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit3.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Word_2K_SRVR"
#pragma resource "*.dfm"
TForm3 *Form3;
//---------------------------------------------------------------------------
__fastcall TForm3::TForm3(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TForm3::Button1Click(TObject *Sender)
{
Form3->Close();
}
//---------------------------------------------------------------------------

void __fastcall TForm3::Button2Click(TObject *Sender)
{
ADOQuery1->Parameters->ParamByName("n")->Value=StrToInt(Edit1->Text);
DataSource1->DataSet=ADOQuery1;
ADOQuery1->Open();
}
//---------------------------------------------------------------------------

void __fastcall TForm3::Button3Click(TObject *Sender)
{
TVariant Visible=false;
WordApplication1->Documents->Add(EmptyParam,EmptyParam,Visible);
}
//---------------------------------------------------------------------------

void __fastcall TForm3::Button4Click(TObject *Sender)
{
WordApplication1->set_Visible(true);

if(WordApplication1->Dialogs->Item(wdDialogFileOpen)->Show(EmptyParam)==1)
WordApplication1->Connect();
}
//---------------------------------------------------------------------------

void __fastcall TForm3::Button5Click(TObject *Sender)
{
WordApplication1->set_Visible(true);
}
//---------------------------------------------------------------------------

void __fastcall TForm3::Button6Click(TObject *Sender)
{
ADOTable1->Open();
TVariant Direction=wdCollapseEnd;
TVariant snew="\n";
WordApplication1->Connect();
while(!ADOTable1->Eof)
{
{WordApplication1->Selection->InsertAfter(snew);
WordApplication1->Selection->InsertAfter(TVariant("ÐÎÁ²ÒÍÈÊ :"+ADOTable1PRIZV->AsString + "!\n"));
WordApplication1->Selection->InsertAfter(TVariant("ÇÀÉÌÀÆÌÀ ÏÎÑÀÄÀ :"+ADOTable1POSADA->AsString + "!\n"));
WordApplication1->Selection->InsertAfter(TVariant("ÑÒÀÆ ÐÎÁÎÒÈ Â ÄÍßÕ :"+ADOTable1STAG->AsString + "!\n"));
WordApplication1->Selection->InsertAfter(TVariant("ÊÎÄ Â²ÄÄ²ËÓ :"+ADOTable1COD_VIDDILU->AsString + "!\n"));
WordFont1->ConnectTo(WordApplication1->Selection->Font);
WordFont1->set_Bold(1);
WordFont1->set_Italic(1);

WordApplication1->Selection->InsertAfter(snew);
WordApplication1->Selection->InsertAfter(TVariant(Memo1->Text));
ADOTable1->Next();
}
}
ADOTable1->Close();
}
//---------------------------------------------------------------------------

void __fastcall TForm3::Button7Click(TObject *Sender)
{
DataSource1->DataSet=ADOTable1;
}
//---------------------------------------------------------------------------


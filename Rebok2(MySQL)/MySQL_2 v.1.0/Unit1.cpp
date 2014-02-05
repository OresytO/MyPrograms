#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
#include "Unit2.h"
#include "Unit3.h"
#include "Unit4.h"
#include "Unit5.h"
#include "Unit6.h"
#include "Unit7.h"
#include "Unit8.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"

TFStart *FStart;

void AddingCourier(){
	FAddCourier->Visible = true;
}

void AddingCities(){
	FCities->Visible = true;
}

void AddingContr(){
	FContr->Visible = true;
}

void AddingForwarder(){
	FAddForwarder->Visible = true;
}

void CreatCombo(TComboBox *Obj){
    //Obj->Sorted = true;
	String str = "������ �� ������";
    int n = Obj->Items->Count;
	Obj->Items->Insert(n, str);

    Obj->ItemIndex = n - 1;
    Obj->AutoDropDown = true;
}

void AddToList(TComboBox *Obj, void (*Fun)()){
	if(!strcmp(Obj->Text.c_str(), "������ �� ������")){
    	Fun();
    }
    //else
}

//---------------------------------------------------------------------------
__fastcall TFStart::TFStart(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------


void __fastcall TFStart::BitBtn1Click(TObject *Sender)
{
	FStart->Visible = false;
    FInputDeli->Visible = true;
    FInputDeli->Active;
}
//---------------------------------------------------------------------------
void __fastcall TFStart::BitBtn2Click(TObject *Sender)
{
	FStart->Visible = false;
    FOutputDeli->Visible = true;
    FOutputDeli->Active;
}
//---------------------------------------------------------------------------

void __fastcall TFStart::BitBtn4Click(TObject *Sender)
{
	exit(1);
}
//---------------------------------------------------------------------------
void __fastcall TFStart::BitBtn3Click(TObject *Sender)
{
	FStart->Visible = false;
    FShow->Visible = true;
    FShow->Active;
}
//---------------------------------------------------------------------------

void __fastcall TFStart::FormCreate(TObject *Sender)
{
	ADOCommand1->CommandText = "USE rebok2_db1; ";//Format(ConnString, ARRAYOFCONST((UserName, Server)));

    try{
        ADOCommand1->Execute();
    }catch (...){
        MessageDlg("Error while ADOCommand1->Execute();", mtError,
                      TMsgDlgButtons() << mbOK, 0);
        return;
    }
}
//---------------------------------------------------------------------------


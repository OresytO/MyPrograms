//---------------------------------------------------------------------------

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
TFContr *FContr;

void TFContr::CleanForm(){
	FContr->Edit1->Clear();
    FContr->Edit2->Clear();
    FContr->Edit3->Clear();
    FContr->Edit4->Clear();
}

//---------------------------------------------------------------------------
__fastcall TFContr::TFContr(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TFContr::BitBtn1Click(TObject *Sender)
{
	FContr->Visible = false;
}
//---------------------------------------------------------------------------
void __fastcall TFContr::FormHide(TObject *Sender)
{
	CleanForm();
}
//---------------------------------------------------------------------------
void __fastcall TFContr::BitBtn2Click(TObject *Sender)
{
	String dataStr = "INSERT INTO `rebok2_db1`.`contragent` (contragent_id, ";
    String colStr, valueStr = "'', '";

	if(Edit1->Text.IsEmpty()){
    	ShowMessage("¬вед≥ть назву контрагента");
    	return;
    } else {
    	colStr = "`name`";
        valueStr += Edit1->Text  + '\'';
    }
    if(Edit2->Text.IsEmpty()){
    	ShowMessage("¬вед≥ть адресу контрагента");
        return;
	} else {
     	colStr += ", adress";
        valueStr += ", '" + Edit2->Text + '\'';
    }
    if(Edit3->Text.IsEmpty()){
    	//ShowMessage("¬вед≥ть phone 1 контрагента");
    	//return;
    } else {
    	colStr += ", phone_1";
        valueStr += ", '" + Edit3->Text  + '\'';
    }
    if(Edit4->Text.IsEmpty()){
    	//ShowMessage("¬вед≥ть phone 2 контрагента");
        //return;
	} else {
     	colStr += ", phone_2";
        valueStr += ", '" + Edit4->Text + '\'';
    }
    dataStr += colStr + ") VALUES (" + valueStr + ");";

    ADOCommand1->CommandText = dataStr;
    ADOCommand1->Execute();

    FContr->Visible = false;
}
//---------------------------------------------------------------------------



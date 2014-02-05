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
TFCities *FCities;

void TFCities::CleanForm(){
	FCities->Edit1->Clear();
    FCities->Edit2->Clear();
}

//---------------------------------------------------------------------------
__fastcall TFCities::TFCities(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TFCities::BitBtn1Click(TObject *Sender)
{
	FCities->Visible = false;
}
//---------------------------------------------------------------------------
void __fastcall TFCities::BitBtn2Click(TObject *Sender)
{
	String dataStr = "INSERT INTO `cities` (";
    String colStr, valueStr = " '";

	if(Edit1->Text.IsEmpty()){
    	ShowMessage("������ ����� cities");
    	return;
    } else {
    	colStr = "`name`";
        valueStr += Edit1->Text  + '\'';
    }
    if(Edit2->Text.IsEmpty()){
    	ShowMessage("������ �������� ������");
        return;
	} else {
     	colStr += ", zip_code";
        valueStr += ", '" + Edit2->Text + '\'';
    }
    dataStr += colStr + ") VALUES (" + valueStr + ");";

    ADOCommand1->CommandText = dataStr;
    ADOCommand1->Execute();

    FCities->Visible = false;
}
//---------------------------------------------------------------------------
void __fastcall TFCities::FormHide(TObject *Sender)
{
	CleanForm();
}
//---------------------------------------------------------------------------





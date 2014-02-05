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
TFAddForwarder *FAddForwarder;

void TFAddForwarder::CleanForm(){
	FAddForwarder->Edit1->Clear();
    FAddForwarder->Edit2->Clear();
    FAddForwarder->Edit3->Clear();
    FAddForwarder->Edit4->Clear();
    FAddForwarder->Edit5->Clear();
}

//---------------------------------------------------------------------------
__fastcall TFAddForwarder::TFAddForwarder(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TFAddForwarder::BitBtn1Click(TObject *Sender)
{
	FAddForwarder->Visible = false;
}
//---------------------------------------------------------------------------
void __fastcall TFAddForwarder::FormHide(TObject *Sender)
{
	CleanForm();
}
//---------------------------------------------------------------------------
void __fastcall TFAddForwarder::BitBtn2Click(TObject *Sender)
{
	String dataStr = "INSERT INTO `forwarder` (";
    String colStr, valueStr = " '";

	if(Edit1->Text.IsEmpty()){
    	ShowMessage("¬вед≥ть пр≥звище");
    	return;
    } else {
    	colStr = "`name`";
        valueStr += Edit1->Text;
    }
    if(Edit2->Text.IsEmpty()){
    	ShowMessage("¬вед≥ть ≥м'€");
        return;
	} else {
     	//colStr += ", ≥м€";
        valueStr += " " + Edit2->Text;
    }
    if(Edit3->Text.IsEmpty()){
    	ShowMessage("¬вед≥ть по батьков≥");
        return;
    } else {
    	//colStr += ", по_батьков≥";
        valueStr += " " + Edit3->Text + '\'';
    }
    if(Edit4->Text.IsEmpty()){
    	ShowMessage("¬вед≥ть сер≥ю та є паспорта");
        return;
    } else {
    	colStr += ", code_є_passport";
        valueStr += ", '" + Edit4->Text + '\'';
    }
    if(Edit5->Text.IsEmpty()){
    	ShowMessage("¬вед≥ть сер≥ю та є посв≥дченн€ вод≥€");
        return;
    } else {
    	colStr += ", `code_є_driver_lice`";
        valueStr += ", '" + Edit5->Text + '\'';
    }
    if(Edit6->Text.IsEmpty()){
    	ShowMessage("¬вед≥ть посаду особи");
        return;
    } else {
    	colStr += ", job_title";
        valueStr += ", '" + Edit6->Text + '\'';
    }
    if(ComboBox1->Text.IsEmpty()){
    	ShowMessage("¬каж≥ть чи маЇ особа право п≥дпису");
        return;
    } else {
    	colStr += ", sign";
        valueStr += ", '" + ComboBox1->Text + '\'';
    }
    dataStr += colStr + ") VALUES (" + valueStr + ");";

    ADOCommand1->CommandText = dataStr;
    ADOCommand1->Execute();

    FAddForwarder->Visible = false;
}
//---------------------------------------------------------------------------
void __fastcall TFAddForwarder::FormCreate(TObject *Sender)
{
	ComboBox1->Items->Add("“ак");
    ComboBox1->Items->Add("Ќ≥");
    ComboBox1->ItemIndex = 1;
}
//---------------------------------------------------------------------------

void __fastcall TFAddForwarder::ComboBox1Change(TObject *Sender)
{
	//if(current_user != "root")return;
}
//---------------------------------------------------------------------------


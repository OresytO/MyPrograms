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
TFOutputDeli *FOutputDeli;
int Courier_id[100];
int Status_id[100];
int Contagent1_id[100];//sender
int Contagent2_id[100];//taker
int City1_id[100];//місце delivery
int City2_id[100];//місце одержання
/*Створення DropList'у з бази даних для відображення переліку перевізників
 *згідно визначеного запиту та збереження id в масиві*/
void ComboDropCur(TComboBox * ComObj, TADODataSet * DataSet, int * &Courier_id)
{
	String NameComp;
    int i = 0;

    DataSet->CommandText = "SELECT name_storage_number FROM `rebok2_db1`.`courier`;";
    DataSet->Open();

    ComObj->Clear();
    while (!DataSet->Eof){
        //Courier_id[i++] = QuerObj->FieldByName("courier_id")->AsInteger;
    	NameComp = DataSet->FieldByName("name_storage_number")->AsString;

		ComObj->Items->Add(NameComp);
		DataSet->Next();
	}
    //Courier_id[i++] = 0;
    CreatCombo(ComObj);
    DataSet->Close();
}
/*Створення DropList'у з бази даних згідно запиту та збереження id в масиві*/
void ComboDropList(TComboBox * ComObj, TADODataSet * DataSet, String SQLstr, int* & Array_id)
{
	int i = 0;
    DataSet->CommandText = SQLstr;
    DataSet->Open();

    ComObj->Clear();
    while (!DataSet->Eof){
    	Array_id[i++] = DataSet->Fields->FieldByNumber(1)->AsInteger;
        ComObj->Items->Add(DataSet->Fields->FieldByNumber(2)->AsString);
		DataSet->Next();
	}
    Array_id[i++] = 0;
    CreatCombo(ComObj);
    DataSet->Close();
}


//---------------------------------------------------------------------------
__fastcall TFOutputDeli::TFOutputDeli(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TFOutputDeli::FormClose(TObject *Sender, TCloseAction &Action)
{
	exit(1);
}
//---------------------------------------------------------------------------

void __fastcall TFOutputDeli::BBackClick(TObject *Sender)
{
	FOutputDeli->Visible = false;
    FStart->Visible = true;
}
//---------------------------------------------------------------------------
void __fastcall TFOutputDeli::BExitClick(TObject *Sender)
{
	Close();
}
//---------------------------------------------------------------------------
void __fastcall TFOutputDeli::BAddToDBClick(TObject *Sender)
{
    String dataStr = "INSERT INTO `rebok2_db1`.`delivery` (delivery_id";
    String colStr, valueStr = "'', '";

	if(!Edit1->Text.IsEmpty()){
    	colStr = ", declaration_number";
        valueStr += Edit1->Text  + '\'';
    } else {
    	//ShowMessage("Помилка  введення");
    	//return;
    }
    if(!ComboBox6->Text.IsEmpty()){
    	colStr += ", sender_place_id";
        valueStr += ", '" + IntToStr(City1_id[ComboBox6->ItemIndex])  + '\'';
    } else {
    	//ShowMessage("Помилка  введення");
    	//return;
    }
    if(!Edit3->Text.IsEmpty()){
    	colStr += ", delivery_cost";
        valueStr += ", '" + Edit3->Text  + '\'';
    } else {
    	//ShowMessage("Помилка  введення");
    	//return;
    }
    if(!Edit4->Text.IsEmpty()){
    	colStr += ", places";
        valueStr += ", '" + Edit4->Text  + '\'';
    } else {
    	//ShowMessage("Помилка  введення");
    	//return;
    }
    if(!ComboBox7->Text.IsEmpty()){
    	colStr += ", destionation_place_id";
        valueStr += ", '" + IntToStr(City2_id[ComboBox7->ItemIndex])  + '\'';
    } else {
    	//ShowMessage("Помилка  введення");
    	//return;
    }
    if(!Edit6->Text.IsEmpty()){
    	colStr += ", weight";
        valueStr += ", '" + Edit6->Text  + '\'';
    } else {
    	//ShowMessage("Помилка  введення");
    	//return;
    }
    if(!Edit7->Text.IsEmpty()){
    	colStr += ", size";
        valueStr += ", '" + Edit7->Text  + '\'';
    } else {
    	//ShowMessage("Помилка  введення");
    	//return;
    }
    if(!Edit8->Text.IsEmpty()){
    	colStr += ", contact_person";
        valueStr += ", '" + Edit8->Text  + '\'';
    } else {
    	//ShowMessage("Помилка  введення");
    	//return;
    }
    if(!DateTimePicker1->Date.DateString().IsEmpty()){
    	colStr += ", send_date";
        valueStr += ", '" + DateTimePicker1->Date.FormatString("YYYY.MM.DD") + '\'';
    } else {
    	//ShowMessage("Помилка  введення");
    	//return;
    }
    if(!DateTimePicker2->Date.DateString().IsEmpty()){
    	colStr += ", take_date";
        valueStr += ", '" + DateTimePicker2->Date.FormatString("YYYY.MM.DD") + '\'';
    } else {
    	//ShowMessage("Помилка  введення");
    	//return;
    }
    if(!ComboBox1->Text.IsEmpty()){
        colStr += ", courier_id";
        valueStr += ", '" + ComboBox1->Text + '\'';

    } else {
    	//ShowMessage("Помилка  введення");
    	//return;
    }
    if(!ComboBox3->Text.IsEmpty()){
    	colStr += ", taker_id";
    	valueStr += ", '" + IntToStr(Contagent1_id[ComboBox3->ItemIndex]) + '\'';
    } else {
    	//ShowMessage("Помилка  введення");
    	//return;
    }
    if(!ComboBox4->Text.IsEmpty()){
    	colStr += ", sender_id";
    	valueStr += ", '" + IntToStr(Contagent2_id[ComboBox4->ItemIndex]) + '\'';
    } else {
    	//ShowMessage("Помилка  введення");
    	//return;
    }
    if(!ComboBox5->Text.IsEmpty()){
    	colStr += ", status_id";
        valueStr += ", '" + IntToStr(Status_id[ComboBox5->ItemIndex]) + '\'';
    } else {
    	//ShowMessage("Помилка  введення");
    	//return;
    }
    if(Memo1->Lines->Count){
    	colStr += ", note";
        valueStr += ", '" + Memo1->Lines->Text + '\'';
    } else {
    	//ShowMessage("Помилка  введення");
    	//return;
    }
    dataStr += colStr + ", in_or_out) VALUES (" + valueStr + ", 'вихідна');";

    ADOCommand1->CommandText = dataStr;
    ADOCommand1->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TFOutputDeli::FormCreate(TObject *Sender)
{
    DateTimePicker1->Date = Now();
    DateTimePicker2->Date = Now();
}
//---------------------------------------------------------------------------
void __fastcall TFOutputDeli::ComboBox1Change(TObject *Sender)
{
	AddToList(ComboBox1, AddingCourier);
}
//---------------------------------------------------------------------------
void __fastcall TFOutputDeli::ComboBox1DropDown(TObject *Sender)
{
	ComboDropCur(ComboBox1, ADODataSet1, Courier_id);
}
//---------------------------------------------------------------------------
void __fastcall TFOutputDeli::ComboBox6DropDown(TObject *Sender)
{
	String SQLstr = "SELECT cities_id, `name` FROM `rebok2_db1`.`cities`;";
    ComboDropList(ComboBox6, ADODataSet1, SQLstr, City1_id);
}
//---------------------------------------------------------------------------

void __fastcall TFOutputDeli::ComboBox6Change(TObject *Sender)
{
	AddToList(ComboBox6, AddingCities);
}
//---------------------------------------------------------------------------

void __fastcall TFOutputDeli::ComboBox7DropDown(TObject *Sender)
{
	String SQLstr = "SELECT cities_id, `name` FROM `rebok2_db1`.`cities`;";
	ComboDropList(ComboBox7, ADODataSet1, SQLstr, City2_id);
}
//---------------------------------------------------------------------------

void __fastcall TFOutputDeli::ComboBox7Change(TObject *Sender)
{
	AddToList(ComboBox7, AddingCities);
}
//---------------------------------------------------------------------------

void __fastcall TFOutputDeli::ComboBox3DropDown(TObject *Sender)
{
	String SQLstr = "SELECT contragent_id, `name` FROM `rebok2_db1`.`contragent`;";
	ComboDropList(ComboBox3, ADODataSet1, SQLstr, Contagent1_id);
}
//---------------------------------------------------------------------------

void __fastcall TFOutputDeli::ComboBox3Change(TObject *Sender)
{
	AddToList(ComboBox3, AddingContr);
}
//---------------------------------------------------------------------------

void __fastcall TFOutputDeli::ComboBox4DropDown(TObject *Sender)
{
	String SQLstr = "SELECT contragent_id, `name` FROM `rebok2_db1`.`contragent`;";
	ComboDropList(ComboBox4, ADODataSet1, SQLstr, Contagent2_id);
}
//---------------------------------------------------------------------------

void __fastcall TFOutputDeli::ComboBox4Change(TObject *Sender)
{
	AddToList(ComboBox4, AddingContr);
}
//---------------------------------------------------------------------------

void __fastcall TFOutputDeli::ComboBox5DropDown(TObject *Sender)
{
	String SQLstr = "SELECT status_id, `status` FROM `rebok2_db1`.`status`;";
	ComboDropList(ComboBox5, ADODataSet1, SQLstr, Status_id);
}
//---------------------------------------------------------------------------


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
TFAddCourier *FAddCourier;

int Payment_id[100];

void TFAddCourier::CleanForm(){
	FAddCourier->Edit1->Clear();
    FAddCourier->Edit2->Clear();
    FAddCourier->Edit3->Clear();
    FAddCourier->Edit4->Clear();
    FAddCourier->Edit5->Clear();
    FAddCourier->Edit6->Clear();
    FAddCourier->ComboBox1->ItemIndex = 0;
    FAddCourier->ComboBox2->ItemIndex = 0;
}

//---------------------------------------------------------------------------
__fastcall TFAddCourier::TFAddCourier(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TFAddCourier::BitBtn1Click(TObject *Sender)
{
	FAddCourier->Visible = false;
}
//---------------------------------------------------------------------------
void __fastcall TFAddCourier::FormCreate(TObject *Sender)
{

	ComboBox1->Items->Add("���������� ����");
    ComboBox1->Items->Add("�������");
    ComboBox1->ItemIndex = 0;
    ComboBox2->ItemIndex = 1;
    /**/
}
//---------------------------------------------------------------------------
void __fastcall TFAddCourier::FormHide(TObject *Sender)
{
	CleanForm();
}
//---------------------------------------------------------------------------
void __fastcall TFAddCourier::ComboBox2DropDown(TObject *Sender)
{
	String SQLstr = "SELECT payment_id, payment FROM `payment`";
    ComboDropList(ComboBox2, ADODataSet1, SQLstr, Payment_id);
}
//---------------------------------------------------------------------------

void __fastcall TFAddCourier::BAddNewCourier2Click(TObject *Sender)
{
	//exit(1);
	String dataStr = "INSERT INTO `courier` (";
    String colStr, valueStr = " '";

	if(Edit1->Text.IsEmpty()){
    	ShowMessage("������ ����� ������");
    	return;
    } else {
    	colStr = "name_storage_number";
        valueStr += Edit1->Text;
    }
    if(Edit2->Text.IsEmpty()){
    	ShowMessage("������ � ������");
        return;
	} else {
     	//colStr += ", �_������";
        valueStr += " " + Edit2->Text + '\'';
    }
    if(Edit3->Text.IsEmpty()){
    	ShowMessage("������ ������ ������");
        return;
    } else {
    	colStr += ", adress";
        valueStr += ", '" + Edit3->Text + '\'';
    }
    if(Edit4->Text.IsEmpty()){
    	ShowMessage("������ � �������� ������");
        return;
    } else {
    	colStr += ", phone_1";
        valueStr += ", '" + Edit4->Text + '\'';
    }
    if(!Edit5->Text.IsEmpty()){
    	colStr += ", phone_2";
        valueStr += ", '" + Edit5->Text + '\'';
    }
    if(!Edit6->Text.IsEmpty()){
    	colStr += ", phone_3";
        valueStr += ", '" + Edit6->Text + '\'';
    }
    if(ComboBox1->Text.IsEmpty()){
    	ShowMessage("������ �� � ��� ������ ���������� ����������� �����");
        return;
    } else {
    	colStr += ", passport_for_id";
        valueStr += ", '" + ComboBox1->Text + '\'';
    }
    if(ComboBox2->Text.IsEmpty()){
    	ShowMessage("������� ��� ����������");
        return;
    } else {
        colStr += ", payment_id";
        valueStr += ", '" + IntToStr(Payment_id[ComboBox2->ItemIndex]) + '\'';
    }

    dataStr += colStr + ") VALUES (" + valueStr + ");";

    //Memo1->Lines->Add(dataStr);

    ADOCommand1->CommandText = dataStr;
    ADOCommand1->Execute();

    FAddCourier->Visible = false;
}
//---------------------------------------------------------------------------


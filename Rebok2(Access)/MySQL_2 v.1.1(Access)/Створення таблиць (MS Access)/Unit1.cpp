//---------------------------------------------------------------------------
#include <ComObj.hpp>
#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;

const int count = 8;

//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TForm1::BitBtn1Click(TObject *Sender)
{
	if(LabeledEdit1->Text.IsEmpty())return;

    if (!this->ADOConnection1->Connected)
	{
        this->ADOConnection1->ConnectionString = "Provider="
                "Microsoft.ACE.OLEDB.12.0;Data Source="
                //+ ExtractFilePath (Application->ExeName) + "DB_rebok2.accdb" //C:\Users\orecto\Desktop\test\DB_rebok2.accdb
                + LabeledEdit1->Text + "DB_rebok2.accdb"
                ";Persist Security Info = False";
        try
        {
            this->ADOConnection1->Open();                                                                              this->ADOConnection1->Open();
        }
        catch (EOleException& E)
        {
            ShowMessage ("�������: " + E.Message);
            return;
        }
	}


    String sql_str[count];
    sql_str[0] = "CREATE  TABLE `payment` ( ";
    sql_str[0] += "  `payment_id` AUTOINCREMENT PRIMARY KEY , ";
    sql_str[0] += "  `payment` TEXT(45) NULL); ";
    
    sql_str[1] = "CREATE  TABLE `courier` ( ";
    sql_str[1] += "  `name_storage_number` TEXT(30) NOT NULL , ";
    sql_str[1] += "  `adress` TEXT(60) NOT NULL , ";
    sql_str[1] += "  `phone_1` TEXT(15) NULL , ";
    sql_str[1] += "  `phone_2` TEXT(15) NULL , ";
    sql_str[1] += "  `phone_3` TEXT(15) NULL , ";
    sql_str[1] += "  `passport_for_id` TEXT(60) NOT NULL , ";
    sql_str[1] += "  `payment_id` Number NOT NULL) ;";
    
    sql_str[2] = "CREATE  TABLE `forwarder` ( ";
    sql_str[2] += "  `forwarder_id` AUTOINCREMENT PRIMARY KEY , ";
    sql_str[2] += "  `name` TEXT(50) NOT NULL , ";
    sql_str[2] += "  `code_�_passport` TEXT(100) NOT NULL , ";
    sql_str[2] += "  `code_�_driver_lice` TEXT(45) NOT NULL , ";
    sql_str[2] += "  `job_title` TEXT(60) NOT NULL , ";
    sql_str[2] += "  `sign` TEXT(3) NOT NULL) ;";

    sql_str[3] = "CREATE  TABLE `contragent` ( ";
    sql_str[3] += "  `contragent_id` AUTOINCREMENT PRIMARY KEY , ";
    sql_str[3] += "  `name` TEXT(45) NOT NULL , ";
    sql_str[3] += "  `adress` TEXT(45) NOT NULL , ";
    sql_str[3] += "  `phone_1` TEXT(45) NULL , ";
    sql_str[3] += "  `phone_2` TEXT(45) NULL) ;";

    sql_str[4] = "CREATE  TABLE `status` ( ";
    sql_str[4] += "  `status_id` AUTOINCREMENT PRIMARY KEY , ";
    sql_str[4] += "  `status` TEXT(45) NULL) ;";

    sql_str[5] = "CREATE  TABLE `cities` ( ";
    sql_str[5] += "  `cities_id` AUTOINCREMENT PRIMARY KEY , ";
    sql_str[5] += "  `name` TEXT(45) NOT NULL , ";
    sql_str[5] += "  `zip_code` TEXT(45) NULL ) ;";

    sql_str[6] = "CREATE  TABLE `power_of_attorney` ( ";
    sql_str[6] += "  `power_of_attorney_id` AUTOINCREMENT PRIMARY KEY , ";
    sql_str[6] += "  `power_of_attorney_date` DATETIME NOT NULL , ";
    sql_str[6] += "  `�_power_of_attorney` TEXT(20) NOT NULL , ";
    sql_str[6] += "  `sign_id` Number NOT NULL , ";
    sql_str[6] += "  `forwarder_id` Number NOT NULL) ;";

    sql_str[7] = "CREATE  TABLE `delivery` ( ";
    sql_str[7] += "  `delivery_id` AUTOINCREMENT PRIMARY KEY , ";
    sql_str[7] += "  `send_date` DATETIME NULL , ";
    sql_str[7] += "  `take_date` DATETIME NULL , ";
    sql_str[7] += "  `delivery_cost` DECIMAL(20,2) NULL , ";
    sql_str[7] += "  `places` Number NULL , ";
    sql_str[7] += "  `declaration_number` TEXT(20) NULL , ";
    sql_str[7] += "  `contact_person` TEXT(30) NULL , ";
    sql_str[7] += "  `note` TEXT(90) NULL , ";
    sql_str[7] += "  `weight` DECIMAL(15,2) NULL , ";
    sql_str[7] += "  `size` TEXT(30) NULL , ";
    sql_str[7] += "  `taker_id` Number NOT NULL , ";
    sql_str[7] += "  `sender_id` Number NOT NULL , ";
    sql_str[7] += "  `status_id` Number NOT NULL , ";
    sql_str[7] += "  `destionation_place_id` Number NOT NULL , ";
    sql_str[7] += "  `sender_place_id` Number NOT NULL , ";
    sql_str[7] += "  `power_of_attorney_id` Number NULL , ";
    sql_str[7] += "  `in_or_out` TEXT(45) NOT NULL , ";
    sql_str[7] += "  `courier_id` TEXT(30) NOT NULL ) ;";

    for(int i = 0; i < count; i++){
        ShowMessage(IntToStr(i));
    	ADOCommand1->CommandText = sql_str[i];
    	ADOCommand1->Execute();

    }

}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormCreate(TObject *Sender)
{
	LabeledEdit1->Text = ExtractFilePath (Application->ExeName);

    if (!this->ADOConnection1->Connected)
	{
        this->ADOConnection1->ConnectionString = "Provider="
                "Microsoft.ACE.OLEDB.12.0;Data Source="
                //+ ExtractFilePath (Application->ExeName) + "DB_rebok2.accdb" //C:\Users\orecto\Desktop\test\DB_rebok2.accdb
                + LabeledEdit1->Text + "DB_rebok2.accdb"
                ";Persist Security Info = False";
        this->ADOConnection1->LoginPrompt = false;
        try
        {
            this->ADOConnection1->Open();                                                                              this->ADOConnection1->Open();
        }
        catch (EOleException& E)
        {
            ShowMessage ("�������: " + E.Message);
            return;
        }
	}

}
//---------------------------------------------------------------------------
void __fastcall TForm1::BitBtn2Click(TObject *Sender)
{
	String sql_str[count];
    sql_str[0] = "DROP TABLE payment;";
    sql_str[1] = "DROP TABLE courier;";
    sql_str[2] = "DROP TABLE forwarder;";
    sql_str[3] = "DROP TABLE contragent;";
    sql_str[4] = "DROP TABLE status;";
    sql_str[5] = "DROP TABLE cities;";
    sql_str[6] = "DROP TABLE power_of_attorney;";
    sql_str[7] = "DROP TABLE delivery;";
	for(int i = 0; i < count; i++){
    	ADOCommand1->CommandText = sql_str[i];
    	ADOCommand1->Execute();
    }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::BitBtn3Click(TObject *Sender)
{
	String sql_str;
    sql_str = "INSERT INTO payment (payment) VALUES ('���������');";
	ADOCommand1->CommandText = sql_str;
    ADOCommand1->Execute();
    sql_str = "INSERT INTO payment (payment) VALUES ('������������');";
	ADOCommand1->CommandText = sql_str;
    ADOCommand1->Execute();

    sql_str = "INSERT INTO status (status) VALUES ('���');";
	ADOCommand1->CommandText = sql_str;
    ADOCommand1->Execute();
    sql_str = "INSERT INTO status (status) VALUES ('�');";
	ADOCommand1->CommandText = sql_str;
    ADOCommand1->Execute();
}
//---------------------------------------------------------------------------


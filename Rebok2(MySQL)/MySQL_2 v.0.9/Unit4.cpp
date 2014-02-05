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
#pragma link "Word_2K_SRVR"
#pragma resource "*.dfm"
TFShow *FShow;

int Forwarder_id[100];
int Sign_id[100];
bool forwarder_check = false, sign_check = false, select_check = false;

String FieldStr[11] = {	"����_��������",
						"����_���������",
    					"�������_�����������",
    					"�������_����",
    					"�������",
    					"����",
    					"���������",
    					"���������",
    					"������",
    					"���������",
    					"���_��������" };

void forwarder_checking(){
    if(FShow->ComboBox2->Text.IsEmpty()){
        MessageBox(0, "������ ����������� �� ������", "�������", MB_OK);
        FShow->ComboBox2->ItemIndex = -1;
    	forwarder_check = false;
        return;
    } else if(FShow->ComboBox2->Text == "������ �� ������"){
    	AddingForwarder();
        FShow->ComboBox2->ItemIndex = -1;
        forwarder_check = false;
        return;
    } else if(!select_check){
        if(FShow->ADODataSet1->IsEmpty()){
    		MessageBox(0, "������ ������", "�������", MB_OK);
    		select_check = false;
            FShow->ComboBox2->ItemIndex = -1;
        	return;
    	} else if(!FShow->DBGrid1->SelectedRows->Count){
        	MessageBox(0, "������ ������ ������ � ���������� ������", "�������", MB_OK);
        	FShow->ComboBox2->ItemIndex = -1;
    		select_check = false;
        	return;
    	}
    	select_check = true;
    }
    forwarder_check = true;
}

void sign_checking(){
    if(FShow->ComboBox3->Text == "������ �� ������"){
    	AddingForwarder();
        FShow->ComboBox3->ItemIndex = -1;
        sign_check = false;
        return;
    } else if(FShow->ComboBox3->Text.IsEmpty()){
        MessageBox(0, "������ �����, �� ������ ����������, �� ������", "�������", MB_OK);
        FShow->ComboBox3->ItemIndex = -1;
    	sign_check = false;
        return;
    }
    sign_check = true;
}

//---------------------------------------------------------------------------
__fastcall TFShow::TFShow(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TFShow::FormClose(TObject *Sender, TCloseAction &Action)
{
	exit(1);
}
//---------------------------------------------------------------------------

void __fastcall TFShow::FormCreate(TObject *Sender)
{
    /* Login details */
    String UserName = "root";//"user"; //"db_user_name";
    String PassWord = ""; //"db_pass_word";
    String Server = "Rebok2_DB";

    DBGrid1->Options = TDBGridOptions(DBGrid1->Options) >> dgEditing
    	<< dgRowSelect << dgMultiSelect << dgIndicator << dgTitles
        << dgColLines << dgRowLines << dgColumnResize;

    /* Connection String */
    /*
    String ConnString ="Provider=MSDASQL.1;";
    ConnString += "Persist Security Info=False;";
    ConnString += "User ID=%s;"; //user;";
    ConnString += "Data Source=%s;"; //Rebok2_DB;";
    ConnString += "Mode=ReadWrite;";
    ConnString += "Initial Catalog=rebok2_db1";
    */
    DateTimePicker1->Date = Now()-10;
    DateTimePicker2->Date = Now()+10;
    DateTimePicker3->Date = Now()-10;
    DateTimePicker4->Date = Now()+10;
}
//---------------------------------------------------------------------------
void __fastcall TFShow::BBackClick(TObject *Sender)
{
	FShow->Visible = false;
    FStart->Visible = true;
}
//---------------------------------------------------------------------------
void __fastcall TFShow::BExitClick(TObject *Sender)
{
    /*
	if(fStart){
    	vVarApp.OleProcedure("Quit");
    }
    /**/
	Close();
}
//---------------------------------------------------------------------------
void __fastcall TFShow::SelectionClick(TObject *Sender)
{
	String SQLStr;
    SQLStr = "SELECT * FROM `delivery_app` WHERE ";

    if(RadioButton1->Checked) SQLStr += " ������ = '��'  AND ";
    else if(RadioButton2->Checked) SQLStr += " ������ = '���'  AND ";

    if(RadioButton4->Checked) SQLStr += " ���_�������� = '������' AND ";
    else if(RadioButton5->Checked) SQLStr += " ���_�������� = '�������' AND ";

    if(DateTimePicker1->Date < DateTimePicker2->Date){
    	SQLStr += " ����_�������� >= '" + DateTimePicker1->Date.FormatString("YYYY.MM.DD");
    	SQLStr += "' AND ";
    	SQLStr += " ����_�������� <= '" + DateTimePicker2->Date.FormatString("YYYY.MM.DD");
    }
    else{
    	ShowMessage("������� ������� ����. ���� '�' �� ���� ������� �� ���� '��'!!!");
    	return;
    }

    if(DateTimePicker3->Date < DateTimePicker4->Date){
    	SQLStr += "' AND ����_��������� >= '" + DateTimePicker3->Date.FormatString("YYYY.MM.DD");
    	SQLStr += "' AND ";
    	SQLStr += " ����_��������� <= '" + DateTimePicker4->Date.FormatString("YYYY.MM.DD");
    }
    else{
    	ShowMessage("������� ������� ����. ���� '�' �� ���� ������� �� ���� '��'!!!");
    	return;
    }
    SQLStr += "';";

    ADODataSet1->Close();
    ADODataSet1->CommandText = SQLStr;
    ADODataSet1->Open();
}
//---------------------------------------------------------------------------

void __fastcall TFShow::ComboBox2Change(TObject *Sender)
{
	forwarder_checking();
    if(!forwarder_check) return;
    else {
    	String SQLStr;

    	SQLStr = "DROP VIEW IF EXISTS `sel_deliv`; ";
    	ADOCommand1->CommandText = SQLStr;
    	ADOCommand1->Execute();

    	SQLStr = "CREATE VIEW `sel_deliv` AS ";
    	SQLStr += "SELECT * FROM `delivery_app` WHERE id IN (";

        int count = DBGrid1->SelectedRows->Count;
        DataSource1->DataSet->First();
	 	DataSource1->DataSet->DisableControls();

	 	while(!DataSource1->DataSet->Eof)
	 	{
	 		if(DBGrid1->SelectedRows->CurrentRowSelected){
	        	SQLStr += ADODataSet1->FieldByName("id")->AsString;
                if(--count)SQLStr += ", ";
            	else SQLStr += ");";
	        }
	  		DataSource1->DataSet->Next();
	 	}
	 	DataSource1->DataSet->EnableControls();

        ADOCommand1->CommandText = SQLStr;
    	ADOCommand1->Execute();

        ADODataSet3->Close();
    	ADODataSet3->CommandText = "SELECT * FROM `sel_deliv`;";
    	ADODataSet3->Open();
    }
}
//---------------------------------------------------------------------------

void __fastcall TFShow::ComboBox2DropDown(TObject *Sender)
{
    String SQLstr = "SELECT forwarder_id, `name` FROM `rebok2_db1`.`forwarder`;";
	ComboDropList(ComboBox2, ADODataSet2, SQLstr, Forwarder_id);
}
//---------------------------------------------------------------------------

void __fastcall TFShow::ComboBox3DropDown(TObject *Sender)
{
    String SQLstr = "SELECT forwarder_id, `name` FROM `rebok2_db1`.`forwarder` WHERE sign = '���';";
    ComboDropList(ComboBox3, ADODataSet5, SQLstr, Sign_id);
}
//---------------------------------------------------------------------------

void __fastcall TFShow::ComboBox3Change(TObject *Sender)
{
    sign_checking();
}
//---------------------------------------------------------------------------

void __fastcall TFShow::BPrint_documentsClick(TObject *Sender)
{
    if(!forwarder_check){
    	forwarder_checking();
        return;
    } else if(!sign_check){
    	sign_checking();
        return;
    }

    Variant vVarApp, vVarDocs, vVarDoc, vVarParagraphs, vVarParagraph,
    		vVarBookmark, Selection, vVarCell, vVarTable, vVarRange;
    String SQLStr;
    int courier_count, recCount;
    const int bkCount = 10;
    AnsiString Text[bkCount], path;
    AnsiString BookmarkNames[bkCount] = {	"������_������_����������",
    										"��������_������_����������",
                                			"���_���������_�������_�����",
                                			"�����_����������_��_�����_������",
                                			"����_���������_���������",
                                			"�����_���������",
                                			"������_�����_��_��������_��������",
                                			"�����_��_��������_��������",
                                			"ϲ�", //"���",
                                			"����_��_�����_����������_�����"};

    SQLStr = "SELECT COUNT(DISTINCT ���������) courier_count FROM `sel_deliv`;";
    ADODataSet4->Close();
    ADODataSet4->CommandText = SQLStr;
    ADODataSet4->Open();

    courier_count = ADODataSet4->Fields->FieldByNumber(1)->AsInteger;

    SQLStr = "DROP VIEW IF EXISTS `sel_courier_list`; ";
    ADOCommand1->CommandText = SQLStr;
    ADOCommand1->Execute();

    SQLStr = "CREATE VIEW `sel_courier_list` AS ";
    SQLStr += "SELECT c.adress, c.name_storage_number, ";
    SQLStr += "concat_ws(' ', c.phone_1, c.phone_2, c.phone_3) phone, c.passport_for_id ";
    SQLStr += "FROM courier c ";
    SQLStr += "NATURAL JOIN sel_deliv  sl ";
    SQLStr += "WHERE sl.��������� = c.name_storage_number ";
    SQLStr += "GROUP BY c.adress; ";
    ADOCommand1->CommandText = SQLStr;
    ADOCommand1->Execute();

    //if(!fStart){
    try{
    	vVarApp = CreateOleObject("Word.Application");
        //fStart = true;
    }catch(...){
    	MessageBox(0, "������� ������� Word", "�������", MB_OK);
        return;
    }
    vVarApp.OlePropertySet("Visible", true);
    //�������� ����������
  	vVarApp.OlePropertyGet("Options").OlePropertySet("CheckGrammarAsYouType",false);
  	vVarApp.OlePropertyGet("Options").OlePropertySet("CheckGrammarWithSpelling",false);

    for(int i = 0; i < courier_count; i++){
    	SQLStr = "SELECT * FROM `sel_courier_list` LIMIT " + IntToStr(i) + ", 1; ";
       	ADODataSet4->Close();
   		ADODataSet4->CommandText = SQLStr;
   		ADODataSet4->Open();

        Text[0] = ADODataSet4->Fields->FieldByName("adress")->AsString;
        Text[1] = ADODataSet4->Fields->FieldByName("phone")->AsString;
        Text[2] = ADODataSet4->Fields->FieldByName("passport_for_id")->AsString;
        Text[3] = ADODataSet4->Fields->FieldByName("name_storage_number")->AsString;
        Text[4] = Now().CurrentDate().FormatString("YYYY.MM.DD");

        SQLStr = "SELECT MAX(�_power_of_attorney + 1) new_� FROM `power_of_attorney`;";
        ADODataSet4->Close();
        ADODataSet4->CommandText = SQLStr;
        ADODataSet4->Open();
        Text[5] = ADODataSet4->Fields->FieldByName("new_�")->AsString;

        SQLStr = "SELECT job_title, `name` FROM `forwarder` WHERE forwarder_id = " + IntToStr(Sign_id[ComboBox3->ItemIndex]) + " ;";
        ADODataSet4->Close();
        ADODataSet4->CommandText = SQLStr;
        ADODataSet4->Open();
        Text[6] = ADODataSet4->Fields->FieldByName("job_title")->AsString;
        Text[7] = ADODataSet4->Fields->FieldByName("name")->AsString;

        AnsiString id[2]={"�������", "���������� ����"};
        if(Text[2] == id[0])SQLStr = "SELECT code_�_passport document, ";
        else if(Text[2] == id[1]) SQLStr = "SELECT code_�_driver_lice document, ";
        else{
        	MessageBox(0, "������� ������ ���������, �� ��������� �����", "�������", MB_OK);
            return;
        }
        SQLStr += "`name` FROM `forwarder` WHERE forwarder_id = " + IntToStr(Forwarder_id[ComboBox2->ItemIndex]) + " ;";
        ADODataSet4->Close();
        ADODataSet4->CommandText = SQLStr;
        ADODataSet4->Open();
        Text[8] = ADODataSet4->Fields->FieldByName("name")->AsString;
        Text[9] = ADODataSet4->Fields->FieldByName("document")->AsString;

        vVarDocs = vVarApp.OlePropertyGet("Documents");
        path = ExtractFilePath(Application->ExeName) + "\Templat.dot";
    	vVarDocs.OleProcedure("Add", path.c_str(), false, 0);
        vVarDoc = vVarDocs.OleFunction("Item", 1);// ������� ��� "ActiveDocument"
        Selection = vVarApp.OlePropertyGet("Selection");
        for(int i = 0; i < bkCount; i++){
        	Selection.OleFunction("GoTo", 4294967295, 0, 0, BookmarkNames[i].c_str());
            //4294967295 �������� wdGoToBookmark �� MSWORD.IDL

            //������ �������� �� ������� Word �������������� �������� ��������
            Selection.OlePropertySet("Text", Text[i].c_str());
        }
        /**/
        //ĳ������� ������ �������� �� �������� ������� �� ������ ����������
        SQLStr = "SELECT �������_����,  �_����������, ����_��������� FROM sel_deliv WHERE ��������� = \"" + Text[3] + "\";";
        ADODataSet4->Close();
        ADODataSet4->CommandText = SQLStr;
        ADODataSet4->Open();

        recCount = ADODataSet4->RecordCount;
        vVarTable = vVarDoc.OlePropertyGet("Tables").OleFunction("Item", 2);
        //��������� ������
  		Variant v = vVarTable.OlePropertyGet("Rows").OleFunction("Item", 2).OleFunction("Select");
        if(recCount > 1)
        	vVarApp.OlePropertyGet("Selection").OleProcedure("InsertRowsBelow", recCount - 1);
        /**/

        //���������� ������� � Word
        for(int i = 2; i < recCount + 2; i++){

            // �������� ����� ������
        	vVarCell = vVarTable.OleFunction("Cell", i, 1); // x �� y �� ���������� ������
        	// ������� ������ � ������� ������ �������
            vVarCell.OlePropertyGet("Range").OlePropertySet("Text", IntToStr(i - 1).c_str());

            // �������� ����� ������
        	vVarCell = vVarTable.OleFunction("Cell", i, 2); // x �� y �� ���������� ������
        	// ������� ������ � ������� ������ �������
            SQLStr = ADODataSet4->Fields->FieldByName("�_����������")->AsString;
            vVarCell.OlePropertyGet("Range").OlePropertySet("Text", SQLStr.c_str());

            // �������� ����� ������
        	vVarCell = vVarTable.OleFunction("Cell", i, 3); // x �� y �� ���������� ������
        	// ������� ������ � ������� ������ �������
            SQLStr = ADODataSet4->Fields->FieldByName("����_���������")->AsString;
            vVarCell.OlePropertyGet("Range").OlePropertySet("Text", SQLStr.c_str());

            // �������� ����� ������
        	vVarCell = vVarTable.OleFunction("Cell", i, 4); // x �� y �� ���������� ������
        	// ������� ������ � ������� ������ �������
            SQLStr = ADODataSet4->Fields->FieldByName("�������_����")->AsString;
            vVarCell.OlePropertyGet("Range").OlePropertySet("Text", SQLStr.c_str());
            /**/
            ADODataSet4->Next();
        }

        //vVarTable.OlePropertyGet("Columns").OleFunction("Select");
        //v = vVarApp.OlePropertyGet("Selection").OlePropertyGet("Font");
  		//v.OlePropertySet("Size",8);
  		//v.OlePropertySet("Name","Century Gothic");
        /**/
        //������������ ���� ���������� �� ����� ������ ���������
        path = "D:\\MySQL_2\\declar_" + Text[5] + ".doc";

        //vVarDoc.OleProcedure("SaveAs", path.c_str()); // , true
        /*
        //������� ��������� ���������
        //���������� ��������  �������
		//vVarApp.OlePropertySet("ActivePrinter","Epson LQ-100 ESC/P 2 on LPT1:");
        str = Printer()->Printers->Text ;
        vVarApp.OlePropertySet("ActivePrinter","Epson LQ-100 ESC/P 2 on LPT1:");
        /**/
        //�������� ��������� Word
        //vVarDocs.OleProcedure("Close"); // , path.c_str()

        //��������� � ������� power_of_attorney ������ ������
        SQLStr = "INSERT INTO `power_of_attorney` (power_of_attorney_id, ";
        SQLStr += "power_of_attorney_date, �_power_of_attorney, ";
        SQLStr += "sign_id, forwarder_id) VALUES ('', '";
        SQLStr += Text[4] + "', '";
        SQLStr += Text[5] + "', ";
        SQLStr += IntToStr(Sign_id[ComboBox3->ItemIndex]) + ", ";
        SQLStr += IntToStr(Forwarder_id[ComboBox2->ItemIndex]) + ");";
        ADOCommand1->CommandText = SQLStr;
        ADOCommand1->Execute();
    }

    //vVarApp.OleProcedure("Quit");
}
//---------------------------------------------------------------------------

void __fastcall TFShow::BitBtn2Click(TObject *Sender)
{
    //������� ��������� ���������
    //���������� ��������  �������
    //vVarApp.OlePropertySet("ActivePrinter","Epson LQ-100 ESC/P 2 on LPT1:");
    Label6->Caption = Printer()->Printers->Text;
    PrintDialog1->Execute();
    //Label6->Caption = PrintDialog1->;
    //vVarApp.OlePropertySet("ActivePrinter","Epson LQ-100 ESC/P 2 on LPT1:");
}
//---------------------------------------------------------------------------




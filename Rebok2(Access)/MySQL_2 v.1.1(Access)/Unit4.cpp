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

String strSelSQL;
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
        MessageBox(0, "������ �����, �� ������ ���������, �� ������", "�������", MB_OK);
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
	Close();
}
//---------------------------------------------------------------------------
void __fastcall TFShow::SelectionClick(TObject *Sender)
{
	String SQLStr;
    //��������� ������ �� ���� ����� � �� ����� � ������� ��������� ������������
    SQLStr = "SELECT * FROM `delivery_app` WHERE ";

    if(RadioButton1->Checked) SQLStr += " ������ = '�'  AND ";
    else if(RadioButton2->Checked) SQLStr += " ������ = '���'  AND ";

    if(RadioButton4->Checked) SQLStr += " ���_�������� = '������' AND ";
    else if(RadioButton5->Checked) SQLStr += " ���_�������� = '�������' AND ";

    if(DateTimePicker1->Date < DateTimePicker2->Date){
    	SQLStr += " ����_�������� >= #" + DateTimePicker1->Date.FormatString("YYYY-MM-DD");
    	SQLStr += "# AND ";
    	SQLStr += " ����_�������� <= #" + DateTimePicker2->Date.FormatString("YYYY-MM-DD");
    }
    else{
    	ShowMessage("������� ������� ����. ���� '�' �� ���� ������� �� ���� '��'!!!");
    	return;
    }

    if(DateTimePicker3->Date < DateTimePicker4->Date){
    	SQLStr += "# AND ����_��������� >= #" + DateTimePicker3->Date.FormatString("YYYY-MM-DD");
    	SQLStr += "# AND ";
    	SQLStr += " ����_��������� <= #" + DateTimePicker4->Date.FormatString("YYYY-MM-DD");
    }
    else{
    	ShowMessage("������� ������� ����. ���� '�' �� ���� ������� �� ���� '��'!!!");
    	return;
    }
    SQLStr += "#;";

    ADODataSet1->Close();
    ADODataSet1->CommandText = SQLStr;
    ADODataSet1->Open();
}
//---------------------------------------------------------------------------

void __fastcall TFShow::ComboBox2Change(TObject *Sender)
{
	//��������
	forwarder_checking();
    if(!forwarder_check) return;
    else {
    	strSelSQL = "SELECT * FROM `delivery_app` WHERE id IN (";

        int count = DBGrid1->SelectedRows->Count;
        DataSource1->DataSet->First();
	 	DataSource1->DataSet->DisableControls();

	 	while(!DataSource1->DataSet->Eof)
	 	{
	 		if(DBGrid1->SelectedRows->CurrentRowSelected){
	        	strSelSQL += ADODataSet1->FieldByName("id")->AsString;
                if(--count)strSelSQL += ", ";
            	else strSelSQL += ")";
	        }
	  		DataSource1->DataSet->Next();
	 	}
	 	DataSource1->DataSet->EnableControls();

        //������ ����� �� ������������ ��������������
        ADODataSet3->Close();
    	ADODataSet3->CommandText = strSelSQL;
    	ADODataSet3->Open();
    }
}
//---------------------------------------------------------------------------

void __fastcall TFShow::ComboBox2DropDown(TObject *Sender)
{
    String SQLstr = "SELECT forwarder_id, `name` FROM `forwarder`;";
	ComboDropList(ComboBox2, ADODataSet2, SQLstr, Forwarder_id);
}
//---------------------------------------------------------------------------

void __fastcall TFShow::ComboBox3DropDown(TObject *Sender)
{
    String SQLstr = "SELECT forwarder_id, `name` FROM `forwarder` WHERE sign = '���';";
    ComboDropList(ComboBox3, ADODataSet2, SQLstr, Sign_id);
}
//---------------------------------------------------------------------------

void __fastcall TFShow::ComboBox3Change(TObject *Sender)
{
    sign_checking();
}
//---------------------------------------------------------------------------

void __fastcall TFShow::BPrint_documentsClick(TObject *Sender)
{
	//��������
    if(!forwarder_check){
    	forwarder_checking();
        return;
    } else if(!sign_check){
    	sign_checking();
        return;
    }
    //���������� ������
    Variant vVarApp, vVarDocs, vVarDoc, vVarParagraphs, vVarParagraph,
    		vVarBookmark, Selection, vVarCell, vVarTable, vVarRange;
    String SQLStr;
    int courier_count, recCount;
    const int bkCount = 10;
    AnsiString Text[bkCount];
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

    //ĳ������� ������ ����� ����������
    SQLStr = "SELECT DISTINCT ��������� FROM (" + strSelSQL + ");";
    ADODataSet4->Close();
    ADODataSet4->CommandText = SQLStr;
    ADODataSet4->Open();
    courier_count = ADODataSet4->RecordCount;

    //��������� Word
    //if(!fStart){
    try{
    	vVarApp = CreateOleObject("Word.Application");
        //fStart = true;
    }catch(...){
    	MessageBox(0, "������� ������� Word", "�������", MB_OK);
        return;
    }
    //������������ �������� ���������
    vVarApp.OlePropertySet("Visible", false);
    //�������� �������� ����������
  	vVarApp.OlePropertyGet("Options").OlePropertySet("CheckGrammarAsYouType",false);
  	vVarApp.OlePropertyGet("Options").OlePropertySet("CheckGrammarWithSpelling",false);

    //������������ ���������  ��������
    //vVarApp.OlePropertySet("ActivePrinter","Epson LQ-100 ESC/P 2 on LPT1:");
    char 	prin_device[255] = {'\0'},
    		prin_driver[255] = {'\0'},
            prin_port[255] = {'\0'};
    THandle prin_handle;
    if(PrintDialog1->Execute()){
    	Printer()->GetPrinter(prin_device, prin_driver, prin_port, prin_handle);
    } else {
    	return;
    }
    String str = prin_device;
    str += " on ";
    str += prin_port;
    vVarApp.OlePropertySet("ActivePrinter", str.c_str());

    //--------------------------------------------------------------------------
    /*������ �� �� ��� ����ղ��� �������ֲ� ���
    �����Ͳ ²������� �� ������� � ����²���ʲ�*/
    //�������� ��������� ���������� ��� ��������� � ��
    String sel_courier_list;
    sel_courier_list = "SELECT DISTINCT c.adress, c.name_storage_number, ";
    sel_courier_list += "c.phone_1 &\" \"& c.phone_2 &\" \"& c.phone_3 AS phone, c.passport_for_id ";
    sel_courier_list += "FROM courier AS c ";
    sel_courier_list += "INNER JOIN (" + strSelSQL + ") AS sl ";
    sel_courier_list += "ON sl.��������� = c.name_storage_number ";
    ADODataSet5->Close();
    ADODataSet5->CommandText = sel_courier_list;
    ADODataSet5->Open();

    for(int i = 0; i < courier_count; i++){
        Text[0] = ADODataSet5->Fields->FieldByName("adress")->AsString;
        Text[1] = ADODataSet5->Fields->FieldByName("phone")->AsString;
        Text[2] = ADODataSet5->Fields->FieldByName("passport_for_id")->AsString;
        Text[3] = ADODataSet5->Fields->FieldByName("name_storage_number")->AsString;
        Text[4] = Now().CurrentDate().FormatString("YYYY.MM.DD");
        ADODataSet5->Next();
        //ĳ������� ����� ����� ���������
        SQLStr = "SELECT MAX(�_power_of_attorney) AS new_� FROM `power_of_attorney`;";
        ADODataSet4->Close();
        ADODataSet4->CommandText = SQLStr;
        ADODataSet4->Open();

        //��� ������� ���� � ��� ���� ����
        if(ADODataSet4->Fields->FieldByName("new_�")->IsNull) Text[5] = "1";
        else Text[5] = IntToStr(ADODataSet4->FieldByName("new_�")->AsInteger + 1);

        //�������� ��������� ���������� ��� �����, �� �������� �������� � ��
        SQLStr = "SELECT job_title, `name` FROM `forwarder` WHERE forwarder_id = "
        		+ IntToStr(Sign_id[ComboBox3->ItemIndex]) + " ;";
        ADODataSet4->Close();
        ADODataSet4->CommandText = SQLStr;
        ADODataSet4->Open();
        Text[6] = ADODataSet4->Fields->FieldByName("job_title")->AsString;
        Text[7] = ADODataSet4->Fields->FieldByName("name")->AsString;

        //�������� ��������� ���������� ��� ����������� � ��
        AnsiString id[2]={"�������", "���������� ����"};
        if(Text[2] == id[0])SQLStr = "SELECT code_�_passport AS document, ";
        else if(Text[2] == id[1]) SQLStr = "SELECT code_�_driver_lice AS document, ";
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

        //----------------------------------------------------------------------
        /*������ � ���������� WORD*/
        vVarDocs = vVarApp.OlePropertyGet("Documents");
        //��������� �������� ����� �������
    	vVarDocs.OleProcedure("Add", path_temp.c_str(), false, 0);
        //�������� �� ��������� ����������
        vVarDoc = vVarDocs.OleFunction("Item", 1);// ������� ��� "ActiveDocument"
        Selection = vVarApp.OlePropertyGet("Selection");
        //����� �������� �� ������� Word �������������� �������� ��������
        for(int i = 0; i < bkCount; i++){
        	Selection.OleFunction("GoTo", 4294967295, 0, 0, BookmarkNames[i].c_str());
            //4294967295 �������� wdGoToBookmark �� MSWORD.IDL
            Selection.OlePropertySet("Text", Text[i].c_str());
        }
        //ĳ������� ������ �������� �� �������� ������� �� ������ ����������
        SQLStr = "SELECT �������_����,  �_����������, ����_��������� FROM (" + strSelSQL + ") WHERE ��������� = \"" + Text[3] + "\";";
        ADODataSet4->Close();
        ADODataSet4->CommandText = SQLStr;
        ADODataSet4->Open();
        //ĳ������� ������� ������ DataSet-�
        recCount = ADODataSet4->RecordCount;
        //�������� �� 1 ��������
        vVarTable = vVarDoc.OlePropertyGet("Tables").OleFunction("Item", 1);
        //������ ��� ����������� ����� �� �������
  		Variant v = vVarTable.OlePropertyGet("Rows").OleFunction("Item", 2).OleFunction("Select");
        /*���� ������� ������ ����� �� 1 ��� ���������� �����
         ������� ������� ����� */
        if(recCount > 1)
        	vVarApp.OlePropertyGet("Selection").OleProcedure("InsertRowsBelow", recCount - 1);
        /**/
        //���������� ������� � Word
        for(int i = 2; i < recCount + 2; i++){
            // �������� ����� ������
        	vVarCell = vVarTable.OleFunction("Cell", i, 1); // x �� y �� ���������� ������
        	// ������� ������ � ������� ������ �������
            vVarCell.OlePropertyGet("Range").OlePropertySet("Text", IntToStr(i - 1).c_str());

        	vVarCell = vVarTable.OleFunction("Cell", i, 2);
            SQLStr = ADODataSet4->Fields->FieldByName("�_����������")->AsString;
            vVarCell.OlePropertyGet("Range").OlePropertySet("Text", SQLStr.c_str());

        	vVarCell = vVarTable.OleFunction("Cell", i, 3);
            SQLStr = ADODataSet4->Fields->FieldByName("����_���������")->AsString;
            vVarCell.OlePropertyGet("Range").OlePropertySet("Text", SQLStr.c_str());

        	vVarCell = vVarTable.OleFunction("Cell", i, 4);
            SQLStr = ADODataSet4->Fields->FieldByName("�������_����")->AsString;
            vVarCell.OlePropertyGet("Range").OlePropertySet("Text", SQLStr.c_str());
            /**/
            ADODataSet4->Next();
        }

        //���������� ��������� �� �������� ������
        vVarDoc.OleProcedure("SaveAs", (path_save + Text[5] + ".doc").c_str()); // , true
        //������� ��������� ���������
        vVarDoc.OleFunction("PrintOut", 0);
        //�������� ��������� Word
        vVarDoc.OleProcedure("Close"); // , path.c_str()

        //----------------------------------------------------------------------
        /*��������� � ������� power_of_attorney ������ ������*/
        SQLStr = "INSERT INTO `power_of_attorney` (";
        SQLStr += "power_of_attorney_date, �_power_of_attorney, ";
        SQLStr += "sign_id, forwarder_id) VALUES ('";
        SQLStr += Text[4] + "', '";
        SQLStr += Text[5] + "', ";
        SQLStr += IntToStr(Sign_id[ComboBox3->ItemIndex]) + ", ";
        SQLStr += IntToStr(Forwarder_id[ComboBox2->ItemIndex]) + ");";
        ADOCommand1->CommandText = SQLStr;
        ADOCommand1->Execute();
    }

    //--------------------------------------------------------------------------
    /*������� �������� �������� ��������, ���� �������*/
    if(CheckBox1->Checked){
    	//ĳ������� ������ � ����� �� �������� �����
    	int rows = ADODataSet3->RecordCount;
    	int columns = ADODataSet3->FieldCount;
        //��������� ����� ��������
    	vVarDocs.OleProcedure("Add");
        //�������� �� ��������� ����������
        vVarDoc = vVarDocs.OleFunction("Item", 1);
        //������������ �������� �������� �������
        vVarDoc.OlePropertyGet("PageSetup").OlePropertySet("Orientation", 1);

        vVarParagraphs = vVarDoc.OlePropertyGet("Paragraphs");
        //��������� ��������� ��� ϲ� �����������
        vVarParagraphs.OleProcedure("Add");
        vVarParagraph = vVarParagraphs.OleFunction("Item", 1);
        vVarParagraph.OlePropertyGet("Range").OlePropertySet("Text",("���������� -> " + Text[8]).c_str());

        //��������� ��������� ��� �������
        vVarParagraphs.OleProcedure("Add");
        vVarParagraph = vVarParagraphs.OleFunction("Item", 2);
        vVarRange = vVarParagraph.OlePropertyGet("Range");
        //������ �� ��������� ��������� �������
        vVarDoc.OlePropertyGet("Tables").
        	OleProcedure("Add", vVarRange, rows + 1, columns + 1, 1, 2);
        //�������� �� ������� ��������
        vVarTable = vVarDoc.OlePropertyGet("Tables").OleFunction("Item", 1);
        //vVarTable.OleFunction("AutoFormat", 25);

        //���������� ��������� ������� ������� ���� � DataSet-�
        for(int i = 1; i <= columns; i++){
        	//���� ������ ������� �����
        	vVarCell = vVarTable.OleFunction("Cell", 1, i);
            //��������� ����� ��������� ����
            SQLStr = ADODataSet3->FieldDefList->Strings[i - 1];
            //��������� '_' ����������, ��� Word ��������� ����� ��������
            int delim = SQLStr.LastDelimiter("_");
            if(delim)SQLStr[delim] = ' ';
            //������� � ������� ������ ������������ ������
            vVarCell.OlePropertyGet("Range").OlePropertySet("Text", SQLStr.c_str());
        }
        //������� ������� ��� ������
        vVarCell = vVarTable.OleFunction("Cell", 1, columns + 1);
        vVarCell.OlePropertyGet("Range").OlePropertySet("Text", "³��.");
        //���������� ������� ���������� � DataSet-�
        for(int i = 2; i <= rows + 1; i++){
        	for(int j = 1; j <= columns; j++){
            	//�������� ������
	        	vVarCell = vVarTable.OleFunction("Cell", i, j);
                //������ � DataSet-� ����������
            	SQLStr = ADODataSet3->Fields->FieldByNumber(j)->AsString;
                //���������� ���������� ����� � ������
            	vVarCell.OlePropertyGet("Range").OlePropertySet("Text", SQLStr.c_str());
            }
            //���������� �� ��������� ����� DataSet-�
            ADODataSet3->Next();
    	}
        //��������� ���� ����� �������
        Variant v;
        vVarTable.OlePropertyGet("Columns").OleFunction("Select");
        v = vVarApp.OlePropertyGet("Selection").OlePropertyGet("Font");
  		v.OlePropertySet("Size", 10);
  		v.OlePropertySet("Name", "Times New Roman");

        //���� �� ���� ��������
        //int Bounds[2] = {0, -1};
		//vVarDoc.OleFunction("PrintOut", VarArrayCreate(Bounds, 1, varVariant));
        vVarDoc.OleFunction("PrintOut", 0);
        //��������� �������� ��� ����������
        vVarDoc.OleProcedure("Close", 0);//0 - wdDoNotSaveChanges
    }
    //��������� Word
    vVarApp.OleProcedure("Quit");
}
//---------------------------------------------------------------------------


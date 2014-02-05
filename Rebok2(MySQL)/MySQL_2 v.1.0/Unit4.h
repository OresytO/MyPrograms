//---------------------------------------------------------------------------

#ifndef Unit4H
#define Unit4H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ADODB.hpp>
#include <DB.hpp>
#include <DBGrids.hpp>
#include <Grids.hpp>
#include <DBCtrls.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <DBTables.hpp>
#include <ExtCtrls.hpp>
#include <CheckLst.hpp>

#include "Word_2K_SRVR.h"
#include <OleServer.hpp>
#include <ComObj.hpp>
#include <utilcls.h>
#include <Dialogs.hpp>
//---------------------------------------------------------------------------
class TFShow : public TForm
{
__published:	// IDE-managed Components
	TDBGrid *DBGrid1;
	TBitBtn *BBack;
	TBitBtn *Selection;
	TBitBtn *BExit;
	TComboBox *ComboBox2;
	TGroupBox *GroupBox1;
	TRadioButton *RadioButton1;
	TRadioButton *RadioButton3;
	TGroupBox *GroupBox2;
	TRadioButton *RadioButton4;
	TRadioButton *RadioButton5;
	TRadioButton *RadioButton6;
	TRadioButton *RadioButton2;
	TADODataSet *ADODataSet1;
	TADOCommand *ADOCommand1;
	TDataSource *DataSource1;
	TGroupBox *GroupBox3;
	TDateTimePicker *DateTimePicker1;
	TDateTimePicker *DateTimePicker2;
	TGroupBox *GroupBox4;
	TDateTimePicker *DateTimePicker3;
	TDateTimePicker *DateTimePicker4;
	TLabel *Label1;
	TLabel *Label2;
	TLabel *Label3;
	TLabel *Label4;
	TLabel *Label6;
	TBitBtn *BPrint_documents;
	TADODataSet *ADODataSet2;
	TADODataSet *ADODataSet3;
	TDBGrid *DBGrid2;
	TDataSource *DataSource2;
	TDataSource *DataSource3;
	TADODataSet *ADODataSet4;
	TComboBox *ComboBox3;
	TADODataSet *ADODataSet5;
	TPrintDialog *PrintDialog1;
	TCheckBox *CheckBox1;
	void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall BBackClick(TObject *Sender);
	void __fastcall BExitClick(TObject *Sender);
	void __fastcall SelectionClick(TObject *Sender);
	void __fastcall ComboBox2Change(TObject *Sender);
	void __fastcall ComboBox2DropDown(TObject *Sender);
	void __fastcall BPrint_documentsClick(TObject *Sender);
	void __fastcall ComboBox3DropDown(TObject *Sender);
	void __fastcall ComboBox3Change(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TFShow(TComponent* Owner);
};

bool checking();

void sign_checking();
void forwarder_checking();
void select_checking();
//---------------------------------------------------------------------------
extern PACKAGE TFShow *FShow;
//---------------------------------------------------------------------------
#endif

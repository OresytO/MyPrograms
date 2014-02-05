//---------------------------------------------------------------------------

#ifndef Unit3H
#define Unit3H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <ADODB.hpp>
#include <DB.hpp>
//---------------------------------------------------------------------------
class TFOutputDeli : public TForm
{
__published:	// IDE-managed Components
	TDateTimePicker *DateTimePicker1;
	TLabel *Label1;
	TLabel *Label2;
	TLabel *Label4;
	TLabel *Label5;
	TLabel *Label7;
	TLabel *Label8;
	TLabel *Label9;
	TLabel *Label10;
	TLabel *Label11;
	TLabel *Label12;
	TLabel *Label13;
	TLabel *Label14;
	TLabel *Label17;
	TLabel *Label18;
	TLabel *Label19;
	TDateTimePicker *DateTimePicker2;
	TEdit *Edit1;
	TComboBox *ComboBox1;
	TEdit *Edit3;
	TEdit *Edit4;
	TEdit *Edit6;
	TEdit *Edit7;
	TComboBox *ComboBox4;
	TEdit *Edit8;
	TMemo *Memo1;
	TBitBtn *BBack;
	TBitBtn *BAddToDB;
	TBitBtn *BExit;
	TComboBox *ComboBox3;
	TComboBox *ComboBox5;
	TComboBox *ComboBox6;
	TComboBox *ComboBox7;
	TADOCommand *ADOCommand1;
	TADODataSet *ADODataSet1;
	void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
	void __fastcall BBackClick(TObject *Sender);
	void __fastcall BExitClick(TObject *Sender);
	void __fastcall BAddToDBClick(TObject *Sender);
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall ComboBox1Change(TObject *Sender);
	void __fastcall ComboBox1DropDown(TObject *Sender);
	void __fastcall ComboBox6DropDown(TObject *Sender);
	void __fastcall ComboBox7DropDown(TObject *Sender);
	void __fastcall ComboBox6Change(TObject *Sender);
	void __fastcall ComboBox7Change(TObject *Sender);
	void __fastcall ComboBox3Change(TObject *Sender);
	void __fastcall ComboBox3DropDown(TObject *Sender);
	void __fastcall ComboBox4Change(TObject *Sender);
	void __fastcall ComboBox4DropDown(TObject *Sender);
	void __fastcall ComboBox5DropDown(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TFOutputDeli(TComponent* Owner);
};

void ComboDropCur(TComboBox * ComObj, TADODataSet * DataSet, int * &Courier_id);
void ComboDropList(TComboBox * ComObj, TADODataSet * DataSet, String SQLstr, int* & Array_id);

//---------------------------------------------------------------------------
extern PACKAGE TFOutputDeli *FOutputDeli;
//---------------------------------------------------------------------------
#endif

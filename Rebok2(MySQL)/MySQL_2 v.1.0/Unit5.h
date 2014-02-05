//---------------------------------------------------------------------------

#ifndef Unit5H
#define Unit5H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ADODB.hpp>
#include <DB.hpp>
#include <DBTables.hpp>
//---------------------------------------------------------------------------
class TFAddCourier : public TForm
{
__published:	// IDE-managed Components
	TLabel *Label1;
	TLabel *Label2;
	TLabel *Label3;
	TLabel *Label4;
	TLabel *Label5;
	TLabel *Label6;
	TLabel *Label7;
	TLabel *Label8;
	TEdit *Edit1;
	TEdit *Edit2;
	TEdit *Edit3;
	TEdit *Edit4;
	TEdit *Edit5;
	TEdit *Edit6;
	TComboBox *ComboBox1;
	TComboBox *ComboBox2;
	TBitBtn *BitBtn1;
	TBitBtn *BAddNewCourier2;
	TADODataSet *ADODataSet1;
	TADOCommand *ADOCommand1;
	void __fastcall BitBtn1Click(TObject *Sender);
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall FormHide(TObject *Sender);
	void __fastcall ComboBox2DropDown(TObject *Sender);
	void __fastcall BAddNewCourier2Click(TObject *Sender);
private:	// User declarations
	void CleanForm();
public:		// User declarations
	__fastcall TFAddCourier(TComponent* Owner);
};
//String get_ID(TComboBox * Combo, TADOQuery * Query, String fieldName);
//String get_ID(TComboBox * Combo, TADOQuery * Query, String fieldName, String tableName);
//---------------------------------------------------------------------------
extern PACKAGE TFAddCourier *FAddCourier;
//---------------------------------------------------------------------------
#endif

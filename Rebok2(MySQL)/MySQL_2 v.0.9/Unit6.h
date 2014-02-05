//---------------------------------------------------------------------------

#ifndef Unit6H
#define Unit6H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ADODB.hpp>
#include <DB.hpp>
//---------------------------------------------------------------------------
class TFAddForwarder : public TForm
{
__published:	// IDE-managed Components
	TLabel *Label1;
	TLabel *Label2;
	TLabel *Label3;
	TLabel *Label4;
	TLabel *Label5;
	TEdit *Edit1;
	TEdit *Edit2;
	TEdit *Edit3;
	TEdit *Edit4;
	TEdit *Edit5;
	TBitBtn *BitBtn1;
	TBitBtn *BitBtn2;
	TEdit *Edit6;
	TLabel *Label6;
	TLabel *Label7;
	TComboBox *ComboBox1;
	TLabel *Label8;
	TADODataSet *ADODataSet1;
	TADOCommand *ADOCommand1;
	void __fastcall BitBtn1Click(TObject *Sender);
	void __fastcall FormHide(TObject *Sender);
	void __fastcall BitBtn2Click(TObject *Sender);
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall ComboBox1Change(TObject *Sender);
private:	// User declarations
	void CleanForm();
public:		// User declarations
	__fastcall TFAddForwarder(TComponent* Owner);
};

//---------------------------------------------------------------------------
extern PACKAGE TFAddForwarder *FAddForwarder;
//---------------------------------------------------------------------------
#endif

//---------------------------------------------------------------------------

#ifndef Unit8H
#define Unit8H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ADODB.hpp>
#include <DB.hpp>
//---------------------------------------------------------------------------
class TFContr : public TForm
{
__published:	// IDE-managed Components
	TLabel *Label1;
	TEdit *Edit1;
	TLabel *Label2;
	TEdit *Edit2;
	TLabel *Label3;
	TEdit *Edit3;
	TLabel *Label4;
	TEdit *Edit4;
	TBitBtn *BitBtn1;
	TBitBtn *BitBtn2;
	TADOCommand *ADOCommand1;
	void __fastcall BitBtn1Click(TObject *Sender);
	void __fastcall FormHide(TObject *Sender);
	void __fastcall BitBtn2Click(TObject *Sender);
private:	// User declarations
	void CleanForm();
public:		// User declarations
	__fastcall TFContr(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TFContr *FContr;
//---------------------------------------------------------------------------
#endif

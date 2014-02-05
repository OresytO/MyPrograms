//---------------------------------------------------------------------------

#ifndef Unit7H
#define Unit7H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ADODB.hpp>
#include <DB.hpp>
//---------------------------------------------------------------------------
class TFCities : public TForm
{
__published:	// IDE-managed Components
	TLabel *Label1;
	TEdit *Edit1;
	TBitBtn *BitBtn1;
	TBitBtn *BitBtn2;
	TLabel *Label2;
	TEdit *Edit2;
	TADOCommand *ADOCommand1;
	void __fastcall BitBtn1Click(TObject *Sender);
	void __fastcall BitBtn2Click(TObject *Sender);
	void __fastcall FormHide(TObject *Sender);
private:	// User declarations
	void CleanForm();
public:		// User declarations
	__fastcall TFCities(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TFCities *FCities;
//---------------------------------------------------------------------------
#endif

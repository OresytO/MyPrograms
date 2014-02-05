//---------------------------------------------------------------------------

#ifndef Unit1H
#define Unit1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ADODB.hpp>
#include <DB.hpp>
//---------------------------------------------------------------------------
class TFStart : public TForm
{
__published:	// IDE-managed Components
	TBitBtn *BitBtn1;
	TBitBtn *BitBtn2;
	TBitBtn *BitBtn3;
	TBitBtn *BitBtn4;
	TLabel *Label1;
	TADOCommand *ADOCommand1;
	TADOConnection *ADOConnection1;
	void __fastcall BitBtn1Click(TObject *Sender);
	void __fastcall BitBtn2Click(TObject *Sender);
	void __fastcall BitBtn4Click(TObject *Sender);
	void __fastcall BitBtn3Click(TObject *Sender);
	void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TFStart(TComponent* Owner);
};
void AddingCourier();
void AddingCities();
void AddingContr();
void AddingForwarder();
void CreatCombo(TComboBox *Obj);
void AddToList(TComboBox *Obj, void (*Fun)());
/*
String fld_pay_1 = "payment_id";
String fld_pay_2 = "payment";

String fld_cour_1 = "name_storage_number";
String fld_cour_2 = "adress";
String fld_cour_3 = "phone_1";
String fld_cour_4 = "phone_2";
String fld_cour_5 = "phone_3";
String fld_cour_6 = "passport_for_id";
String fld_cour_7 = "payment_id";

String fld_del_8 = "";
*/

//---------------------------------------------------------------------------
extern PACKAGE TFStart *FStart;
//---------------------------------------------------------------------------
#endif

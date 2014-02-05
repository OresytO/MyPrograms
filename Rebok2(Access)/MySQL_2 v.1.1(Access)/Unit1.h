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

/*ШЛЯХИ ДО РІЗНИХ РЕСУРСІВ*/
//Місце розташування програми
String path_appl = ExtractFilePath(Application->ExeName);
//Вказємо шлях де розташований шаблон Word
String path_temp = path_appl + "\\Templat.dot";
//Шлях до місця де потрібно зберігати довіреності
String path_save = path_appl + "\\declare №";
//Шлях до БД
String path_db = path_appl + "DB_rebok2.accdb";

//---------------------------------------------------------------------------
extern PACKAGE TFStart *FStart;
//---------------------------------------------------------------------------
#endif

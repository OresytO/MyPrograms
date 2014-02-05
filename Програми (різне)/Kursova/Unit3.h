//---------------------------------------------------------------------------

#ifndef Unit3H
#define Unit3H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ADODB.hpp>
#include <DB.hpp>
#include <DBCtrls.hpp>
#include <DBGrids.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include "Word_2K_SRVR.h"
#include <OleServer.hpp>
#include <Buttons.hpp>
//---------------------------------------------------------------------------
class TForm3 : public TForm
{
__published:	// IDE-managed Components
        TLabel *Label1;
        TDataSource *DataSource1;
        TDBGrid *DBGrid1;
        TDBNavigator *DBNavigator1;
        TADOConnection *ADOConnection1;
        TADOTable *ADOTable1;
        TADOQuery *ADOQuery1;
        TButton *Button1;
        TButton *Button2;
        TEdit *Edit1;
        TButton *Button3;
        TButton *Button4;
        TButton *Button5;
        TLabel *Label2;
        TWordApplication *WordApplication1;
        TWordDocument *WordDocument1;
        TButton *Button6;
        TMemo *Memo1;
        TIntegerField *ADOTable1COD_WORKERS;
        TStringField *ADOTable1PRIZV;
        TStringField *ADOTable1NAME;
        TStringField *ADOTable1POBATKOVI;
        TIntegerField *ADOTable1COD_VIDDILU;
        TStringField *ADOTable1POSADA;
        TSmallintField *ADOTable1STAG;
        TIntegerField *ADOTable1TEL_WORK;
        TWordFont *WordFont1;
        void __fastcall Button1Click(TObject *Sender);
        void __fastcall Button2Click(TObject *Sender);
        void __fastcall Button3Click(TObject *Sender);
        void __fastcall Button4Click(TObject *Sender);
        void __fastcall Button5Click(TObject *Sender);
        void __fastcall Button6Click(TObject *Sender);
        void __fastcall Button7Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TForm3(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm3 *Form3;
//---------------------------------------------------------------------------
#endif
 
//---------------------------------------------------------------------------

#ifndef TabulationH
#define TabulationH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Menus.hpp>
#include <TeEngine.hpp>
#include <TeeProcs.hpp>
#include <Chart.hpp>
#include <Series.hpp>
#include <MPlayer.hpp>
#include <jpeg.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
        TLabeledEdit *LabeledEdit1;
        TLabeledEdit *LabeledEdit2;
        TLabeledEdit *LabeledEdit3;
        TLabel *Label1;
        TGroupBox *GroupBox1;
        TCheckBox *CheckBox1;
        TCheckBox *CheckBox2;
        TCheckBox *CheckBox3;
        TMemo *Memo1;
        TMainMenu *MainMenu1;
        TPopupMenu *PopupMenu1;
        TMenuItem *N1;
        TMenuItem *N2;
        TMenuItem *N3;
        TMenuItem *N4;
        TMenuItem *N5;
        TMenuItem *N6;
        TMenuItem *N7;
        TCheckBox *CheckBox4;
        TChart *Chart1;
        TLineSeries *Series1;
        TMediaPlayer *MediaPlayer1;
        TMenuItem *N8;
        TMenuItem *N9;
        TLabel *Label2;
        TLabel *Label3;
        TEdit *Edit1;
        TEdit *Edit2;
        TEdit *Edit3;
        TEdit *Edit4;
        TMenuItem *N10;
        TLabel *Label4;
        TEdit *Edit5;
        TEdit *Edit6;
        TEdit *Edit7;
        TEdit *Edit8;
        TEdit *Edit9;
        TEdit *Edit10;
        TEdit *Edit11;
        TEdit *Edit12;
        TEdit *Edit13;
        TEdit *Edit14;
        TEdit *Edit15;
        TEdit *Edit16;
        TEdit *Edit17;
        TEdit *Edit18;
        TEdit *Edit19;
        TEdit *Edit20;
        TEdit *Edit21;
        TEdit *Edit22;
        TEdit *Edit23;
        TEdit *Edit24;
        TLabel *Label5;
        TEdit *Edit25;
        TEdit *Edit26;
        TEdit *Edit27;
        TEdit *Edit28;
        TEdit *Edit29;
        TEdit *Edit30;
        TEdit *Edit31;
        TEdit *Edit32;
        TEdit *Edit33;
        TEdit *Edit34;
        TEdit *Edit35;
        TEdit *Edit36;
        TEdit *Edit37;
        TEdit *Edit38;
        TEdit *Edit39;
        TEdit *Edit40;
        TEdit *Edit41;
        TEdit *Edit42;
        TEdit *Edit43;
        TEdit *Edit44;
        TLabel *Label6;
        TLabel *Label7;
        TEdit *Edit45;
        TEdit *Edit46;
        TEdit *Edit47;
        TEdit *Edit48;
        TEdit *Edit49;
        TEdit *Edit50;
        TEdit *Edit51;
        TEdit *Edit52;
        TEdit *Edit53;
        TEdit *Edit54;
        TEdit *Edit55;
        TEdit *Edit56;
        TEdit *Edit57;
        TEdit *Edit58;
        TEdit *Edit59;
        TEdit *Edit60;
        TEdit *Edit61;
        TEdit *Edit62;
        TEdit *Edit63;
        TEdit *Edit64;
        TLabel *Label8;
        TMenuItem *L1;
        TGroupBox *GroupBox2;
        TEdit *Edit65;
        TEdit *Edit66;
        TEdit *Edit67;
        TEdit *Edit68;
        TEdit *Edit69;
        TEdit *Edit70;
        TEdit *Edit71;
        TEdit *Edit72;
        TEdit *Edit73;
        TEdit *Edit74;
        TEdit *Edit75;
        TEdit *Edit76;
        TEdit *Edit77;
        TEdit *Edit78;
        TEdit *Edit79;
        TEdit *Edit80;
        TGroupBox *GroupBox3;
        TImage *Image1;
        TImage *Image2;
        TImage *Image3;
        TImage *Image4;
        TEdit *Edit81;
        TLabel *Label9;
        TLabel *Label10;
        TEdit *Edit82;
        TMenuItem *N11;
        TLabel *Label11;
        TEdit *Edit83;
        TLabel *Label12;
        TEdit *Edit84;
        TLabel *Label13;
        TEdit *Edit85;
        TLabel *Label14;
        TEdit *Edit86;
        TLabel *Label15;
        TEdit *Edit87;
        TLabel *Label16;
        TEdit *Edit88;
        TLabel *Label17;
        TEdit *Edit89;
        TLabel *Label18;
        TLabel *Label19;
        TLabel *Label20;
        TLabel *Label21;
        TLabel *Label22;
        TEdit *Edit90;
        TLabel *Label23;
        TLabel *Label24;
        TEdit *Edit91;
        TLabel *Label25;
        TEdit *Edit92;
        TLabel *Label26;
        TEdit *Edit93;
        TLabel *Label27;
        TEdit *Edit94;
        TLabel *Label28;
        TEdit *Edit95;
        TLabel *Label29;
        TEdit *Edit96;
        TLabel *Label30;
        TEdit *Edit97;
        TLabel *Label31;
        TEdit *Edit98;
        TLabel *Label32;
        TEdit *Edit99;
        TLabel *Label33;
        TEdit *Edit100;
        TLabel *Label34;
        TEdit *Edit101;
        TButton *Button1;
        TMenuItem *R1;
        TGroupBox *GroupBox4;
        TEdit *Edit102;
        TEdit *Edit103;
        TEdit *Edit104;
        TEdit *Edit105;
        TEdit *Edit106;
        TEdit *Edit107;
        TEdit *Edit108;
        TEdit *Edit109;
        TEdit *Edit110;
        TEdit *Edit111;
        TEdit *Edit112;
        TEdit *Edit113;
        TEdit *Edit114;
        TEdit *Edit115;
        TEdit *Edit116;
        TEdit *Edit117;
        TLabel *Label35;
        TEdit *Edit118;
        TLabel *Label36;
        TEdit *Edit119;
        TLabel *Label37;
        TEdit *Edit120;
        TLabel *Label38;
        TEdit *Edit121;
        TLabel *Label39;
        TLabel *Label40;
        TLabel *Label41;
        TLabel *Label42;
        TMenuItem *A1;
        TGroupBox *GroupBox5;
        TEdit *Edit122;
        TEdit *Edit123;
        TEdit *Edit124;
        TEdit *Edit125;
        TEdit *Edit126;
        TEdit *Edit127;
        TEdit *Edit128;
        TEdit *Edit129;
        TEdit *Edit130;
        TEdit *Edit131;
        TEdit *Edit132;
        TEdit *Edit133;
        TEdit *Edit134;
        TEdit *Edit135;
        TEdit *Edit136;
        TEdit *Edit137;
        TEdit *Edit138;
        TEdit *Edit139;
        TEdit *Edit140;
        TEdit *Edit141;
        TLabel *Label43;
        TLabel *Label44;
        TEdit *Edit142;
        TEdit *Edit143;
        TEdit *Edit144;
        TEdit *Edit145;
        void __fastcall N6Click(TObject *Sender);
        void __fastcall N3Click(TObject *Sender);
        void __fastcall N7Click(TObject *Sender);
        void __fastcall N2Click(TObject *Sender);
        void __fastcall N9Click(TObject *Sender);
        void __fastcall N10Click(TObject *Sender);
        void __fastcall L1Click(TObject *Sender);
        void __fastcall N11Click(TObject *Sender);
        void __fastcall Button1Click(TObject *Sender);
        void __fastcall R1Click(TObject *Sender);
        void __fastcall A1Click(TObject *Sender);
        //void __fastcall Series1Click(TChartSeries *Sender, int ValueIndex,
        //  TMouseButton Button, TShiftState Shift, int X, int Y);
        //void __fastcall SpeedButton1Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
const double pi=3.14159265358979;
// Опис кількості елементів масиву <H> та його значень
int mH, H[4];
// Опис кількості елементів масиву <G> та його значень
int mG, nG, G[4][5];
// Опис кількості елементів масиву <D1> та його значень
int mD1, nD1, D1[4][4], d1[4];
// Опис кількості елементів масиву <D2> та його значень
int mD2, nD2, D2[4][4], d2[4];

// Опис кількості елементів квадратної матриці <L> та її значень
int mL, nL; double L[4][4];

// Опис кількості елементів квадратної матриці <R> та її значень
int mR, nR; double R[4][4];

// Опис кількості елементів квадратної матриці <A> та її значень
int mA, nA; double A[4][4];

// Оголошення параметрів геометричних фігур
// Параметри кола
double a, r;

// Параметри трикутника
double a3, b3, c3, k31, k32;

// Параметри прямокутника
double a4, b4, k41;

// Параметри чотирикутника
double a5, b5, c5, d5, k51, Kx1, x1, x2, Ky2, y1, y2;

// Опис кількості елементів вектора вільних членів <V> та її значень
int mV; double V[4];

// Підпрограма для визначення площі кола
double Platz(double r);

// Підпрограма для визначення площі прямокутника
double Platz(double a, double b);

// Підпрограма для визначення площі трикутника
double Platz(double a, double b, double c);

// Підпрограма для визначення площі чотирикутника
double Platz(double a, double b, double x1, double y2);

double abs(double x);

// Розв'язування систем лінійних рівнянь методом Гауса
// а - матриця коефіцієнтів, рядки підряд, b - вільні члени, x - розв'язок.
void Gauss(double *a, double *b, double *x,int n);

#endif

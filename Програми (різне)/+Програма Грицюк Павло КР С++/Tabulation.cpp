//---------------------------------------------------------------------------

#include <vcl.h>
#include <math>
#include <iostream> // Для потокового введення-виведення
#include <fstream> // Для роботи з файлами

#pragma hdrstop

#include "Tabulation.h"
using namespace std; // Використання стандартного простору імен

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
}

//---------------------------------------------------------------------------

void __fastcall TForm1::N3Click(TObject *Sender)
{
        Memo1->Clear();
        Series1->Clear();
}
//---------------------------------------------------------------------------



//---------------------------------------------------------------------------
void __fastcall TForm1::N6Click(TObject *Sender)
{
        exit(1); // Закриваємо вікно програми
}
void __fastcall TForm1::N7Click(TObject *Sender)
{
        Memo1->Clear();
        Series1->Clear();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::N2Click(TObject *Sender)
{
    if(CheckBox1->Checked) {
        MediaPlayer1->FileName = "notify.wav";
        MediaPlayer1->Open();
        double x,y;
        double a = StrToFloat(LabeledEdit1->Text);
        double b = StrToFloat(LabeledEdit2->Text);
        double h = StrToFloat(LabeledEdit3->Text);
        Memo1->Lines->Append("X\tY");
        for(x=a; x<b+h/2; x+=h){
                y = sin(x)+1;
                Memo1->Lines->Append(FloatToStrF(x,ffFixed,4,2)+
                      '\t'+FloatToStrF(y,ffFixed,4,2));
                if(CheckBox4->Checked)
                       Series1->Add(y,FloatToStrF(x,ffFixed,4,2),clRed);
        }
        MediaPlayer1->Play();
    }
}
//---------------------------------------------------------------------------

// Введення елементів масивів з файлу
void __fastcall TForm1::N9Click(TObject *Sender)
{
        ifstream in("Date.txt");
        if(!in) {
                Label2->Caption="Не вдається відкрити файл: Date.txt";
                for(int i=0;i<10; i++) {
                        //Label2->Caption="Не вдається відкрити файл: Date.txt";
                        if(Label2->Visible)            // Якщо поле світиться -
                                Label2->Visible=false; // то поле гаситься
                        else
                                Label2->Visible=true;  // то поле світиться
                        Sleep(1000); Beep(294,1000/8);
                        Label2->Caption="Не вдається відкрити файл: Date.txt";
                }
                exit(1); // Закриваємо вікно програми
        }

        // Введення елементів масиву <H>
        in >> mH;
        Label3->Caption="Масив <H["+IntToStr(mH)+"]>";
        for(int i=0;i<mH;i++) {
                in >> H[i];
                //Memo1->Lines->Append(IntToStr(i)+" -> "+IntToStr(H[i]));
        }
        Edit1->Text=IntToStr(H[0]);
        Edit2->Text=IntToStr(H[1]);
        Edit3->Text=IntToStr(H[2]);
        Edit4->Text=IntToStr(H[3]);

        // Введення елементів масиву <G>
        in >> mG >> nG;
        Label4->Caption="Масив <G["+IntToStr(mG)+"]["+IntToStr(nG)+"]>";
        for(int i=0;i<mG;i++)
                for(int j=0;j<nG;j++) in >> G[i][j];
        Edit5->Text=IntToStr(G[0][0]);  Edit6->Text=IntToStr(G[0][1]);  Edit7->Text=IntToStr(G[0][2]);  Edit8->Text=IntToStr(G[0][3]);  Edit9->Text=IntToStr(G[0][4]);
        Edit10->Text=IntToStr(G[1][0]); Edit11->Text=IntToStr(G[1][1]); Edit12->Text=IntToStr(G[1][2]); Edit13->Text=IntToStr(G[1][3]); Edit14->Text=IntToStr(G[1][4]);
        Edit15->Text=IntToStr(G[2][0]); Edit16->Text=IntToStr(G[2][1]); Edit17->Text=IntToStr(G[2][2]); Edit18->Text=IntToStr(G[2][3]); Edit19->Text=IntToStr(G[2][4]);
        Edit20->Text=IntToStr(G[3][0]); Edit21->Text=IntToStr(G[3][1]); Edit22->Text=IntToStr(G[3][2]); Edit23->Text=IntToStr(G[3][3]); Edit24->Text=IntToStr(G[3][4]);

        // Введення елементів масиву <D1>
        in >> mD1 >> nD1;
        Label5->Caption="Масив <D1["+IntToStr(mD1)+"]["+IntToStr(nD1)+"]>";
        Label6->Caption="і <d1["+IntToStr(mD1)+"]>";
        for(int i=0;i<mD1;i++) {
                for(int j=0;j<nD1;j++) in >> D1[i][j];
                d1[i]=D1[i][i];
        }
        Edit25->Text=IntToStr(D1[0][0]); Edit26->Text=IntToStr(D1[0][1]); Edit27->Text=IntToStr(D1[0][2]); Edit28->Text=IntToStr(D1[0][3]);  Edit41->Text=IntToStr(d1[0]);
        Edit29->Text=IntToStr(D1[1][0]); Edit30->Text=IntToStr(D1[1][1]); Edit31->Text=IntToStr(D1[1][2]); Edit32->Text=IntToStr(D1[1][3]);  Edit42->Text=IntToStr(d1[1]);
        Edit33->Text=IntToStr(D1[2][0]); Edit34->Text=IntToStr(D1[2][1]); Edit35->Text=IntToStr(D1[2][2]); Edit36->Text=IntToStr(D1[2][3]);  Edit43->Text=IntToStr(d1[2]);
        Edit37->Text=IntToStr(D1[3][0]); Edit38->Text=IntToStr(D1[3][1]); Edit39->Text=IntToStr(D1[3][2]); Edit40->Text=IntToStr(D1[3][3]);  Edit44->Text=IntToStr(d1[3]);

        // Введення елементів масиву <D2
        in >> mD2 >> nD2;
        Label7->Caption="Масив <D2["+IntToStr(mD2)+"]["+IntToStr(nD2)+"]>";
        Label8->Caption="і <d2["+IntToStr(mD2)+"]>";
        for(int i=0;i<mD2;i++) {
                for(int j=0;j<nD2;j++) in >> D2[i][j];
                d2[i]=D2[i][mD2-i-1];
                //Memo1->Lines->Append(IntToStr(mD2-i-1)+" -> "+IntToStr(d2[i]));
        }
        Edit45->Text=IntToStr(D2[0][0]); Edit46->Text=IntToStr(D2[0][1]); Edit47->Text=IntToStr(D2[0][2]); Edit48->Text=IntToStr(D2[0][3]);  Edit61->Text=IntToStr(d2[0]);
        Edit49->Text=IntToStr(D2[1][0]); Edit50->Text=IntToStr(D2[1][1]); Edit51->Text=IntToStr(D2[1][2]); Edit52->Text=IntToStr(D2[1][3]);  Edit62->Text=IntToStr(d2[1]);
        Edit53->Text=IntToStr(D2[2][0]); Edit54->Text=IntToStr(D2[2][1]); Edit55->Text=IntToStr(D2[2][2]); Edit56->Text=IntToStr(D2[2][3]);  Edit63->Text=IntToStr(d2[2]);
        Edit57->Text=IntToStr(D2[3][0]); Edit58->Text=IntToStr(D2[3][1]); Edit59->Text=IntToStr(D2[3][2]); Edit60->Text=IntToStr(D2[3][3]);  Edit64->Text=IntToStr(d2[3]);

        in.close();
}
//---------------------------------------------------------------------------

// Введення елементів масивів з форм
void __fastcall TForm1::N10Click(TObject *Sender)
{
        // Дозвіл на введення елементів масиву <H>
        H[0]=StrToInt(Edit1->Text); H[1]=StrToInt(Edit2->Text); H[2]=StrToInt(Edit3->Text); H[3]=StrToInt(Edit4->Text);

        // Дозвіл на введення елементів масиву <G>
        G[0][0]=StrToInt(Edit5->Text);  G[0][1]=StrToInt(Edit6->Text);  G[0][2]=StrToInt(Edit7->Text);  G[0][3]=StrToInt(Edit8->Text); G[0][4]=StrToInt(Edit9->Text);
        G[1][0]=StrToInt(Edit10->Text); G[1][1]=StrToInt(Edit11->Text); G[1][2]=StrToInt(Edit12->Text); G[1][3]=StrToInt(Edit13->Text); G[1][4]=StrToInt(Edit14->Text);
        G[2][0]=StrToInt(Edit15->Text); G[2][1]=StrToInt(Edit16->Text); G[2][2]=StrToInt(Edit17->Text); G[2][3]=StrToInt(Edit18->Text); G[2][4]=StrToInt(Edit19->Text);
        G[3][0]=StrToInt(Edit20->Text); G[3][1]=StrToInt(Edit21->Text); G[3][2]=StrToInt(Edit22->Text); G[3][3]=StrToInt(Edit23->Text); G[3][4]=StrToInt(Edit24->Text);

        // Дозвіл на введення елементів масиву <D1>
        D1[0][0]=StrToInt(Edit25->Text); D1[0][1]=StrToInt(Edit26->Text); D1[0][2]=StrToInt(Edit27->Text); D1[0][3]=StrToInt(Edit28->Text); d1[0]=StrToInt(Edit41->Text);
        D1[1][0]=StrToInt(Edit29->Text); D1[1][1]=StrToInt(Edit30->Text); D1[1][2]=StrToInt(Edit31->Text); D1[1][3]=StrToInt(Edit32->Text); d1[1]=StrToInt(Edit42->Text);
        D1[2][0]=StrToInt(Edit33->Text); D1[2][1]=StrToInt(Edit34->Text); D1[2][2]=StrToInt(Edit35->Text); D1[2][3]=StrToInt(Edit36->Text); d1[2]=StrToInt(Edit43->Text);
        D1[3][0]=StrToInt(Edit37->Text); D1[3][1]=StrToInt(Edit38->Text); D1[3][2]=StrToInt(Edit39->Text); D1[3][3]=StrToInt(Edit40->Text); d1[3]=StrToInt(Edit44->Text);

        // Дозвіл на введення елементів масиву <D2>
        D2[0][0]=StrToInt(Edit45->Text); D2[0][1]=StrToInt(Edit46->Text); D2[0][2]=StrToInt(Edit47->Text); D2[0][3]=StrToInt(Edit48->Text); d2[0]=StrToInt(Edit61->Text);
        D2[1][0]=StrToInt(Edit49->Text); D2[1][1]=StrToInt(Edit50->Text); D2[1][2]=StrToInt(Edit51->Text); D2[1][3]=StrToInt(Edit52->Text); d2[1]=StrToInt(Edit62->Text);
        D2[2][0]=StrToInt(Edit53->Text); D2[2][1]=StrToInt(Edit54->Text); D2[2][2]=StrToInt(Edit55->Text); D2[2][3]=StrToInt(Edit56->Text); d2[2]=StrToInt(Edit63->Text);
        D2[3][0]=StrToInt(Edit57->Text); D2[3][1]=StrToInt(Edit58->Text); D2[3][2]=StrToInt(Edit59->Text); D2[3][3]=StrToInt(Edit60->Text); d2[3]=StrToInt(Edit64->Text);
       
}
//---------------------------------------------------------------------------

// Обчислення елементів матриці <L>
void __fastcall TForm1::L1Click(TObject *Sender)
{
        mL=nL=4;
        GroupBox2->Caption="Квадратна матриця <L["+IntToStr(mL)+"]["+IntToStr(nL)+"]>";
        for(int i=0;i<mL;i++) {
                for(int j=0;j<nL;j++) {
                        L[i][j]=0.0;
                        //Memo1->Lines->Append(IntToStr(i)+" -> "+FloatToStrF(L[i][j],ffFixed,4,2));
                }
        }

        L[0][0]=a;  Edit65->Text=FloatToStrF(L[0][0],ffFixed,4,2);
        L[1][0]=a4; Edit69->Text=FloatToStrF(L[1][0],ffFixed,4,2);
        L[2][0]=a3; Edit73->Text=FloatToStrF(L[2][0],ffFixed,4,2);
        L[3][0]=a5; Edit77->Text=FloatToStrF(L[3][0],ffFixed,4,2);

        L[1][1]=b4; Edit70->Text=FloatToStrF(L[1][1],ffFixed,4,2);
        L[2][1]=b3; Edit74->Text=FloatToStrF(L[2][1],ffFixed,4,2);
        L[3][1]=b5; Edit78->Text=FloatToStrF(L[3][1],ffFixed,4,2);

        L[2][2]=c3; Edit75->Text=FloatToStrF(L[2][2],ffFixed,4,2);
        L[3][2]=c5; Edit79->Text=FloatToStrF(L[3][2],ffFixed,4,2);

        L[3][3]=d5; Edit80->Text=FloatToStrF(L[3][3],ffFixed,4,2);
}
//---------------------------------------------------------------------------

// Обчислення елементів матриці <R>
void __fastcall TForm1::R1Click(TObject *Sender)
{
        mR=nR=4;
        //Memo1->Lines->Append("R[4][4]");
        GroupBox4->Caption="Квадратна матриця <R["+IntToStr(mR)+"]["+IntToStr(nR)+"]>";
        for(int i=0;i<mR;i++) {
                for(int j=0;j<i+1;j++) {
                        R[i][j]=L[i][j];
                        //Memo1->Lines->Append(IntToStr(i)+" -> "+FloatToStrF(R[i][j],ffFixed,4,2));
                }
        }
        //Memo1->Lines->Append("R[i][j]");
        for(int i=0;i<mR-1;i++) {
                for(int j=i+1;j<nR;j++) {
                        R[i][j]=L[j][i];
                        //Memo1->Lines->Append(IntToStr(i)+IntToStr(j)+" -> "+FloatToStrF(R[i][j],ffFixed,4,2));
                }
        }

        Edit102->Text=FloatToStrF(R[0][0],ffFixed,4,2);
        Edit103->Text=FloatToStrF(R[0][1],ffFixed,4,2);
        Edit104->Text=FloatToStrF(R[0][2],ffFixed,4,2);
        Edit105->Text=FloatToStrF(R[0][3],ffFixed,4,2);

        Edit106->Text=FloatToStrF(R[1][0],ffFixed,4,2);
        Edit107->Text=FloatToStrF(R[1][1],ffFixed,4,2);
        Edit108->Text=FloatToStrF(R[1][2],ffFixed,4,2);
        Edit109->Text=FloatToStrF(R[1][3],ffFixed,4,2);

        Edit110->Text=FloatToStrF(R[2][0],ffFixed,4,2);
        Edit111->Text=FloatToStrF(R[2][1],ffFixed,4,2);
        Edit112->Text=FloatToStrF(R[2][2],ffFixed,4,2);
        Edit113->Text=FloatToStrF(R[2][3],ffFixed,4,2);

        Edit114->Text=FloatToStrF(R[3][0],ffFixed,4,2);
        Edit115->Text=FloatToStrF(R[3][1],ffFixed,4,2);
        Edit116->Text=FloatToStrF(R[3][2],ffFixed,4,2);
        Edit117->Text=FloatToStrF(R[3][3],ffFixed,4,2);
}
//---------------------------------------------------------------------------

// Обчислення параметрів геометричних фігур
void __fastcall TForm1::N11Click(TObject *Sender)
{
        mV=4; for(int i=0; i<mV; i++) V[i]=0.0;
        // Параметри кола
        a = r=10+5*cos(H[0]*pi/180);
        //a = r= StrToFloat(Edit81->Text);
        Edit81->Text=FloatToStrF(a,ffFixed,4,2);
        V[0]=Platz(r); // Обчислення площі кола
        Label10->Visible=true; Edit82->Visible=true;  Edit82->Text=FloatToStrF(r,ffFixed,4,2);
        Label35->Visible=true; Edit118->Visible=true; Edit118->Text=FloatToStrF(V[0],ffFixed,4,2);
        Label39->Visible=true;

        // Параметри трикутника
        Edit86->Visible=true; a3=a*2.;
        Edit86->Text=FloatToStrF(a3,ffFixed,4,2);
        k31 = StrToFloat(Edit87->Text); b3=k31*a3;
        Edit88->Visible=true; Edit88->Text=FloatToStrF(b3,ffFixed,4,2);
        k32 = StrToFloat(Edit89->Text); c3=k32*a3;
        Edit90->Visible=true; Edit90->Text=FloatToStrF(c3,ffFixed,4,2);
        if(a3+c3<=b3) {
                Label23->Visible=true;
                Label23->Caption="Трикутник створити неможливо";
        }
        else {
                V[2]=Platz(a3,b3,c3); // Обчислення площі трикутника
                Label37->Visible=true; Edit120->Visible=true; Edit120->Text=FloatToStrF(V[2],ffFixed,4,2);
                Label41->Visible=true;
        }

        // Параметри прямокутника
        Edit83->Visible=true; a4=a*2.; Edit83->Text=FloatToStrF(a4,ffFixed,4,2);
        k41 = StrToFloat(Edit84->Text); b4=k41*a4;
        Edit85->Visible=true; Edit85->Text=FloatToStrF(b4,ffFixed,4,2);
        V[1]=Platz(a4,b4); // Обчислення площі прямокутника
        Label36->Visible=true; Edit119->Visible=true; Edit119->Text=FloatToStrF(V[1],ffFixed,4,2);
        Label40->Visible=true;

        // Параметри чотирикутника
        a5=a*2.;    Edit91->Visible=true; Edit91->Text=FloatToStrF(a5,ffFixed,4,2);
        k51 = StrToFloat(Edit93->Text);
        b5=k51*a5; Edit92->Visible=true; Edit92->Text=FloatToStrF(b5,ffFixed,4,2);
        Kx1 = StrToFloat(Edit100->Text);
        x1=Kx1*a5; Edit95->Visible=true; Edit95->Text=FloatToStrF(x1,ffFixed,4,2);
        Ky2 = StrToFloat(Edit101->Text);
        y2=Ky2*b5; Edit99->Visible=true; Edit99->Text=FloatToStrF(y2,ffFixed,4,2);
        x2=a5+x1;  Edit98->Visible=true; Edit98->Text=FloatToStrF(x2,ffFixed,4,2);
        y1=b5-y2;  Edit97->Visible=true; Edit97->Text=FloatToStrF(y1,ffFixed,4,2);
        c5=sqrt(pow(x2,2)+pow(y1,2)); Edit94->Visible=true; Edit94->Text=FloatToStrF(c5,ffFixed,4,2);
        d5=sqrt(pow(x1,2)+pow(y2,2)); Edit96->Visible=true; Edit96->Text=FloatToStrF(d5,ffFixed,4,2);
        V[3]=Platz(a5,b5,x1,y2); // Обчислення площі чотирикутника
        Label38->Visible=true; Edit121->Visible=true; Edit121->Text=FloatToStrF(V[3],ffFixed,4,2);
        Label42->Visible=true;
}
//---------------------------------------------------------------------------


// Повторне обчислення параметрів геометричних фігур
void __fastcall TForm1::Button1Click(TObject *Sender)
{
        mV=4; for(int i=0; i<mV; i++) V[i]=0.0;
        // Параметри кола
        a = r= StrToFloat(Edit81->Text); V[0]=Platz(r); // Обчислення площі кола
        Label10->Visible=true; Edit82->Visible=true;  Edit82->Text=FloatToStrF(a,ffFixed,4,2);
        Label35->Visible=true; Edit118->Visible=true; Edit118->Text=FloatToStrF(V[0],ffFixed,4,2);
        Label39->Visible=true;

        // Параметри трикутника
        Label23->Visible=false;
        Edit86->Visible=true; a3=a*2.;
        Edit86->Text=FloatToStrF(a3,ffFixed,4,2);
        k31 = StrToFloat(Edit87->Text); b3=k31*a3;
        Edit88->Visible=true; Edit88->Text=FloatToStrF(b3,ffFixed,4,2);
        k32 = StrToFloat(Edit89->Text); c3=k32*a3;
        Edit90->Visible=true; Edit90->Text=FloatToStrF(c3,ffFixed,4,2);
        if(a3+c3<=b3) {
                Label23->Visible=true;
                Label23->Caption="Трикутник створити неможливо";
        }
        else {
                V[2]=Platz(a3,b3,c3); // Обчислення площі трикутника
                Label37->Visible=true; Edit120->Visible=true; Edit120->Text=FloatToStrF(V[2],ffFixed,4,2);
                Label41->Visible=true;
        }

        // Параметри прямокутника
        Edit83->Visible=true; a4=a*2.; Edit83->Text=FloatToStrF(a4,ffFixed,4,2);
        k41 = StrToFloat(Edit84->Text); b4=k41*a4;
        Edit85->Visible=true; Edit85->Text=FloatToStrF(b4,ffFixed,4,2);
        V[1]=Platz(a4,b4); // Обчислення площі прямокутника
        Label36->Visible=true; Edit119->Visible=true; Edit119->Text=FloatToStrF(V[1],ffFixed,4,2);
        Label40->Visible=true;

        // Параметри чотирикутника
        a5=a*2.;    Edit91->Visible=true; Edit91->Text=FloatToStrF(a5,ffFixed,4,2);
        k51 = StrToFloat(Edit93->Text);
        b5=k51*a5; Edit92->Visible=true; Edit92->Text=FloatToStrF(b5,ffFixed,4,2);
        Kx1 = StrToFloat(Edit100->Text);
        x1=Kx1*a5; Edit95->Visible=true; Edit95->Text=FloatToStrF(x1,ffFixed,4,2);
        Ky2 = StrToFloat(Edit101->Text);
        y2=Ky2*b5; Edit99->Visible=true; Edit99->Text=FloatToStrF(y2,ffFixed,4,2);
        x2=a5+x1;  Edit98->Visible=true; Edit98->Text=FloatToStrF(x2,ffFixed,4,2);
        y1=b5-y2;  Edit97->Visible=true; Edit97->Text=FloatToStrF(y1,ffFixed,4,2);
        c5=sqrt(pow(x2,2)+pow(y1,2)); Edit94->Visible=true; Edit94->Text=FloatToStrF(c5,ffFixed,4,2);
        d5=sqrt(pow(x1,2)+pow(y2,2)); Edit96->Visible=true; Edit96->Text=FloatToStrF(d5,ffFixed,4,2);
        V[3]=Platz(a5,b5,x1,y2); // Обчислення площі чотирикутника
        Label38->Visible=true; Edit121->Visible=true; Edit121->Text=FloatToStrF(V[3],ffFixed,4,2);
        Label42->Visible=true;
}
//---------------------------------------------------------------------------

// Підпрограма для визначення площі кола
double Platz(double r)
{
        return pi*pow(r,2);
}

// Підпрограма для визначення площі прямокутника
double Platz(double a, double b)
{
        return a*b;
}

// Підпрограма для визначення площі трикутника
double Platz(double a, double b, double c)
{
        double p=(a+b+c)/2;               // півпериметр
        return sqrt(p*(p-a)*(p-b)*(p-c)); // Формула Герона
}

// Підпрограма для визначення площі чотирикутника
double Platz(double a, double b, double x1, double y2)
{
        double t1=x1*y2/2;              // площа нижнього трикутника
        double t2=(b-y2)*(a+x1)/2;      // площа верхнього трикутника
        return (a+x1)*b-t1-t2;               // площа чотирикутника
}

// Обчислення елементів матриці <A>
void __fastcall TForm1::A1Click(TObject *Sender)
{
        mA=nA=4;
       // Опис кількості елементів квадратної матриці <A> та її значень
        double Tmp1[5][5], Tmp2[5][5];
//        Memo1->Lines->Append("A[4][4]");
        GroupBox5->Caption="Система лінійних рівнянь <A["+IntToStr(mA)+"]["+IntToStr(nA)+"] x X["
                                +IntToStr(mA)+"] = V["+IntToStr(mA)+"]";

      // Множення матриць <Tmp1=D1*G>
      double s = 0;
      for(int i = 0; i < mD1; i++) {
            for(int j = 0; j < nG; j++) {
                  s = 0;
                  for(int k = 0; k < nD1; k++)
                        s += D1[i][k] * G[k][j];
                  Tmp1[i][j] = s;
            }
      }

      //Memo1->Lines->Append("Tmp2=Gt");
      // Транспонування матриці <Tmp2=Gt>
        for(int i=0;i<mG;i++) {
                for(int j=0;j<nG;j++) {
                        Tmp2[j][i] = G[i][j];
                        //Memo1->Lines->Append(IntToStr(i)+" -> "+FloatToStrF(Tmp2[i][j],ffFixed,4,2));
                }
        }

      // Множення матриць <A=Tmp1*Tmp2>
      s = 0;
      for(int i = 0; i < mD1; i++) {
            for(int j = 0; j < mG; j++) {
                  s = 0;
                  for(int k = 0; k < nG; k++)
                        s += Tmp1[i][k] * Tmp2[k][j];
                  A[i][j] = s;
            }
      }

        for(int i=0;i<mA;i++) {
                for(int j=0;j<nA;j++) {
                        Tmp1[i][j] = A[i][j] + R[i][j];
                }
        }

      // Множення матриць <A=Tmp1*D2>
      s = 0;
      for(int i = 0; i < mA; i++) {
            for(int j = 0; j < nG; j++) {
                  s = 0;
                  for(int k = 0; k < nG; k++)
                        s += Tmp1[i][k] * D2[k][j];
                  A[i][j] = s;
            }
      }

        Edit122->Text=FloatToStrF(A[0][0],ffFixed,7,2);
        Edit123->Text=FloatToStrF(A[0][1],ffFixed,7,2);
        Edit124->Text=FloatToStrF(A[0][2],ffFixed,7,2);
        Edit125->Text=FloatToStrF(A[0][3],ffFixed,7,2);

        Edit126->Text=FloatToStrF(A[1][0],ffFixed,7,2);
        Edit127->Text=FloatToStrF(A[1][1],ffFixed,7,2);
        Edit128->Text=FloatToStrF(A[1][2],ffFixed,7,2);
        Edit129->Text=FloatToStrF(A[1][3],ffFixed,7,2);

        Edit130->Text=FloatToStrF(A[2][0],ffFixed,7,2);
        Edit131->Text=FloatToStrF(A[2][1],ffFixed,7,2);
        Edit132->Text=FloatToStrF(A[2][2],ffFixed,7,2);
        Edit133->Text=FloatToStrF(A[2][3],ffFixed,7,2);

        Edit134->Text=FloatToStrF(A[3][0],ffFixed,7,2);
        Edit135->Text=FloatToStrF(A[3][1],ffFixed,7,2);
        Edit136->Text=FloatToStrF(A[3][2],ffFixed,7,2);
        Edit137->Text=FloatToStrF(A[3][3],ffFixed,7,2);

        double X[5], B[4*4];
        for(int i=0;i<mA;i++) { X[i]=V[i]/cos(mA-i);
                for(int j=0;j<nA;j++) {
                        B[i*nA+j] = A[i][j];
                        //Memo1->Lines->Append(IntToStr(i*nA+j)+" -> "+FloatToStrF(B[i*nA+j],ffFixed,4,2));
                }
        }
        // Розв'язування систем лінійних рівнянь методом Гауса
        // а - матриця коефіцієнтів, рядки підряд, b - вільні члени, x - розв'язок.
        //Gauss(B,V,X,mA*nA);
/*
        for(int i=0;i<nA;i++) {
             Memo1->Lines->Append(IntToStr(i)+" -> "+FloatToStrF(X[i],ffFixed,4,2));
        }
*/
        Edit138->Text=FloatToStrF(X[0],ffFixed,7,2);
        Edit139->Text=FloatToStrF(X[1],ffFixed,7,2);
        Edit140->Text=FloatToStrF(X[2],ffFixed,7,2);
        Edit141->Text=FloatToStrF(X[3],ffFixed,7,2);

        Edit142->Text=FloatToStrF(V[0],ffFixed,7,2);
        Edit143->Text=FloatToStrF(V[1],ffFixed,7,2);
        Edit144->Text=FloatToStrF(V[2],ffFixed,7,2);
        Edit145->Text=FloatToStrF(V[3],ffFixed,7,2);
}
//---------------------------------------------------------------------------

double abs(double x)
{
 if (x<0)
 {
  return -x;
 }
 return x;
}

// Розв'язування систем лінійних рівнянь методом Гауса
// а - матриця коефіцієнтів, рядки підряд, b - вільні члени, x - розв'язок.
void Gauss(double *a, double *b, double *x, int n)
{
 int i,j,k,t;
 double kof,s;
 double temp;
 for (i=n-1; i>0; --i) // Цикл по уравнениям - вычитаемым
 {
  for (t=i, j=i-1; j>=0; --j) //Ищем строку с максимальным в i-том столбце коэффициентом.
  {
   if (fabs(a[i*n+t])<fabs(a[i*n+j]))
   {
    t=j;
   }
  }
  if (a[i*n+t]==0.0)
  {
   return;
  }
  if (t!=i) // Если она не i-тая
  {
   for (k=n-1; k>=0; --k) // Меняем её с i-той
   {
    temp=a[k*n+t];
    a[k*n+t]=a[k*n+i];
    a[k*n+i]=temp;
   }
  }
  for (j=i-1; j>=0; --j) // Цикл пo уравнениям-уменьшаемым
  {
   kof=a[i+j*n]/a[i*n+i]; // kof=a[j][i]/a[i][i];
   for (a[i+j*n]=0.0, b[j]-=b[i]*kof, k=i-1; k>=0; --k) // Цикл по столбцам
   {
    a[k+j*n]-=a[k+i*n]*kof; // a[k][j]-=a[k][i]*kof
   }
  }
 }
 x=new double [n];
 if (x)
 {
  for (i=0; i<n; ++i)
  {
   for (s=0.0, j=i-1; j>=0; --j)
   {
    s+=a[j+i*n]*x[j]; //s+=a[j][i]*x[j]
   }
   x[i]=(b[i]-s)/a[i*n+i]; // x[i]=(b[i]-s)/a[i][i];
   //cout << x[i] << "\n";
  }
 }
}

//---------------------------------------------------------------------------

#include <vcl.h>
#include <ComObj.hpp>
#include <utilcls.h>
#include <IniFiles.hpp>
#include <stdio.h>
#include <string>
#pragma hdrstop

#define SECURITY_WIN32 1

#include <security.h>

#include "Unit1.h"

#define CntRow 19
#define CntRow2 18
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;

AnsiString FieldName[CntRow] = {"nach1", "nach2", "fil", "num", "day", "mon", "year",
                                "disp", "tel_disp", "index", "city", "street",
                                "nom_dom", "okpo", "tax_num", "tax_doc",
                                "rahunok", "bank", "mfo"};

AnsiString FieldZnach[CntRow];

AnsiString FieldName2[CntRow2] = {"num_contr", "day_contr", "mon_contr", "year_contr",
                                  "abon_name", "index2", "city2", "street2", "nom_dom2",
                                  "rahunok2", "bank2", "mfo2", "okpo2", "tax_num2",
                                  "tax_doc2", "pr1", "pr2", "pr3"};

AnsiString FieldZnach2[CntRow2];

AnsiString str;
AnsiString ip;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
  : TForm(Owner)
{
  str = "";

  TIniFile *ini;
  ini = new TIniFile(ChangeFileExt(Application->ExeName, ".ini"));
  if (!ini->ValueExists("MAIN", "nach1"))
    ini->WriteString("MAIN", "nach1", nach1->Text);
  str = ini->ReadString("MAIN", "nach1", nach1->Text);
  nach1->Text = str;
  if (!ini->ValueExists("MAIN", "nach2"))
    ini->WriteString("MAIN", "nach2", nach2->Text);
  str = ini->ReadString("MAIN", "nach2", nach2->Text);
  nach2->Text = str;
  if (!ini->ValueExists("MAIN", "fil"))
    ini->WriteString("MAIN", "fil", fil->Text);
  str = ini->ReadString("MAIN", "fil", fil->Text);
  fil->Text = str;
  if (!ini->ValueExists("MAIN", "num"))
    ini->WriteString("MAIN", "num", num->Text);
  str = ini->ReadString("MAIN", "num", num->Text);
  num->Text = str;
  if (!ini->ValueExists("MAIN", "day"))
    ini->WriteString("MAIN", "day", day->Text);
  str = ini->ReadString("MAIN", "day", day->Text);
  day->Text = str;
  if (!ini->ValueExists("MAIN", "mon"))
    ini->WriteString("MAIN", "mon", mon->Text);
  str = ini->ReadString("MAIN", "mon", mon->Text);
  mon->Text = str;
  if (!ini->ValueExists("MAIN", "year"))
    ini->WriteString("MAIN", "year", year->Text);
  str = ini->ReadString("MAIN", "year", year->Text);
  year->Text = str;
  if (!ini->ValueExists("MAIN", "disp"))
    ini->WriteString("MAIN", "disp", disp->Text);
  str = ini->ReadString("MAIN", "disp", disp->Text);
  disp->Text = str;
  if (!ini->ValueExists("MAIN", "tel_disp"))
    ini->WriteString("MAIN", "tel_disp", tel_disp->Text);
  str = ini->ReadString("MAIN", "tel_disp", tel_disp->Text);
  tel_disp->Text = str;
  if (!ini->ValueExists("MAIN", "index"))
    ini->WriteString("MAIN", "index", index->Text);
  str = ini->ReadString("MAIN", "index", index->Text);
  index->Text = str;
  if (!ini->ValueExists("MAIN", "city"))
    ini->WriteString("MAIN", "city", city->Text);
  str = ini->ReadString("MAIN", "city", city->Text);
  city->Text = str;
  if (!ini->ValueExists("MAIN", "street"))
    ini->WriteString("MAIN", "street", street->Text);
  str = ini->ReadString("MAIN", "street", street->Text);
  street->Text = str;
  if (!ini->ValueExists("MAIN", "nom_dom"))
    ini->WriteString("MAIN", "nom_dom", nom_dom->Text);
  str = ini->ReadString("MAIN", "nom_dom", nom_dom->Text);
  nom_dom->Text = str;
  if (!ini->ValueExists("MAIN", "okpo"))
    ini->WriteString("MAIN", "okpo", okpo->Text);
  str = ini->ReadString("MAIN", "okpo", okpo->Text);
  okpo->Text = str;
  if (!ini->ValueExists("MAIN", "tax_num"))
    ini->WriteString("MAIN", "tax_num", tax_num->Text);
  str = ini->ReadString("MAIN", "tax_num", tax_num->Text);
  tax_num->Text = str;
  if (!ini->ValueExists("MAIN", "tax_doc"))
    ini->WriteString("MAIN", "tax_doc", tax_doc->Text);
  str = ini->ReadString("MAIN", "tax_doc", tax_doc->Text);
  tax_doc->Text = str;
  if (!ini->ValueExists("MAIN", "rahunok"))
    ini->WriteString("MAIN", "rahunok", rahunok->Text);
  str = ini->ReadString("MAIN", "rahunok", rahunok->Text);
  rahunok->Text = str;
  if (!ini->ValueExists("MAIN", "bank"))
    ini->WriteString("MAIN", "bank", bank->Text);
  str = ini->ReadString("MAIN", "bank", bank->Text);
  bank->Text = str;
  if (!ini->ValueExists("MAIN", "mfo"))
    ini->WriteString("MAIN", "mfo", mfo->Text);
  str = ini->ReadString("MAIN", "mfo", mfo->Text);
  mfo->Text = str;
  if (!ini->ValueExists("MAIN", "ip"))
    ini->WriteString("MAIN", "ip", "10.36.7.134");
  ip = ini->ReadString("MAIN", "ip", "10.36.7.134");

  delete ini;
}

//---------------------------------------------------------------------------
void TForm1::CrAddons2()
{
  AnsiString query = "SELECT a.abon_id,ABON_46.GETADDRESSBYID (2, c.device_id,2),\
                     ABON_46.GETADDRESSBYID (2, c.device_id,3),d.QUANTITY,c.setup_date,\
                     (select distinct a2.tarif\
                      from rg46.tarif_service a2,rg46.tarif_block b2,\
                      rg46.tarif_scheme_info c2, rg46.tarif_scheme_link d2\
                      where a2.tarifblock_id=b2.tarifblock_id\
                      and a2.service_id=c.devicecat_id\
                      and a.abonstatus_id=d2.abonstatus_id\
                      and d2.tarifscheme_id=c2.tarifscheme_id\
                      and c2.tarifblock_id=b2.tarifblock_id\
                      and b2.remove_date is NULL) as tarif, c.phone\
                      FROM rg46.abonent a, abon_46.device c, abon_46.device_info d\
                      WHERE a.PERSONAL_COUNT=%s\
                      AND a.abon_id=c.abon_id\
                      AND c.device_id=d.device_id\
                      AND c.remove_date is NULL\
                      AND c.devicecat_id IN (1251,1252,1263)\
                      ORDER BY c.phone";

  struct dodatok1
  {
    AnsiString adr1;
    AnsiString adr2;
    AnsiString cnt;
    AnsiString setup_date;
    AnsiString price;
    AnsiString phone;
  } *arr;

  char *sss;

  int ii,jj;
  AnsiString vAsCurDir=GetCurrentDir();
  Variant v,v1,out;

  char *qry = new char[query.Length()+ls->Text.Length()];
  sprintf(qry, query.c_str(), ls->Text.c_str());
  DB->ExecuteSQLQuery(qry, Variant(0), ii, jj, out, qoOpen, -1);
  delete qry;

  int summa = 0;
  arr = new struct dodatok1[ii];
  for (int i = 0; i < ii; i++)
  {
    Application->ProcessMessages();
    arr[i].adr1 = out.GetElement(i,1).AsType(varString);
    arr[i].adr2 = out.GetElement(i,2).AsType(varString);
    arr[i].cnt = out.GetElement(i,3).AsType(varString);
    arr[i].setup_date = out.GetElement(i,4).AsType(varString);
    arr[i].price = out.GetElement(i,5).AsType(varString);
    arr[i].phone = out.GetElement(i,6).AsType(varString);
    summa += StrToInt(arr[i].price)*StrToInt(arr[i].cnt);
  }

  if(!fStart)
  {
    try
    {
      //Создаем объект Word.Application
      vVarApp=CreateOleObject("Word.Application");
      fStart=true;
    }
    catch(...)
    {
      MessageBox(0, "Ошибка при открытии сервера Word",
                    "Ошибка", MB_OK);
      return;
    }
  }
  //Делаем сервер видимым
  vVarApp.OlePropertySet("Visible",false);
  //Получаем свойство Documents объекта
  vVarDocs=vVarApp.OlePropertyGet("Documents");
  AnsiString vAsCurDir1=vAsCurDir+"\\dodatok.doc";
  vVarDocs.OleProcedure("Open", vAsCurDir1.c_str());
  if(vVarDocs.OlePropertyGet("Count") != 1)
  {
    MessageBox(0, "Ошибка при создании документов",
                  "Ошибка", MB_OK);

    return;
  }

  vVarDoc=vVarDocs.OleFunction("Item",1);
  //И сделаем его Альбомным
  vVarDoc.OlePropertyGet("PageSetup").OlePropertySet("Orientation",1);

  v1 = vVarApp.OlePropertyGet("Selection");
  v1.OleFunction("WholeStory");
  v1.OleProcedure("Delete");

  AnsiString str = "ВАТ \"Укртелеком\" .\nДоговір №%s від \"%s\" %s %s р.";
  sss = new char[str.Length()+FieldZnach2[0].Length()+FieldZnach2[1].Length()+FieldZnach2[2].Length()+FieldZnach2[3].Length()];
  sprintf(sss,str.c_str(),FieldZnach2[0].c_str(),FieldZnach2[1].c_str(),FieldZnach2[2].c_str(),FieldZnach2[3].c_str());

  vVarParagraphs=vVarDoc.OlePropertyGet("Sections");
  vVarParagraph=vVarParagraphs.OleFunction("Item",1)
                              .OlePropertyGet("Headers");
  vVarParagraph=vVarParagraph.OleFunction("Item", 1);
  vVarParagraph.OlePropertyGet("Range")
               .OlePropertySet("Text", sss);

  delete sss;

  //Будем работать с первым документом - Item == 2;
  vVarDoc=vVarDocs.OleFunction("Item",1);
  //Смотреть будем тоже на первый документ
  vVarDoc.OleProcedure("Activate");
  //vVarDoc.OleProcedure("Select");
  vVarParagraphs=vVarDoc.OlePropertyGet("Paragraphs");
  //Задаем текст для вывода
  str="Додаток 2";
  //Добавляем параграф
  vVarParagraphs.OleProcedure("Add");
  //Работаем с первым параграфом
  vVarParagraph=vVarParagraphs.OleFunction("Item",1);
  //Заносим в него текст
  vVarParagraph.OlePropertyGet("Range").
               OlePropertySet("Text",str.c_str());
  //Выравниваем по правому краю
  vVarParagraph.OlePropertySet("Alignment",2);
  //Второй параграф
  str="до Договору № " + FieldZnach2[0];
  vVarParagraphs.OleProcedure("Add");
  vVarParagraph=vVarParagraphs.OleFunction("Item",2);
  vVarParagraph.OlePropertyGet("Range").
                OlePropertySet("Text",str.c_str());
  vVarParagraph.OlePropertySet("Alignment",2);
  //Четвертый параграф
  str="від \""+ FieldZnach2[1] + "\" " + FieldZnach2[2] + " " + FieldZnach2[3] + "р.";
  vVarParagraphs.OleProcedure("Add");
  vVarParagraph=vVarParagraphs.OleFunction("Item",3);
  vVarParagraph.OlePropertyGet("Range").
               OlePropertySet("Text",str.c_str());
  vVarParagraph.OlePropertySet("Alignment",2);
  //Пятый параграф - пустой
  vVarParagraphs.OleProcedure("Add");
  //Шестой параграф
  str="Розрахунок вартості послуг з організації пар проводів між двома кінцевими пунктами та щомісячне користування послугами";
  vVarParagraphs.OleProcedure("Add");
  vVarParagraph=vVarParagraphs.OleFunction("Item",5);
  vVarParagraph.OlePropertyGet("Range").
               OlePropertySet("Text",str.c_str());
  //wdAlignParagraphCenter
  vVarParagraph.OlePropertySet("Alignment",1);
  v=vVarParagraph.OlePropertyGet("Range").OlePropertyGet("Font");
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Name","Times New Roman");
  v.OlePropertySet("Bold",true);
  v.OlePropertySet("Italic",false);
  v.OlePropertySet("Underline",0);
  v=vVarApp.OlePropertyGet("Selection");
  v.OleFunction("EndKey");

  str="за Договором №%s від \"%s\" %s %sр.";
  sss = new char[str.Length()+FieldZnach2[0].Length()+FieldZnach2[1].Length()+FieldZnach2[2].Length()+FieldZnach2[3].Length()];
  sprintf(sss,str.c_str(),FieldZnach2[0].c_str(),FieldZnach2[1].c_str(),FieldZnach2[2].c_str(),FieldZnach2[3].c_str());
  vVarParagraphs.OleProcedure("Add");
  vVarParagraph=vVarParagraphs.OleFunction("Item",6);
  vVarParagraph.OlePropertyGet("Range").
               OlePropertySet("Text",sss);
  //wdAlignParagraphCenter
  vVarParagraph.OlePropertySet("Alignment",1);

  vVarParagraphs.OleProcedure("Add"); //7
  vVarParagraphs.OleProcedure("Add"); //8

  vVarParagraph=vVarParagraphs.OleFunction("Item",8);
  vVarRange = vVarParagraph.OlePropertyGet("Range");
  vVarParagraph.OlePropertySet("Alignment",1);

  vVarDoc.OlePropertyGet("Tables").
          OleProcedure("Add", vVarRange, ii+1, 6, 1, 1);

  vVarParagraphs.OleProcedure("Add"); //9
  vVarParagraphs.OleProcedure("Add"); //10

  //Работать будем с первой таблицей
  vVarTable=vVarDoc.OlePropertyGet("Tables").
                    OleFunction("Item",1);

  v=vVarTable.OlePropertyGet("Columns");
  //Устанавливаем ширину первого столбца
  v.OleFunction("Item",1).OlePropertySet("Width",30);
  v.OleFunction("Item",2).OlePropertySet("Width",120);
  v.OleFunction("Item",3).OlePropertySet("Width",200);
  v.OleFunction("Item",4).OlePropertySet("Width",50);
  v.OleFunction("Item",5).OlePropertySet("Width",70);
  v.OleFunction("Item",6).OlePropertySet("Width",180);

  //Выравниваем таблицу по центру
  vVarTable.OlePropertyGet("Rows").
            OlePropertySet("Alignment",1);
  //Установка ширины таблицы
  vVarTable.OleFunction("AutoFitBehavior",2);
  //Сетка в таблице
  vVarApp.OlePropertyGet("ActiveWindow").
          OlePropertyGet("View").
          OlePropertySet("TableGridlines",true);

  vVarCell=vVarTable.OleFunction("Cell",1,1);
  vVarCell.OleFunction("Select");
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("Font");
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Underline",0);
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Bold",false);
  vVarCell.OlePropertyGet("Range").
           OlePropertySet("Text","№ з/п");

  vVarCell=vVarTable.OleFunction("Cell",1,2);
  vVarCell.OleFunction("Select");
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("Font");
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Underline",0);
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Bold",false);
  vVarCell.OlePropertyGet("Range").
           OlePropertySet("Text","Назва послуги");

  vVarCell=vVarTable.OleFunction("Cell",1,3);
  vVarCell.OleFunction("Select");
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("Font");
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Underline",0);
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Bold",false);
  vVarCell.OlePropertyGet("Range").
           OlePropertySet("Text","Кінцеві пункти");

  vVarCell=vVarTable.OleFunction("Cell",1,4);
  vVarCell.OleFunction("Select");
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("Font");
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Underline",0);
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Bold",false);
  vVarCell.OlePropertyGet("Range").
           OlePropertySet("Text","Кількість пар \nпроводів ");

  vVarCell=vVarTable.OleFunction("Cell",1,5);
  vVarCell.OleFunction("Select");
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("Font");
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Underline",0);
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Bold",false);
  vVarCell.OlePropertyGet("Range").
           OlePropertySet("Text","Плата за\nвключення (грн.)\nбез ПДВ");

  vVarCell=vVarTable.OleFunction("Cell",1,6);
  vVarCell.OleFunction("Select");
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("Font");
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Underline",0);
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Bold",false);
  vVarCell.OlePropertyGet("Range").
           OlePropertySet("Text","Примітки");

  for (int i = 0; i < ii; i++)
  {
    Application->ProcessMessages();
    vVarCell=vVarTable.OleFunction("Cell",i+2,1);
    vVarCell.OleFunction("Select");
    v = vVarApp.OlePropertyGet("Selection").
                OlePropertyGet("Font");
    v.OlePropertySet("Size",12);
    v.OlePropertySet("Underline",0);
    v.OlePropertySet("Color",clBlack);
    v.OlePropertySet("Bold",false);
    vVarCell.OlePropertyGet("Range").
             OlePropertySet("Text",i+1);

    vVarCell=vVarTable.OleFunction("Cell",i+2,2);
    vVarCell.OleFunction("Select");
    v = vVarApp.OlePropertyGet("Selection").
                OlePropertyGet("Font");
    v.OlePropertySet("Size",12);
    v.OlePropertySet("Underline",0);
    v.OlePropertySet("Color",clBlack);
    v.OlePropertySet("Bold",false);
    vVarCell.OlePropertyGet("Range").
             OlePropertySet("Text","Організація та включення Споживачу пар проводів між двома кінцевими пунктами");

    str = "%s\n%s";
    sss = new char[str.Length()+arr[i].adr1.Length()+arr[i].adr2.Length()+1];
    sprintf(sss, str.c_str(), arr[i].adr1.c_str(), arr[i].adr2.c_str());
    vVarCell=vVarTable.OleFunction("Cell",i+2,3);
    vVarCell.OleFunction("Select");
    v = vVarApp.OlePropertyGet("Selection").
                OlePropertyGet("Font");
    v.OlePropertySet("Size",12);
    v.OlePropertySet("Underline",0);
    v.OlePropertySet("Color",clBlack);
    v.OlePropertySet("Bold",false);
    vVarCell.OlePropertyGet("Range").
             OlePropertySet("Text", sss);
    delete sss;

    vVarCell=vVarTable.OleFunction("Cell",i+2,4);
    vVarCell.OleFunction("Select");
    v = vVarApp.OlePropertyGet("Selection").
                OlePropertyGet("Font");
    v.OlePropertySet("Size",12);
    v.OlePropertySet("Underline",0);
    v.OlePropertySet("Color",clBlack);
    v.OlePropertySet("Bold",false);
    vVarCell.OlePropertyGet("Range").
             OlePropertySet("Text", arr[i].cnt.c_str());

    vVarCell=vVarTable.OleFunction("Cell",i+2,5);
    vVarCell.OleFunction("Select");
    v = vVarApp.OlePropertyGet("Selection").
                OlePropertyGet("Font");
    v.OlePropertySet("Size",12);
    v.OlePropertySet("Underline",0);
    v.OlePropertySet("Color",clBlack);
    v.OlePropertySet("Bold",false);
    vVarCell.OlePropertyGet("Range").
             OlePropertySet("Text", "666,67");

    vVarCell=vVarTable.OleFunction("Cell",i+2,6);
    vVarCell.OleFunction("Select");
    v = vVarApp.OlePropertyGet("Selection").
                OlePropertyGet("Font");
    v.OlePropertySet("Size",12);
    v.OlePropertySet("Underline",0);
    v.OlePropertySet("Color",clBlack);
    v.OlePropertySet("Bold",false);
    vVarCell.OlePropertyGet("Range").
             OlePropertySet("Text", arr[i].phone.c_str());
  }

  vVarApp.OlePropertyGet("Selection").
          OleProcedure("MoveDown",4,2);

  str="Постійна плата за щомісячне користування парами проводів";
  //Заносим в него текст
  vVarParagraph.OlePropertyGet("Range").
               OlePropertySet("Text",str.c_str());

  vVarParagraphs.OleProcedure("Add");
  vVarParagraphs.OleProcedure("Add");
  vVarApp.OlePropertyGet("Selection").
          OleProcedure("MoveDown",4,2);

  vVarRange = vVarParagraph.OlePropertyGet("Range");
  vVarParagraph.OlePropertySet("Alignment",1);

  vVarDoc.OlePropertyGet("Tables").
          OleProcedure("Add", vVarRange, ii+2, 5, 1, 1);

  vVarTable=vVarDoc.OlePropertyGet("Tables").
                    OleFunction("Item",2);

  v=vVarTable.OlePropertyGet("Columns");
  v.OleFunction("Item",1).OlePropertySet("Width",30);
  v.OleFunction("Item",2).OlePropertySet("Width",110);
  v.OleFunction("Item",3).OlePropertySet("Width",250);
  v.OleFunction("Item",4).OlePropertySet("Width",50);
  v.OleFunction("Item",5).OlePropertySet("Width",80);

  //Выравниваем таблицу по центру
  vVarTable.OlePropertyGet("Rows").
            OlePropertySet("Alignment",1);
  //Установка ширины таблицы
  vVarTable.OleFunction("AutoFitBehavior",2);

  vVarCell=vVarTable.OleFunction("Cell",1,1);
  vVarCell.OleFunction("Select");
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("Font");
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Underline",0);
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Bold",false);
  vVarCell.OlePropertyGet("Range").
           OlePropertySet("Text","№ з/п");

  vVarCell=vVarTable.OleFunction("Cell",1,2);
  vVarCell.OleFunction("Select");
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("Font");
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Underline",0);
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Bold",false);
  vVarCell.OlePropertyGet("Range").
           OlePropertySet("Text","Назва послуги");

  vVarCell=vVarTable.OleFunction("Cell",1,3);
  vVarCell.OleFunction("Select");
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("Font");
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Underline",0);
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Bold",false);
  vVarCell.OlePropertyGet("Range").
           OlePropertySet("Text","Кінцеві пункти");

  vVarCell=vVarTable.OleFunction("Cell",1,4);
  vVarCell.OleFunction("Select");
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("Font");
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Underline",0);
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Bold",false);
  vVarCell.OlePropertyGet("Range").
           OlePropertySet("Text","Кількість пар \nпроводів ");

  vVarCell=vVarTable.OleFunction("Cell",1,5);
  vVarCell.OleFunction("Select");
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("Font");
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Underline",0);
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Bold",false);
  vVarCell.OlePropertyGet("Range").
           OlePropertySet("Text","Вартість щомісячного користування парами проводів (грн.) без ПДВ");

  for (int i = 0; i < ii; i++)
  {
    Application->ProcessMessages();
    vVarCell=vVarTable.OleFunction("Cell",i+2,1);
    vVarCell.OleFunction("Select");
    v = vVarApp.OlePropertyGet("Selection").
                OlePropertyGet("Font");
    v.OlePropertySet("Size",12);
    v.OlePropertySet("Underline",0);
    v.OlePropertySet("Color",clBlack);
    v.OlePropertySet("Bold",false);
    vVarCell.OlePropertyGet("Range").
             OlePropertySet("Text",i+1);

    vVarCell=vVarTable.OleFunction("Cell",i+2,2);
    vVarCell.OleFunction("Select");
    v = vVarApp.OlePropertyGet("Selection").
                OlePropertyGet("Font");
    v.OlePropertySet("Size",12);
    v.OlePropertySet("Underline",0);
    v.OlePropertySet("Color",clBlack);
    v.OlePropertySet("Bold",false);
    vVarCell.OlePropertyGet("Range").
             OlePropertySet("Text","Надання в користування Споживачу пар проводів між двома кінцевими пунктами");

    str = "%s\n%s";
    sss = new char[str.Length()+arr[i].adr1.Length()+arr[i].adr2.Length()+1];
    sprintf(sss, str.c_str(), arr[i].adr1.c_str(), arr[i].adr2.c_str());
    vVarCell=vVarTable.OleFunction("Cell",i+2,3);
    vVarCell.OleFunction("Select");
    v = vVarApp.OlePropertyGet("Selection").
                OlePropertyGet("Font");
    v.OlePropertySet("Size",12);
    v.OlePropertySet("Underline",0);
    v.OlePropertySet("Color",clBlack);
    v.OlePropertySet("Bold",false);
    vVarCell.OlePropertyGet("Range").
             OlePropertySet("Text", sss);
    delete sss;

    vVarCell=vVarTable.OleFunction("Cell",i+2,4);
    vVarCell.OleFunction("Select");
    v = vVarApp.OlePropertyGet("Selection").
                OlePropertyGet("Font");
    v.OlePropertySet("Size",12);
    v.OlePropertySet("Underline",0);
    v.OlePropertySet("Color",clBlack);
    v.OlePropertySet("Bold",false);
    vVarCell.OlePropertyGet("Range").
             OlePropertySet("Text", arr[i].cnt.c_str());

    vVarCell=vVarTable.OleFunction("Cell",i+2,5);
    vVarCell.OleFunction("Select");
    v = vVarApp.OlePropertyGet("Selection").
                OlePropertyGet("Font");
    v.OlePropertySet("Size",12);
    v.OlePropertySet("Underline",0);
    v.OlePropertySet("Color",clBlack);
    v.OlePropertySet("Bold",false);
    vVarCell.OlePropertyGet("Range").
             OlePropertySet("Text", arr[i].price.c_str());
  }

  vVarCell=vVarTable.OleFunction("Cell",ii+2,5);
  vVarCell.OleFunction("Select");
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("Font");
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Underline",0);
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Bold",false);
  vVarCell.OlePropertyGet("Range").
           OlePropertySet("Text", IntToStr(summa).c_str());

  vVarParagraphs.OleProcedure("Add");
  vVarParagraphs.OleProcedure("Add");
  vVarApp.OlePropertyGet("Selection").
          OleProcedure("MoveDown",4,2);

  vVarRange = vVarParagraph.OlePropertyGet("Range");
  vVarParagraph.OlePropertySet("Alignment",1);

  vVarDoc.OlePropertyGet("Tables").
          OleProcedure("Add", vVarRange, 1, 3, 1, 1);

  vVarTable=vVarDoc.OlePropertyGet("Tables").
                    OleFunction("Item",3);

  v=vVarTable.OlePropertyGet("Columns");
  //Устанавливаем ширину первого столбца
  v.OleFunction("Item",1).OlePropertySet("Width",270);
  v.OleFunction("Item",2).OlePropertySet("Width",220);
  v.OleFunction("Item",3).OlePropertySet("Width",270);

  vVarTable.OleFunction("AutoFormat",1,false,true,
                                      true,true,
                                      true,false,
                                      true,false,true);

  str = "Укртелеком";
  vVarCell=vVarTable.OleFunction("Cell",1,1);
  vVarCell.OleFunction("Select");
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("Font");
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Underline",0);
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Bold",true);
  vVarCell.OlePropertyGet("Range").
           OlePropertySet("Text",str.c_str());

  str = "Споживач";
  vVarCell=vVarTable.OleFunction("Cell",1,3);
  vVarCell.OleFunction("Select");
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("Font");
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Underline",0);
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Bold",true);
  vVarCell.OlePropertyGet("Range").
           OlePropertySet("Text",str.c_str());

  vVarParagraphs.OleProcedure("Add");
  vVarApp.OlePropertyGet("Selection").
          OleProcedure("MoveDown",4,2);

  vVarRange = vVarParagraph.OlePropertyGet("Range");
  vVarParagraph.OlePropertySet("Alignment",0);

  vVarDoc.OlePropertyGet("Tables").
          OleProcedure("Add", vVarRange, 1, 3, 1, 1);

  vVarTable=vVarDoc.OlePropertyGet("Tables").
                    OleFunction("Item",4);

  v=vVarTable.OlePropertyGet("Columns");
  //Устанавливаем ширину первого столбца
  v.OleFunction("Item",1).OlePropertySet("Width",270);
  v.OleFunction("Item",2).OlePropertySet("Width",220);
  v.OleFunction("Item",3).OlePropertySet("Width",270);

  vVarTable.OleFunction("AutoFormat",1,false,true,
                                      true,true,
                                      true,false,
                                      true,false,true);

  //Выравниваем таблицу по центру
  vVarTable.OlePropertyGet("Rows").
            OlePropertySet("Alignment",0);

  AnsiString str2 = "Чернігівська філія ВАТ \"Укртелеком\"\n%s\n\n%s";
  sss = new char[str2.Length()+FieldZnach[0].Length()+FieldZnach[1].Length()];
  wsprintf(sss,str2.c_str(),FieldZnach[0].c_str(),FieldZnach[1].c_str());

  vVarCell=vVarTable.OleFunction("Cell",2,1);
  vVarCell.OleFunction("Select");
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("Font");
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Underline",0);
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Bold",true);
  vVarCell.OlePropertyGet("Range").
           OlePropertySet("Text",sss);

  v = vVarApp.OlePropertyGet("Selection");
  v.OleProcedure("MoveRight", 1, strlen(sss));
  delete sss;

  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("ParagraphFormat");
  v.OlePropertySet("Alignment", 2);

  str2 = "%s\n%s\n\n%s";
  sss = new char[str2.Length()+FieldZnach2[4].Length()+FieldZnach2[15].Length()+FieldZnach2[16].Length()];
  wsprintf(sss,str2.c_str(),FieldZnach2[4].c_str(),FieldZnach2[15].c_str(),FieldZnach2[16].c_str());

  vVarCell=vVarTable.OleFunction("Cell",2,3);
  vVarCell.OleFunction("Select");
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("Font");
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Underline",0);
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Bold",true);
  vVarCell.OlePropertyGet("Range").
           OlePropertySet("Text",sss);

  v = vVarApp.OlePropertyGet("Selection");
  v.OleProcedure("MoveRight", 1, strlen(sss));
  delete sss;

  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("ParagraphFormat");
  v.OlePropertySet("Alignment", 2);

//  delete sss;

  vAsCurDir1=vAsCurDir+"\\dodatok2.doc";
  vVarDoc=vVarDocs.OleFunction("Item",1);
  vVarDoc.OleProcedure("SaveAs",vAsCurDir1.c_str());

  if(fStart)
  {
    vVarApp.OleProcedure("Quit");
    fStart = false;
    vVarApp = Unassigned;
  }
}

//---------------------------------------------------------------------------
void TForm1::CrAddons1()
{
  AnsiString query = "SELECT a.abon_id,ABON_46.GETADDRESSBYID (2, c.device_id,2), \
                     ABON_46.GETADDRESSBYID (2, c.device_id,3),d.QUANTITY,c.setup_date, \
                     c.phone \
                     FROM rg46.abonent a, abon_46.device c, abon_46.device_info d \
                     WHERE a.PERSONAL_COUNT=%s \
                     AND a.abon_id=c.abon_id \
                     AND c.device_id=d.device_id \
                     AND c.remove_date is NULL \
                     AND c.devicecat_id IN (1251,1252,1263) \
                     ORDER BY c.phone";

  struct dodatok1
  {
    AnsiString adr1;
    AnsiString adr2;
    AnsiString cnt;
    AnsiString setup_date;
    AnsiString phone;
  } *arr;

//  struct dodatok *arr;

  char *sss;

  int ii,jj;
  AnsiString vAsCurDir=GetCurrentDir();
  Variant v,v1,out;

  char *qry = new char[query.Length()+ls->Text.Length()];
  sprintf(qry, query.c_str(), ls->Text.c_str());
  DB->ExecuteSQLQuery(qry, Variant(0), ii, jj, out, qoOpen, -1);
  delete qry;

  arr = new struct dodatok1[ii];//(struct dodatok1*)malloc(sizeof(struct dodatok1)*ii);
  for (int i = 0; i < ii; i++)
  {
//    Application->ProcessMessages();
    if (!out.GetElement(i,1).IsNull())
      arr[i].adr1 = out.GetElement(i,1).AsType(varString);
    else
      arr[i].adr1 = "";
    if (!out.GetElement(i,2).IsNull())
      arr[i].adr2 = out.GetElement(i,2).AsType(varString);
    else
      arr[i].adr2 = "";
    if (!out.GetElement(i,3).IsNull())
      arr[i].cnt = out.GetElement(i,3).AsType(varString);
    else
      arr[i].cnt = "";
    if (!out.GetElement(i,3).IsNull())
      arr[i].setup_date = out.GetElement(i,4).AsType(varString);
    else
      arr[i].setup_date = "";
    if (!out.GetElement(i,3).IsNull())
      arr[i].phone = out.GetElement(i,5).AsType(varString);
    else
      arr[i].phone = "";
  }
  if(!fStart)
  {
    try
    {
      //Создаем объект Word.Application
      vVarApp=CreateOleObject("Word.Application");
      fStart=true;
    }
    catch(...)
    {
      MessageBox(0, "Ошибка при открытии сервера Word",
                    "Ошибка", MB_OK);
      return;
    }
  }
  //Делаем сервер видимым
  vVarApp.OlePropertySet("Visible",false);
  //Получаем свойство Documents объекта
  vVarDocs=vVarApp.OlePropertyGet("Documents");
  AnsiString vAsCurDir1=vAsCurDir+"\\dodatok.doc";
  vVarDocs.OleProcedure("Open", vAsCurDir1.c_str());
  //Проверяем, что создано два документа
  if(vVarDocs.OlePropertyGet("Count") != 1)
  {
    MessageBox(0, "Ошибка при создании документов",
                  "Ошибка", MB_OK);

    return;
  }

  vVarDoc=vVarDocs.OleFunction("Item",1);
  //И сделаем его Альбомным
  vVarDoc.OlePropertyGet("PageSetup").OlePropertySet("Orientation",1);

  //Будем работать с первым документом - Item == 2;
  vVarDoc=vVarDocs.OleFunction("Item",1);
  //Смотреть будем тоже на первый документ
  vVarDoc.OleProcedure("Activate");
  //vVarDoc.OleProcedure("Select");

//  vVarApp.OlePropertyGet("Selection").OleProcedure("Delete");
  v1 = vVarApp.OlePropertyGet("Selection");
  v1.OleFunction("WholeStory");
  v1.OleProcedure("Delete");

//  vVarDoc.OlePropertyGet("Bookmarks")
//  vVarParagraph=vVarDoc.OlePropertyGet("Sections");
  AnsiString str = "ВАТ \"Укртелеком\" .\nДоговір №%s від \"%s\" %s %s р.";
  sss = new char[str.Length()+FieldZnach2[0].Length()+FieldZnach2[1].Length()+FieldZnach2[2].Length()+FieldZnach2[3].Length()];
  sprintf(sss,str.c_str(),FieldZnach2[0].c_str(),FieldZnach2[1].c_str(),FieldZnach2[2].c_str(),FieldZnach2[3].c_str());

  vVarParagraphs=vVarDoc.OlePropertyGet("Sections");
  vVarParagraph=vVarParagraphs.OleFunction("Item",1)
                              .OlePropertyGet("Headers");
  vVarParagraph=vVarParagraph.OleFunction("Item", 1);
  vVarParagraph.OlePropertyGet("Range")
               .OlePropertySet("Text", sss);

  delete sss;

/*  vVarParagraph.OlePropertyGet("Range")
               .OlePropertySet("Text", "sadfsdfsefsd");*/
//  vVarParagraph=vVarParagraph.OlePropertyGet("Headers");
//  vVarParagraph.OleFunction("Item", wdHeaderFooterPrimary);

  vVarParagraphs=vVarDoc.OlePropertyGet("Paragraphs");
  //Задаем текст для вывода
  str="Додаток 1";
  //Добавляем параграф
  vVarParagraphs.OleProcedure("Add");
  //Работаем с первым параграфом
  vVarParagraph=vVarParagraphs.OleFunction("Item",1);
  //Заносим в него текст
  vVarParagraph.OlePropertyGet("Range").
               OlePropertySet("Text",str.c_str());
  //Выравниваем по правому краю
  vVarParagraph.OlePropertySet("Alignment",2);
  //Второй параграф
  str="до Договору № " + FieldZnach2[0];
  vVarParagraphs.OleProcedure("Add");
  vVarParagraph=vVarParagraphs.OleFunction("Item",2);
  vVarParagraph.OlePropertyGet("Range").
                OlePropertySet("Text",str.c_str());
  vVarParagraph.OlePropertySet("Alignment",2);
  //Четвертый параграф
  str="від \""+ FieldZnach2[1] + "\" " + FieldZnach2[2] + " " + FieldZnach2[3] + "р.";
  vVarParagraphs.OleProcedure("Add");
  vVarParagraph=vVarParagraphs.OleFunction("Item",3);
  vVarParagraph.OlePropertyGet("Range").
               OlePropertySet("Text",str.c_str());
  vVarParagraph.OlePropertySet("Alignment",2);
  //Пятый параграф - пустой
  vVarParagraphs.OleProcedure("Add");
  //Шестой параграф
  str="Технічні дані по організації пар проводів між двома кінцевими пунктами ";
  vVarParagraphs.OleProcedure("Add");
  vVarParagraph=vVarParagraphs.OleFunction("Item",5);
  vVarParagraph.OlePropertyGet("Range").
               OlePropertySet("Text",str.c_str());
  //wdAlignParagraphCenter
  vVarParagraph.OlePropertySet("Alignment",1);
  v=vVarParagraph.OlePropertyGet("Range").OlePropertyGet("Font");
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Name","Times New Roman");
  v.OlePropertySet("Bold",true);
  v.OlePropertySet("Italic",false);
  v.OlePropertySet("Underline",0);
  v=vVarApp.OlePropertyGet("Selection");
  v.OleFunction("EndKey");

  str="за Договором №%s від \"%s\" %s %sр.";
  sss = new char[str.Length()+FieldZnach2[0].Length()+FieldZnach2[1].Length()+FieldZnach2[2].Length()+FieldZnach2[3].Length()];
  sprintf(sss,str.c_str(),FieldZnach2[0].c_str(),FieldZnach2[1].c_str(),FieldZnach2[2].c_str(),FieldZnach2[3].c_str());
  vVarParagraphs.OleProcedure("Add");
  vVarParagraph=vVarParagraphs.OleFunction("Item",6);
  vVarParagraph.OlePropertyGet("Range").
               OlePropertySet("Text",sss);

  delete sss;

  //wdAlignParagraphCenter
  vVarParagraph.OlePropertySet("Alignment",1);

  vVarParagraphs.OleProcedure("Add"); //7
  vVarParagraphs.OleProcedure("Add"); //8

  vVarParagraph=vVarParagraphs.OleFunction("Item",8);
  vVarRange = vVarParagraph.OlePropertyGet("Range");
  vVarParagraph.OlePropertySet("Alignment",1);

  vVarDoc.OlePropertyGet("Tables").
          OleProcedure("Add", vVarRange, ii+1, 5, 1, 1);

  vVarParagraphs.OleProcedure("Add"); //9
  vVarParagraphs.OleProcedure("Add"); //10

  //Работать будем с первой таблицей
  vVarTable=vVarDoc.OlePropertyGet("Tables").
                    OleFunction("Item",1);

  v=vVarTable.OlePropertyGet("Columns");
  //Устанавливаем ширину первого столбца
  v.OleFunction("Item",1).OlePropertySet("Width",30);
  v.OleFunction("Item",2).OlePropertySet("Width",200);
  v.OleFunction("Item",3).OlePropertySet("Width",200);
  v.OleFunction("Item",4).OlePropertySet("Width",80);
  v.OleFunction("Item",5).OlePropertySet("Width",80);

  //Выравниваем таблицу по центру
  vVarTable.OlePropertyGet("Rows").
            OlePropertySet("Alignment",1);
  //Установка ширины таблицы
  vVarTable.OleFunction("AutoFitBehavior",2);
  //Сетка в таблице
  vVarApp.OlePropertyGet("ActiveWindow").
          OlePropertyGet("View").
          OlePropertySet("TableGridlines",true);

  vVarCell=vVarTable.OleFunction("Cell",1,1);
  vVarCell.OleFunction("Select");
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("Font");
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Underline",0);
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Bold",false);
  vVarCell.OlePropertyGet("Range").
           OlePropertySet("Text","№ з/п");

  vVarCell=vVarTable.OleFunction("Cell",1,2);
  vVarCell.OleFunction("Select");
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("Font");
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Underline",0);
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Bold",false);
  vVarCell.OlePropertyGet("Range").
           OlePropertySet("Text","Назва послуги, \nцільове призначення");

  vVarCell=vVarTable.OleFunction("Cell",1,3);
  vVarCell.OleFunction("Select");
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("Font");
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Underline",0);
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Bold",false);
  vVarCell.OlePropertyGet("Range").
           OlePropertySet("Text","Кінцеві пункти");

  vVarCell=vVarTable.OleFunction("Cell",1,4);
  vVarCell.OleFunction("Select");
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("Font");
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Underline",0);
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Bold",false);
  vVarCell.OlePropertyGet("Range").
           OlePropertySet("Text","Кількість пар \nпроводів ");

  vVarCell=vVarTable.OleFunction("Cell",1,5);
  vVarCell.OleFunction("Select");
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("Font");
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Underline",0);
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Bold",false);
  vVarCell.OlePropertyGet("Range").
           OlePropertySet("Text","Дата організації \nпар проводів");

  for (int i = 0; i < ii; i++)
  {
    Application->ProcessMessages();
    vVarCell=vVarTable.OleFunction("Cell",i+2,1);
    vVarCell.OleFunction("Select");
    v = vVarApp.OlePropertyGet("Selection").
                OlePropertyGet("Font");
    v.OlePropertySet("Size",12);
    v.OlePropertySet("Underline",0);
    v.OlePropertySet("Color",clBlack);
    v.OlePropertySet("Bold",false);
    vVarCell.OlePropertyGet("Range").
             OlePropertySet("Text",i+1);

    vVarCell=vVarTable.OleFunction("Cell",i+2,2);
    vVarCell.OleFunction("Select");
    v = vVarApp.OlePropertyGet("Selection").
                OlePropertyGet("Font");
    v.OlePropertySet("Size",12);
    v.OlePropertySet("Underline",0);
    v.OlePropertySet("Color",clBlack);
    v.OlePropertySet("Bold",false);
    vVarCell.OlePropertyGet("Range").
             OlePropertySet("Text","Надання в користування Споживачу пар проводів для _________________");

    str = "%s\n%s";
    sss = new char[str.Length()+arr[i].adr1.Length()+arr[i].adr2.Length()+1];
    sprintf(sss, str.c_str(), arr[i].adr1.c_str(), arr[i].adr2.c_str());
    vVarCell=vVarTable.OleFunction("Cell",i+2,3);
    vVarCell.OleFunction("Select");
    v = vVarApp.OlePropertyGet("Selection").
                OlePropertyGet("Font");
    v.OlePropertySet("Size",12);
    v.OlePropertySet("Underline",0);
    v.OlePropertySet("Color",clBlack);
    v.OlePropertySet("Bold",false);
    vVarCell.OlePropertyGet("Range").
             OlePropertySet("Text", sss);
    delete sss;

    vVarCell=vVarTable.OleFunction("Cell",i+2,4);
    vVarCell.OleFunction("Select");
    v = vVarApp.OlePropertyGet("Selection").
                OlePropertyGet("Font");
    v.OlePropertySet("Size",12);
    v.OlePropertySet("Underline",0);
    v.OlePropertySet("Color",clBlack);
    v.OlePropertySet("Bold",false);
    vVarCell.OlePropertyGet("Range").
             OlePropertySet("Text", (arr[i].cnt + "\n" + arr[i].phone).c_str());

    vVarCell=vVarTable.OleFunction("Cell",i+2,5);
    vVarCell.OleFunction("Select");
    v = vVarApp.OlePropertyGet("Selection").
                OlePropertyGet("Font");
    v.OlePropertySet("Size",12);
    v.OlePropertySet("Underline",0);
    v.OlePropertySet("Color",clBlack);
    v.OlePropertySet("Bold",false);
    vVarCell.OlePropertyGet("Range").
             OlePropertySet("Text", arr[i].setup_date.c_str());
  }

  vVarApp.OlePropertyGet("Selection").
          OleProcedure("MoveDown",4,2);

  vVarRange = vVarParagraph.OlePropertyGet("Range");
  vVarParagraph.OlePropertySet("Alignment",1);

  vVarDoc.OlePropertyGet("Tables").
          OleProcedure("Add", vVarRange, 1, 3, 1, 1);

  vVarTable=vVarDoc.OlePropertyGet("Tables").
                    OleFunction("Item",2);

  v=vVarTable.OlePropertyGet("Columns");
  //Устанавливаем ширину первого столбца
  v.OleFunction("Item",1).OlePropertySet("Width",270);
  v.OleFunction("Item",2).OlePropertySet("Width",220);
  v.OleFunction("Item",3).OlePropertySet("Width",270);

  vVarTable.OleFunction("AutoFormat",1,false,true,
                                      true,true,
                                      true,false,
                                      true,false,true);

  str = "Укртелеком";
  vVarCell=vVarTable.OleFunction("Cell",1,1);
  vVarCell.OleFunction("Select");
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("Font");
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Underline",0);
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Bold",true);
  vVarCell.OlePropertyGet("Range").
           OlePropertySet("Text",str.c_str());

  str = "Споживач";
  vVarCell=vVarTable.OleFunction("Cell",1,3);
  vVarCell.OleFunction("Select");
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("Font");
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Underline",0);
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Bold",true);
  vVarCell.OlePropertyGet("Range").
           OlePropertySet("Text",str.c_str());

  vVarParagraphs.OleProcedure("Add");
  vVarApp.OlePropertyGet("Selection").
          OleProcedure("MoveDown",4,2);

  vVarRange = vVarParagraph.OlePropertyGet("Range");
  vVarParagraph.OlePropertySet("Alignment",0);

  vVarDoc.OlePropertyGet("Tables").
          OleProcedure("Add", vVarRange, 1, 3, 1, 1);

  vVarTable=vVarDoc.OlePropertyGet("Tables").
                    OleFunction("Item",3);

  v=vVarTable.OlePropertyGet("Columns");
  //Устанавливаем ширину первого столбца
  v.OleFunction("Item",1).OlePropertySet("Width",270);
  v.OleFunction("Item",2).OlePropertySet("Width",220);
  v.OleFunction("Item",3).OlePropertySet("Width",270);

  vVarTable.OleFunction("AutoFormat",1,false,true,
                                      true,true,
                                      true,false,
                                      true,false,true);

  //Выравниваем таблицу по центру
  vVarTable.OlePropertyGet("Rows").
            OlePropertySet("Alignment",0);

  AnsiString str2 = "Чернігівська філія ВАТ \"Укртелеком\"\n%s\n\n%s";
  sss = new char[str2.Length()+FieldZnach[0].Length()+FieldZnach[1].Length()];
  wsprintf(sss,str2.c_str(),FieldZnach[0].c_str(),FieldZnach[1].c_str());

  vVarCell=vVarTable.OleFunction("Cell",2,1);
  vVarCell.OleFunction("Select");
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("Font");
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Underline",0);
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Bold",true);
  vVarCell.OlePropertyGet("Range").
           OlePropertySet("Text",sss);

  v = vVarApp.OlePropertyGet("Selection");
  v.OleProcedure("MoveRight", 1, strlen(sss));
  delete sss;
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("ParagraphFormat");
  v.OlePropertySet("Alignment", 2);

  str2 = "%s\n%s\n\n%s";
  sss = new char[str2.Length()+FieldZnach2[4].Length()+FieldZnach2[15].Length()+FieldZnach2[16].Length()];
  wsprintf(sss,str2.c_str(),FieldZnach2[4].c_str(),FieldZnach2[15].c_str(),FieldZnach2[16].c_str());

  vVarCell=vVarTable.OleFunction("Cell",2,3);
  vVarCell.OleFunction("Select");
  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("Font");
  v.OlePropertySet("Size",12);
  v.OlePropertySet("Underline",0);
  v.OlePropertySet("Color",clBlack);
  v.OlePropertySet("Bold",true);
  vVarCell.OlePropertyGet("Range").
           OlePropertySet("Text",sss);

  v = vVarApp.OlePropertyGet("Selection");
  v.OleProcedure("MoveRight", 1, strlen(sss));
  delete sss;

  v = vVarApp.OlePropertyGet("Selection").
              OlePropertyGet("ParagraphFormat");
  v.OlePropertySet("Alignment", 2);

  delete sss;

  vAsCurDir1=vAsCurDir+"\\dodatok1.doc";
  vVarDoc=vVarDocs.OleFunction("Item",1);
  vVarDoc.OleProcedure("SaveAs",vAsCurDir1.c_str());

  if(fStart)
  {
    vVarApp.OleProcedure("Quit");
    fStart = false;
    vVarApp = Unassigned;
  }
}

//---------------------------------------------------------------------------
void __fastcall TForm1::FormClose(TObject *Sender, TCloseAction &Action)
{
  AnsiString str = "";

  TIniFile *ini;
  ini = new TIniFile(ChangeFileExt(Application->ExeName, ".ini"));
  ini->WriteString("MAIN", "nach1", nach1->Text);
  ini->WriteString("MAIN", "nach2", nach2->Text);
  ini->WriteString("MAIN", "fil", fil->Text);
  ini->WriteString("MAIN", "num", num->Text);
  ini->WriteString("MAIN", "day", day->Text);
  ini->WriteString("MAIN", "mon", mon->Text);
  ini->WriteString("MAIN", "year", year->Text);
  ini->WriteString("MAIN", "disp", disp->Text);
  ini->WriteString("MAIN", "tel_disp", tel_disp->Text);
  ini->WriteString("MAIN", "index", index->Text);
  ini->WriteString("MAIN", "city", city->Text);
  ini->WriteString("MAIN", "street", street->Text);
  ini->WriteString("MAIN", "nom_dom", nom_dom->Text);
  ini->WriteString("MAIN", "okpo", okpo->Text);
  ini->WriteString("MAIN", "tax_num", tax_num->Text);
  ini->WriteString("MAIN", "tax_doc", tax_doc->Text);
  ini->WriteString("MAIN", "rahunok", rahunok->Text);
  ini->WriteString("MAIN", "bank", bank->Text);
  ini->WriteString("MAIN", "mfo", mfo->Text);
  ini->WriteString("MAIN", "ip", "10.36.7.134");
  delete ini;

  astra->LogOut();
  delete DB;
}

//---------------------------------------------------------------------------
AnsiString GetMonth(int num)
{
  if (num == 0)
    return "січня";
  if (num == 1)
    return "лютого";
  if (num == 2)
    return "березня";
  if (num == 3)
    return "квітня";
  if (num == 4)
    return "травня";
  if (num == 5)
    return "червня";
  if (num == 6)
    return "липня";
  if (num == 7)
    return "серпня";
  if (num == 8)
    return "вересня";
  if (num == 9)
    return "жовтня";
  if (num == 10)
    return "листопада";
  if (num == 11)
    return "грудня";
  return "";
}

//---------------------------------------------------------------------------

void __fastcall TForm1::ConnectClick(TObject *Sender)
{
  Connect->Enabled = false;
  char *str = new char[ls->Text.Length()];
  strcpy(str, ls->Text.c_str());
  for (int i = 0; i < ls->Text.Length(); i++)
  {
    if (str[i] >= '0' && str[i] <= '9')
      continue;
    else
    {
      delete str;
      Connect->Enabled = true;
      ShowMessage("Введенное значение не является числом!");
      ls->SetFocus();
      return;
    }
  }
  delete str;
  int value;
  if (ls->Text.Length() < 16)
  {
    unsigned int crc = 0;
    AnsiString nsils;
    AnsiString ttt;
    ttt = "743300";
    nsils = ls->Text;
    for (int i = 0; i < 10-nsils.Length()-1; i++)
      ttt += "0";
    ttt += nsils;
    for (int i = 1; i <= ttt.Length(); i++)
    {
      crc += (unsigned int)(StrToInt(ttt[i]));
    }
    crc = crc % 10;
    ttt += " ";
    ttt[ttt.Length()] = (crc + 0x30);
    ls->Text = ttt;
  }
  StatusBar1->SimpleText = "Ждите... Идет работа!";
  if (CrMainReport())
  {
    CrAddons1();
    CrAddons2();
    StatusBar1->SimpleText = "Отчеты сделаны!";
  }
  else
    StatusBar1->SimpleText = "Ошибка при создании отчетов!";
  Connect->Enabled = true;
  ls->SetFocus();
}
//---------------------------------------------------------------------------

bool TForm1::CrMainReport()
{
  bool exist = false;
  AnsiString    vAsCurDir = GetCurrentDir();
  vAsCurDir=vAsCurDir+"\\record.xls";
/*
  AnsiString query = "SELECT cc.contract_num,cc.setup_date,p.ABON_NAME,h.IND,r.NAME, \
                      s.NAME,h.NUM,ba.PAY_ACCOUNT,bb.FULL_NAME, \
                      bb.MFO,p.OKPO,p.TAX_NUM,p.TAX_DOC,ap1.VALUE,ap2.VALUE,ap3.VALUE \
                      FROM rg46.abonent ab,abon_46.pred p,abon_46.ABON_ADDRESS a, \
                      rg46.HOUSE h, rg46.STREET s,rg46.street_type b, rg46.region r, \
                      abon_46.bank_account ba, abon_46.contract cc, rg46.bank bb, \
                      abon_46.abon_property ap1,abon_46.abon_property ap2, \
                      abon_46.abon_property ap3 \
                      WHERE ab.personal_count=%s and cc.remove_date is NULL \
                      AND ab.abon_id=a.abon_id AND p.abon_id=a.abon_id \
                      AND a.HOUSE_ID=h.HOUSE_ID AND h.STREET_ID=s.STREET_ID \
                      AND s.STREETTYPE_ID=b.STREETTYPE_ID AND ab.abon_id=cc.abon_id(+) \
                      AND h.REGION_ID=r.REGION_ID AND ba.abon_id=p.abon_id \
                      AND a.ADDRESSTYPE_ID=4 AND ba.BANK_ID(+)=bb.BANK_ID \
                      AND ap1.ABON_ID(+)=p.abon_id \
                      AND ap2.ABON_ID(+)=p.abon_id \
                      AND ap3.ABON_ID(+)=p.abon_id \
                      AND ap1.PROPERTY_ID(+)=1018 \
                      AND ap2.PROPERTY_ID(+)=1019 \
                      AND ap3.PROPERTY_ID(+)=1017";
*/


  AnsiString query = "SELECT cc.contract_num,cc.setup_date,p.ABON_NAME,h.IND,r.NAME,\
                      s.NAME,h.NUM,ba.PAY_ACCOUNT,bb.FULL_NAME, \
                      bb.MFO,p.OKPO,p.TAX_NUM,p.TAX_DOC,ap1.VALUE,ap2.VALUE,ap3.VALUE \
                      FROM abon_46.ABON_ADDRESS a, \
                      rg46.HOUSE h, rg46.STREET s,rg46.street_type b, rg46.region r, \
                      abon_46.pred p LEFT OUTER JOIN abon_46.bank_account ba ON \
                      (ba.abon_id=p.abon_id) LEFT OUTER JOIN abon_46.abon_property ap1 ON \
                      (ap1.ABON_ID=p.abon_id and ap1.PROPERTY_ID=1018) \
                      LEFT OUTER JOIN abon_46.abon_property ap2 ON \
                      (ap2.ABON_ID=p.abon_id AND ap2.PROPERTY_ID=1019) \
                      LEFT OUTER JOIN abon_46.abon_property ap3 ON \
                      (ap3.ABON_ID=p.abon_id AND ap3.PROPERTY_ID=1017) \
                      LEFT OUTER JOIN rg46.bank bb ON (ba.BANK_ID=bb.BANK_ID), \
                      rg46.abonent ab LEFT OUTER JOIN abon_46.contract cc ON \
                      (ab.abon_id=cc.abon_id) WHERE ab.personal_count=%s \
                      and cc.remove_date is NULL AND ab.abon_id=a.abon_id AND \
                      p.abon_id=a.abon_id AND a.HOUSE_ID=h.HOUSE_ID AND \
                      h.STREET_ID=s.STREET_ID AND s.STREETTYPE_ID=b.STREETTYPE_ID\
                      AND h.REGION_ID=r.REGION_ID";
  int i,j;
  Variant out;
/*  AnsiString query = "select a.contract_num,a.setup_date,c.abon_name\
                      from abon_46.CONTRACT a,rg46.abonent b, abon_46.pred c\
                      where a.abon_id=b.abon_id\
                      and b.personal_count=%s\
                      and a.remove_date is NULL and a.abon_id=c.abon_id";*/

  char *qry = new char[query.Length()+ls->Text.Length()];
  sprintf(qry, query.c_str(), ls->Text.c_str());
  try
  {
    Form1->DB->ExecuteSQLQuery(qry, Variant(0), i, j, out, qoOpen, -1);
  }
  catch (Exception &msg)
  {
    ShowMessage(msg.Message);
  }
  delete qry;

  if (i == 0 || j == 0)
  {
    ShowMessage("Данных по абоненту нету!!!");
    return false;
  }

  if (!out.GetElement(0,0).IsNull())
    FieldZnach2[0] = out.GetElement(0,0).AsType(varString);
  else
    FieldZnach2[0] = "";
  AnsiString t = "";
  if (!out.GetElement(0,1).IsNull())
  {
    t = out.GetElement(0,1).AsType(varString);
    AnsiString tt = t.SubString(1,2);
    FieldZnach2[1] = tt;
    tt = t.SubString(4,2);
    FieldZnach2[2] = GetMonth(StrToInt(tt)-1);
    tt = t.SubString(7,4);
    FieldZnach2[3] = tt;
  }
  else
  {
    FieldZnach2[1] = "";
    FieldZnach2[2] = "";
    FieldZnach2[3] = "";
  }
  if (!out.GetElement(0,2).IsNull())
    FieldZnach2[4] = out.GetElement(0,2).AsType(varString);
  else
    FieldZnach2[4] = "";
  if (!out.GetElement(0,3).IsNull())
    FieldZnach2[5] = out.GetElement(0,3).AsType(varString);
  else
    FieldZnach2[5] = "";
  if (!out.GetElement(0,4).IsNull())
    FieldZnach2[6] = out.GetElement(0,4).AsType(varString);
  else
    FieldZnach2[6] = "";
  if (!out.GetElement(0,5).IsNull())
    FieldZnach2[7] = out.GetElement(0,5).AsType(varString);
  else
    FieldZnach2[7] = "";
  if (!out.GetElement(0,6).IsNull())
    FieldZnach2[8] = out.GetElement(0,6).AsType(varString);
  else
    FieldZnach2[8] = "";
  if (!out.GetElement(0,7).IsNull())
    FieldZnach2[9] = out.GetElement(0,7).AsType(varString);
  else
    FieldZnach2[9] = "";
  if (!out.GetElement(0,8).IsNull())
    FieldZnach2[10] = out.GetElement(0,8).AsType(varString);
  else
    FieldZnach2[10] = "";
  if (!out.GetElement(0,9).IsNull())
    FieldZnach2[11] = out.GetElement(0,9).AsType(varString);
  else
    FieldZnach2[11] = "";
  if (!out.GetElement(0,10).IsNull())
    FieldZnach2[12] = out.GetElement(0,10).AsType(varString);
  else
    FieldZnach2[12] = "";
  if (!out.GetElement(0,11).IsNull())
    FieldZnach2[13] = out.GetElement(0,11).AsType(varString);
  else
    FieldZnach2[13] = "";
  if (!out.GetElement(0,12).IsNull())
    FieldZnach2[14] = out.GetElement(0,12).AsType(varString);
  else
    FieldZnach2[14] = "";
  if (!out.GetElement(0,13).IsNull())
    FieldZnach2[15] = out.GetElement(0,13).AsType(varString);
  else
    FieldZnach2[15] = "";
  if (!out.GetElement(0,14).IsNull())
    FieldZnach2[16] = out.GetElement(0,14).AsType(varString);
  else
    FieldZnach2[16] = "";
  if (!out.GetElement(0,15).IsNull())
    FieldZnach2[17] = out.GetElement(0,15).AsType(varString);
  else
    FieldZnach2[17] = "";

  query = "";

  FieldZnach[0] = nach1->Text;
  FieldZnach[1] = nach2->Text;
  FieldZnach[2] = fil->Text;
  FieldZnach[3] = num->Text;
  FieldZnach[4] = day->Text;
  FieldZnach[5] = mon->Text;
  FieldZnach[6] = year->Text;
  FieldZnach[7] = disp->Text;
  FieldZnach[8] = tel_disp->Text;
  FieldZnach[9] = index->Text;
  FieldZnach[10] = city->Text;
  FieldZnach[11] = street->Text;
  FieldZnach[12] = nom_dom->Text;
  FieldZnach[13] = okpo->Text;
  FieldZnach[14] = tax_num->Text;
  FieldZnach[15] = tax_doc->Text;
  FieldZnach[16] = rahunok->Text;
  FieldZnach[17] = bank->Text;
  FieldZnach[18] = mfo->Text;

  Variant v;
  if(!fStart)
  {
    try
    {
      vVarApp=CreateOleObject("Excel.Application");
      fStart=true;
    }
    catch(...)
    {
      MessageBox(0, "Ошибка при открытии сервера Excel",
                    "Ошибка", MB_OK);
      return false;
    }
  }
  else return false;

  vVarApp.OlePropertySet("Visible",false);
  vVarBooks=vVarApp.OlePropertyGet("Workbooks");
  if (FileExists(vAsCurDir))
  {
    exist = true;
    vVarBooks.OleProcedure("Open", vAsCurDir.c_str());
  }
  else
  {
    vVarApp.OlePropertySet("SheetsInNewWorkbook",3);
    vVarBooks.OleProcedure("Add");
  }
  vVarBook=vVarBooks.OlePropertyGet("Item",1);
  vVarSheets=vVarBook.OlePropertyGet("Worksheets") ;
  vVarSheet=vVarSheets.OlePropertyGet("Item",1);
  vVarSheet.OleProcedure("Activate");
//  vAsCurDir=GetCurrentDir();
  vVarSheet=vVarSheets.OlePropertyGet("Item",1);
  vVarSheet.OleProcedure("Activate");
  for (int i=1; i <= CntRow; i++)
  {
    Application->ProcessMessages();
    vVarCell=vVarSheet.OlePropertyGet("Cells").OlePropertyGet("Item",1,i);
    vVarCell.OlePropertySet("NumberFormat", "@");
    vVarCell.OlePropertySet("Value", FieldName[i-1].c_str());
    vVarCell= vVarSheet.OlePropertyGet("Cells").OlePropertyGet("Item",2,i);
    vVarCell.OlePropertySet("NumberFormat", "@");
    vVarCell.OlePropertySet("Value", FieldZnach[i-1].c_str());
  }
  for (int i=CntRow+1; i <= CntRow+CntRow2+1; i++)
  {
    Application->ProcessMessages();
    vVarCell=vVarSheet.OlePropertyGet("Cells").OlePropertyGet("Item",1,i);
    vVarCell.OlePropertySet("NumberFormat", "@");
    vVarCell.OlePropertySet("Value", FieldName2[i-CntRow-1].c_str());
    vVarCell= vVarSheet.OlePropertyGet("Cells").OlePropertyGet("Item",2,i);
    vVarCell.OlePropertySet("NumberFormat", "@");
    vVarCell.OlePropertySet("Value", FieldZnach2[i-CntRow-1].c_str());
  }
  if (!exist)
    vVarApp.OlePropertyGet("Workbooks").OlePropertyGet("Item",1).
            OleProcedure("SaveAs",vAsCurDir.c_str());
  else
    vVarApp.OlePropertyGet("Workbooks").OlePropertyGet("Item",1).
            OleProcedure("Save");

  if(fStart)
  {
    vVarApp.OleProcedure("Quit");
    fStart = false;
    vVarApp = Unassigned;
  }

  return true;
}

//---------------------------------------------------------------------------
void __fastcall TForm1::FormCreate(TObject *Sender)
{
  astra = new TAstraConnection(NULL);
  astra->Connect(ip);

  char UserName[1024];
  unsigned long UserLen = 1024;
  GetUserNameEx(2, UserName, &UserLen);
//  ShowMessage(UserName);

  char UserGuid[1024];
  unsigned long GuidLen = 1024;
  GetUserNameEx(6, UserGuid, &GuidLen);
//  ShowMessage(UserGuid);

  char UserComp[1024];
  unsigned long CompLen = 1024;
  GetComputerName(UserComp, &CompLen);

  char ConnectString[1024];

  strcpy(ConnectString, UserComp);
  strcat(ConnectString, "\\");
  strcat(ConnectString, UserGuid);
  astra->Login("astra46", UserName, "", ConnectString);

//  astra->Login("astra46", "innovinn", "database", "report");
  DB = new TdmOraDB(NULL);
  DB->Connect(Integer(TVarData(astra->Connection).VDispatch));
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormActivate(TObject *Sender)
{
  ls->SetFocus();  
}
//---------------------------------------------------------------------------


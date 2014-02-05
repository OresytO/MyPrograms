//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
//---------------------------------------------------------------------------
USEFORM("Unit1.cpp", FStart);
USEFORM("Unit2.cpp", FInputDeli);
USEFORM("Unit3.cpp", FOutputDeli);
USEFORM("Unit4.cpp", FShow);
USEFORM("Unit5.cpp", FAddCourier);
USEFORM("Unit6.cpp", FAddForwarder);
USEFORM("Unit7.cpp", FCities);
USEFORM("Unit8.cpp", FContr);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
	try
	{
		Application->Initialize();
		Application->Title = "Rebok2";
		Application->CreateForm(__classid(TFStart), &FStart);
		Application->CreateForm(__classid(TFInputDeli), &FInputDeli);
		Application->CreateForm(__classid(TFOutputDeli), &FOutputDeli);
		Application->CreateForm(__classid(TFShow), &FShow);
		Application->CreateForm(__classid(TFAddCourier), &FAddCourier);
		Application->CreateForm(__classid(TFAddForwarder), &FAddForwarder);
		Application->CreateForm(__classid(TFCities), &FCities);
		Application->CreateForm(__classid(TFContr), &FContr);
		Application->Run(); 
	}
	catch (Exception &exception)
	{
		Application->ShowException(&exception);
	}
	catch (...)
	{
		try
		{
			throw Exception("");
		}
		catch (Exception &exception)
		{
			Application->ShowException(&exception);
		}
	}
	return 0;
}
//---------------------------------------------------------------------------

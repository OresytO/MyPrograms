#include<vcl>
#include<iostream>
#include<math>
#include<conio>
using namespace std;

const int size = 10;  // ���������� ��������

double Fc(double x, double y, double z, double b);
int main();

	double xp = Nv-D;	cout<< "�������� xp = " <<setw(6) <<xp<< "; ";
    double xk = D+Nv;	cout<< "�������� xk = " <<setw(6) <<xk<< "; ";
    double dx = (xk-xp)/10;	cout<< "�������� dx = " <<setw(6) <<dx<< "." <<endl;
    double yp = (Nv-D)/2;	cout<< "�������� yp = " <<setw(6) <<yp<< "; ";
    double yk = (Nv+D)*2;	cout<< "�������� yk = " <<setw(6) <<yk<< "; ";
    double dy = (yk-yp)/12;	cout<< "�������� dy = " <<setw(6) <<dy<< "." <<endl;
    double  z = sqrt(Nv*Nv+D*D);	cout<< "�������� z = " <<setw(7) << z << "." <<endl<<endl;

     cout<< "��������� ����������� ������� c[x, y, z, b]" <<endl;
     cout<<setw(12) << " y/x -- > ";
     for(x = xp; x <= xk+dx/2; x += dx)
          cout<<setw(12) << x;
     cout<<endl;
     for(y = yp; y <= yk+dy/2; y += dy)
     {
          cout<<setw(6) << y << " -- > ";
          for(x = xp; x <= xk+dx/2; x += dx)
          {
               b = Fb(x, y, z);
               cout<<setw(12) << Fc(x, y, z, b); // ���������� �������� ������� c[x, y, z, b]
          }
          cout<<endl;
     }





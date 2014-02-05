#include <vcl>
#include <iostream>
#include <iomanip>
#include <math>
#include <conio>
using namespace std;

const int size = 10;

double Fb(double x, double y, double z);
double Fc(double x, double y, double z, double b);
double Fact(int n);	// ��������
double Fs(double x, int i, int j);	// ����
double Fss(double x, int m, int n);	// ������� ����

double Fai(double x, int i);
double FSer(double A[size], int n);
double Fmin(double A[size], int n);
double Fmax(double A[size], int n);
double Fsum(double A[size], double x);
double Flog(double osn, double ch);

int main()
{
cout.precision(3);	// ������ #.###
cout.setf(ios_base::fixed);	// ������ #.##
SetConsoleOutputCP(1251);	// ��������� ��������

// ���� ������
double dx, xp, xk, x, y, yp, yk, dy, z, b;

cout << "�������� ������� �1" << endl << endl;
int N;	cout << "������ �������� N = ";	cin >> N;
xp = -1.83 * N + 0.5;	cout << "�������� xp = " << setw(6) << xp << "; ";
xk = 2.38 * N + 0.5;	cout << setw(14) << "�������� xk = " << setw(6) << xk << "; ";
dx = (xk - xp)/8;	cout << setw(14) << "�������� dx = " << setw(6) << dx << "." << endl;
yp = -0.74 * N + 1.3;	cout << "�������� yp = " << setw(6) << yp << "; ";
yk = 0.86 * N + 1.7;	cout << setw(14) << "�������� yk = " << setw(6) << yk << "; ";
dy = (yk - yp)/10;	cout << setw(14) << "�������� dy = " << setw(6) << dy << "." << endl;
z = -1.3 * N + 1.5;	cout << "�������� z = " << setw(7) << z << "." << endl << endl;

cout << "��������� ����������� ������� b[x, y, z]" << endl;
cout << setw(12) << " y/x --> ";
for(x = xp; x <= xk; x += dx)
cout << setw(12) << x;
cout << endl;
for(y = yp; y <= yk; y += dy)
{
cout << setw(7) << y << " --> ";
for(x = xp; x <= xk; x += dx)
cout << setw(12) << Fb(x, y, z);	// ���������� �������� ������� b[x, y, z]
cout << endl;
}

cout << endl << "�������� ������� �2" << endl << endl;
double D = 15;

xp = N - D;	cout << "�������� xp = " << setw(8) << xp << "; ";
xk = D + N;	cout << "�������� xk = " << setw(8) << xk << "; ";
dx = (xk - xp)/10;	cout << "�������� dx = " << setw(8) << dx << "." << endl;
yp = (N - D)/2;	cout << "�������� yp = " << setw(8) << yp << "; ";
yk = (N + D) * 2;	cout << "�������� yk = " << setw(8) << yk << "; ";
dy = (yk - yp)/12;	cout << "�������� dy = " << setw(8) << dy << "." << endl;
z = sqrt(N * N + D * D);	cout << "�������� z = " << setw(7) << z << "." << endl << endl;

cout << "��������� ����������� ������� c[x, y, z, b]" << endl;
cout << setw(12) << " y/x --> ";
for(x = xp; x <= xk + dx/2; x += dx)
cout << setw(12) << x;
cout << endl;
for(y = yp; y <= yk + dy/2; y += dy)
{
cout << setw(7) << y << " --> ";
for(x = xp; x <= xk + dx/2; x += dx)
{
b = Fb(x, y, z);
cout << setw(12) << Fc(x, y, z, b);	// ���������� �������� ������� c[x, y, z, b]
}
cout << endl;
}

cout << endl << "�������� ������� �3" << endl << endl;
int n = 5, m = 10;
x = 1.61 * N;	cout << "�������� x = " << x << "." << endl;
cout << "������� ����/���� ss' = " << Fss(x, m, n) << endl;

cout << endl << "�������� ������� �4" << endl << endl;
cout.precision(3);
double A[size];
n = 10;
x = 0.68 * N;	cout << "�������� x = " << x << "." << endl << endl;
for(int i = 0; i < size; i++)
{
A[i] = Fai(x, i + 1);
cout << "A[" << i << "] = " << setw(6) << A[i] << endl;
}

// ������ �������
cout << endl << "������ �������� ������ A C = " << FSer(A, n) << endl;
cout << "̳������� �������� ������ A m = " << Fmin(A, n) << endl;
cout << "����������� �������� ������ A M = " << Fmax(A, n) << endl << endl;

z = (pow(fabs(Fmax(A, n)), 0.3)  -  FSer(A, n))/(Fmax(A, n) * Fmin(A, n)) * Fsum(A, x)
 - pow(Flog(9, fabs(Fmax(A, n) + Fmin(A, n))), 2.3);
cout << "�������� ������ z = " << z << endl;
getch(); return 0;
}


// ���������� �������� ����������� ������� b[x, y, z]
double Fb(double x, double y, double z)
{
double b1 =  pow(fabs(y + x ), 0.2)/pow(fabs(z), 1.34);
double b2 = pow(x - y, 2)/pow(sin(z), 2);
double b3 = pow(fabs(z - y), 3)/pow(cos(z * z), 3);
return b1 + b2 + b3;

}

// ���������� �������� ����������� ������� �[x, y, z, b]
double Fc(double x, double y, double z, double b)
{
double c = 0;
if((x >= -0.5)&&(x < 0.2))
{
c  = pow(1 + y, 2) - pow(fabs((x + pow(z, 3))/(b * b + 4)), 1.0/3);
}
else if((0.4 <= y)&&(y < 0.8))
c =exp(-(x - 2)) + (y + z)/pow(fabs(b + z),0.34);
else c = pow(1 + y, 2) * (x + pow(z,3))/1.5/pow(fabs(b), 0.34);
return c;
}

// ���������� ���������� �������� �������� ������
double FSer(double A[size], int n)
{
double s = 0;
for(int i = 0; i < n; i++) s += A[i];
return s/n;
}

// ���������� ���������� �������� �������� ������
double Fmin(double A[size], int n)
{
double min = A[0];
for(int i = 1; i < n; i++)
if(min > A[i]) min = A[i];
return min;
}

// ���������� ������������� �������� �������� ������
double Fmax(double A[size], int n)
{
double max = A[0];
for(int i = 1; i < n; i++)
if(max < A[i]) max = A[i];
return max;
}

// ���������� ���� �������� z;
double Fsum(double A[size], double x)
{
double s = 0;
for(int i = 1; i <= size; i++)
s += A[i - 1]/((i * i)/x);
return s;
}

double Flog(double osn, double ch)
{
return log(osn)/log(ch);
}

// ���������� �������� �������� ������
double Fai(double x, int i)
{
double a1 = pow(cos(i + 3), 3)/(pow(i, 2.0/i) + 3.5 * x);
double a2 = pow(Flog(2,(i + x)), 1.0/i);
return a1 - a2;
}

double Fact(int n)
{
double f = 1;
if(n > 1) for(int i = 2; i <= n; i++) f *= i;
return f;
}

double Fs(double x, int i, int j )
{
double w1 = pow(- 1, j - 1) * pow(x + i, 3);
double w2 = i * i +Fact(j)  + 2;
return w1/w2;
}

double Fss(double x, int m, int n)
{
double s = 0, s1 = 0, c = 0;
for(int i = 1; i <= m; i++)
{
for(int j = 1; j <= n; j++)
{
c = Fs(x, i, j);
cout << setprecision(8) << setw(16) << c;
s1 += c;
}
cout << setw(7) << "P = " << setw(15) << s1 << endl;
s += s1;
}
return s;
}



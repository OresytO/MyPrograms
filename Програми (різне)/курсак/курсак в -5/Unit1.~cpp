#include<vcl>
#include<iostream> // Для потокового введення - виведення
#include<iomanip>
#include<math>
#include<conio> // Для консольного режиму роботи
using namespace std;  // Використання стандартного простору імен

const int size = 10;  // Оголошення констант

// Обчислення значення математичної функції a[x, y, z, b]
double Fn_a(double x, double y, double z, double b);
// Обчислення значення математичної функції b[x, y, z]
double Fn_b(double x, double y, double z);

double Fn_c(double x, double y, double z, double b);

double Fact(int n);
double Fn_w(double x, int i, int j);
double Fn_Ws(double ( *Fn_w)(double, int, int), double x, int m, int n);

double Fn_ai(double x, int i);
// Обчислення середнього значення елементів масиву
double Fn_Szn(double A[size], int n);
// Обчислення мінімального значення елементів масиву
double Fn_min(double A[size], int n);
// Обчислення максимального значення елементів масиву
double Fn_max(double A[size], int n);
// Обчислення суми множника z
double Fn_sum(double A[size], double x);
// Обчислення значення логарифма від будь - якого числа за будь - якою основою
double Fn_log(double osn, double ch);


int main()
{
     // Задання точності
     cout.precision(3);	// Формат #.###
     cout.setf(ios_base::fixed);	// Формат #.##
     SetConsoleOutputCP(1251);	// Виведення кирилиці

     // Опис змінних
     double dx, xp, xk, x, y, yp, yk, dy, z, b;

     cout << "Завдання №1" << endl << endl;
     int Nv; cout<< "Введіть значення Nv = "; cin>>Nv;
     xp = -1.83 * Nv + 0.5; 	cout<< "Значення xp = " <<setw(6) <<xp<< "; ";
     xk = 2.38 * Nv + 0.5; 	cout<<setw(14) << "Значення xk = " <<setw(6) <<xk<< "; ";
     dx = (xk - xp)/8; 	cout<<setw(14) << "Значення dx = " <<setw(6) <<dx<< "." <<endl;
     yp = -0.74 * Nv + 1.3; 	cout<< "Значення yp = " <<setw(6) <<yp<< "; ";
     yk = 0.86 * Nv + 1.7; 	cout<<setw(14) << "Значення yk = " <<setw(6) <<yk<< "; ";
     dy = (yk - yp)/10; 	cout<<setw(14) << "Значення dy = " <<setw(6) <<dy<< "." <<endl;
     z = -1.3 * Nv + 1.5; 	cout<< "Значення z = " <<setw(7) << z << "." <<endl<<endl;

     cout<< "Двовимірне табулювання функції a[x, y, z, b]" <<endl;
     cout<<setw(12) << " y/x -- > ";
     for(x = xp; x <= xk+dx/2; x += dx)
          cout<<setw(8) << x;
     cout<<endl;
     for(y = yp; y <= yk+dy/2; y += dy)
     {
          cout<<setw(6) << y << " -- > ";
          for(x = xp; x <= xk+dx/2; x += dx)
          {
               b = Fn_b(x, y, z);
               cout<<setw(8) << Fn_a(x, y, z, b); // Розрахунок значення функцій a[x, y, z, b]
          }
          cout<<endl;
     }

     cout << endl << "Завдання №2" << endl << endl;
     double D =14;

     xp = Nv-D; cout<< "Значення xp = " <<setw(6) <<xp<< "; ";
     xk = D+Nv; cout<< "Значення xk = " <<setw(6) <<xk<< "; ";
     dx = (xk-xp)/10; cout<< "Значення dx = " <<setw(6) <<dx<< "." <<endl;
     yp = (Nv-D)/2; cout<< "Значення yp = " <<setw(6) <<yp<< "; ";
     yk = (Nv+D)*2;cout<< "Значення yk = " <<setw(6) <<yk<< "; ";
     dy = (yk-yp)/12; cout<< "Значення dy = " <<setw(6) <<dy<< "." <<endl;
     z = sqrt(Nv*Nv+D*D); cout<< "Значення z = " <<setw(7) << z << "." <<endl<<endl;

     cout<< "Двовимірне табулювання функції c[x, y, z, b]" <<endl;
     cout<<setw(12) << " y/x -- > ";
     for(x = xp; x <= xk+dx/2; x += dx)
          cout<<setw(12) << x;
     cout<<endl;
     for(y = yp; y <= yk+dy/2; y += dy)
     {
          cout<<setw(6) << y << " -- > ";
          for(x = xp; x <= xk+dx/2; x += dx)
          {
               b = Fn_b(x, y, z);
               cout<<setw(12) << Fn_c(x, y, z, b); // Розрахунок значення функцій c[x, y, z, b]
          }
          cout<<endl;
     }

     cout << endl << "Завдання №3" << endl << endl;
     int n = 5, m = 10;
     x = 1.61 * Nv;   cout << "Значення x = " << x << "." << endl;

     cout << "Подвійна сума/суми Ws' = " << Fn_Ws(Fn_w, x, m, n) << endl;

     cout << endl << "Завдання №4" << endl << endl;
     cout.precision(3);
     double A[size];
     n = 10;
     x = 0.68 * Nv;	cout << "Значення x = " << x << "." << endl << endl;
     for(int i = 0; i < size; i++)
     {
          A[i] = Fn_ai (x, i + 1);
          cout << "A[" << i << "] =" << setw(7) << A[i] << endl;
     }

     // Виклик функцій
     cout << endl << "Середнє значення масиву A C = " << Fn_Szn(A, n) << endl;
     cout << "Мінімальне значення масиву A m = " << Fn_min(A, n) << endl;
     cout << "Максимальне значення масиву A M = " << Fn_max(A, n) << endl << endl;

     z = (Fn_Szn(A, n) * Fn_min(A, n)) / (Fn_max(A, n) + Fn_min(A, n)) * Fn_sum(A, x) - pow(Fn_log(6, fabs(Fn_max(A, n) + Fn_min(A, n) * Fn_min(A, n))), 1.3);
     cout << "Значення виразу z = " << z << endl;
     getch(); return 0;
}

// Обчислення середнього значення елементів масиву
double Fn_Szn(double A[size], int n)
{
     double s = 0;
     for(int i = 0; i < n; i++) s += A[i];
     return s/n;
}

// Обчислення мінімального значення елементів масиву
double Fn_min(double A[size], int n)
{
     double min = A[0];
     for(int i = 1; i < n; i++)
     if(min > A[i]) min = A[i];
     return min;
}

// Обчислення максимального значення елементів масиву
double Fn_max(double A[size], int n)
{
     double max = A[0];
     for(int i = 1; i < n; i++)
     if(max < A[i]) max = A[i];
     return max;
}

// Обчислення суми множника z;
double Fn_sum(double A[size], double x)
{
     double s = 0;
     for(int i = 1; i <= size; i++)
          s += (x + i)/(pow(fabs(A[i - 1]), 0.56));
     return s;
}

double Fn_log(double osn, double ch)
{
     return log(osn) / log(ch);
}

// Обчислення значення елемента масиву
double Fn_ai(double x, int i)
{
     double c1 = (pow(i, 3.0/i) + 3 * x)/(cos(i + 2));
     double c2 = (pow(Fn_log(2, i + 1), 3))/(pow(sin(i + x), 2));
     return c1 - c2;
}


double Fact(int n)
{
     double f = 1;
     if(n > 1) for(int i = 2; i <= n; i++) f *= i;
     return f;
}

double Fn_w(double x, int i, int j )
{
     double w1 = (sin(pow((x + j), 2)));
     double w2 = ( Fact(i) + x + 2);
     return w1/w2;
}

double Fn_Ws(double ( *Fn_w)(double, int, int), double x, int m, int n)
{
     double s = 0, s1 = 0, c = 0;
     int z;
     for(int i = 0; i <= m; i++)
     {
          z = -1;
          for(int j = 1; j <= n; j++)
          {
               z = -z;
               c = z * Fn_w(x, i, j);
               cout << setprecision(8) << setw(12) << c;
               s1 += c;
          }
          cout << setw(7) << "P = " << setw(8) << s1 << endl;
          s += s1;
     }
     return s;
}
// Обчислення значення математичної функції a[x, y, z, b]
double Fn_a(double x, double y, double z, double b)
{
	 double a1 = y - pow(fabs(x * x - b), 1.0/3);
     double a2 = (y - x * x)/(z + y * y);
     return log(pow(fabs(a1 * a2), 2.0/3));

}
// Обчислення значення математичної функції b[x, y, z]
double Fn_b(double x, double y, double z)
{
     double b1 = (x + y * y - pow(z,3))/pow(sin(pow(x + z,2)),3);
     double b2 = pow(sin(x - z),2);
     double b3 = pow(fabs(y + z),0.34);
     return 1 - b1 + b2/b3;

}

// Обчислення значення математичної функції с[x, y, z, b]
double Fn_c(double x, double y, double z, double b)
{
     double c = 0;
     if ((x > -0.5)&&(x <= -0.2))
          c = pow(log(fabs((y - b * b)/(z + 4 * y * y))),2) - tan(pow(fabs(x),0.2));
     else if ((0.2 < x)&&(x <= 0.5))
          c = (y + x * x)/(z + 1.3) - sqrt(fabs(x * x - b/3));
     else c = (z + 4.5 * y * y)/(pow(sin(x * x - b),2))+ 3 * x * y;

     return c;
}




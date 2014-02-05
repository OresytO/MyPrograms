 // ������ ��������� GUI � ���������� �������
 import java.awt.*;
 import java.awt.event.*;

 public class GUI_Beispiel2 extends Frame {
   // ����������� ����������� ������� Adapter � Listener
   // ��� ���������� �������
   // ������ GUI_GBeispiel2
   class MeinWindowLauscher extends WindowAdapter {
   public void windowClosing(WindowEvent e) {
     // ����� �� ���������
     System.exit(0);
   }
  }

  class MeinActionLauscher implements ActionListener {
    public void actionPerformed(ActionEvent e) {
      // ��������� �������� ������
      java.awt.Toolkit.getDefaultToolkit().beep();
    }
  }

   // ����������� ��������� ��� ������
   GUI_Beispiel2(String titel) {
     super(titel);

     // ������������ ������
     Button hansel = new Button("�������");
     Button und = new Button("�");
     Button gretel = new Button("�������");

     
     // ��������� Layout-��������� ��� ���������� ������ � �������
     setLayout(new FlowLayout());

     // ���������� ������ � ������
     add(hansel);
     add(und);
     add(gretel);


     //���������� �������������� ������� ��� ���� -  WindowListener
     addWindowListener(new MeinWindowLauscher());

     // ����������� ActionListener ��� ������.
     // ������ ��� ��������� ����� ���������. 
     // ������, ��������� ����� ������������ ������������.
     hansel.addActionListener(new MeinActionLauscher());
     und.addActionListener(new MeinActionLauscher());
     gretel.addActionListener(new MeinActionLauscher());
   }

   public static void main(String[] args) {
     // ���������� � �������� ���������� ������
     GUI_Beispiel2 fenster =
                new GUI_Beispiel2("GUI � ���������� �������");
     fenster.pack();
     fenster.setVisible(true);
   }
 }

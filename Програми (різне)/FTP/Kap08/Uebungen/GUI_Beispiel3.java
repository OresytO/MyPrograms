 // ������ ��������� GUI � ���������� �������
 import java.awt.*;
 import java.awt.event.*;

public class GUI_Beispiel3 extends Frame {
  Button m_hansel, m_und, m_gretel;

   // ����������� ����������� ������� Adapter � Listener
   // ��� ���������� �������
   // ������ GUI_GBeispiel3
   class MeinWindowLauscher extends WindowAdapter {
   public void windowClosing(WindowEvent e) {
     // ����� �� ���������
     System.exit(0);
   }
  }

  class MeinActionLauscher implements ActionListener{
    public void actionPerformed(ActionEvent e){
      // ��������� ���������
      m_hansel.setLabel("�����������");
      m_und.setLabel("�");
      m_gretel.setLabel("����");
    }
  }

   // ����������� ��������� ��� ������
   GUI_Beispiel3(String titel) {
     super(titel);

     // ������������ ������
     m_hansel = new Button("�������");
     m_und    = new Button("�");
     m_gretel = new Button("�������");
   
     // ��������� Layout-��������� ��� ���������� ������ � �������
     setLayout(new FlowLayout());

     // ���������� ������ � ������
     add(m_hansel);
     add(m_und);
     add(m_gretel);


     // ���������� �������������� ������� ��� ���� -  WindowListener
     addWindowListener(new MeinWindowLauscher());

     // ����������� ActionListener ��� ������.
     // ������ ��� ��������� ����� ���������. 
     // ������, ��������� ����� ������������ ������������.
     m_hansel.addActionListener(new MeinActionLauscher());
     m_und.addActionListener(new MeinActionLauscher());
     m_gretel.addActionListener(new MeinActionLauscher());

   }

   public static void main(String[] args) {
     // ���������� � �������� ���������� ������
     GUI_Beispiel3 fenster =
                new GUI_Beispiel3("GUI � ���������� �������");
     fenster.pack();
     fenster.setVisible(true);
   }
 }

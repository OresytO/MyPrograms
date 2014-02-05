 // ��������� Swing-������
 import javax.swing.*;
 import java.awt.*;
 import java.awt.event.*;

 // ����������� ������ ����
 public class Swing_Beispiel extends JFrame {
   JButton m_hansel, m_und, m_gretel;


   // ��������� ������� ��� ��������� ����������
   class MeinActionLauscher implements ActionListener {
     public void actionPerformed(ActionEvent e) {
       int i;

       m_hansel.setText("�����������");
       m_und.setText("���");
       m_gretel.setText("� ����");
     }
   }

   // �����������
   Swing_Beispiel(String titel) {
     super(titel);

   // ������������ ������
     m_hansel = new JButton("�������");
     m_und	= new JButton("�");
     m_gretel = new JButton("�������");

     // Layout-�������� ��� ������������ ������
     setLayout(new FlowLayout());

     // ���������� ������ � ����
     add(m_hansel);
     add(m_und);
     add(m_gretel);


     // ���������� �������������, ���� ���� �����������
     setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);

     // ���������� �������������� ������� ActionListener ��� ������
     m_hansel.addActionListener(new MeinActionLauscher());
     m_und.addActionListener(new MeinActionLauscher());
     m_gretel.addActionListener(new MeinActionLauscher());
   }


   public static void main(String[] args) {
     Swing_Beispiel fenster = new Swing_Beispiel("Swing");
     fenster.pack();
     fenster.setSize(300,100);
     fenster.setVisible(true);
   }
 }

SELECT  d.send_date AS ����_��������, 
        d.take_date AS ����_���������, 
        d.delivery_cost AS �������_�����������, 
        d.places AS �������_����, 
        `size` AS �������, 
        d.weight AS ���, 
        (SELECT con.`name` FROM contragent AS con WHERE con.contragent_id = d.sender_id) AS ���������,
        (SELECT con.`name` FROM contragent AS con WHERE con.contragent_id = d.taker_id) AS ���������, 
        (SELECT s.`status` FROM `status` AS s WHERE s.status_id = d.status_id) AS ������, 
        d.courier_id AS ���������, 
        d.in_or_out AS ���_��������, 
        d.delivery_id AS id, 
        d.declaration_number AS �_����������
FROM delivery AS d;

SELECT COUNT(SELECT DISTINCT courier_id 
FROM `delivery`) AS courier_count 
FROM `delivery`;

SELECT DISTINCT ���������  
FROM (SELECT * FROM `delivery_app` 
    WHERE   ����_�������� >= #2013-07-20# 
        AND ����_�������� <= #2013-08-09# 
        AND ����_��������� >= #2013-07-20# 
        AND ����_��������� <= #2013-08-09#);

SELECT DISTINCT c.adress, c.name_storage_number, 
c.phone_1 &" "& c.phone_2 &" "& c.phone_3 AS phone, c.passport_for_id 
FROM courier AS c 
INNER JOIN (SELECT ��������� FROM `delivery_app` WHERE id IN (5, 8, 12, 14)) AS sl 
ON sl.��������� = c.name_storage_number
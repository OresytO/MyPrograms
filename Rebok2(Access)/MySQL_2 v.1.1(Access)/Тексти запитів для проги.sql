SELECT  d.send_date AS дата_відправки, 
        d.take_date AS дата_одержання, 
        d.delivery_cost AS вартість_перевезення, 
        d.places AS кількість_місць, 
        `size` AS габарит, 
        d.weight AS ваг, 
        (SELECT con.`name` FROM contragent AS con WHERE con.contragent_id = d.sender_id) AS відправник,
        (SELECT con.`name` FROM contragent AS con WHERE con.contragent_id = d.taker_id) AS одержувач, 
        (SELECT s.`status` FROM `status` AS s WHERE s.status_id = d.status_id) AS статус, 
        d.courier_id AS перевізник, 
        d.in_or_out AS вид_відправки, 
        d.delivery_id AS id, 
        d.declaration_number AS №_декларації
FROM delivery AS d;

SELECT COUNT(SELECT DISTINCT courier_id 
FROM `delivery`) AS courier_count 
FROM `delivery`;

SELECT DISTINCT перевізник  
FROM (SELECT * FROM `delivery_app` 
    WHERE   дата_відправки >= #2013-07-20# 
        AND дата_відправки <= #2013-08-09# 
        AND дата_одержання >= #2013-07-20# 
        AND дата_одержання <= #2013-08-09#);

SELECT DISTINCT c.adress, c.name_storage_number, 
c.phone_1 &" "& c.phone_2 &" "& c.phone_3 AS phone, c.passport_for_id 
FROM courier AS c 
INNER JOIN (SELECT перевізник FROM `delivery_app` WHERE id IN (5, 8, 12, 14)) AS sl 
ON sl.перевізник = c.name_storage_number
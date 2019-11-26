SELECT * FROM invoice
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
WHERE invoice_line.unit_price > 0.99;             

SELECT invoice.invoice_date, customer.first_name, customer.last_name, invoice.total
FROM invoice
INNER JOIN CUSTOMER ON invoice.customer_id = customer.customer_id;

SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
JOIN employee e ON c.support_rep_id = e.employee_id;

SELECT album.title, artist.name
FROM album
JOIN artist ON album.artist_id = artist.artist_id;

SELECT pt.track_id
FROM playlist_track pt
JOIN playlist p ON p.playlist_id = pt.playlist_id
WHERE p.name = 'Music';

SELECT track.name
FROM track
JOIN playlist_track ON track.track_id = playlist_track.track_id
WHERE playlist_track.playlist_id = 5;

SELECT track.name, playlist.name
FROM track
JOIN playlist_track ON track.track_id = playlist_track.track_id
JOIN playlist ON playlist_track.playlist_id = playlist.playlist_id;

SELECT track.name, album.title
FROM track
JOIN album ON track.album_id = album.album_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name = 'Alternative & Punk';




SELECT *
FROM invoice
WHERE invoice_id IN ( 
    SELECT invoice_id 
    FROM invoice_line 
    WHERE unit_price > 0.99 
);

SELECT *
FROM playlist_track
WHERE playlist_id IN (
    SELECT playlist_id 
    FROM playlist 
    WHERE name = 'Music'
);

SELECT name
FROM track
WHERE track_id IN (
    SELECT track_id
    FROM playlist_track
    WHERE playlist_id = 5
);

SELECT *
FROM track
WHERE genre_id IN (
    SELECT genre_id
    FROM genre
    WHERE name = 'Comedy'
);

SELECT *
FROM track
WHERE album_id IN (
    SELECT album_id
    FROM album
    WHERE title = 'Fireball'
);

SELECT *
FROM track
WHERE album_id IN (
 	SELECT album_id
 	FROM album
 	WHERE artist_id IN (
      SELECT artist_id
      FROM artist
      WHERE name = 'Queen'
  )
);




UPDATE customer
SET fax = null
WHERE fax IS NOT null;

UPDATE customer
SET company = 'Self'
WHERE company IS null;

UPDATE customer 
SET last_name = 'Thompson' 
WHERE first_name = 'Julia' AND last_name = 'Barnett';

UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = ( SELECT genre_id FROM genre WHERE name = 'Metal' )
AND composer IS null;




SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;

SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name;

SELECT ar.name, COUNT(*)
FROM album al
JOIN artist ar ON ar.artist_id = al.artist_id
GROUP BY ar.name;




SELECT DISTINCT composer
FROM track;

SELECT DISTINCT billing_postal_code
FROM invoice;

SELECT DISTINCT company
FROM customer;




DELETE 
FROM practice_delete 
WHERE type = 'bronze';

DELETE 
FROM practice_delete 
WHERE type = 'silver'

DELETE 
FROM practice_delete 
WHERE value = 150;







CREATE TABLE users 
(user_id SERIAL PRIMARY KEY,
name TEXT,
email TEXT);

CREATE TABLE product
(product_id SERIAL PRIMARY KEY,
name TEXT,
price INT);

CREATE TABLE orders
(id SERIAL PRIMARY KEY,
product_id INT,
FOREIGN KEY (id) references product(product_id));



INSERT INTO users 
(name, email) 
VALUES 
('kindred','kindred@gmail.com'),('wolf','wolf@gmail.com'),('arrow','arrow@gmail.com');

INSERT INTO product 
(name, price)
VALUES 
('soul', 50), ('arrow',2),('hunt',150);

INSERT INTO orders
(product_id)
VALUES
(1), (2), (3);



SELECT * FROM product p
INNER JOIN orders o
ON p.product_id = o.product_id
WHERE o.id = 1;

SELECT * FROM orders

SELECT SUM(p.price)
FROM orders o
JOIN product p ON o.product_id = p.product_id;




ALTER TABLE orders
ADD COLUMN user_id INT
REFERENCES users(user_id);



UPDATE orders
SET user_id = 1;


SELECT * FROM orders
WHERE user_id = 1;


SELECT user_id, COUNT(*) FROM orders
GROUP BY user_id;


SELECT user_id, SUM(p.price) AS total_amount
FROM orders o
LEFT OUTER JOIN product p ON o.product_id = p.product_id
GROUP BY user_id;

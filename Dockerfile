FROM mysql:5.6 as premasaik/mysql

FROM wordpress as premasaik/wordpress
  COPY . /usr/src/wordpress/

FROM mysql:5.6

FROM wordpress
  COPY . /usr/src/wordpress/

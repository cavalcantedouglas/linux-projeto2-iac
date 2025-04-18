#!/bin/bash

# ATENCAO
# RODAR ESTE SCRIPT COM PRIVILEGIOS DE ADMINISTRADOR OU ROOT
if [ "$EUID" -ne 0 ]; then
	echo "Erro: Este script precisa ser executado com privilegios de root. Tente: sudo. $0"
	exit 1
fi


echo "Setup servidor web com Apache"
echo "==========================="
echo "Iniciando..."
echo "==========================="

echo "Atualizando pacotes"
apt updat

echo "Instalando e configurando servidor web Apache"
# Instalando Apache
apt install apache2 -y

# Habilitando para iniciar automaticamente no boot
systemctl enable apache2

echo "Instalando unzip"
apt install unzip -y

echo "Baixando zip com aplicacao no diretorio tmp e descompactando arquivo"
wget https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip -P /tmp/

# Descompactando arquivo
unzip /tmp/main.zip -d /tmp/

echo "Copiando arquivos da aplicacao no diretorio padrao do Apache"
cp -r /tmp/linux-site-dio-main/* /var/www/html/

echo "Limpando arquivos temporarios"
rm -rf /tmp/main.zip /tmp/linux-site-dio-main

echo "==========================="
echo "Configuração concluída! Acesse o site em http://$(hostname -I | awk '{print $1}')"
echo "==========================="


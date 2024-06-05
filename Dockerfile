FROM openshift/httpd:latest
 
# Define o diretório de trabalho
WORKDIR /var/www/html
 
# Adiciona o HTML dinâmico ao container
RUN echo '\
<!DOCTYPE html>\n\
<html>\n\
<head>\n\
  <title>Check Decoder_Ring</title>\n\
  <script>\n\
    var decoderRing = "'${Decoder_Ring}'";\n\
    window.onload = function() {\n\
      if (!decoderRing || decoderRing === "undefined") {\n\
        document.getElementById("output").innerText = "Error";\n\
      } else {\n\
        document.getElementById("output").innerText = decoderRing;\n\
      }\n\
    };\n\
  </script>\n\
</head>\n\
<body>\n\
  <h1 id="output"></h1>\n\
</body>\n\
</html>' > /var/www/html/index.html
 
# Expor a porta padrão do HTTPD
EXPOSE 8080
 
# Comando para iniciar o HTTPD
CMD ["httpd", "-D", "FOREGROUND"]
